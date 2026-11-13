import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/item_homepage.dart';
import 'package:myportofolio_mobile/widgets/info_card.dart';
import 'package:myportofolio_mobile/widgets/item_card.dart';

export 'package:myportofolio_mobile/models/item_homepage.dart';
export 'package:myportofolio_mobile/widgets/info_card.dart';
export 'package:myportofolio_mobile/widgets/item_card.dart';

/// Halaman menu utama aplikasi MyPortfolio Mobile.
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  final String npm = "2506591753";
  final String nama = "Malvin Lionard";
  final String kelas = "PBP F";

  static const List<ItemHomepage> items = [
    ItemHomepage(
      "Lihat Proyek",
      Icons.folder_open_rounded,
      Color(0xFF1E40AF),
      subtitle: "Eksplorasi karya",
    ),
    ItemHomepage(
      "Tambah Proyek",
      Icons.add_circle_outline_rounded,
      Color(0xFF047857),
      subtitle: "Input portofolio",
    ),
    ItemHomepage(
      "Logout",
      Icons.logout_rounded,
      Color(0xFFB91C1C),
      subtitle: "Keluar sesi",
    ),
  ];

  static const List<String> techStacks = [
    "Flutter & Dart",
    "Django",
    "Python",
    "Data Science",
  ];

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.work_outline_rounded, color: Colors.white, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'MyPortfolio',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Banner profil ringkas pemilik portofolio.
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    colorScheme.primary,
                    colorScheme.primary.withValues(alpha: 0.82),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.white,
                    child: Text(
                      "ML",
                      style: TextStyle(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14.0),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Selamat datang di MyPortfolio!",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          "Sistem Informasi • Fasilkom UI",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16.0),

            // Baris horizontal berisi 3 kartu informasi identitas mahasiswa.
            Row(
              children: [
                InfoCard(
                  title: 'NPM',
                  content: npm,
                  icon: Icons.badge_outlined,
                ),
                const SizedBox(width: 8.0),
                InfoCard(
                  title: 'Name',
                  content: nama,
                  icon: Icons.person_outline_rounded,
                ),
                const SizedBox(width: 8.0),
                InfoCard(
                  title: 'Class',
                  content: kelas,
                  icon: Icons.school_outlined,
                ),
              ],
            ),

            const SizedBox(height: 24.0),

            const Text(
              'Menu Portofolio',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              'Pilih aksi di bawah untuk mengelola data portofolio kamu.',
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: 13.0,
              ),
            ),

            const SizedBox(height: 12.0),

            // Kisi 3 kolom untuk menampilkan kartu tombol aksi dengan warna unik.
            GridView.count(
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              childAspectRatio: 0.92,
              shrinkWrap: true,
              children: items.map((ItemHomepage item) {
                return ItemCard(item);
              }).toList(),
            ),

            const SizedBox(height: 24.0),

            // Bagian tambahan: ringkasan minat teknologi pada portofolio.
            Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.code_rounded,
                        size: 18.0,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(width: 6.0),
                      const Text(
                        'Fokus Teknologi',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 6.0,
                    children: techStacks.map((String tech) {
                      return Chip(
                        label: Text(
                          tech,
                          style: const TextStyle(fontSize: 12.0),
                        ),
                        visualDensity: VisualDensity.compact,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}