-- Établi : base de données. À coller une fois dans Supabase > SQL Editor > New query, puis « Run ».

-- Une seule table : chaque projet, tag, élément en vrac ou période de congé est une ligne.
create table if not exists public.rows (
  user_id    uuid        not null default auth.uid() references auth.users(id) on delete cascade,
  key        text        not null,
  data       jsonb,
  deleted    boolean     not null default false,
  updated_at timestamptz not null default now(),
  primary key (user_id, key)
);
create index if not exists rows_user_updated on public.rows (user_id, updated_at);

-- L'heure de modification est toujours celle du serveur.
create or replace function public.rows_touch() returns trigger language plpgsql as $$
begin new.updated_at := now(); return new; end $$;
drop trigger if exists rows_touch on public.rows;
create trigger rows_touch before insert or update on public.rows for each row execute function public.rows_touch();

-- Chacun ne voit et ne modifie que ses propres lignes.
alter table public.rows enable row level security;
drop policy if exists "lire ses lignes" on public.rows;
drop policy if exists "ajouter ses lignes" on public.rows;
drop policy if exists "modifier ses lignes" on public.rows;
create policy "lire ses lignes"     on public.rows for select to authenticated using (auth.uid() = user_id);
create policy "ajouter ses lignes"  on public.rows for insert to authenticated with check (auth.uid() = user_id);
create policy "modifier ses lignes" on public.rows for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
revoke all on public.rows from anon;
grant select, insert, update on public.rows to authenticated;

-- Petit signal hebdomadaire (envoyé par GitHub) pour que le projet gratuit ne se mette pas en veille.
create or replace function public.ping() returns integer language sql stable as $$ select 1 $$;
grant execute on function public.ping() to anon, authenticated;
