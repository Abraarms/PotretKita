-- Jalankan sekali di Supabase > SQL Editor setelah membuat bucket foto-berdua.
-- Bucket harus PRIVATE (public = false).
-- Kebijakan ini memberi akses kepada semua akun yang berhasil login pada proyek ini.
-- Karena itu, buat hanya dua akun yang kalian gunakan dan nonaktifkan pendaftaran publik.
create policy "logged-in users can view couple photos"
on storage.objects for select to authenticated
using (bucket_id = 'foto-berdua');

create policy "logged-in users can upload couple photos"
on storage.objects for insert to authenticated
with check (bucket_id = 'foto-berdua');

create policy "logged-in users can delete couple photos"
on storage.objects for delete to authenticated
using (bucket_id = 'foto-berdua');
