import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/app_provider.dart';
import '../../theme/app_theme.dart';
import '../auth/login_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _notificationsEnabled = true;
  String _selectedLanguage = 'Indonesia';

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final isDark = provider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Appearance Section
            _sectionTitle('Tampilan'),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8),
                ],
              ),
              child: Column(
                children: [
                  _settingTile(
                    icon: Icons.dark_mode_rounded,
                    label: 'Mode Gelap',
                    subtitle: isDark ? 'Aktif' : 'Nonaktif',
                    color: const Color(0xFF6366F1),
                    trailing: Switch(
                      value: isDark,
                      onChanged: (_) => provider.toggleTheme(),
                      activeThumbColor: AppTheme.primaryGreen,
                    ),
                  ),
                  _divider(),
                  _settingTile(
                    icon: Icons.text_fields_rounded,
                    label: 'Ukuran Font',
                    subtitle: 'Default',
                    color: AppTheme.accentAmber,
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.accentAmber.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('Normal',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.accentAmber)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Notification Section
            _sectionTitle('Notifikasi'),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8),
                ],
              ),
              child: Column(
                children: [
                  _settingTile(
                    icon: Icons.notifications_active_rounded,
                    label: 'Push Notification',
                    subtitle: _notificationsEnabled ? 'Aktif' : 'Nonaktif',
                    color: AppTheme.primaryGreen,
                    trailing: Switch(
                      value: _notificationsEnabled,
                      onChanged: (v) => setState(() => _notificationsEnabled = v),
                      activeThumbColor: AppTheme.primaryGreen,
                    ),
                  ),
                  _divider(),
                  _settingTile(
                    icon: Icons.email_outlined,
                    label: 'Notifikasi Email',
                    subtitle: 'Kirim notifikasi via email',
                    color: AppTheme.accentOrange,
                    trailing: Switch(
                      value: false,
                      onChanged: (_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Fitur segera hadir!', style: GoogleFonts.plusJakartaSans()),
                            backgroundColor: AppTheme.accentAmber,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        );
                      },
                      activeThumbColor: AppTheme.accentOrange,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Security Section
            _sectionTitle('Keamanan'),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8),
                ],
              ),
              child: Column(
                children: [
                  _settingTile(
                    icon: Icons.lock_outline_rounded,
                    label: 'Ubah Password',
                    subtitle: 'Ganti password akun Anda',
                    color: AppTheme.dangerRed,
                    onTap: () => _showChangePasswordDialog(context),
                  ),
                  _divider(),
                  _settingTile(
                    icon: Icons.fingerprint_rounded,
                    label: 'Autentikasi Biometrik',
                    subtitle: 'Segera hadir',
                    color: AppTheme.successGreen,
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppTheme.accentAmber.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text('Soon',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 9, fontWeight: FontWeight.w700, color: AppTheme.accentAmber)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Language Section
            _sectionTitle('Bahasa & Regional'),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8),
                ],
              ),
              child: Column(
                children: [
                  _settingTile(
                    icon: Icons.language_rounded,
                    label: 'Bahasa Aplikasi',
                    subtitle: _selectedLanguage,
                    color: AppTheme.primaryGreen,
                    onTap: () => _showLanguageDialog(context),
                  ),
                  _divider(),
                  _settingTile(
                    icon: Icons.access_time_rounded,
                    label: 'Zona Waktu',
                    subtitle: 'WIB (GMT+7)',
                    color: const Color(0xFF8B5CF6),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // About & Support Section
            _sectionTitle('Tentang & Bantuan'),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8),
                ],
              ),
              child: Column(
                children: [
                  _settingTile(
                    icon: Icons.info_outline_rounded,
                    label: 'Tentang Aplikasi',
                    subtitle: 'E-Ticketing Helpdesk v2.0.0',
                    color: AppTheme.primaryGreen,
                    onTap: () => _showAbout(context),
                  ),
                  _divider(),
                  _settingTile(
                    icon: Icons.help_outline_rounded,
                    label: 'Pusat Bantuan',
                    subtitle: 'FAQ dan panduan pengguna',
                    color: AppTheme.accentOrange,
                    onTap: () => _showHelpDialog(context),
                  ),
                  _divider(),
                  _settingTile(
                    icon: Icons.star_outline_rounded,
                    label: 'Beri Rating',
                    subtitle: 'Bantu kami meningkatkan aplikasi',
                    color: AppTheme.accentAmber,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Terima kasih atas feedback Anda!', style: GoogleFonts.plusJakartaSans()),
                          backgroundColor: AppTheme.successGreen,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      );
                    },
                  ),
                  _divider(),
                  _settingTile(
                    icon: Icons.description_outlined,
                    label: 'Kebijakan Privasi',
                    subtitle: 'Baca kebijakan privasi kami',
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Logout
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8),
                ],
              ),
              child: _settingTile(
                icon: Icons.logout_rounded,
                label: 'Keluar',
                subtitle: 'Keluar dari akun Anda',
                color: AppTheme.dangerRed,
                textColor: AppTheme.dangerRed,
                onTap: _logout,
              ),
            ),
            const SizedBox(height: 32),
            Center(
              child: Text(
                'E-Ticketing Helpdesk v2.0.0\nDIV Teknik Informatika - Universitas Airlangga',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  color: Colors.grey.shade400,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.3,
      ),
    );
  }

  Widget _settingTile({
    required IconData icon,
    required String label,
    required Color color,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    Color? textColor,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color, size: 18),
      ),
      title: Text(
        label,
        style: GoogleFonts.plusJakartaSans(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: textColor,
        ),
      ),
      subtitle: subtitle != null
          ? Text(subtitle,
              style: GoogleFonts.plusJakartaSans(fontSize: 11, color: Colors.grey.shade500))
          : null,
      trailing: trailing ?? const Icon(Icons.chevron_right_rounded, size: 18),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
    );
  }

  Widget _divider() {
    return const Divider(height: 1, indent: 56);
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Keluar', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700)),
        content: Text('Yakin ingin keluar dari aplikasi?', style: GoogleFonts.plusJakartaSans()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Batal', style: GoogleFonts.plusJakartaSans()),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.dangerRed),
            onPressed: () {
              context.read<AppProvider>().logout();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (_) => false,
              );
            },
            child: Text('Keluar', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final oldCtrl = TextEditingController();
    final newCtrl = TextEditingController();
    final confirmCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Ubah Password', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700)),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: oldCtrl,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password Lama',
                  prefixIcon: Icon(Icons.lock_outline_rounded),
                ),
                validator: (v) => v!.isEmpty ? 'Diperlukan' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: newCtrl,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password Baru',
                  prefixIcon: Icon(Icons.lock_rounded),
                ),
                validator: (v) {
                  if (v!.isEmpty) return 'Diperlukan';
                  if (v.length < 6) return 'Min. 6 karakter';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: confirmCtrl,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Konfirmasi Password',
                  prefixIcon: Icon(Icons.lock_rounded),
                ),
                validator: (v) {
                  if (v!.isEmpty) return 'Diperlukan';
                  if (v != newCtrl.text) return 'Password tidak cocok';
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () async {
              if (!formKey.currentState!.validate()) return;
              final user = context.read<AppProvider>().currentUser!;
              if (oldCtrl.text != user.password) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Password lama salah!', style: GoogleFonts.plusJakartaSans()),
                    backgroundColor: AppTheme.dangerRed,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                );
                return;
              }
              await context.read<AppProvider>().resetPassword(user.name, user.email, newCtrl.text);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Password berhasil diubah!', style: GoogleFonts.plusJakartaSans()),
                  backgroundColor: AppTheme.successGreen,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              );
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    final languages = ['Indonesia', 'English'];
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Pilih Bahasa', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: languages.map((lang) => ListTile(
            title: Text(lang, style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600)),
            trailing: _selectedLanguage == lang
                ? const Icon(Icons.check_circle_rounded, color: AppTheme.primaryGreen)
                : null,
            onTap: () {
              setState(() => _selectedLanguage = lang);
              Navigator.pop(ctx);
            },
          )).toList(),
        ),
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Pusat Bantuan', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _helpItem('Cara membuat tiket', 'Buka menu Tiket, lalu tap tombol "Buat Tiket" di bagian bawah.'),
            _helpItem('Cara melacak tiket', 'Buka detail tiket, lalu pilih tab "Tracking" untuk melihat status progres.'),
            _helpItem('Cara menghubungi helpdesk', 'Kirim komentar di detail tiket untuk berkomunikasi langsung.'),
            _helpItem('Lupa password', 'Gunakan fitur "Lupa Password" pada halaman login.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Tutup', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _helpItem(String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w700)),
          const SizedBox(height: 2),
          Text(desc,
              style: GoogleFonts.plusJakartaSans(fontSize: 12, color: Colors.grey.shade600, height: 1.4)),
        ],
      ),
    );
  }

  void _showAbout(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'E-Ticketing Helpdesk',
      applicationVersion: '2.0.0',
      applicationIcon: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppTheme.primaryGreen, AppTheme.primaryDark],
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Icon(Icons.support_agent_rounded, color: Colors.white, size: 32),
      ),
      children: [
        Text(
          'Aplikasi E-Ticketing Helpdesk untuk pelaporan, monitoring, dan penyelesaian masalah IT.\n\nDIV Teknik Informatika\nUniversitas Airlangga\n\n© 2026 All Rights Reserved',
          style: GoogleFonts.plusJakartaSans(fontSize: 13, height: 1.6),
        ),
      ],
    );
  }
}
