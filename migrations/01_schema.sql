-- Run this once in your Supabase project's SQL editor (Database > SQL Editor > New query)

create table meals (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  name text not null,
  type text not null check (type in ('family', 'personal')),
  repeats int not null default 1,
  calories int,
  created_at timestamptz not null default now()
);

create table plans (
  user_id uuid primary key references auth.users(id) on delete cascade,
  schedule jsonb not null default '{}'::jsonb,
  overflow jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

create table weights (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  date date not null,
  weight numeric not null,
  created_at timestamptz not null default now(),
  unique (user_id, date)
);

create table settings (
  user_id uuid primary key references auth.users(id) on delete cascade,
  goal_weight numeric
);

alter table meals enable row level security;
alter table plans enable row level security;
alter table weights enable row level security;
alter table settings enable row level security;

create policy "own meals" on meals for all
  using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "own plans" on plans for all
  using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "own weights" on weights for all
  using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "own settings" on settings for all
  using (auth.uid() = user_id) with check (auth.uid() = user_id);
