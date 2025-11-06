-- Supabase schema for Smoothie Move (MFR de Gionges)

create table if not exists users (
  id uuid primary key,
  display_name text,
  role text default 'student',
  points numeric default 0,
  created_at timestamp with time zone default timezone('utc'::text, now())
);

create table if not exists activities (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references users(id) on delete cascade,
  type text,
  value numeric,
  points numeric,
  status text default 'pending',
  photo_path text,
  provider text,
  meta jsonb,
  submitted_at timestamp with time zone default timezone('utc'::text, now()),
  validated_at timestamp with time zone,
  validator_id uuid
);

create table if not exists points_history (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references users(id),
  change numeric,
  reason text,
  activity_id uuid,
  created_at timestamp with time zone default timezone('utc'::text, now())
);

create table if not exists qr_tokens (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references users(id),
  points_required numeric,
  code text,
  used boolean default false,
  created_at timestamp with time zone default timezone('utc'::text, now()),
  used_at timestamp with time zone,
  used_by text
);

create table if not exists challenges (
  id uuid primary key default gen_random_uuid(),
  title text,
  start_at timestamp with time zone,
  end_at timestamp with time zone,
  bonus_points numeric,
  target jsonb,
  created_by uuid
);

-- Function to credit points and update activity status
create or replace function credit_points(p_user_id uuid, p_points numeric, p_activity_id uuid)
returns void language plpgsql as $$
begin
  update users set points = points + p_points where id = p_user_id;
  insert into points_history (user_id, change, reason, activity_id) values (p_user_id, p_points, 'activity_validated', p_activity_id);
  update activities set status = 'validated', validated_at = timezone('utc'::text, now()) where id = p_activity_id;
end;
$$;