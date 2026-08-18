-- Run this in Supabase SQL Editor to add daily habit checklist support.

create table habits (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  name text not null,
  created_at timestamptz not null default now()
);

create table habit_logs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  habit_id uuid not null references habits(id) on delete cascade,
  date date not null,
  done boolean not null default true,
  unique (user_id, habit_id, date)
);

alter table habits enable row level security;
alter table habit_logs enable row level security;

create policy "own habits" on habits for all
  using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "own habit_logs" on habit_logs for all
  using (auth.uid() = user_id) with check (auth.uid() = user_id);
