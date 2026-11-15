# MyPortfolio Mobile - Adam Wahyu Syaputra

Aplikasi mobile portofolio pribadi berbasis **Flutter** yang dikembangkan untuk mata kuliah **Pemrograman Berbasis Platform CSGE602022** di Fakultas Ilmu Komputer, Universitas Indonesia pada Semester Gasal 2026/2027.

* **Nama**: Adam Wahyu Syaputra
* **NPM**: 2506534964
* **Kelas**: PBP D

---

## Tech Stack

* **Framework**: Flutter
* **Bahasa Pemrograman**: Dart
* **UI System**: Material Design 3

---

## Setup Instructions

Instruksi berikut dapat diikuti untuk menjalankan aplikasi ini secara lokal di komputer Anda:

### 1. Clone Repository
```bash
git clone https://github.com/adamwsyaputra/myportofolio_mobile.git
cd myportofolio_mobile
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Jalankan Aplikasi
```bash
flutter run
```
Untuk memeriksa kualitas kode dan menjalankan pengujian widget:
```bash
flutter analyze
flutter test
```

---

## Weekly Progress Tracker

- [x] **Minggu 7**
  - [x] Tutorial 08: Basic Flutter
  - [x] Individual Assignment 7: Basic Flutter
- [ ] **Minggu 8**
  - [ ] Tutorial 09: Flutter Navigation & Input Form
  - [ ] Individual Assignment 8: Flutter Navigation & Input Form
- [ ] **Minggu 9**
  - [ ] Tutorial 10: Django-Flutter Authentication & Integration
  - [ ] Individual Assignment 9: Django-Flutter Authentication & Integration

---

### Assignment 7

#### 1. Widget Tree dan Cara Kerja Hubungan Parent dengan Child
Widget tree di Flutter adalah struktur hierarki berbentuk pohon yang menggambarkan bagaimana seluruh widget disusun untuk membentuk tampilan aplikasi di layar. Dalam hubungan parent dan child, widget yang berada di atas berperan sebagai parent yang membungkus, mengatur ukuran, menentukan posisi, serta meneruskan konfigurasi ke widget child di bawahnya. Ada parent yang hanya punya satu child lewat properti `child` seperti `Scaffold`, `SingleChildScrollView`, `Padding`, `Center`, `Card`, `Container`, `Material`, dan `InkWell`, serta ada parent yang menampung banyak child sekaligus lewat properti `children` seperti `Column`, `Row`, dan `GridView.count`. Misalnya di proyek ini, `MyApp` menjadi root widget yang membungkus `MaterialApp`, lalu di dalamnya ada `MyHomePage` yang menyusun `Scaffold`, `AppBar`, `Row` berisi tiga `InfoCard`, serta `GridView.count` berisi tiga `ItemCard`.

---

#### 2. Daftar Widget yang Digunakan beserta Fungsinya
* **`MyApp`**: Widget kustom paling atas bertipe `StatelessWidget` yang menginisialisasi aplikasi dan membungkus `MaterialApp`.
* **`MaterialApp`**: Widget utama yang menyediakan konfigurasi tema Material Design, judul aplikasi, serta halaman awal melalui properti `home`.
* **`MyHomePage`**: Widget halaman utama aplikasi yang menampilkan kartu informasi pemilik portofolio dan menu tombol aksi.
* **`Scaffold`**: Kerangka dasar struktur halaman visual Material Design yang menyediakan tempat untuk `appBar`, `body`, dan area tampilnya `SnackBar`.
* **`AppBar`**: Baris navigasi di bagian paling atas layar yang menampilkan judul aplikasi `MyPortfolio`.
* **`SingleChildScrollView`**: Membungkus isi body halaman supaya tampilan tetap bisa di-scroll jika tinggi konten melebihi ukuran layar.
* **`Padding`**: Memberikan jarak kosong di sekeliling widget child supaya elemen tidak menempel langsung ke tepi layar atau elemen lain.
* **`Column`**: Menyusun daftar widget `children` secara vertikal dari atas ke bawah.
* **`Row`**: Menyusun daftar widget `children` secara horizontal dari kiri ke kanan, dipakai untuk menyejajarkan tiga `InfoCard`.
* **`SizedBox`**: Memberikan jarak vertikal atau horizontal dengan ukuran tetap antar widget.
* **`Center`**: Menempatkan widget child tepat di posisi tengah dari ruang yang tersedia.
* **`Text`**: Menampilkan tulisan di layar seperti nama, NPM, kelas, sambutan, dan label tombol.
* **`GridView.count`**: Menyusun daftar `ItemCard` dalam bentuk grid dengan jumlah kolom tetap sebanyak 3 kolom.
* **`InfoCard`**: Widget kustom `StatelessWidget` untuk menampilkan satu kotak informasi identitas pemilik portofolio yang terdiri dari judul dan isi.
* **`Card`**: Panel dengan sudut membulat dan bayangan tipis `elevation` untuk membungkus tampilan `InfoCard`.
* **`Container`**: Widget pembungkus serbaguna untuk mengatur lebar, `padding`, dan tata letak isi di dalam `InfoCard` maupun `ItemCard`.
* **`ItemCard`**: Widget kustom `StatelessWidget` yang merepresentasikan kartu tombol aksi dengan warna, ikon, dan teks dari objek `ItemHomepage`.
* **`Material`**: Memberikan latar warna `item.color` dan bentuk sudut membulat `borderRadius` sekaligus menjadi kanvas tempat munculnya efek sentuhan dari `InkWell`.
* **`InkWell`**: Menangkap interaksi ketukan user lewat `onTap` dan menampilkan animasi ripple effect saat kartu ditekan.
* **`Icon`**: Menampilkan ikon visual dari `Icons` di bagian atas teks pada setiap `ItemCard`.
* **`ScaffoldMessenger`**: Mengelola antrean tampilan `SnackBar` pada `Scaffold` yang sedang aktif, termasuk menyembunyikan `SnackBar` sebelumnya lewat `hideCurrentSnackBar` dan memunculkan yang baru lewat `showSnackBar`.
* **`SnackBar`**: Pesan pop-up melayang di bagian bawah layar yang memberi tahu tombol mana yang baru saja ditekan oleh user.

---

#### 3. Tujuan Penggunaan `MaterialApp` sebagai Root Widget
`MaterialApp` berfungsi menyediakan fondasi dan layanan standar yang dibutuhkan oleh aplikasi bergaya Material Design, mulai dari pengaturan tema warna `ThemeData`, sistem navigasi antar halaman `Navigator`, lokalisasi, sampai `ScaffoldMessenger` untuk menampilkan notifikasi `SnackBar`. Widget ini hampir selalu dipasang sebagai root widget karena banyak widget turunan di Flutter seperti `Scaffold`, `AppBar`, `Card`, `InkWell`, dan `Text` bergantung pada data tema dan konfigurasi yang disediakan oleh `MaterialApp` di atasnya pada widget tree. Tanpa `MaterialApp` di posisi root, kita harus mengatur arah teks `Directionality`, tema, dan navigator satu per satu secara manual.

---

#### 4. Perbedaan `StatelessWidget` dan `StatefulWidget` serta Kapan Dipakai
`StatelessWidget` adalah widget yang bersifat immutable atau tidak memiliki state internal yang berubah selama widget tersebut tampil di layar, sehingga tampilannya hanya bergantung pada data yang dikirim lewat constructor saat pertama kali dibuat. Sebaliknya, `StatefulWidget` adalah widget yang memiliki objek `State` terpisah yang bersifat mutable, sehingga tampilannya dapat diperbarui kapan saja saat aplikasi berjalan dengan memanggil fungsi `setState` untuk memicu proses rebuild. Kita memilih `StatelessWidget` ketika membuat komponen yang sifatnya menampilkan data statis atau langsung menjalankan aksi tanpa mengubah data di dalam dirinya sendiri, seperti `MyHomePage`, `InfoCard`, dan `ItemCard` pada Tugas 7 ini. Kita baru membutuhkan `StatefulWidget` ketika tampilan widget harus berubah secara dinamis mengikuti interaksi user atau perubahan data, misalnya pada halaman form input, fitur filter pencarian, checkbox, atau halaman yang memuat data dari API.

---

#### 5. Pengertian `BuildContext`, Kenapa Penting, dan Cara Penggunaannya di Method `build`
`BuildContext` adalah objek yang merepresentasikan posisi atau alamat suatu widget di dalam widget tree. Objek ini sangat penting karena setiap widget di Flutter membutuhkan `BuildContext` untuk mencari dan mengakses data maupun layanan milik widget parent atau ancestor yang berada di atasnya pada pohon widget. Di dalam method `build`, parameter `context` kita teruskan ke method pencarian bawaan Flutter seperti `Theme.of` pada `AppBar` untuk mengambil warna `primary` dari tema aplikasi, `MediaQuery.of` pada `InfoCard` untuk membaca lebar layar perangkat supaya lebar ketiga kartu proporsional, serta `ScaffoldMessenger.of` di dalam `onTap` pada `ItemCard` untuk menemukan `Scaffold` terdekat dan menampilkan `SnackBar`.

---

#### 6. Konsep Hot Reload vs Hot Restart serta Kapan Harus Memakai Hot Restart atau Full Restart
`Hot reload` bekerja dengan cara menyuntikkan perubahan kode terbaru langsung ke dalam Dart Virtual Machine yang sedang berjalan lalu membangun ulang widget tree tanpa menghapus state aplikasi yang sedang aktif, sehingga perubahan tampilan UI bisa langsung terlihat dalam hitungan milidetik. Sementara itu, `hot restart` menjalankan ulang aplikasi dari fungsi `main` dan mengatur ulang seluruh state kembali ke nilai awal. Kita tidak bisa mengandalkan `hot reload` dan harus memakai `hot restart` ketika kita mengubah nilai variabel di level class seperti daftar `items` atau atribut `npm` dan `nama` pada `MyHomePage`, mengubah fungsi `main`, atau mengubah isi `initState`, karena `hot reload` masih menyimpan instance state lama di memori. Adapun `full restart` harus dilakukan ketika kita menambah package baru di `pubspec.yaml`, mengubah konfigurasi aset, atau mengubah kode native di folder Android dan iOS yang membutuhkan proses kompilasi ulang dari awal.

---

### Pengungkapan Penggunaan AI

* **Alat yang Digunakan**: AI(Gemini) digunakan sebagai teman diskusi dan konsultasi konsep dasar Flutter seperti cara kerja widget tree, pengaturan warna pada `Material` dan `InkWell`, serta pencegahan overflow pada layout. Pembuatan kode aplikasi dikerjakan dengan melanjutkan struktur dari Tutorial 08 dan debugging dibantu oleh Antigravity.

#### Analisis Keterbatasan AI & Perbaikan Manual
* **Pengaturan Scroll pada `GridView.count`**: Saat berkonsultasi mengenai penambahan `SingleChildScrollView` pada `body` supaya halaman tidak mengalami bottom overflow di layar kecil, saran awal sempat lupa mengatur `primary: false` pada `GridView.count` sehingga berpotensi bentrok antara scroll milik `SingleChildScrollView` dengan scroll bawaan `GridView`. Saya sesuaikan secara manual dengan mengubah `primary: false` dan `shrinkWrap: true` pada `GridView.count` di `lib/menu.dart`.
* **Penyesuaian Widget Test**: Berkas bawaan `test/widget_test.dart` dari hasil inisialisasi proyek Flutter masih menguji aplikasi counter bawaan yang mencari angka `0` dan ikon tambah, sehingga gagal saat dijalankan pada aplikasi portofolio. Saya perbarui isi `test/widget_test.dart` secara manual untuk menguji keberadaan teks identitas pada `InfoCard`, ketiga tombol `ItemCard`, serta munculnya `SnackBar` saat tombol ditekan.
