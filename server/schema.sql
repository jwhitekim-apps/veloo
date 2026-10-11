-- veloo — Supabase 스키마
-- Supabase SQL Editor에서 한 번에 실행

-- ── users ──────────────────────────────────────────────────────────────────
create table if not exists users (
  id            uuid        default gen_random_uuid() primary key,
  username      text        unique not null,
  password_hash text        not null,
  is_approved   boolean     not null default false,
  created_at    timestamptz not null default now()
);

-- ── sessions ───────────────────────────────────────────────────────────────
create table if not exists sessions (
  id         uuid        default gen_random_uuid() primary key,
  user_id    uuid        not null references users(id) on delete cascade,
  token      text        unique not null,
  expires_at timestamptz not null,
  created_at timestamptz not null default now()
);

create index if not exists sessions_token_idx      on sessions (token);
create index if not exists sessions_expires_at_idx on sessions (expires_at);

-- ── paper_history ──────────────────────────────────────────────────────────
create table if not exists paper_history (
  id         bigserial   primary key,
  user_id    uuid        not null references users(id) on delete cascade,
  query      text,
  paper_id   text,
  title      text,
  result     jsonb       not null,
  created_at timestamptz not null default now()
);

create index if not exists paper_history_user_id_idx    on paper_history (user_id);
create index if not exists paper_history_paper_id_idx   on paper_history (paper_id);
create index if not exists paper_history_created_at_idx on paper_history (created_at desc);

-- ── translation_history ────────────────────────────────────────────────────
create table if not exists translation_history (
  id              bigserial   primary key,
  user_id         uuid        not null references users(id) on delete cascade,
  source_text     text        not null,
  translated_text text        not null,
  type            text        not null check (type in ('word', 'sentence')),
  created_at      timestamptz not null default now()
);

create index if not exists translation_history_user_id_idx    on translation_history (user_id);
create index if not exists translation_history_source_idx     on translation_history (source_text);
create index if not exists translation_history_created_at_idx on translation_history (created_at desc);

-- ── arch_history ───────────────────────────────────────────────────────────
create table if not exists arch_history (
  id          bigserial   primary key,
  user_id     uuid        not null references users(id) on delete cascade,
  image_name  text,
  explanation jsonb       not null,
  feedback    jsonb,
  created_at  timestamptz not null default now()
);

create index if not exists arch_history_user_id_idx    on arch_history (user_id);
create index if not exists arch_history_created_at_idx on arch_history (created_at desc);

create table if not exists contextor_history (
  id         bigint generated always as identity primary key,
  user_id    uuid not null references users(id) on delete cascade,
  query      text not null,
  result     jsonb not null,
  created_at timestamptz default now()
);
alter table contextor_history
  add column if not exists user_id uuid references users(id) on delete cascade;
create index if not exists contextor_history_user_id_idx on contextor_history (user_id);
create index if not exists contextor_history_query_idx on contextor_history (query);

-- ── users 추가 열 ───────────────────────────────────────────────────────────
alter table users
  add column if not exists email text;
