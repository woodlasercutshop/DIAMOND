-- Выполните в Supabase: SQL Editor -> New query -> Run
create table if not exists dia (
  id text primary key,
  coll text not null,
  data jsonb not null,
  u bigint not null
);
create index if not exists dia_u_idx on dia (u);
alter table dia enable row level security;
drop policy if exists "dia_open" on dia;
create policy "dia_open" on dia for all to anon using (true) with check (true);

-- Мгновенные обновления (Realtime)
alter publication supabase_realtime add table public.dia;
alter table public.dia replica identity full;
