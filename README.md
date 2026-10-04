# Portofolio Perdi

Portofolio pribadi dibuat dengan Flutter.
Perdi - NPM 24312212 - Informatika, Universitas Indonesia.

## Cara menjalankan

Folder ini hanya berisi kode Dart (`lib/`) dan konfigurasi. Folder platform
(android, ios, web) dibuat oleh Flutter dengan perintah berikut:

```bash
cd portfolio_perdi
flutter create . --platforms=web,android,ios
flutter pub get
flutter run -d chrome      # atau pilih emulator / perangkat Android
```

## Cara mengubah isi

Buka `lib/data.dart`. Semua teks, proyek, keahlian, dan kontak ada di sana.
Bagian bertanda `GANTI` adalah contoh yang perlu kamu isi dengan data aslimu.
Tombol WhatsApp dan email memakai paket `url_launcher`, jadi jalankan `flutter pub get` lagi setelah memperbarui folder.

## Struktur

```
lib/
  main.dart            titik masuk aplikasi
  theme.dart           warna dan tema
  data.dart            isi portofolio
  pages/home_page.dart halaman utama dan semua bagian
  widgets/id_card.dart kartu mahasiswa di bagian awal
  widgets/reveal.dart, hover_lift.dart, dot_grid.dart  efek tampilan
  demos/               demo interaktif untuk kartu proyek
  utils.dart           buka tautan dan salin teks
  widgets/section_block.dart pembungkus bagian dan lebar konten
assets/images/        foto profil (profile.jpg dan profile_avatar.jpg)
test/widget_test.dart  tes sederhana
```

## Build web

```bash
flutter build web
```
Hasilnya ada di `build/web`, bisa di-host di GitHub Pages atau Netlify.
