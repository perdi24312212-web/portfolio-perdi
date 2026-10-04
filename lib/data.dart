import 'package:flutter/material.dart';

import 'demos/ipk_demo.dart';
import 'demos/pomodoro_demo.dart';
import 'demos/todo_demo.dart';

/// Semua isi portofolio ada di file ini.
/// Bagian bertanda GANTI sebaiknya kamu ubah dengan data aslimu.
class Profile {
  static const name = 'Perdi';
  static const npm = '24312212';
  static const prodi = 'Informatika';
  static const campus = 'Universitas Indonesia';

  static const headline = 'Mahasiswa Informatika yang senang membangun aplikasi.';
  static const intro =
      'Saya $name, mahasiswa $prodi di $campus. Di sini saya mengumpulkan '
      'proyek dan keahlian yang sedang saya kembangkan.';

  // GANTI: ceritakan dirimu dengan kata-katamu sendiri.
  static const about = [
    'Saya sedang menempuh kuliah di program studi Informatika, '
        'Universitas Indonesia. Saya tertarik pada pengembangan aplikasi '
        'mobile dan web, serta cara membuat perangkat lunak yang mudah dipakai.',
    'Saya belajar dengan membuat proyek nyata, dan sekarang sedang '
        'memperdalam Flutter untuk membangun aplikasi lintas platform.',
  ];

  // Kontak
  static const email = 'perdi24312212@gmail.com';
  static const emailUrl = 'mailto:$email?subject=Halo%20Perdi';
  static const whatsappDisplay = '0853-1914-7609';
  static const whatsappRaw = '085319147609';
  static const whatsappUrl =
      'https://wa.me/6285319147609?text=Halo%20Perdi%2C%20saya%20melihat%20portofolio%20kamu.';

  // GANTI: isi dengan username aslimu.
  static const github = 'github.com/username-kamu';
  static const linkedin = 'linkedin.com/in/username-kamu';
}

class Project {
  final String title;
  final String description;
  final List<String> tags;
  final IconData icon;

  /// Jika diisi, kartu menampilkan tombol "Coba demo".
  final WidgetBuilder? demo;
  const Project(this.title, this.description, this.tags, this.icon, [this.demo]);
}

/// Tiga proyek pertama punya demo yang bisa dicoba langsung di portofolio.
/// Kode demo ada di folder lib/demos.
final projects = <Project>[
  Project(
    'Kalkulator IPK',
    'Menghitung IPK dari jumlah SKS dan nilai huruf dengan skala 4,0. '
        'Bisa menambah dan menghapus mata kuliah.',
    ['Flutter', 'Dart', 'State management'],
    Icons.calculate_outlined,
    (_) => const IpkDemo(),
  ),
  Project(
    'Daftar Tugas Kuliah',
    'Mencatat tugas, menandai yang sudah selesai, dan menghapusnya '
        'saat tidak diperlukan.',
    ['Flutter', 'Dart', 'Form input'],
    Icons.checklist,
    (_) => const TodoDemo(),
  ),
  Project(
    'Timer Pomodoro',
    'Timer belajar dengan sesi fokus 25 menit dan istirahat 5 menit.',
    ['Flutter', 'Dart', 'Timer'],
    Icons.timer_outlined,
    (_) => const PomodoroDemo(),
  ),
  Project(
    'Portofolio Pribadi',
    'Situs yang sedang kamu lihat. Dibuat dengan Flutter, responsif '
        'untuk layar ponsel dan komputer.',
    ['Flutter', 'Material 3', 'Responsive'],
    Icons.web,
  ),
];

// GANTI: sesuaikan dengan kemampuanmu.
const skills = <String, List<String>>{
  'Bahasa pemrograman': ['Dart', 'Python', 'Java', 'JavaScript', 'SQL'],
  'Framework dan alat': ['Flutter', 'Git', 'GitHub', 'Figma'],
  'Bidang yang dipelajari': [
    'Struktur data',
    'Basis data',
    'Rekayasa perangkat lunak',
    'Jaringan komputer',
  ],
};
