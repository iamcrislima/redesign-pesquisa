-- IRD 1Doc — pesquisa do redesign
-- Fase 1 (persistência) + Fase 4 (leitura só com sessão).
--
-- Rode este arquivo INTEIRO no SQL Editor do Supabase, de uma vez.
-- Tabela e RLS estão na mesma transação de propósito: uma tabela criada
-- sem política fica legível por qualquer anônimo até a segunda metade rodar.

begin;

create table public.respostas (
  codigo        text primary key,          -- código de acompanhamento, ex. RD-2026/2963
  wave          text not null,
  criado_em     timestamptz not null default now(),

  cliente_id    text not null,
  cliente_nome  text not null,
  tipo_org      text not null check (tipo_org in ('Prefeitura','Câmara','Saneamento','Consórcio','Outro')),

  papel         text,
  tempo         text,
  freq          text,
  status        text not null check (status in ('usa','voltou','nao_sei')),

  -- quais áreas/jornadas a pessoa marcou: são o denominador de sat e ces
  jorn          text[]  not null default '{}',
  areas         text[]  not null default '{}',

  nota          int     check (nota between 0 and 10),
  nota_why      text,
  u1            int     check (u1 between 1 and 7),
  u2            int     check (u2 between 1 and 7),

  legado        jsonb   not null default '{}',
  legado_worse  text,
  ces           jsonb   not null default '{}',
  sat           jsonb   not null default '{}',

  -- bloco rotativo da Central de atendimento
  atend         jsonb   not null default '{}',
  atend_papel   text,
  atend_why     text,

  admin         int,
  admin_why     text,
  risco         int,
  risco_why     text,
  one_thing     text,
  time_sink     text,

  rev_usou      text,
  rev_quando    text,
  rev_motivos   text[] not null default '{}',
  rev_ponto     text,
  rev_traria    text,
  rev_recomenda text,

  talk          boolean not null default false,  -- aceitou entrevista: alimenta a fila do painel
  seed          boolean not null default false   -- dado de demonstração: sem isso, demo vira permanente
);

create index respostas_wave_idx   on public.respostas (wave);
create index respostas_tipo_idx   on public.respostas (tipo_org);
create index respostas_status_idx on public.respostas (status);

-- Identidade separada das respostas, ligada só pelo código de acompanhamento.
create table public.contatos (
  codigo text primary key references public.respostas(codigo) on delete cascade,
  nome   text,
  email  text
);

alter table public.respostas enable row level security;
alter table public.contatos  enable row level security;

-- Anônimo escreve e nunca lê. Sem policy de select para anon, a RLS nega por padrão:
-- é isto que sustenta a Fase 4 no banco, e não a checagem na interface.
create policy "anon insere resposta" on public.respostas
  for insert to anon, authenticated with check (true);
create policy "autenticado le respostas" on public.respostas
  for select to authenticated using (true);

create policy "anon insere contato" on public.contatos
  for insert to anon, authenticated with check (true);
create policy "autenticado le contatos" on public.contatos
  for select to authenticated using (true);

-- Apagar exige sessão: "Limpar demonstração" passa a ser ação de equipe logada.
create policy "autenticado apaga demo" on public.respostas
  for delete to authenticated using (seed = true);

commit;
