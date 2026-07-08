# 🎫 E-Ticketing Helpdesk Mobile App

> Aplikasi mobile helpdesk berbasis e-ticketing untuk manajemen tiket IT support.
> Dibangun dengan **Flutter** dan **Supabase** sebagai backend.

**Mata Kuliah:** Praktikum Mobile Apps  
**Ujian:** UAS (Ujian Akhir Semester)  
**Versi:** 2.0.0

---

## 📋 Deskripsi Aplikasi

Aplikasi **E-Ticketing Helpdesk** adalah sistem manajemen tiket berbasis mobile yang memungkinkan pengguna untuk melaporkan masalah IT (hardware, software, network, dll) dan mendapatkan bantuan dari tim helpdesk. Aplikasi ini mendukung 3 role pengguna dengan fitur yang berbeda-beda.

---

## ✨ Fitur Utama

### 👤 User (Pelapor)
- Login, Register, Reset Password
- Membuat tiket baru (dengan kategori & prioritas)
- Melihat daftar tiket sendiri
- Edit & hapus tiket (selama status masih *open*)
- Menambahkan komentar pada tiket
- Menerima notifikasi update tiket
- Melihat riwayat perubahan tiket
- Edit profil

### 🛠️ Helpdesk (Teknisi)
- Melihat tiket yang di-assign
- Mengubah status tiket (*open* → *in progress* → *closed*)
- Menambahkan komentar/solusi pada tiket
- Menerima notifikasi tiket baru

### 🔑 Admin
- Dashboard statistik tiket
- Manajemen pengguna (CRUD user, helpdesk, admin)
- Assign tiket ke helpdesk
- Melihat semua tiket
- Full kontrol atas sistem

---

## 🏗️ Arsitektur & Teknologi

| Komponen | Teknologi |
|----------|-----------|
| **Framework** | Flutter (Dart) |
| **State Management** | Provider |
| **Backend** | Supabase (PostgreSQL + REST API) |
| **Database** | PostgreSQL (via Supabase) |
| **API** | Supabase REST API (PostgREST) |
| **Font** | Google Fonts |
| **Chart** | fl_chart |
| **Animasi** | Lottie, Flutter Staggered Animations, Shimmer |

---

## 📁 Struktur Proyek

```
lib/
├── main.dart                          # Entry point aplikasi
├── models/                            # Data models
│   ├── user_model.dart                # Model pengguna
│   ├── ticket_model.dart              # Model tiket (termasuk Comment & TicketHistory)
│   └── notification_model.dart        # Model notifikasi
├── providers/
│   └── app_provider.dart              # State management (Provider)
├── services/
│   └── supabase_service.dart          # Konfigurasi & inisialisasi Supabase
├── screens/
│   ├── auth/                          # Autentikasi
│   │   ├── splash_screen.dart         # Splash screen
│   │   ├── login_screen.dart          # Login
│   │   ├── register_screen.dart       # Register
│   │   └── reset_password_screen.dart # Reset password
│   ├── dashboard/
│   │   ├── main_screen.dart           # Bottom navigation utama
│   │   └── dashboard_screen.dart      # Dashboard & statistik
│   ├── ticket/
│   │   ├── ticket_list_screen.dart    # Daftar tiket
│   │   ├── create_ticket_screen.dart  # Buat tiket baru
│   │   ├── edit_ticket_screen.dart    # Edit tiket
│   │   ├── ticket_detail_screen.dart  # Detail tiket + komentar + riwayat
│   │   └── notification_screen.dart   # Daftar notifikasi
│   ├── helpdesk/
│   │   └── helpdesk_screen.dart       # Panel helpdesk
│   ├── admin/
│   │   └── admin_screen.dart          # Panel admin (manajemen user)
│   └── profile/
│       ├── profile_screen.dart        # Profil pengguna
│       └── setting_screen.dart        # Pengaturan akun
├── theme/
│   └── app_theme.dart                 # Konfigurasi tema (warna, typography)
├── utils/
│   ├── app_helpers.dart               # Helper functions
│   ├── app_router.dart                # Routing/navigasi
│   └── dummy_data.dart                # Data dummy untuk pengembangan
└── widgets/
    └── common_widgets.dart            # Widget reusable
```

---

## 🗄️ Database Schema

Aplikasi menggunakan **5 tabel utama** di Supabase PostgreSQL:

```
┌──────────────┐     ┌──────────────────┐     ┌──────────────┐
│    users      │     │     tickets      │     │   comments   │
├──────────────┤     ├──────────────────┤     ├──────────────┤
│ id (UUID) PK │◄────│ created_by_id FK │     │ id (UUID) PK │
│ name         │◄────│ assigned_to_id FK│     │ ticket_id FK │──► tickets
│ email        │     │ id (TEXT) PK     │◄────│ author_id FK │──► users
│ username     │     │ title            │     │ author_name  │
│ password     │     │ description      │     │ content      │
│ role         │     │ category         │     │ created_at   │
│ department   │     │ priority         │     └──────────────┘
│ avatar       │     │ status           │
│ phone        │     │ created_at       │     ┌──────────────────┐
│ created_at   │     │ updated_at       │     │ ticket_history   │
└──────────────┘     └──────────────────┘     ├──────────────────┤
                                               │ id (UUID) PK     │
┌──────────────────┐                           │ ticket_id FK     │──► tickets
│  notifications   │                           │ action           │
├──────────────────┤                           │ performed_by     │
│ id (UUID) PK     │                           │ performed_by_role│
│ title            │                           │ created_at       │
│ body             │                           └──────────────────┘
│ ticket_id FK     │──► tickets
│ type             │
│ is_read          │
│ user_id FK       │──► users
│ created_at       │
└──────────────────┘
```

Detail lengkap schema: [`supabase_schema.sql`](supabase_schema.sql)

---

## 🌐 Dokumentasi API Backend

Aplikasi ini menggunakan **Supabase REST API (PostgREST)** sebagai backend.

### Base URL
```
https://onphaqtfgljduatmuzkt.supabase.co
```

### Header yang Diperlukan
| Header | Nilai |
|--------|-------|
| `apikey` | `<supabase_anon_key>` |
| `Authorization` | `Bearer <supabase_anon_key>` |
| `Content-Type` | `application/json` |

### Daftar Endpoint API

#### 🔐 Auth
| Method | Endpoint | Deskripsi |
|--------|----------|-----------|
| `POST` | `/auth/v1/signup` | Register pengguna baru |
| `POST` | `/auth/v1/token?grant_type=password` | Login pengguna |
| `POST` | `/auth/v1/recover` | Reset password |

#### 👤 Users
| Method | Endpoint | Deskripsi |
|--------|----------|-----------|
| `GET` | `/rest/v1/users?id=eq.<uuid>` | Ambil data user by ID |
| `POST` | `/rest/v1/users` | Buat user baru (Admin) |
| `PATCH` | `/rest/v1/users?id=eq.<uuid>` | Update profil user |
| `DELETE` | `/rest/v1/users?id=eq.<uuid>` | Hapus user (Admin) |

#### 🎫 Tickets
| Method | Endpoint | Deskripsi |
|--------|----------|-----------|
| `GET` | `/rest/v1/tickets?created_by_id=eq.<uuid>` | Ambil tiket by user |
| `POST` | `/rest/v1/tickets` | Buat tiket baru |
| `PATCH` | `/rest/v1/tickets?id=eq.<ticket_id>` | Update tiket |
| `DELETE` | `/rest/v1/tickets?id=eq.<ticket_id>` | Hapus tiket |

#### 💬 Comments
| Method | Endpoint | Deskripsi |
|--------|----------|-----------|
| `GET` | `/rest/v1/comments?ticket_id=eq.<ticket_id>` | Ambil komentar by tiket |
| `POST` | `/rest/v1/comments` | Tambah komentar |

#### 📜 Ticket History
| Method | Endpoint | Deskripsi |
|--------|----------|-----------|
| `GET` | `/rest/v1/ticket_history?ticket_id=eq.<ticket_id>` | Ambil riwayat tiket |
| `POST` | `/rest/v1/ticket_history` | Tambah entri riwayat |

#### 🔔 Notifications
| Method | Endpoint | Deskripsi |
|--------|----------|-----------|
| `GET` | `/rest/v1/notifications?user_id=eq.<uuid>` | Ambil notifikasi user |
| `POST` | `/rest/v1/notifications` | Buat notifikasi baru |
| `PATCH` | `/rest/v1/notifications?user_id=eq.<uuid>` | Tandai notifikasi dibaca |

### 📄 File Dokumentasi API
| File | Deskripsi |
|------|-----------|
| [`swagger.yaml`](swagger.yaml) | Dokumentasi OpenAPI 3.0 (bisa dibuka di [Swagger Editor](https://editor.swagger.io)) |
| [`uts_mobile_api_collection.json`](uts_mobile_api_collection.json) | Postman Collection (import ke Postman untuk testing) |

---

## 🚀 Cara Menjalankan Aplikasi

### Prasyarat
- Flutter SDK ≥ 3.0.0
- Dart SDK ≥ 3.0.0
- Android Studio / VS Code
- Android Emulator atau perangkat fisik

### Langkah-langkah

1. **Clone repository**
   ```bash
   git clone <repository-url>
   cd uts_mobile
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Jalankan aplikasi**
   ```bash
   flutter run
   ```

4. **Build APK** (untuk release)
   ```bash
   flutter build apk --release
   ```
   File APK akan tersedia di: `build/app/outputs/flutter-apk/app-release.apk`

---

## 🔑 Akun untuk Testing

| Role | Username | Password | Nama |
|------|----------|----------|------|
| **Admin** | `admin` | `admin123` | Admin Utama |
| **Helpdesk** | `rizki` | `123456` | Rizki Prasetyo |
| **Helpdesk** | `dewi` | `123456` | Dewi Kusuma |
| **User** | `budi` | `123456` | Budi Santoso |
| **User** | `siti` | `123456` | Siti Rahayu |
| **User** | `andi` | `123456` | Andi Wijaya |

---

## 📦 Dependencies

| Package | Versi | Fungsi |
|---------|-------|--------|
| `supabase_flutter` | ^2.8.4 | Koneksi ke Supabase backend |
| `provider` | ^6.1.1 | State management |
| `google_fonts` | ^6.1.0 | Custom typography |
| `fl_chart` | ^0.67.0 | Chart/grafik di dashboard |
| `lottie` | ^3.1.0 | Animasi Lottie |
| `shimmer` | ^3.0.0 | Loading shimmer effect |
| `flutter_staggered_animations` | ^1.1.1 | Animasi staggered |
| `intl` | ^0.19.0 | Internationalization & format tanggal |
| `timeago` | ^3.6.1 | Format waktu relatif |
| `image_picker` | ^1.0.7 | Ambil foto dari kamera/galeri |
| `uuid` | ^4.3.3 | Generate UUID |
| `badges` | ^3.1.2 | Badge/notifikasi icon |
| `cached_network_image` | ^3.3.1 | Caching gambar dari network |
| `shared_preferences` | ^2.2.2 | Penyimpanan lokal |
| `font_awesome_flutter` | ^9.1.0 | Ikon Font Awesome |

---

## 📱 APK Download

File APK release tersedia di folder [`apk/`](apk/) pada repository ini.

---

## 👨‍💻 Dibuat Oleh

**NAMA:** Muhammad Rizki Ibrahim
**NIM:** 434241085

Projek ini dibuat sebagai tugas **UAS Praktikum Mobile Apps**.
