-- ==============================================================================
-- E-Ticketing Helpdesk — Supabase Database Schema
-- Project: uts_mobile
-- ==============================================================================

-- 1. USERS TABLE
-- ==============================================================================
CREATE TABLE IF NOT EXISTS users (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  username TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL,
  role TEXT NOT NULL DEFAULT 'user' CHECK (role IN ('user', 'helpdesk', 'admin')),
  department TEXT NOT NULL DEFAULT '',
  avatar TEXT DEFAULT '',
  phone TEXT DEFAULT '',
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Disable RLS for simplicity (can be enabled later)
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow all access to users" ON users FOR ALL USING (true) WITH CHECK (true);

-- 2. TICKETS TABLE
-- ==============================================================================
CREATE TABLE IF NOT EXISTS tickets (
  id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  category TEXT NOT NULL,
  priority TEXT NOT NULL CHECK (priority IN ('low', 'medium', 'high')),
  status TEXT NOT NULL DEFAULT 'open' CHECK (status IN ('open', 'in progress', 'resolved', 'closed', 'pending')),
  created_by_id UUID REFERENCES users(id) ON DELETE SET NULL,
  created_by_name TEXT NOT NULL,
  assigned_to_id UUID REFERENCES users(id) ON DELETE SET NULL,
  assigned_to_name TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE tickets ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow all access to tickets" ON tickets FOR ALL USING (true) WITH CHECK (true);

-- 3. COMMENTS TABLE
-- ==============================================================================
CREATE TABLE IF NOT EXISTS comments (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  ticket_id TEXT REFERENCES tickets(id) ON DELETE CASCADE,
  author_id UUID REFERENCES users(id) ON DELETE SET NULL,
  author_name TEXT NOT NULL,
  author_role TEXT NOT NULL,
  content TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE comments ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow all access to comments" ON comments FOR ALL USING (true) WITH CHECK (true);

-- 4. TICKET HISTORY TABLE
-- ==============================================================================
CREATE TABLE IF NOT EXISTS ticket_history (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  ticket_id TEXT REFERENCES tickets(id) ON DELETE CASCADE,
  action TEXT NOT NULL,
  performed_by TEXT NOT NULL,
  performed_by_role TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE ticket_history ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow all access to ticket_history" ON ticket_history FOR ALL USING (true) WITH CHECK (true);

-- 5. NOTIFICATIONS TABLE
-- ==============================================================================
CREATE TABLE IF NOT EXISTS notifications (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  ticket_id TEXT REFERENCES tickets(id) ON DELETE CASCADE,
  type TEXT NOT NULL,
  is_read BOOLEAN DEFAULT false,
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ DEFAULT now()
);

ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow all access to notifications" ON notifications FOR ALL USING (true) WITH CHECK (true);

-- 6. AUTO-INCREMENT FUNCTION FOR TICKET ID
-- ==============================================================================
CREATE OR REPLACE FUNCTION generate_ticket_id()
RETURNS TEXT AS $$
DECLARE
  next_num INTEGER;
BEGIN
  SELECT COALESCE(MAX(CAST(SUBSTRING(id FROM 5) AS INTEGER)), 0) + 1
  INTO next_num
  FROM tickets;
  RETURN 'TKT-' || LPAD(next_num::TEXT, 3, '0');
END;
$$ LANGUAGE plpgsql;

-- ==============================================================================
-- SEED DATA — Initial Admin & Sample Users
-- ==============================================================================

-- Insert users (password stored as plain text for simplicity in this academic project)
INSERT INTO users (id, name, email, username, password, role, department, avatar, phone) VALUES
  ('11111111-0000-0000-0000-000000000001', 'Admin Utama', 'admin@company.com', 'admin', 'admin123', 'admin', 'IT', 'AU', '086789012345'),
  ('22222222-0000-0000-0000-000000000001', 'Rizky Prasetyo', 'rizky@company.com', 'rizky', '123456', 'helpdesk', 'IT Support', 'RP', '084567890123'),
  ('22222222-0000-0000-0000-000000000002', 'Dewi Kusuma', 'dewi@company.com', 'dewi', '123456', 'helpdesk', 'IT Support', 'DK', '085678901234'),
  ('33333333-0000-0000-0000-000000000001', 'Budi Santoso', 'budi@company.com', 'budi', '123456', 'user', 'Finance', 'BS', '081234567890'),
  ('33333333-0000-0000-0000-000000000002', 'Siti Rahayu', 'siti@company.com', 'siti', '123456', 'user', 'HR', 'SR', '082345678901'),
  ('33333333-0000-0000-0000-000000000003', 'Andi Wijaya', 'andi@company.com', 'andi', '123456', 'user', 'Marketing', 'AW', '083456789012');

-- Insert sample tickets
INSERT INTO tickets (id, title, description, category, priority, status, created_by_id, created_by_name, assigned_to_id, assigned_to_name, created_at, updated_at) VALUES
  ('TKT-001', 'Laptop tidak bisa menyala', 'Laptop saya tiba-tiba tidak mau menyala setelah update Windows kemarin. Sudah dicoba restart tapi tetap tidak bisa.', 'Hardware', 'high', 'in progress', '33333333-0000-0000-0000-000000000001', 'Budi Santoso', '22222222-0000-0000-0000-000000000001', 'Rizky Prasetyo', now() - interval '2 days 3 hours', now() - interval '5 hours'),
  ('TKT-002', 'Email tidak bisa terkirim', 'Saat mencoba mengirim email ke klien, selalu muncul error "SMTP connection failed". Ini sudah berlangsung sejak 2 hari lalu.', 'Software', 'medium', 'open', '33333333-0000-0000-0000-000000000002', 'Siti Rahayu', NULL, NULL, now() - interval '1 day', now() - interval '1 day'),
  ('TKT-003', 'Printer offline di lantai 3', 'Printer Canon IP2770 di ruang Marketing lantai 3 menampilkan status offline dan tidak bisa digunakan.', 'Hardware', 'low', 'resolved', '33333333-0000-0000-0000-000000000003', 'Andi Wijaya', '22222222-0000-0000-0000-000000000002', 'Dewi Kusuma', now() - interval '5 days', now() - interval '1 day'),
  ('TKT-004', 'Akses VPN gagal', 'Tidak bisa terhubung ke VPN perusahaan saat bekerja dari rumah. Error yang muncul: "Authentication failed".', 'Network', 'high', 'pending', '33333333-0000-0000-0000-000000000001', 'Budi Santoso', NULL, NULL, now() - interval '6 hours', now() - interval '6 hours'),
  ('TKT-005', 'Software akuntansi crash', 'Aplikasi Accurate versi terbaru sering crash ketika membuka laporan bulanan. Sudah coba reinstall tapi masalah tetap ada.', 'Software', 'high', 'closed', '33333333-0000-0000-0000-000000000002', 'Siti Rahayu', '22222222-0000-0000-0000-000000000001', 'Rizky Prasetyo', now() - interval '10 days', now() - interval '7 days'),
  ('TKT-006', 'Monitor berkedip-kedip', 'Monitor di meja saya berkedip-kedip sejak kemarin. Sudah ganti kabel tapi masih sama.', 'Hardware', 'medium', 'open', '33333333-0000-0000-0000-000000000003', 'Andi Wijaya', NULL, NULL, now() - interval '12 hours', now() - interval '12 hours');

-- Insert sample comments
INSERT INTO comments (ticket_id, author_id, author_name, author_role, content, created_at) VALUES
  ('TKT-001', '22222222-0000-0000-0000-000000000001', 'Rizky Prasetyo', 'helpdesk', 'Halo Pak Budi, saya sedang memeriksa masalah ini. Bisa tolong coba tekan tombol power selama 30 detik?', now() - interval '10 hours'),
  ('TKT-001', '33333333-0000-0000-0000-000000000001', 'Budi Santoso', 'user', 'Sudah dicoba tapi masih tidak bisa menyala Pak.', now() - interval '8 hours'),
  ('TKT-003', '22222222-0000-0000-0000-000000000002', 'Dewi Kusuma', 'helpdesk', 'Printer sudah diperbaiki. Masalahnya adalah kabel USB yang longgar. Silakan coba lagi.', now() - interval '1 day'),
  ('TKT-005', '22222222-0000-0000-0000-000000000001', 'Rizky Prasetyo', 'helpdesk', 'Masalah sudah diselesaikan dengan update driver graphics card. Harap konfirmasi.', now() - interval '7 days 2 hours'),
  ('TKT-005', '33333333-0000-0000-0000-000000000002', 'Siti Rahayu', 'user', 'Sudah berjalan normal. Terima kasih!', now() - interval '7 days');

-- Insert sample ticket history
INSERT INTO ticket_history (ticket_id, action, performed_by, performed_by_role, created_at) VALUES
  ('TKT-001', 'Tiket dibuat', 'Budi Santoso', 'user', now() - interval '2 days 3 hours'),
  ('TKT-001', 'Tiket di-assign ke Rizky Prasetyo', 'Admin Utama', 'admin', now() - interval '2 days'),
  ('TKT-001', 'Status diubah menjadi In Progress', 'Rizky Prasetyo', 'helpdesk', now() - interval '10 hours'),
  ('TKT-002', 'Tiket dibuat', 'Siti Rahayu', 'user', now() - interval '1 day'),
  ('TKT-003', 'Tiket dibuat', 'Andi Wijaya', 'user', now() - interval '5 days'),
  ('TKT-003', 'Status diubah menjadi Resolved', 'Dewi Kusuma', 'helpdesk', now() - interval '1 day'),
  ('TKT-004', 'Tiket dibuat', 'Budi Santoso', 'user', now() - interval '6 hours'),
  ('TKT-005', 'Tiket dibuat', 'Siti Rahayu', 'user', now() - interval '10 days'),
  ('TKT-005', 'Status diubah menjadi Closed', 'Admin Utama', 'admin', now() - interval '7 days'),
  ('TKT-006', 'Tiket dibuat', 'Andi Wijaya', 'user', now() - interval '12 hours');

-- Insert sample notifications
INSERT INTO notifications (title, body, ticket_id, type, is_read, user_id, created_at) VALUES
  ('Tiket TKT-001 diperbarui', 'Status tiket "Laptop tidak bisa menyala" diubah menjadi In Progress', 'TKT-001', 'status_update', false, '33333333-0000-0000-0000-000000000001', now() - interval '10 hours'),
  ('Komentar baru di TKT-001', 'Rizky Prasetyo menambahkan komentar pada tiket Anda', 'TKT-001', 'new_comment', false, '33333333-0000-0000-0000-000000000001', now() - interval '8 hours'),
  ('Tiket TKT-003 diselesaikan', 'Tiket "Printer offline di lantai 3" telah diselesaikan', 'TKT-003', 'resolved', true, '33333333-0000-0000-0000-000000000003', now() - interval '1 day');


ALTER TABLE tickets ADD COLUMN attachment_url TEXT;

ALTER TABLE users ADD COLUMN is_active BOOLEAN DEFAULT true;

ALTER TABLE ticket_history ADD COLUMN performed_by_id UUID REFERENCES users(id) ON DELETE SET NULL;

CREATE OR REPLACE FUNCTION update_modified_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_ticket_modtime
    BEFORE UPDATE ON tickets
    FOR EACH ROW
    EXECUTE PROCEDURE update_modified_column();


-- Update existing tickets with old statuses
UPDATE tickets SET status = 'closed' WHERE status = 'resolved';
UPDATE tickets SET status = 'open' WHERE status = 'pending';
-- Drop old constraint and add new one
ALTER TABLE tickets DROP CONSTRAINT IF EXISTS tickets_status_check;
ALTER TABLE tickets ADD CONSTRAINT tickets_status_check
  CHECK (status IN ('open', 'in progress', 'closed'));