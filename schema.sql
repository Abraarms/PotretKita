-- Jalankan sekali di Supabase > SQL Editor setelah membuat bucket foto-berdua.
-- Bucket harus PRIVATE (public = false).
-- Kebijakan ini memberi akses kepada semua akun yang berhasil login pada proyek ini.
-- Karena itu, buat hanya dua akun yang kalian gunakan dan nonaktifkan pendaftaran publik.
drop policy if exists "logged-in users can view couple photos" on storage.objects;
drop policy if exists "logged-in users can upload couple photos" on storage.objects;
drop policy if exists "logged-in users can delete couple photos" on storage.objects;
create policy "logged-in users can view couple photos"
on storage.objects for select to authenticated
using (bucket_id = 'foto-berdua');

-- Metadata bersama untuk keterangan dan favorit pada setiap foto.
create table if not exists public.photo_notes (
  path text primary key,
  caption text not null default '',
  favorite boolean not null default false,
  updated_at timestamptz not null default now()
);
alter table public.photo_notes enable row level security;
drop policy if exists "logged-in users can read photo notes" on public.photo_notes;
drop policy if exists "logged-in users can add photo notes" on public.photo_notes;
drop policy if exists "logged-in users can edit photo notes" on public.photo_notes;
drop policy if exists "logged-in users can delete photo notes" on public.photo_notes;
create policy "logged-in users can read photo notes" on public.photo_notes for select to authenticated using (true);
create policy "logged-in users can add photo notes" on public.photo_notes for insert to authenticated with check (true);
create policy "logged-in users can edit photo notes" on public.photo_notes for update to authenticated using (true) with check (true);
create policy "logged-in users can delete photo notes" on public.photo_notes for delete to authenticated using (true);

create policy "logged-in users can upload couple photos"
on storage.objects for insert to authenticated
with check (bucket_id = 'foto-berdua');

create policy "logged-in users can delete couple photos"
on storage.objects for delete to authenticated
using (bucket_id = 'foto-berdua');
