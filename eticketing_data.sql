SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- \restrict eirfHjG91yAUxCPgvjsM4dNpbTmAB7MCN6wiv39gsrnsql4ryjxE2ytbfQPD5nZ

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: custom_oauth_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: webauthn_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: webauthn_credentials; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."users" ("id", "name", "email", "username", "password", "role", "department", "avatar", "phone", "created_at", "is_active") VALUES
	('11111111-0000-0000-0000-000000000001', 'Admin Utama', 'admin@mail.com', 'admin', 'admin123', 'admin', 'IT', 'AU', '086789012345', '2026-06-04 07:22:29.829283+00', true),
	('33333333-0000-0000-0000-000000000002', 'Siti Rahayu', 'siti@mail.com', 'siti', '123456', 'user', 'HR', 'SR', '082345678901', '2026-06-04 07:22:29.829283+00', true),
	('33333333-0000-0000-0000-000000000003', 'Andi Wijaya', 'andi@mail.com', 'andi', '123456', 'user', 'Marketing', 'AW', '083456789012', '2026-06-04 07:22:29.829283+00', true),
	('22222222-0000-0000-0000-000000000001', 'Rizki Prasetyo', 'rizki@mail.com', 'rizki', '123456', 'helpdesk', 'IT Support', 'RI', '084567890123', '2026-06-04 07:22:29.829283+00', true),
	('33333333-0000-0000-0000-000000000001', 'Budi Santoso', 'budi@mail.com', 'budi', '123456', 'user', 'Finance', 'BU', '081234567890', '2026-06-04 07:22:29.829283+00', true),
	('22222222-0000-0000-0000-000000000002', 'Dewi Kusuma', 'dewi@mail.com', 'dewi', '123456', 'helpdesk', 'IT Support', 'DK', '085678901234', '2026-06-04 07:22:29.829283+00', true);


--
-- Data for Name: tickets; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."tickets" ("id", "title", "description", "category", "priority", "status", "created_by_id", "created_by_name", "assigned_to_id", "assigned_to_name", "created_at", "updated_at", "attachment_url") VALUES
	('TKT-001', 'Laptop tidak bisa menyala', 'Laptop saya tiba-tiba tidak mau menyala setelah update Windows kemarin. Sudah dicoba restart tapi tetap tidak bisa.', 'Hardware', 'high', 'in progress', '33333333-0000-0000-0000-000000000001', 'Budi Santoso', '22222222-0000-0000-0000-000000000001', 'Rizky Prasetyo', '2026-06-02 04:22:29.829283+00', '2026-06-04 02:22:29.829283+00', NULL),
	('TKT-002', 'Email tidak bisa terkirim', 'Saat mencoba mengirim email ke klien, selalu muncul error "SMTP connection failed". Ini sudah berlangsung sejak 2 hari lalu.', 'Software', 'medium', 'open', '33333333-0000-0000-0000-000000000002', 'Siti Rahayu', NULL, NULL, '2026-06-03 07:22:29.829283+00', '2026-06-03 07:22:29.829283+00', NULL),
	('TKT-006', 'Monitor berkedip-kedip', 'Monitor di meja saya berkedip-kedip sejak kemarin. Sudah ganti kabel tapi masih sama.', 'Hardware', 'medium', 'open', '33333333-0000-0000-0000-000000000003', 'Andi Wijaya', NULL, NULL, '2026-06-03 19:22:29.829283+00', '2026-06-03 19:22:29.829283+00', NULL),
	('TKT-008', 'Monitor kedap kedip', 'KUrang enak dilihat', 'Hardware', 'medium', 'closed', '33333333-0000-0000-0000-000000000001', 'Budi Santoso', '22222222-0000-0000-0000-000000000001', 'Rizki Prasetyo', '2026-06-12 03:33:00.155172+00', '2026-07-06 16:17:06.630051+00', NULL),
	('TKT-009', 'Keyboard ngelag', 'keyboard saya kalau ketik n dan m gabisa mas', 'Hardware', 'low', 'closed', '33333333-0000-0000-0000-000000000001', 'Budi Santoso', '22222222-0000-0000-0000-000000000001', 'Rizki Prasetyo', '2026-07-05 13:48:03.14938+00', '2026-07-06 16:17:10.019778+00', NULL),
	('TKT-005', 'Software akuntansi crash', 'Aplikasi Accurate versi terbaru sering crash ketika membuka laporan bulanan. Sudah coba reinstall tapi masalah tetap ada.', 'Software', 'high', 'open', '33333333-0000-0000-0000-000000000002', 'Siti Rahayu', '22222222-0000-0000-0000-000000000001', 'Rizky Prasetyo', '2026-05-25 07:22:29.829283+00', '2026-06-04 15:27:26.76747+00', NULL),
	('TKT-007', 'Keyboard saya rusak dan akhirnya saya patahin', 'INI USERNYA LAGI DEPRESI MAKANYA MENGAMBIL TINDAKAN BEGITU', 'Hardware', 'medium', 'in progress', '33333333-0000-0000-0000-000000000001', 'Budi Santoso', '22222222-0000-0000-0000-000000000001', 'Rizki Prasetyo', '2026-06-04 08:29:35.910816+00', '2026-06-04 15:31:33.241956+00', NULL),
	('TKT-011', 'HP saya retak', 'habis jatuh dari kamar mandi', 'Hardware', 'high', 'closed', '33333333-0000-0000-0000-000000000001', 'Budi Santoso', '22222222-0000-0000-0000-000000000001', 'Rizki Prasetyo', '2026-07-06 16:38:46.253754+00', '2026-07-06 16:42:53.358322+00', NULL),
	('TKT-003', 'Printer offline di lantai 3', 'Printer Canon IP2770 di ruang Marketing lantai 3 menampilkan status offline dan tidak bisa digunakan.', 'Hardware', 'low', 'closed', '33333333-0000-0000-0000-000000000003', 'Andi Wijaya', '22222222-0000-0000-0000-000000000002', 'Dewi Kusuma', '2026-05-30 07:22:29.829283+00', '2026-07-03 14:06:56.154753+00', NULL),
	('TKT-004', 'Akses VPN gagal', 'Tidak bisa terhubung ke VPN perusahaan saat bekerja dari rumah. Error yang muncul: "Authentication failed".', 'Network', 'high', 'open', '33333333-0000-0000-0000-000000000001', 'Budi Santoso', NULL, NULL, '2026-06-04 01:22:29.829283+00', '2026-07-03 14:06:56.154753+00', NULL),
	('TKT-010', 'Mouse saya cursornya hilang', 'Ini kejadian beberapa hari ini', 'Hardware', 'low', 'in progress', '33333333-0000-0000-0000-000000000001', 'Budi Santoso', '22222222-0000-0000-0000-000000000002', 'Dewi Kusuma', '2026-07-06 16:11:51.961393+00', '2026-07-06 16:15:26.362253+00', NULL);


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."comments" ("id", "ticket_id", "author_id", "author_name", "author_role", "content", "created_at") VALUES
	('81e6c5ff-2905-4ff5-9d43-cd6556b14025', 'TKT-001', '22222222-0000-0000-0000-000000000001', 'Rizky Prasetyo', 'helpdesk', 'Halo Pak Budi, saya sedang memeriksa masalah ini. Bisa tolong coba tekan tombol power selama 30 detik?', '2026-06-03 21:22:29.829283+00'),
	('873af758-a42a-4cef-8b8d-55cb5f47523a', 'TKT-001', '33333333-0000-0000-0000-000000000001', 'Budi Santoso', 'user', 'Sudah dicoba tapi masih tidak bisa menyala Pak.', '2026-06-03 23:22:29.829283+00'),
	('813aa131-7468-41b3-8248-145e7b196f33', 'TKT-003', '22222222-0000-0000-0000-000000000002', 'Dewi Kusuma', 'helpdesk', 'Printer sudah diperbaiki. Masalahnya adalah kabel USB yang longgar. Silakan coba lagi.', '2026-06-03 07:22:29.829283+00'),
	('444d3658-4353-4dcb-8d62-991c5197043e', 'TKT-005', '22222222-0000-0000-0000-000000000001', 'Rizky Prasetyo', 'helpdesk', 'Masalah sudah diselesaikan dengan update driver graphics card. Harap konfirmasi.', '2026-05-28 05:22:29.829283+00'),
	('5da8c224-346a-442e-8128-6ce5ce4ac100', 'TKT-005', '33333333-0000-0000-0000-000000000002', 'Siti Rahayu', 'user', 'Sudah berjalan normal. Terima kasih!', '2026-05-28 07:22:29.829283+00'),
	('93f87fb9-1705-4608-b5d7-257dedf2d96f', 'TKT-007', '11111111-0000-0000-0000-000000000001', 'Admin Utama', 'admin', 'njir', '2026-06-04 08:30:40.706376+00'),
	('a12a0cf4-967a-40e0-a868-c1140729c911', 'TKT-007', '11111111-0000-0000-0000-000000000001', 'Admin Utama', 'admin', 'lu apain sample gitu bang', '2026-06-04 08:30:49.897055+00'),
	('a14578c7-3620-424c-9372-d36f928e5c66', 'TKT-008', '11111111-0000-0000-0000-000000000001', 'Admin Utama', 'admin', 'monitornya jelek mas', '2026-06-12 03:34:50.238321+00'),
	('75749067-2c2d-4b57-bbe3-34dff5954b9b', 'TKT-009', '22222222-0000-0000-0000-000000000001', 'Rizki Prasetyo', 'helpdesk', 'woi', '2026-07-05 14:28:17.803107+00'),
	('10f0080d-b76f-4e00-96a4-6d99f7abccd8', 'TKT-009', '22222222-0000-0000-0000-000000000001', 'Rizki Prasetyo', 'helpdesk', 'keyboard lu jelek', '2026-07-05 14:28:27.406887+00'),
	('5c911f59-e90b-465a-a261-258e25b3efe2', 'TKT-009', '22222222-0000-0000-0000-000000000001', 'Rizki Prasetyo', 'helpdesk', 'ganti aja', '2026-07-05 14:28:35.40099+00'),
	('0c474df5-bd8b-4f5f-831e-6ef86f42cce1', 'TKT-010', '22222222-0000-0000-0000-000000000001', 'Rizki Prasetyo', 'helpdesk', 'ini mosuenya baik baik aja mas', '2026-07-06 16:13:45.022153+00'),
	('450613f9-bc30-40f7-9ee8-aeb3c0273450', 'TKT-011', '22222222-0000-0000-0000-000000000001', 'Rizki Prasetyo', 'helpdesk', 'kenapa tuh mas', '2026-07-06 16:39:39.284644+00'),
	('9d4190e7-8528-49c7-af15-a4e6fd2b25b5', 'TKT-011', '11111111-0000-0000-0000-000000000001', 'Admin Utama', 'admin', 'ada ada sja mas ini', '2026-07-06 16:41:16.62361+00');


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."notifications" ("id", "title", "body", "ticket_id", "type", "is_read", "user_id", "created_at") VALUES
	('7f65af14-3e01-47f1-92ad-c412f39d088f', 'Tiket TKT-003 diselesaikan', 'Tiket "Printer offline di lantai 3" telah diselesaikan', 'TKT-003', 'resolved', true, '33333333-0000-0000-0000-000000000003', '2026-06-03 07:22:29.829283+00'),
	('6b756213-04ed-4654-954f-a5e424a4345d', 'Status tiket diperbarui', 'Status "Software akuntansi crash" diubah menjadi Open', 'TKT-005', 'status_update', false, '22222222-0000-0000-0000-000000000002', '2026-06-04 08:06:24.724969+00'),
	('0636a6d2-1514-410f-b9d3-327f6a78a353', 'Status tiket diperbarui', 'Status "Software akuntansi crash" diubah menjadi Open', 'TKT-005', 'status_update', false, '33333333-0000-0000-0000-000000000002', '2026-06-04 08:06:24.945058+00'),
	('53d08293-a05e-4b5e-998b-6a5963379f9b', 'Status tiket diperbarui', 'Status "Software akuntansi crash" diubah menjadi In Progress', 'TKT-005', 'status_update', false, '22222222-0000-0000-0000-000000000002', '2026-06-04 08:27:21.803518+00'),
	('1e708fd6-fc05-4b0d-83f8-14a67c9b0719', 'Status tiket diperbarui', 'Status "Software akuntansi crash" diubah menjadi In Progress', 'TKT-005', 'status_update', false, '22222222-0000-0000-0000-000000000002', '2026-06-04 08:27:22.015009+00'),
	('6ab3ba0b-ad46-4105-a33f-1f9eacfb8fa7', 'Status tiket diperbarui', 'Status "Software akuntansi crash" diubah menjadi In Progress', 'TKT-005', 'status_update', false, '33333333-0000-0000-0000-000000000002', '2026-06-04 08:27:22.050676+00'),
	('a05f4180-acef-422d-b48b-8a4e8230daa4', 'Status tiket diperbarui', 'Status "Software akuntansi crash" diubah menjadi In Progress', 'TKT-005', 'status_update', false, '22222222-0000-0000-0000-000000000002', '2026-06-04 08:27:22.061166+00'),
	('0d2eddd5-084b-4ac8-a96e-1d96c5ea3a90', 'Status tiket diperbarui', 'Status "Software akuntansi crash" diubah menjadi In Progress', 'TKT-005', 'status_update', false, '33333333-0000-0000-0000-000000000002', '2026-06-04 08:27:22.357268+00'),
	('c69439b4-0de2-49a3-869e-058f5867a16e', 'Status tiket diperbarui', 'Status "Software akuntansi crash" diubah menjadi Resolved', 'TKT-005', 'status_update', false, '22222222-0000-0000-0000-000000000002', '2026-06-04 08:27:22.36217+00'),
	('dfeee7ac-5f2e-40a2-90b0-49ff0a4c6b72', 'Status tiket diperbarui', 'Status "Software akuntansi crash" diubah menjadi In Progress', 'TKT-005', 'status_update', false, '33333333-0000-0000-0000-000000000002', '2026-06-04 08:27:22.370403+00'),
	('22e73e47-213f-4fbc-881d-9e0820ebabc5', 'Status tiket diperbarui', 'Status "Software akuntansi crash" diubah menjadi Resolved', 'TKT-005', 'status_update', false, '33333333-0000-0000-0000-000000000002', '2026-06-04 08:27:22.658665+00'),
	('eb65a41b-f649-4e13-a5ce-ea84e4e3a4ea', 'Status tiket diperbarui', 'Status "Software akuntansi crash" diubah menjadi Closed', 'TKT-005', 'status_update', false, '22222222-0000-0000-0000-000000000002', '2026-06-04 08:27:23.194623+00'),
	('baa18eb8-f9e5-48f6-835b-e661e7cc9063', 'Status tiket diperbarui', 'Status "Software akuntansi crash" diubah menjadi Closed', 'TKT-005', 'status_update', false, '33333333-0000-0000-0000-000000000002', '2026-06-04 08:27:23.744858+00'),
	('7a4a7e6a-ae6f-4c00-a760-23e6f5cf19f4', 'Status tiket diperbarui', 'Status "Software akuntansi crash" diubah menjadi Open', 'TKT-005', 'status_update', false, '22222222-0000-0000-0000-000000000002', '2026-06-04 08:27:30.138418+00'),
	('fba79759-a1f5-4773-a304-76827bf3c1da', 'Status tiket diperbarui', 'Status "Software akuntansi crash" diubah menjadi Open', 'TKT-005', 'status_update', false, '33333333-0000-0000-0000-000000000002', '2026-06-04 08:27:30.367783+00'),
	('fd4611e6-6737-4846-90a1-cf206b2e0bce', 'Tiket baru dibuat', 'Tiket "Keyboard saya rusak dan akhirnya saya patahin" berhasil dibuat', 'TKT-007', 'new_ticket', false, '22222222-0000-0000-0000-000000000002', '2026-06-04 08:29:36.288936+00'),
	('7f30bc00-10c5-4dc8-a1c5-40b743382453', 'Komentar baru', 'Admin Utama menambahkan komentar pada tiket "Keyboard saya rusak dan akhirnya saya patahin"', 'TKT-007', 'new_comment', false, '22222222-0000-0000-0000-000000000002', '2026-06-04 08:30:41.27094+00'),
	('dd1443ab-befb-46ca-9f6c-e6dc5847537c', 'Komentar baru', 'Admin Utama menambahkan komentar pada tiket "Keyboard saya rusak dan akhirnya saya patahin"', 'TKT-007', 'new_comment', false, '22222222-0000-0000-0000-000000000002', '2026-06-04 08:30:50.452427+00'),
	('636ebec3-8d24-42a1-b020-3f3928a70eea', 'Status tiket diperbarui', 'Status "Keyboard saya rusak dan akhirnya saya patahin" diubah menjadi In Progress', 'TKT-007', 'status_update', false, '22222222-0000-0000-0000-000000000002', '2026-06-04 08:31:30.431524+00'),
	('9797cc76-2f15-4688-ab84-f13df276c5e5', 'Komentar baru di TKT-001', 'Rizky Prasetyo menambahkan komentar pada tiket Anda', 'TKT-001', 'new_comment', true, '33333333-0000-0000-0000-000000000001', '2026-06-03 23:22:29.829283+00'),
	('b7e46464-472c-40a8-a9a2-61329d8cb5df', 'Status tiket diperbarui', 'Status "Software akuntansi crash" diubah menjadi Open', 'TKT-005', 'status_update', true, '22222222-0000-0000-0000-000000000001', '2026-06-04 08:06:24.837245+00'),
	('690fa556-8cf6-44fb-9f3c-0403de526b22', 'Status tiket diperbarui', 'Status "Software akuntansi crash" diubah menjadi In Progress', 'TKT-005', 'status_update', true, '22222222-0000-0000-0000-000000000001', '2026-06-04 08:27:21.931432+00'),
	('16775b30-e444-4631-87ae-7ed81680004a', 'Status tiket diperbarui', 'Status "Software akuntansi crash" diubah menjadi In Progress', 'TKT-005', 'status_update', true, '22222222-0000-0000-0000-000000000001', '2026-06-04 08:27:22.205754+00'),
	('7854bdf1-1a4a-4c62-a729-4b1faae3136d', 'Status tiket diperbarui', 'Status "Software akuntansi crash" diubah menjadi In Progress', 'TKT-005', 'status_update', true, '22222222-0000-0000-0000-000000000001', '2026-06-04 08:27:22.220402+00'),
	('225ddb18-8c87-4cea-b91b-cc7fe1acb8ed', 'Status tiket diperbarui', 'Status "Software akuntansi crash" diubah menjadi Open', 'TKT-005', 'status_update', true, '11111111-0000-0000-0000-000000000001', '2026-06-04 08:06:24.612406+00'),
	('8369d43e-e3e7-4617-a8a6-7d3c4ceab363', 'Status tiket diperbarui', 'Status "Software akuntansi crash" diubah menjadi In Progress', 'TKT-005', 'status_update', true, '11111111-0000-0000-0000-000000000001', '2026-06-04 08:27:21.68075+00'),
	('306f500d-3096-4f29-bbd8-78aae6db3bbb', 'Status tiket diperbarui', 'Status "Software akuntansi crash" diubah menjadi In Progress', 'TKT-005', 'status_update', true, '11111111-0000-0000-0000-000000000001', '2026-06-04 08:27:21.878339+00'),
	('8a28783a-1f60-4b54-ae15-e67f040e53cb', 'Status tiket diperbarui', 'Status "Software akuntansi crash" diubah menjadi In Progress', 'TKT-005', 'status_update', true, '11111111-0000-0000-0000-000000000001', '2026-06-04 08:27:21.940602+00'),
	('2a368ce3-ec15-454b-ad75-da89d676a7f6', 'Status tiket diperbarui', 'Status "Software akuntansi crash" diubah menjadi Resolved', 'TKT-005', 'status_update', true, '11111111-0000-0000-0000-000000000001', '2026-06-04 08:27:22.196905+00'),
	('9511c180-d565-42f0-8c6b-a79206e3f83d', 'Status tiket diperbarui', 'Status "Software akuntansi crash" diubah menjadi Closed', 'TKT-005', 'status_update', true, '11111111-0000-0000-0000-000000000001', '2026-06-04 08:27:22.69706+00'),
	('e548b88a-aa3c-48d9-a6c6-14273d4b13bd', 'Status tiket diperbarui', 'Status "Software akuntansi crash" diubah menjadi Open', 'TKT-005', 'status_update', true, '11111111-0000-0000-0000-000000000001', '2026-06-04 08:27:30.013754+00'),
	('cf4a88c3-1418-43fe-98fa-797255df6171', 'Tiket baru dibuat', 'Tiket "Keyboard saya rusak dan akhirnya saya patahin" berhasil dibuat', 'TKT-007', 'new_ticket', true, '11111111-0000-0000-0000-000000000001', '2026-06-04 08:29:36.169348+00'),
	('0bd9ada2-1791-4e4b-baac-c3d4ef742239', 'Komentar baru', 'Admin Utama menambahkan komentar pada tiket "Keyboard saya rusak dan akhirnya saya patahin"', 'TKT-007', 'new_comment', true, '11111111-0000-0000-0000-000000000001', '2026-06-04 08:30:41.12585+00'),
	('a0d949e3-e775-4eae-9e81-e889db37c061', 'Status tiket diperbarui', 'Status "Keyboard saya rusak dan akhirnya saya patahin" diubah menjadi In Progress', 'TKT-007', 'status_update', true, '22222222-0000-0000-0000-000000000001', '2026-06-04 08:31:30.56999+00'),
	('879806d2-6f48-4d3b-9ac8-a3ff6d6bed9a', 'Tiket baru dibuat', 'Tiket "Monitor kedap kedip" berhasil dibuat', 'TKT-008', 'new_ticket', false, '22222222-0000-0000-0000-000000000002', '2026-06-12 03:33:00.670857+00'),
	('8ff3544f-5b5f-4b4e-a8a3-8d809a2c7665', 'Komentar baru', 'Admin Utama menambahkan komentar pada tiket "Monitor kedap kedip"', 'TKT-008', 'new_comment', false, '22222222-0000-0000-0000-000000000002', '2026-06-12 03:34:51.470984+00'),
	('8968f38a-b9ed-4a26-877d-8be5cbc3123c', 'Status tiket diperbarui', 'Status "Software akuntansi crash" diubah menjadi Resolved', 'TKT-005', 'status_update', true, '22222222-0000-0000-0000-000000000001', '2026-06-04 08:27:22.508665+00'),
	('3c8bfa4a-9bd4-4944-8547-b22d06136b7c', 'Tiket TKT-001 diperbarui', 'Status tiket "Laptop tidak bisa menyala" diubah menjadi In Progress', 'TKT-001', 'status_update', true, '33333333-0000-0000-0000-000000000001', '2026-06-03 21:22:29.829283+00'),
	('ef6b3a10-7306-4020-80ec-fc0833d7fa4a', 'Komentar baru', 'Admin Utama menambahkan komentar pada tiket "Keyboard saya rusak dan akhirnya saya patahin"', 'TKT-007', 'new_comment', true, '33333333-0000-0000-0000-000000000001', '2026-06-04 08:30:41.552156+00'),
	('fe308bfa-f453-4bbf-b96e-6c7d9aa1d6c4', 'Komentar baru', 'Admin Utama menambahkan komentar pada tiket "Keyboard saya rusak dan akhirnya saya patahin"', 'TKT-007', 'new_comment', true, '33333333-0000-0000-0000-000000000001', '2026-06-04 08:30:50.715503+00'),
	('5709dc93-51d0-48aa-b317-b12de5f207ed', 'Status tiket diperbarui', 'Status "Software akuntansi crash" diubah menjadi Closed', 'TKT-005', 'status_update', true, '22222222-0000-0000-0000-000000000001', '2026-06-04 08:27:23.38855+00'),
	('8c88acf2-1d62-4ce2-88df-f5ad060995e2', 'Status tiket diperbarui', 'Status "Software akuntansi crash" diubah menjadi Open', 'TKT-005', 'status_update', true, '22222222-0000-0000-0000-000000000001', '2026-06-04 08:27:30.252102+00'),
	('066073dd-0737-4dc1-9128-c6861f3732fb', 'Tiket baru dibuat', 'Tiket "Keyboard ngelag" berhasil dibuat', 'TKT-009', 'new_ticket', false, '22222222-0000-0000-0000-000000000002', '2026-07-05 13:48:03.757834+00'),
	('44c10338-f0b9-4d3d-960e-6e70da391dd3', 'Komentar baru', 'Admin Utama menambahkan komentar pada tiket "Monitor kedap kedip"', 'TKT-008', 'new_comment', true, '33333333-0000-0000-0000-000000000001', '2026-06-12 03:34:51.812121+00'),
	('b379e7ab-49cb-4aa7-acbb-fd6a9a0172d9', 'Status tiket diperbarui', 'Status "Keyboard saya rusak dan akhirnya saya patahin" diubah menjadi In Progress', 'TKT-007', 'status_update', true, '33333333-0000-0000-0000-000000000001', '2026-06-04 08:31:30.709749+00'),
	('5956ce4b-9463-4a5a-8218-3945106562d6', 'Komentar baru', 'Rizki Prasetyo menambahkan komentar pada tiket "Keyboard ngelag"', 'TKT-009', 'new_comment', false, '22222222-0000-0000-0000-000000000002', '2026-07-05 14:28:18.515848+00'),
	('93ed84db-aacd-4cbc-b2e2-a4d6035280dd', 'Komentar baru', 'Rizki Prasetyo menambahkan komentar pada tiket "Keyboard ngelag"', 'TKT-009', 'new_comment', false, '33333333-0000-0000-0000-000000000001', '2026-07-05 14:28:18.887451+00'),
	('b86bbdf2-288d-4908-b3bc-d3196998d6b1', 'Komentar baru', 'Rizki Prasetyo menambahkan komentar pada tiket "Keyboard ngelag"', 'TKT-009', 'new_comment', false, '22222222-0000-0000-0000-000000000002', '2026-07-05 14:28:28.145149+00'),
	('7c0c7b91-0715-4b90-ade7-4852d99713c0', 'Komentar baru', 'Rizki Prasetyo menambahkan komentar pada tiket "Keyboard ngelag"', 'TKT-009', 'new_comment', false, '33333333-0000-0000-0000-000000000001', '2026-07-05 14:28:28.462262+00'),
	('7b3a75a7-85de-45ea-a1a1-842c6a00cf72', 'Komentar baru', 'Rizki Prasetyo menambahkan komentar pada tiket "Keyboard ngelag"', 'TKT-009', 'new_comment', false, '22222222-0000-0000-0000-000000000002', '2026-07-05 14:28:36.116428+00'),
	('8bcaa187-d935-466e-b4da-b005d8d7a90a', 'Komentar baru', 'Rizki Prasetyo menambahkan komentar pada tiket "Keyboard ngelag"', 'TKT-009', 'new_comment', false, '33333333-0000-0000-0000-000000000001', '2026-07-05 14:28:36.468365+00'),
	('337e9f49-e21c-4fb6-942c-20ebc9cf6d75', 'Tiket baru dibuat', 'Tiket "Mouse saya cursornya hilang" berhasil dibuat', 'TKT-010', 'new_ticket', false, '22222222-0000-0000-0000-000000000002', '2026-07-06 16:11:52.980129+00'),
	('dbcca51f-6c45-4df0-8b25-29f102a1d8fc', 'Komentar baru', 'Rizki Prasetyo menambahkan komentar pada tiket "Mouse saya cursornya hilang"', 'TKT-010', 'new_comment', false, '22222222-0000-0000-0000-000000000002', '2026-07-06 16:13:46.071302+00'),
	('c0453399-c9ab-4868-b6cb-98e26e9d3ef0', 'Komentar baru', 'Rizki Prasetyo menambahkan komentar pada tiket "Mouse saya cursornya hilang"', 'TKT-010', 'new_comment', false, '33333333-0000-0000-0000-000000000001', '2026-07-06 16:13:46.424155+00'),
	('d9bd49ab-1684-4355-b852-956e995aa394', 'Tiket selesai', 'Tiket "Monitor kedap kedip" telah diselesaikan', 'TKT-008', 'status_update', false, '22222222-0000-0000-0000-000000000002', '2026-07-06 16:17:07.106028+00'),
	('cce11e46-4500-43ce-bbdc-06e35943f1d4', 'Tiket selesai', 'Tiket "Monitor kedap kedip" telah diselesaikan', 'TKT-008', 'status_update', false, '33333333-0000-0000-0000-000000000001', '2026-07-06 16:17:07.37509+00'),
	('5e87c42f-26d5-4af2-8099-92ef63640b5e', 'Tiket selesai', 'Tiket "Keyboard ngelag" telah diselesaikan', 'TKT-009', 'status_update', false, '22222222-0000-0000-0000-000000000002', '2026-07-06 16:17:10.411963+00'),
	('33bef54a-e691-4e49-b36f-e63ed99932a3', 'Tiket selesai', 'Tiket "Keyboard ngelag" telah diselesaikan', 'TKT-009', 'status_update', false, '33333333-0000-0000-0000-000000000001', '2026-07-06 16:17:10.681721+00'),
	('6ea435cb-d73c-48c9-8c3e-4433659be231', 'Tiket baru dibuat', 'Tiket "Keyboard saya rusak dan akhirnya saya patahin" berhasil dibuat', 'TKT-007', 'new_ticket', true, '22222222-0000-0000-0000-000000000001', '2026-06-04 08:29:36.40197+00'),
	('99b96dc9-7a77-4709-90a7-09712231928f', 'Komentar baru', 'Admin Utama menambahkan komentar pada tiket "Keyboard saya rusak dan akhirnya saya patahin"', 'TKT-007', 'new_comment', true, '22222222-0000-0000-0000-000000000001', '2026-06-04 08:30:41.40419+00'),
	('2cc65ede-dd51-4aae-bc14-79ca49d84b4a', 'Komentar baru', 'Admin Utama menambahkan komentar pada tiket "Keyboard saya rusak dan akhirnya saya patahin"', 'TKT-007', 'new_comment', true, '22222222-0000-0000-0000-000000000001', '2026-06-04 08:30:50.581733+00'),
	('458f02f0-e30f-4aa1-85b2-408b7eb146ab', 'Tiket baru dibuat', 'Tiket "Monitor kedap kedip" berhasil dibuat', 'TKT-008', 'new_ticket', true, '22222222-0000-0000-0000-000000000001', '2026-06-12 03:33:00.824144+00'),
	('a123d6d7-a03f-4321-bb2c-710aff1153e9', 'Tiket baru dibuat', 'Tiket "Monitor kedap kedip" berhasil dibuat', 'TKT-008', 'new_ticket', true, '11111111-0000-0000-0000-000000000001', '2026-06-12 03:33:00.511651+00'),
	('0035768c-af11-4380-9562-ee3f02cf70f4', 'Komentar baru', 'Admin Utama menambahkan komentar pada tiket "Monitor kedap kedip"', 'TKT-008', 'new_comment', true, '11111111-0000-0000-0000-000000000001', '2026-06-12 03:34:51.310779+00'),
	('d98eacc3-4e39-44de-abf5-02401f0886fe', 'Tiket baru dibuat', 'Tiket "Keyboard ngelag" berhasil dibuat', 'TKT-009', 'new_ticket', true, '11111111-0000-0000-0000-000000000001', '2026-07-05 13:48:03.60713+00'),
	('d00d64d0-5c78-443f-b9f0-5f1cdcd83037', 'Komentar baru', 'Rizki Prasetyo menambahkan komentar pada tiket "Keyboard ngelag"', 'TKT-009', 'new_comment', true, '11111111-0000-0000-0000-000000000001', '2026-07-05 14:28:18.345145+00'),
	('3f150612-7d43-4b83-95b8-429ec871d0b9', 'Komentar baru', 'Rizki Prasetyo menambahkan komentar pada tiket "Keyboard ngelag"', 'TKT-009', 'new_comment', true, '11111111-0000-0000-0000-000000000001', '2026-07-05 14:28:27.980305+00'),
	('b7c71f9a-5b0f-4774-869e-24a1162fe601', 'Komentar baru', 'Rizki Prasetyo menambahkan komentar pada tiket "Keyboard ngelag"', 'TKT-009', 'new_comment', true, '11111111-0000-0000-0000-000000000001', '2026-07-05 14:28:35.934143+00'),
	('81385a4e-2f84-4991-88ba-243c59113339', 'Tiket baru dibuat', 'Tiket "Mouse saya cursornya hilang" berhasil dibuat', 'TKT-010', 'new_ticket', true, '11111111-0000-0000-0000-000000000001', '2026-07-06 16:11:52.649356+00'),
	('1ca4a348-b6e2-481b-996c-c1274df1235c', 'Komentar baru', 'Rizki Prasetyo menambahkan komentar pada tiket "Mouse saya cursornya hilang"', 'TKT-010', 'new_comment', true, '11111111-0000-0000-0000-000000000001', '2026-07-06 16:13:45.694491+00'),
	('c84f4f39-7626-4b6c-bb30-993a1a23b2b7', 'Tiket selesai', 'Tiket "Monitor kedap kedip" telah diselesaikan', 'TKT-008', 'status_update', true, '11111111-0000-0000-0000-000000000001', '2026-07-06 16:17:06.963769+00'),
	('db374fec-f1f7-40a3-bb07-ee79186d143b', 'Komentar baru', 'Admin Utama menambahkan komentar pada tiket "Monitor kedap kedip"', 'TKT-008', 'new_comment', true, '22222222-0000-0000-0000-000000000001', '2026-06-12 03:34:51.644181+00'),
	('b175f304-8170-4081-848b-c42cd44b4fa7', 'Tiket baru dibuat', 'Tiket "Keyboard ngelag" berhasil dibuat', 'TKT-009', 'new_ticket', true, '22222222-0000-0000-0000-000000000001', '2026-07-05 13:48:04.034392+00'),
	('fd92eb42-bc49-4fcb-872c-560532a74a07', 'Komentar baru', 'Rizki Prasetyo menambahkan komentar pada tiket "Keyboard ngelag"', 'TKT-009', 'new_comment', true, '22222222-0000-0000-0000-000000000001', '2026-07-05 14:28:18.708217+00'),
	('39e4b134-688e-49bd-a8bc-689ae619ba75', 'Komentar baru', 'Rizki Prasetyo menambahkan komentar pada tiket "Keyboard ngelag"', 'TKT-009', 'new_comment', true, '22222222-0000-0000-0000-000000000001', '2026-07-05 14:28:28.305085+00'),
	('edc6de93-2df8-4606-9682-748a8335319d', 'Komentar baru', 'Rizki Prasetyo menambahkan komentar pada tiket "Keyboard ngelag"', 'TKT-009', 'new_comment', true, '22222222-0000-0000-0000-000000000001', '2026-07-05 14:28:36.283964+00'),
	('33c77c48-2461-4ceb-a0c1-0283ecb84bb2', 'Tiket baru dibuat', 'Tiket "Mouse saya cursornya hilang" berhasil dibuat', 'TKT-010', 'new_ticket', true, '22222222-0000-0000-0000-000000000001', '2026-07-06 16:11:53.333198+00'),
	('d0bb8c6c-2084-402d-be2a-4572d25667bd', 'Komentar baru', 'Rizki Prasetyo menambahkan komentar pada tiket "Mouse saya cursornya hilang"', 'TKT-010', 'new_comment', true, '22222222-0000-0000-0000-000000000001', '2026-07-06 16:13:46.235645+00'),
	('2771688a-2991-4efb-8785-4a566124cbf6', 'Tiket selesai', 'Tiket "Monitor kedap kedip" telah diselesaikan', 'TKT-008', 'status_update', true, '22222222-0000-0000-0000-000000000001', '2026-07-06 16:17:07.239824+00'),
	('3f682310-5a30-4fac-a2c3-25e8ffc87ef9', 'Tiket selesai', 'Tiket "Keyboard ngelag" telah diselesaikan', 'TKT-009', 'status_update', true, '22222222-0000-0000-0000-000000000001', '2026-07-06 16:17:10.547277+00'),
	('93f46064-dbe5-4280-9965-65021318746c', 'Tiket baru dibuat', 'Tiket "HP saya retak" berhasil dibuat', 'TKT-011', 'new_ticket', false, '22222222-0000-0000-0000-000000000002', '2026-07-06 16:38:46.964171+00'),
	('d85a2333-0c24-4a12-acb5-e7173947e767', 'Tiket baru dibuat', 'Tiket "HP saya retak" berhasil dibuat', 'TKT-011', 'new_ticket', false, '22222222-0000-0000-0000-000000000001', '2026-07-06 16:38:47.147595+00'),
	('a0f44129-82a9-4e92-9600-7716e42f3d6e', 'Komentar baru', 'Rizki Prasetyo menambahkan komentar pada tiket "HP saya retak"', 'TKT-011', 'new_comment', false, '22222222-0000-0000-0000-000000000002', '2026-07-06 16:39:39.914645+00'),
	('bdb32d30-8a42-417a-a5b3-1e43fa424670', 'Komentar baru', 'Rizki Prasetyo menambahkan komentar pada tiket "HP saya retak"', 'TKT-011', 'new_comment', false, '22222222-0000-0000-0000-000000000001', '2026-07-06 16:39:40.065025+00'),
	('74473406-5e84-4cc9-aeaa-cb820859f506', 'Komentar baru', 'Rizki Prasetyo menambahkan komentar pada tiket "HP saya retak"', 'TKT-011', 'new_comment', false, '33333333-0000-0000-0000-000000000001', '2026-07-06 16:39:40.20309+00'),
	('647b3850-9497-43c5-9e13-f121219b052e', 'Komentar baru', 'Admin Utama menambahkan komentar pada tiket "HP saya retak"', 'TKT-011', 'new_comment', false, '22222222-0000-0000-0000-000000000001', '2026-07-06 16:41:17.658661+00'),
	('edffb139-3ba7-4b95-bc5c-0edd29402596', 'Komentar baru', 'Admin Utama menambahkan komentar pada tiket "HP saya retak"', 'TKT-011', 'new_comment', false, '22222222-0000-0000-0000-000000000002', '2026-07-06 16:41:17.813507+00'),
	('8fd95e05-44bc-43c6-bb80-8204594ef61e', 'Komentar baru', 'Admin Utama menambahkan komentar pada tiket "HP saya retak"', 'TKT-011', 'new_comment', false, '33333333-0000-0000-0000-000000000001', '2026-07-06 16:41:17.971399+00'),
	('4333d946-33ff-424f-9552-472854afd5c3', 'Status tiket diperbarui', 'Status "HP saya retak" diubah menjadi Closed', 'TKT-011', 'status_update', false, '22222222-0000-0000-0000-000000000001', '2026-07-06 16:41:31.287457+00'),
	('1a1c0533-3776-4316-8523-a5c256e53600', 'Status tiket diperbarui', 'Status "HP saya retak" diubah menjadi Closed', 'TKT-011', 'status_update', false, '22222222-0000-0000-0000-000000000002', '2026-07-06 16:41:31.411527+00'),
	('a22826e1-9034-4276-84ee-ab32a662f108', 'Status tiket diperbarui', 'Status "HP saya retak" diubah menjadi Closed', 'TKT-011', 'status_update', false, '33333333-0000-0000-0000-000000000001', '2026-07-06 16:41:31.538267+00'),
	('3a211b38-d50d-491d-b223-cd6951d4146a', 'Status tiket diperbarui', 'Status "HP saya retak" diubah menjadi Open', 'TKT-011', 'status_update', false, '22222222-0000-0000-0000-000000000001', '2026-07-06 16:41:36.552759+00'),
	('204e0f50-6600-42b5-bc7a-e2b23c45f54e', 'Status tiket diperbarui', 'Status "HP saya retak" diubah menjadi Open', 'TKT-011', 'status_update', false, '22222222-0000-0000-0000-000000000002', '2026-07-06 16:41:36.720276+00'),
	('3578d45d-3bd6-4809-9e7c-80a5775b08b0', 'Status tiket diperbarui', 'Status "HP saya retak" diubah menjadi Open', 'TKT-011', 'status_update', false, '33333333-0000-0000-0000-000000000001', '2026-07-06 16:41:36.90697+00'),
	('590d7e11-a5b4-4743-8080-6fc1d030c3b4', 'Komentar baru', 'Admin Utama menambahkan komentar pada tiket "Keyboard saya rusak dan akhirnya saya patahin"', 'TKT-007', 'new_comment', true, '11111111-0000-0000-0000-000000000001', '2026-06-04 08:30:50.315719+00'),
	('9c68b92e-463d-4f49-8336-39d247405906', 'Status tiket diperbarui', 'Status "Keyboard saya rusak dan akhirnya saya patahin" diubah menjadi In Progress', 'TKT-007', 'status_update', true, '11111111-0000-0000-0000-000000000001', '2026-06-04 08:31:30.292481+00'),
	('75394b7e-34ea-48db-b277-255256e31c83', 'Tiket selesai', 'Tiket "Keyboard ngelag" telah diselesaikan', 'TKT-009', 'status_update', true, '11111111-0000-0000-0000-000000000001', '2026-07-06 16:17:10.280803+00'),
	('dcd3c2c8-0f61-41e2-8d93-9b7a8e3c30d9', 'Tiket baru dibuat', 'Tiket "HP saya retak" berhasil dibuat', 'TKT-011', 'new_ticket', true, '11111111-0000-0000-0000-000000000001', '2026-07-06 16:38:46.805412+00'),
	('a26786c3-ed86-4cdf-877b-e423a887ddeb', 'Komentar baru', 'Rizki Prasetyo menambahkan komentar pada tiket "HP saya retak"', 'TKT-011', 'new_comment', true, '11111111-0000-0000-0000-000000000001', '2026-07-06 16:39:39.750724+00'),
	('26bb99e6-cb79-44eb-a553-55deb860f0d7', 'Komentar baru', 'Admin Utama menambahkan komentar pada tiket "HP saya retak"', 'TKT-011', 'new_comment', true, '11111111-0000-0000-0000-000000000001', '2026-07-06 16:41:17.522499+00'),
	('bfdf9018-dfc0-49eb-a396-484822e3b4f4', 'Status tiket diperbarui', 'Status "HP saya retak" diubah menjadi Closed', 'TKT-011', 'status_update', true, '11111111-0000-0000-0000-000000000001', '2026-07-06 16:41:31.133012+00'),
	('84131766-b2c8-4a83-8cc8-490d0467d712', 'Status tiket diperbarui', 'Status "HP saya retak" diubah menjadi Open', 'TKT-011', 'status_update', true, '11111111-0000-0000-0000-000000000001', '2026-07-06 16:41:36.350447+00'),
	('b54fa1e2-220b-4aa7-8780-01d41cd44c8e', 'Tiket selesai', 'Tiket "HP saya retak" telah diselesaikan', 'TKT-011', 'status_update', false, '11111111-0000-0000-0000-000000000001', '2026-07-06 16:42:53.636047+00'),
	('cf0bb136-43a1-47e4-a885-72c65c9b1299', 'Tiket selesai', 'Tiket "HP saya retak" telah diselesaikan', 'TKT-011', 'status_update', false, '22222222-0000-0000-0000-000000000001', '2026-07-06 16:42:53.776299+00'),
	('dbc0fa6d-54df-4ac4-a2fa-cc3b31f68f8e', 'Tiket selesai', 'Tiket "HP saya retak" telah diselesaikan', 'TKT-011', 'status_update', false, '22222222-0000-0000-0000-000000000002', '2026-07-06 16:42:53.912352+00'),
	('b8ae21a2-4807-4acd-96a3-78fc25c80db8', 'Tiket selesai', 'Tiket "HP saya retak" telah diselesaikan', 'TKT-011', 'status_update', false, '33333333-0000-0000-0000-000000000001', '2026-07-06 16:42:54.057455+00');


--
-- Data for Name: ticket_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."ticket_history" ("id", "ticket_id", "action", "performed_by", "performed_by_role", "created_at", "performed_by_id") VALUES
	('04029d75-d7af-46fc-acad-bed11e73b5d3', 'TKT-001', 'Tiket dibuat', 'Budi Santoso', 'user', '2026-06-02 04:22:29.829283+00', NULL),
	('7e4f963e-5d4f-4c53-93a5-98066f2b69d6', 'TKT-001', 'Tiket di-assign ke Rizky Prasetyo', 'Admin Utama', 'admin', '2026-06-02 07:22:29.829283+00', NULL),
	('ea360a35-d1b7-4dc1-a7a9-087a915374d6', 'TKT-001', 'Status diubah menjadi In Progress', 'Rizky Prasetyo', 'helpdesk', '2026-06-03 21:22:29.829283+00', NULL),
	('90a329e1-d8b8-4ec7-9488-e7907e51b58e', 'TKT-002', 'Tiket dibuat', 'Siti Rahayu', 'user', '2026-06-03 07:22:29.829283+00', NULL),
	('c0e21b91-f50a-462e-8e31-980108e4f196', 'TKT-003', 'Tiket dibuat', 'Andi Wijaya', 'user', '2026-05-30 07:22:29.829283+00', NULL),
	('07a12b0d-5283-4f50-94d5-fc27ef3730fd', 'TKT-003', 'Status diubah menjadi Resolved', 'Dewi Kusuma', 'helpdesk', '2026-06-03 07:22:29.829283+00', NULL),
	('9c7be315-1800-4a4c-9eba-e029d1b7b49d', 'TKT-004', 'Tiket dibuat', 'Budi Santoso', 'user', '2026-06-04 01:22:29.829283+00', NULL),
	('84ceea1a-1702-4e2b-893e-f392457571fb', 'TKT-005', 'Tiket dibuat', 'Siti Rahayu', 'user', '2026-05-25 07:22:29.829283+00', NULL),
	('b6d471ad-d1f7-4dcb-9918-797bd02b3875', 'TKT-005', 'Status diubah menjadi Closed', 'Admin Utama', 'admin', '2026-05-28 07:22:29.829283+00', NULL),
	('a6b486a4-a7e7-4fa7-9997-05cd5af8e3e6', 'TKT-006', 'Tiket dibuat', 'Andi Wijaya', 'user', '2026-06-03 19:22:29.829283+00', NULL),
	('9197cc8d-ed3f-4337-aa95-2aec61b76630', 'TKT-005', 'Status diubah menjadi Open', 'Rizki Prasetyo', 'helpdesk', '2026-06-04 08:06:24.487557+00', NULL),
	('8d1d2c09-93ee-49fa-8dbc-3ac0a8eefe8d', 'TKT-005', 'Status diubah menjadi In Progress', 'Rizki Prasetyo', 'helpdesk', '2026-06-04 08:27:21.554209+00', NULL),
	('2044587e-1863-4060-9603-64be5067f95c', 'TKT-005', 'Status diubah menjadi In Progress', 'Rizki Prasetyo', 'helpdesk', '2026-06-04 08:27:21.724652+00', NULL),
	('f157dd91-cd6f-4e0d-a35b-05353cfc01b3', 'TKT-005', 'Status diubah menjadi In Progress', 'Rizki Prasetyo', 'helpdesk', '2026-06-04 08:27:21.808133+00', NULL),
	('a298c9bc-3248-4f5b-b033-4a055332bab1', 'TKT-005', 'Status diubah menjadi Resolved', 'Rizki Prasetyo', 'helpdesk', '2026-06-04 08:27:22.035203+00', NULL),
	('d13db77b-e40c-4589-b4c6-df0f7a56fd17', 'TKT-005', 'Status diubah menjadi Closed', 'Rizki Prasetyo', 'helpdesk', '2026-06-04 08:27:22.579933+00', NULL),
	('6df0fc1a-ef85-49a3-9543-c1ee4b818f07', 'TKT-005', 'Status diubah menjadi Open', 'Rizki Prasetyo', 'helpdesk', '2026-06-04 08:27:29.885439+00', NULL),
	('fa22e15a-b157-401b-bcc8-7a0a40d5c8e1', 'TKT-007', 'Tiket dibuat', 'Budi Santoso', 'user', '2026-06-04 08:29:36.03662+00', NULL),
	('fc8d1691-d66d-49bf-a328-4336870705dc', 'TKT-007', 'Komentar ditambahkan oleh Admin Utama', 'Admin Utama', 'admin', '2026-06-04 08:30:40.853328+00', NULL),
	('15de2e06-0648-4574-9ffc-99d36c981e82', 'TKT-007', 'Komentar ditambahkan oleh Admin Utama', 'Admin Utama', 'admin', '2026-06-04 08:30:50.038125+00', NULL),
	('225dbc42-4bc5-4b29-8ae6-0f3e0e13e4a8', 'TKT-007', 'Status diubah menjadi In Progress', 'Admin Utama', 'admin', '2026-06-04 08:31:30.145811+00', NULL),
	('30bffb92-5a7e-47fa-8fa1-a6365ee89f18', 'TKT-007', 'Tiket di-assign ke Rizki Prasetyo', 'Admin Utama', 'admin', '2026-06-04 08:31:36.385994+00', NULL),
	('f4992041-4154-4156-8522-691b08c88e19', 'TKT-008', 'Tiket dibuat', 'Budi Santoso', 'user', '2026-06-12 03:33:00.329209+00', NULL),
	('72dfae00-08a5-418b-bded-43ca97946587', 'TKT-008', 'Komentar ditambahkan oleh Admin Utama', 'Admin Utama', 'admin', '2026-06-12 03:34:50.664923+00', NULL),
	('9c03a836-bdbb-4036-900d-aee9a4bc5706', 'TKT-009', 'Tiket dibuat', 'Budi Santoso', 'user', '2026-07-05 13:48:03.325068+00', NULL),
	('0a296136-37a9-4e46-9c35-3937d9234f44', 'TKT-009', 'Tiket di-assign ke Rizki Prasetyo', 'Rizki Prasetyo', 'helpdesk', '2026-07-05 14:28:03.536068+00', NULL),
	('5bcd029d-a102-41db-9d40-8500187fb361', 'TKT-009', 'Komentar ditambahkan oleh Rizki Prasetyo', 'Rizki Prasetyo', 'helpdesk', '2026-07-05 14:28:17.964486+00', NULL),
	('2993089f-4d38-4b66-b1e2-365c06557913', 'TKT-009', 'Komentar ditambahkan oleh Rizki Prasetyo', 'Rizki Prasetyo', 'helpdesk', '2026-07-05 14:28:27.604942+00', NULL),
	('39f702ca-cf3b-498a-9d9a-786cb7602b88', 'TKT-009', 'Komentar ditambahkan oleh Rizki Prasetyo', 'Rizki Prasetyo', 'helpdesk', '2026-07-05 14:28:35.586001+00', NULL),
	('aee2a321-7fad-43a5-94f0-dfbf1549ed1d', 'TKT-010', 'Tiket dibuat', 'Budi Santoso', 'user', '2026-07-06 16:11:52.308609+00', NULL),
	('fc547952-d323-4f31-b3be-b0ca9b5ef0e0', 'TKT-010', 'Tiket di-assign ke Rizki Prasetyo', 'Rizki Prasetyo', 'helpdesk', '2026-07-06 16:13:26.168153+00', NULL),
	('105a1566-4c13-4ccb-be41-3771a4bb84d3', 'TKT-010', 'Komentar ditambahkan oleh Rizki Prasetyo', 'Rizki Prasetyo', 'helpdesk', '2026-07-06 16:13:45.292901+00', NULL),
	('973b6e54-43bf-4b52-ac83-6a24d45cee57', 'TKT-010', 'Tiket di-assign ke Dewi Kusuma', 'Admin Utama', 'admin', '2026-07-06 16:15:26.543887+00', NULL),
	('3fdc8e70-29da-4fec-85f4-8d4399b9a501', 'TKT-008', 'Tiket di-assign ke Rizki Prasetyo', 'Rizki Prasetyo', 'helpdesk', '2026-07-06 16:16:57.184231+00', NULL),
	('772be8f8-9034-4fba-ae12-99a102e3104b', 'TKT-008', 'Tiket diselesaikan dan ditutup', 'Rizki Prasetyo', 'helpdesk', '2026-07-06 16:17:06.816859+00', NULL),
	('a907b279-0b1c-4748-88b6-fbff41c553d4', 'TKT-009', 'Tiket diselesaikan dan ditutup', 'Rizki Prasetyo', 'helpdesk', '2026-07-06 16:17:10.156282+00', NULL),
	('470af723-2fa7-4424-a05f-53f21a743792', 'TKT-011', 'Tiket dibuat', 'Budi Santoso', 'user', '2026-07-06 16:38:46.491298+00', NULL),
	('1a7d39fa-a96a-491b-8f5d-e652b19bdc22', 'TKT-011', 'Tiket di-assign ke Rizki Prasetyo', 'Rizki Prasetyo', 'helpdesk', '2026-07-06 16:39:28.253426+00', NULL),
	('87db6099-5846-4941-8b10-b3de8f555fdd', 'TKT-011', 'Komentar ditambahkan oleh Rizki Prasetyo', 'Rizki Prasetyo', 'helpdesk', '2026-07-06 16:39:39.434901+00', NULL),
	('f93561cb-b67f-451e-8158-cad69147d218', 'TKT-011', 'Komentar ditambahkan oleh Admin Utama', 'Admin Utama', 'admin', '2026-07-06 16:41:16.944717+00', NULL),
	('026e3115-96e8-4f08-b89e-990264f7f528', 'TKT-011', 'Status diubah menjadi Closed', 'Admin Utama', 'admin', '2026-07-06 16:41:30.924098+00', NULL),
	('b333ca4c-5043-4294-beee-8fda846251ce', 'TKT-011', 'Status diubah menjadi Open', 'Admin Utama', 'admin', '2026-07-06 16:41:36.185898+00', NULL),
	('c30b7595-90ed-4198-9af7-f70cd92e4a67', 'TKT-011', 'Tiket di-assign ke Rizki Prasetyo', 'Admin Utama', 'admin', '2026-07-06 16:41:51.943675+00', NULL),
	('b3e7b60f-e7c2-478e-88b0-9d33b51488d4', 'TKT-011', 'Tiket diselesaikan dan ditutup', 'Rizki Prasetyo', 'helpdesk', '2026-07-06 16:42:53.512598+00', NULL);


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 1, false);


--
-- PostgreSQL database dump complete
--

-- \unrestrict eirfHjG91yAUxCPgvjsM4dNpbTmAB7MCN6wiv39gsrnsql4ryjxE2ytbfQPD5nZ

RESET ALL;
