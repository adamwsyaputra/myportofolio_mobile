# MyPortfolio Mobile - Adam Wahyu Syaputra

Aplikasi mobile portofolio pribadi berbasis **Flutter** yang dikembangkan untuk mata kuliah **Pemrograman Berbasis Platform CSGE602022** di Fakultas Ilmu Komputer, Universitas Indonesia pada Semester Gasal 2026/2027.

* **Nama**: Adam Wahyu Syaputra
* **NPM**: 2506534964
* **Kelas**: PBP D

---

## Tech Stack

* **Framework**: Flutter
* **Bahasa Pemrograman**: Dart
* **UI System**: Material Design 3 lewat package `material_ui`

---

## Struktur Proyek & Fitur

Aplikasi saat ini mencakup halaman beranda portofolio, navigation drawer `LeftDrawer`, form tambah proyek `ProjectFormPage`, dan form tambah pengalaman `ExperienceFormPage` dengan validasi terpisah di `FormValidators`.

```text
lib/
├── main.dart
├── screens/
│   ├── menu.dart
│   ├── project_form.dart
│   └── experience_form.dart
├── utils/
│   └── form_validators.dart
└── widgets/
    ├── left_drawer.dart
    └── project_card.dart
```

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
Untuk menjalankan pada device atau emulator default:
```bash
flutter run
```
Untuk menjalankan di browser Chrome sekaligus menguji navigasi drawer `Home` dan form pada ukuran layar ponsel:
```bash
flutter run -d chrome
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
- [x] **Minggu 8**
  - [x] Tutorial 09: Flutter Navigation & Input Form
  - [x] Individual Assignment 8: Flutter Navigation & Input Form
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

---

### Tugas 8

#### 1. Perbedaan `Navigator.push()`, `Navigator.pushReplacement()`, dan `Navigator.pop()`
`Navigator` di Flutter mengelola halaman sebagai tumpukan route atau stack. `Navigator.push()` menambahkan halaman baru di atas halaman yang sedang aktif sehingga halaman sebelumnya tetap tersimpan di bawahnya, sedangkan `Navigator.pushReplacement()` mengganti route paling atas saja dengan halaman baru tanpa membersihkan seluruh stack di bawahnya. Sementara itu, `Navigator.pop()` menghapus route atau dialog paling atas dari stack dan menampilkan halaman tepat di bawahnya. Pada proyek ini, kartu aksi di `ItemCard` memakai `Navigator.push()` untuk membuka `ProjectFormPage` dan `ExperienceFormPage` supaya user bisa kembali ke `MyHomePage` lewat tombol Back perangkat. Di `LeftDrawer`, opsi `Home` memakai `Navigator.pushReplacement()` menuju `MyHomePage` untuk langsung mengganti halaman form yang sedang aktif, sehingga halaman form dibuang dari stack dan user tidak kembali ke form saat menekan Back.

---

#### 2. Peran `Scaffold`, `AppBar`, dan `Drawer` untuk Konsistensi Halaman serta Contoh Warna Tema
Memasang `Scaffold`, `AppBar`, dan komponen `LeftDrawer` yang sama di setiap halaman membuat struktur dasar aplikasi tetap seragam, di mana header selalu berada di atas, menu navigasi selalu muncul dari sisi kiri, dan area konten utama punya ruang yang terpisah rapi. Dengan susunan ini, user tidak bingung saat berpindah antara `MyHomePage`, `ProjectFormPage`, dan `ExperienceFormPage` karena pola navigasi dan posisinya selalu sama. Untuk menjaga konsistensi warna, kita mengambil warna utama dari `Theme.of(context).colorScheme.primary` yang berasal dari `ColorScheme.fromSeed` di `MyApp`, lalu memakainya bersama di `backgroundColor` milik `AppBar` pada `MyHomePage`, `ProjectFormPage`, dan `ExperienceFormPage`, di `DrawerHeader` pada `LeftDrawer`, serta pada tombol `Save` dan `Simpan`.

---

#### 3. Pemilihan Layout Form serta Peran Spacing dan Scroll saat Layar Terbatas
Pada `ExperienceFormPage`, seluruh input disusun secara vertikal memakai `Column` di dalam `SingleChildScrollView` dengan properti `padding: const EdgeInsets.all(16.0)` untuk jarak tepi dan widget `SizedBox` untuk jarak antar field, berbeda dengan `ProjectFormPage` dan `MyHomePage` yang memakai widget `Padding` terpisah. Tata letak satu kolom vertikal dipilih supaya label, kolom input, dan pesan error mudah dibaca dari atas ke bawah pada layar HP yang sempit. Properti `padding` dan `SizedBox` menjaga tiap input tidak saling menempel sehingga area sentuhnya jelas dan nyaman ditekan. Ketika ukuran layar terbatas, toggle `Sedang Berlangsung` dimatikan sehingga field `Tanggal Selesai` muncul, atau saat keyboard virtual terbuka, `SingleChildScrollView` mencegah terjadinya bottom overflow dan memastikan seluruh input serta tombol `Simpan` tetap bisa di-scroll dan ditekan.

---

#### 4. Peran `GlobalKey<FormState>`, `validator`, dan `validate()` serta Alasan Jenis Input dan Keyboard Saja Belum Cukup
`GlobalKey<FormState>` berperan sebagai pengenal unik yang menghubungkan widget `Form` dengan state internalnya agar kita bisa memicu pengecekan form dari tombol `Simpan`. Properti `validator` pada tiap `TextFormField` dan `FormField` berisi aturan pengecekan yang mengembalikan teks pesan error jika gagal atau `null` jika valid. Saat tombol `Simpan` ditekan, `_formKey.currentState!.validate()` menjalankan seluruh `validator` di dalam form dan mengembalikan nilai `bool`, yaitu `true` kalau semua validator mengembalikan `null` dan `false` kalau ada yang gagal, sehingga `AlertDialog` hanya dibuka ketika hasilnya `true`. Contoh nilai yang ditolak di form kita adalah input spasi saja seperti `"   "` pada `Judul Pengalaman`, teks `"bukan-url"` pada `URL Thumbnail`, atau `Tanggal Selesai` yang lebih awal dari `Tanggal Mulai`. Memilih tipe keyboard seperti `keyboardType: TextInputType.url` saja belum cukup karena hanya mengatur layout tombol virtual di perangkat mobile, tidak berpengaruh di Chrome desktop, dan tidak mencegah user mengetik spasi atau melakukan copy-paste URL sembarangan. Begitu juga memilih jenis widget input seperti `showDatePicker()` atau `maxLength` hanya membatasi format dasar input, tapi tidak bisa menegakkan aturan bisnis seperti melarang teks wajib yang kosong atau memastikan urutan `Tanggal Selesai` tidak sebelum `Tanggal Mulai` tanpa `validator`.

---

#### Pengungkapan Penggunaan AI Tugas 8

* **Alat yang Digunakan**: Antigravity digunakan untuk membantu merancang rencana implementasi `ExperienceFormPage`, mengekstrak helper validasi di `lib/utils/form_validators.dart`, menghubungkan navigasi `LeftDrawer` dan `ItemCard`, serta menyusun dan memperbaiki widget test di `test/widget_test.dart`.
* **Strategi Prompting**: Meminta perencanaan struktur file dan pembagian commit terlebih dahulu sebelum menulis kode, lalu mengeksekusi perubahan secara bertahap per fitur sambil memverifikasi setiap tahap lewat `flutter analyze` dan `flutter test`.

#### Log Prompting Tugas 8

**Prompt 1:**
> Sekarang waktunya tugas 8. Apa aja requirements nya, planning aja dulu

**Respons AI:**
> Berikut adalah rencana lengkap (planning saja dulu) untuk mengerjakan Tugas 8 agar memenuhi seluruh checklist dan mengincar nilai 4.0 tanpa *overcomplicated*.
>
> **1. Apa Saja yang Harus Dilakukan di Tugas 8**
> * **Halaman Formulir Baru di `lib/screens/`**:
>   * Membuat halaman formulir baru sebagai `StatefulWidget` menggunakan `Form` dan `GlobalKey<FormState>` untuk salah satu bagian portofolio kustom Anda (bukan `Project`).
>   * Minimal 3 input yang sesuai tipe data modelnya, dilengkapi validasi (menolak kosong / hanya spasi, memeriksa batas panjang, format URL, atau urutan tanggal jika ada).
>   * Menggunakan `Scaffold` dan `AppBar` dengan tema yang konsisten dengan halaman utama, serta dibungkus widget penggulir (`SingleChildScrollView`) agar tetap bisa diakses di layar sempit atau saat keyboard muncul.
> * **Navigasi dari Halaman Utama & `LeftDrawer`**:
>   * Menambahkan kartu aksi baru di halaman utama (`lib/screens/menu.dart`) yang membuka formulir baru menggunakan `Navigator.push()` (supaya bisa kembali lewat tombol Back).
>   * Menambahkan opsi baru di `LeftDrawer` (`lib/widgets/left_drawer.dart`) dengan tetap mempertahankan opsi *Home* dan *Add Project*, lalu memasang `LeftDrawer` yang sama di halaman formulir baru.
> * **Validasi & Dialog Ringkasan**:
>   * Tombol **Simpan** memanggil `_formKey.currentState!.validate()`. Jika tidak valid, tampilkan pesan kesalahan di kolom terkait.
>   * Jika seluruh input valid, tampilkan ringkasan seluruh isian di `AlertDialog` melalui `showDialog()` dengan tombol `OK` / `Tutup` untuk menutup dialog dan mereset form.
> * **Kualitas Kode, Pengujian, & Dokumentasi**:
>   * `flutter analyze` bersih (`No issues found!`) dan pengujian berjalan baik.
>   * Memperbarui `README.md` dengan bagian `### Tugas 8` (4 pertanyaan reflektif) + AI Disclosure tanpa menghapus jawaban Assignment 7.
>
> **2. Rancangan Teknis & Strategi Nilai 4.0 (Tetap Simpel)**
>
> Dari dua model kustom di backend Django Anda (`Experience` dan `Skill`), saya merekomendasikan `Experience` (`lib/screens/experience_form.dart`) karena atributnya secara alami cocok dengan seluruh tipe input & validasi yang dicontohkan di soal:
>
> | Field Model Experience | Widget Input di Flutter | Aturan Validasi |
> | :--- | :--- | :--- |
> | `title` (`max_length=255`) | `TextFormField` | Wajib diisi, bukan hanya spasi, maks. 255 karakter |
> | `category` (6 pilihan) | `DropdownButtonFormField<String>` | `Full-Time`, `Part-Time`, `Internship`, `Research`, `Volunteer`, `Freelance` (pakai `initialValue`) |
> | `description` | `TextFormField` (`maxLines: 4`) | Wajib diisi, bukan hanya spasi |
> | `thumbnail` (URL opsional) | `TextFormField` (`TextInputType.url`) | Boleh kosong; jika diisi wajib URL valid (`http://` atau `https://`) |
> | `is_ongoing` | `SwitchListTile` | Default `true`; jika dimatikan (`false`), pemilih Tanggal Selesai otomatis muncul |
> | `started_at` & `ended_at` | `FormField<DateTime>` + `showDatePicker()` | Tanggal mulai wajib dipilih; jika `!is_ongoing`, tanggal selesai wajib dipilih dan tidak boleh sebelum tanggal mulai |
>
> **Poin ekstra yang simpel untuk mengincar nilai 4.0:**
> * **Code Quality (4.0)**: Memisahkan helper validasi ke `lib/utils/form_validators.dart` agar bersih/modular, menambahkan docstrings (`///`) informatif, serta menyelaraskan warna `AppBar` dan `DrawerHeader` memakai `Theme.of(context).colorScheme.primary` (konsisten lintas semua halaman, sekaligus langsung jadi bukti konkret untuk Pertanyaan Reflektif #2).
> * **Functionality & UX (4.0)**: Integrasi `showDatePicker()` di dalam `FormField<DateTime>` (sehingga pesan error tanggal ikut muncul saat tekan **Simpan**), toggle dinamis `SwitchListTile` untuk status Ongoing, dan validasi URL.
> * **Automated Testing**: Memperluas `test/widget_test.dart` untuk menguji navigasi dari kartu & drawer, penolakan input tidak valid, serta munculnya `AlertDialog` ringkasan saat input valid.

#### Analisis Keterbatasan AI & Perbaikan Manual Tugas 8
* **Overflow pada `DrawerHeader` di `LeftDrawer`**: Saat pengujian widget drawer Tugas 8 dijalankan, ditemukan error `RenderFlex overflowed by 78 pixels` pada `Column` di dalam `DrawerHeader` karena ukuran teks judul 30 dan subtitle 15 bawaan dari implementasi Tutorial 09 melebihi tinggi tetap `DrawerHeader`. Ukuran font disesuaikan menjadi 20 dan 13 dengan `MainAxisAlignment.center` supaya aman di layar sempit maupun lingkungan test.
* **Sinkronisasi Scroll dan Floating `SnackBar` pada Widget Test**: Pengujian awal di `test/widget_test.dart` sempat gagal karena `tester.ensureVisible()` tidak otomatis menjalankan `pumpAndSettle()` sehingga koordinat sentuhan masih membaca posisi scroll lama, serta floating `SnackBar` navigasi dari halaman utama sempat menutupi tombol `Simpan`. Test diperbaiki dengan menambahkan helper `_scrollAndTap` yang selalu menjalankan `pumpAndSettle()` setelah scroll dan menyembunyikan `SnackBar` navigasi sebelum interaksi tombol form.
* **Overflow `InfoCard` pada Layar HP Sempit**: Pengujian widget awal dari AI hanya memakai ukuran layar default sehingga bug layout pada layar HP sempat terlewat. Saat aplikasi diuji langsung di Chrome pada viewport `390x844`, muncul error `RenderFlex overflowed by 0.245 pixels on the right` pada `Row` ketiga `InfoCard` di `lib/screens/menu.dart` karena lebar kartu sebelumnya masih dihitung lewat `MediaQuery.of(context).size.width / 3.5` tanpa memperhitungkan margin bawaan `Card`, membuat angka NPM ikut terpotong dan tinggi kartu tidak rata. Saya perbaiki dengan membungkus ketiga `InfoCard` memakai `Expanded` di dalam `IntrinsicHeight` dan `Row` dengan `CrossAxisAlignment.stretch`, menghapus lebar fixed tersebut, menyesuaikan padding dan ukuran font kartu serta `childAspectRatio: 1.2` pada `GridView.count`, lalu menambahkan widget test khusus viewport `360x800` di `test/widget_test.dart` supaya masalah overflow serupa langsung tertangkap saat pengujian.
