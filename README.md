# myportofolio_mobile

Nama : Malvin Lionard
NPM : 2506591753
Kelas : PBP F

Log Progres Mingguan
- Tutorial 8 --> Inisialisasi proyek myportofolio_mobile, memisahkan menu.dart dari main.dart, mengonversi MyHomePage menjadi StatelessWidgets, dan membuat komponen dasar InfoCard dan ItemCard.
- Tugas 7 --> Mengedit identitas pemilik portofolio sesuai data pribadi saya, menambahkan atribut color di model ItemHomepage untuk membedakan warna dari setiap ItemCard, modularisasi arsitektur kode ke folder models/ dan widgets/, memperbaiki UX (terutama di bagian profile hero banner, floating snackbar, dan singlechildscrollview), dan mengisi dokumentasi serta pertanyaan reflektif di README.md
- Tugas 8 --> Me,buat halaman formulir ExperienceFormPage di lib/screens/experience_form.dart dengan validasi teks, DropdownButtonFormField, showDatePIcker, validasi urutan tanggal dan URL, toggle status aktif saaat ini, dan AlertDialog ringkasan, lalu menambahkan kartu aksi Tambah Pengalaman di halaman utama serta opsi Add EXperience di LeftDrawer.

### Tugas 7

1. Widget tree di Flutter adalah struktur hierarki yang bentuknya seperti pohon yang merepresentasikan seluruh elemen antarmuka pengguna dari konfigurasi aplikasi tingkat paling atas sampai elemen visual terkecil, seperti teks, ikon, atau padding. Di Flutter ini, hampir seluruh komponen antarmukanya widget, dan aplikasi dibangun dengan menyusun widget di dalam widget lain (konsep composition over inheritance). Hubungan induk-anak bekerja dengan mekanisme constraints dan posisi, yaitu:
    - induk memberikan batasan atau constraints ke widget anak di bawahnya, misal aturan ukuran minimum dan maksimum.
    - Anak menentukan ukuran berdasarkan batasan yang sudah ditentukan induknya tadi, dengan menghitung dan melaporkan ukuran yang si anak butuhkan ke induk.
    - Induk mengatur posisi dengan menempatkan widget anak pada koordinat tertentu di layar. Widget induk menggunakan properti child jika anaknya hanya satu, atau children jika anaknya banyak.

2. Seluruh widget yang saya gunakan di proyek myportofolio_mobile:
    - MyApp (Stateless Widget) --> Root widget custom aplikasi yang membungkus MaterialApp.
    - MaterialApp --> Menyediakan konfigurasi inti aplikasi berbasis Material Design, misalnya judul, tema warna, dan halaman awal.
    - MyHomePage (Stateless Widget) --> Widget halaman utama aplikasi yang menyusun struktur antarmuka menu portofolio.
    - Scaffold --> Menyediakan kerangka tata letak halaman Material Design yang mencakup AppBar, area untuk isi utama, dan konteks tampilan untuk SnackBar.
    - AppBar --> Bagian navigasi yang ada di atas layar untuk menampilkan judul dan ikon aplikasi.
    - SingleChildScrollView --> Membuat seluruh konten halaman dapat di-scroll secara vertikal sehingga tidak terjadi RenderFlex overflow di layar yang ukurannya kecil.
    - Padding --> Memberikan ruang jarak kosong di sekeliling widget anak agar elemennya tidak menempel langusng ke tepi layar atau batas.
    - Column --> Menyusun daftar widget anak secara vertikal (dari atas ke bawah).
    - Row --> Menyusun daftar widget anak secara horizontal (dari kiri ke kanan).
    - Container --> Kotak untuk mengatur dekorasi visual (gradasi, sudut kotak menjadi bulat, border, dan padding).
    - CircleAvatar --> Menampilkan lingkaran profil pada banner sambutan pengguna.
    - Expanded --> Membagi ruang yang ada dengan proporsional di dalam Row agar seluruh InfoCard punya lebar yang seragam dan teks di dalam SnackBar tidak meluap.
    - SizedBox --> Memberikan jarak pemisah, baik horizontal maupun vertikal, antarwidget.
    - Text --> Menampilkan stirng teks pada layar dengan style yang bisa diatur.
    - Icon --> Menampilkan ikon grafis dari Material Icons.
    - InfoCard (Stateless Widget) --> Widget kustom untuk menampilkan card identitas mahasiswa.
    - Card --> Kontainer Material Desain dengan elevation dan sudut rounded untuk membungkus konten InfoCard.
    - GridView.count --> Menyusun daftar ItemCard ke dalam grid dengan rapi.
    - ItemCard (Stateless Widget) --> Widget yang merepresentasikan satu kartu tombol aksi dengan warna dan interaksi ketika disentuh.
    - Material --> Permukaan Material Desain yang memberikan warna background, elevasi bayangan, dan efek klip sudut agar animasinya mengikuti bentuk kartu,
    - InkWell --> Area interaktif yang merespons sentuhan pengguna dengan efek visual.
    - SnackBar --> Bagian notifikasi sementara di bawah layar yang memberikan feedback langsung stelah pengguna menekan salah satu ItemCard.
    - Wrap --> Menyusun daftar chip keahilan teknologi secara horizontal dan otomatis berpindah baris kalau ruangnya tidak cukup.
    - Chip --> Elemen kapsul untuk menampilkan label teknologi.

3. MaterialApp berfungsi sebagai fondasi utama pada aplikasi yang mengimplementasikan spesifikasi sistem desain Material Design dari Google. Widget ini mengelola berbagai konfigurasi global aplikasi dalam satu tempat, yaitu sistem tema dan skema warna, sistem navigasi dan peruteran antarhalaman, lokalisasi bahasa, serta penyediaan ScaffoldMessenger untuk menampilkan notifikasi seperti SnackBar. Material App umumnya ditempatkan sebagai root widget karena ia "menyuntikkan" berbagai objek konfigurasi penting ke bagian paling atas dari widget tree. Karena ada di puncak pohon, seluruh widget turunan di bawahnya bisa mewarisi dan mengakses tema, ukuran layar, maupun rute navigasi secara konsisten lewat BuildContext tanpa perlu mengoper parameter secara manual.

4. Perbedaan antara StatelessWidget dan StatefulWidget adalah kemampuan menyimpan dan memperbarui data yang memengaruhi tampilan antarmukanya, yaitu:
    - StatelessWidget itu immutable atau tidak dapat diubah setelah dibuat. Konfigurasinya bergantung hanya pada parameter yang diterusukan saat konstruktor dipanggil, dan metode build() hanya dipanggil ulang jika widget induknya membangun ulang widget tersebut dengan argumen yan gbaru.
    - StatefulWidgetitu mutable karena dipasangkan dengan objek State terpisah yang menyimpan data dinamis. Kalau ada data internal yang berubah dan metode setState() diapnggil, Flutter akan menandai widget tersebut sebagai dirty dan memanggil ulang metode build() untuk memperbarui tampilan antarmuka sesuai dengan state yang terbaru.
Kita menggunakan StatelessWidget ketika tampilakn widgetnya statis atau tidak berubah, misalnya kartu profil InfoCard, kartu tombol ItemCard, layar informasi, atau halaman menu. Alasannya karena elemen-elemen tersebut memang tidak akan berubah dan lebih ringan secara memori. Di sisi lain, kita menggunakan StatefulWidget jika widgetnya perlu mengelola interaksi atau data yang berubah secara dinamis di layar, misalnya input formulir, checkbox, counter, maupun animasi.

5. BuildContext adalah objek handle yang merepresentasikan lokasi spesifik sebuah widget di dalam widget tree Flutter. Secara internal, setiap widget memiliki Elemenet sendiri yang mengimplementasikan antarmuka BuildContext. BuildContext sangat penting karena Flutter menggunakan struktur pohon yang dalam. Kalau tanpa BuildContext, widget tidak tahu posisinya di mana dan tidak tahu cara berkomunikasi dengan widget yang ada di atasnya. Di dalam metode build(BuildContext context), parameter context digunakan untuk melakukan pencarian ke atas pohon menuju widget induk terdekat yang menyediakan konfigurasi bersama, misalnya untuk ambil skema warna dan tipografi tema, menampilkan notifikasi SnackBar pada Scaffold terdekat, atau berpindah halaman.

6. Hot Reload menyuntikkan berkas kode Dart yang sudah dimodifikasi langsung ke Dart Virtual Machine yang sedang berjalan. Setelah VM memperbarui kelas dan fungsi yang berubah, Flutter akan membangu ulang widget tre dengan tetap mempertahankan state aplikasi saat itu. Sedangkan, hot restart memuat ulang seluruh kode aplikasi ke dalam Dart VM dan menjalankan ulan gaplikasi dari fungsi main() dari awal, jadi seluruh state aplikasi direset ke kondisi awal, tapi tidak perlu compile ulang dari nol. Kita harus menggunakan hot restart dan bukan hot reload ketika perubahan kodenya terjadi di inisialisasi state awal di dalam initState(), perubahan variabel global atau static const, perubahan pada struktur fungsi di main(), atau perubahan konstruktor dan tipe kelas yang memengaruhi siklus hidup state, lalu untuk full restart adalah ketika perubahannya terjadi di luar kode Dart, misalnya menambahkan paket atau dependensi baru pada pubspec.yaml, mendaftarkan aset gambar baru, atau mengubah konfigurasi kode native platform.

AI DISCLOSURE

Dalam pengerjaan Tugas Individu 7 ini, saya menggunakan Gemini sebagai asisten dengan prompt yang berfokus dari Tutorial 8.

- Bagian yang dibantu oleh AI:
a. Membantu merancang pemisahan file dari struktur lama di Tutorial 8 menjadi modul terpisah.
b. Membantu menyusun palet warna kartu ItemCard serta merapikan tata letak komponen visual.
c. Membantu menyusun jawaban reflektif di README.

ANALISIS KETERBATASAN AI

1. Pada draf awal, penyusunan GridView.countt di dalam Column bisa memicu RenderFlew overflow di layar yang keci. Saya membungkus body menggunakan SingleChildScrollView dan menambahkan physics: const NeverScrollableScrollPhysics() di GridView.count.
2. Beberapa saran kode Dart masih menggunakan metode .withOpacity() yang sudah deprecated di versi Flutter terbaru. Saya memeriksa dengan flutter analyze dan menggantinya dengan .withValues().
3. AI cenderung menyarankan variasi teks pesan interaktif yang berbeda-beda untuk tiap tombol. Saya mengganti teks SnackBar agar selalu "Kamu telah menekan tombol ${item.name}!".

### Tugas 8

1. Perbedaan Navigator.push(), Navigator.pushReplacement(), dan Navigator.pop() serta Alur Navigasi Aplikasi:

    - Navigator.push() menambahkan rute (route) halaman baru ke puncak tumpukan navigasi (navigation stack) tanpa menghapus halaman sebelumnya. Pengguna masih bisa kembali ke halaman sebelumnya menggunakan tombol kembali bawaan perangkat atau Navigator.pop(). Metode inilah yang digunakan saat menekan kartu aksi Tambah Pengalaman di ItemCard sehingga riwayat halaman utama tetap tersimpan di bawah tumpukan.

    - Navigator.pushReplacement() menggantikan rute halaman yang sedang aktif di puncak tumpukan dengan rute halaman baru, sehingga halaman lama dihapus dari tumpukan dan tidak dapat dikembalikan dengan tombol back biasa. Metode ini dipakai pada opsi navigasi di LeftDrawer.

    - Navigator.pop() menghapus rute teratas dari tumpukan navigasi untuk kembali ke halaman sebelumnya, atau menutup lapisan overlay seperti AlertDialog setelah pengguna menekan tombol Tutup.

    - Untuk alur navigasinya, ketika pengguna berada di ExperienceFormPage (baik dibuka melalui kartu aksi maupun melalui drawer) lalu membuka LeftDrawer dan menekan Home, LeftDrawer memanggil Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyHomePage())). Rute halaman formulir langsung digantikan oleh halaman utama MyHomePage, sehingga pengguna kembali ke beranda secara mulus meskipun aplikasi dijalankan di Chrome tanpa tombol kembali fisik.

2. Peran Scaffold, AppBar, dan Drawer dalam Konsistensi Struktur serta Contoh Penggunaan Tema:

    - Scaffold menyediakan kerangka tata letak standar Material Design yang memiliki slot tetap untuk appBar, drawer, dan body. Dengan mempertahankan susunan Scaffold -> AppBar -> LeftDrawer pada MyHomePage, ProjectFormPage, dan ExperienceFormPage, pengguna selalu menemukan posisi judul di bagian atas, ikon menu garis tiga di pojok kiri atas, dan area konten utama di tengah layar secara konsisten.

    - Contoh penggunaan warna tema portofolio di lebih dari satu halaman: Skema warna utama aplikasi didefinisikan terpusat di main.dart melalui ColorScheme.fromSeed(seedColor: Colors.indigo) dan diakses lewat Theme.of(context).colorScheme.primary. Warna colorScheme.primary ini digunakan secara konsisten sebagai backgroundColor pada AppBar di MyHomePage (menu.dart), AppBar di ExperienceFormPage (experience_form.dart), dan latar belakang DrawerHeader di LeftDrawer (left_drawer.dart).

3. Alasan Pemilihan Tata Letak Formulir dan Peran Widget Pengatur Jarak serta Penggulir:

    - Formulir disusun menggunakan pola SafeArea -> Form -> SingleChildScrollView -> Column dengan crossAxisAlignment: CrossAxisAlignment.stretch. Tata letak vertikal satu kolom dipilih karena paling ergonomis untuk pengisian data di layar perangkat bergerak (mobile-first), membuat alur baca dari atas ke bawah jelas, dan menjaga lebar setiap kolom input tetap proporsional.

    - Peran widget penggulir (SingleChildScrollView): Ketika layar ponsel sempit atau papan ketik virtual (on-screen keyboard) muncul dan menyita hampir separuh tinggi layar, SingleChildScrollView memungkinkan pengguna menggulir halaman ke atas dan ke bawah sehingga seluruh input maupun tombol Simpan di bagian bawah tetap dapat dijangkau tanpa memicu error RenderFlex overflow.

    - Peran widget pengatur jarak (Padding dan SizedBox): Padding(padding: EdgeInsets.all(16.0)) memberi margin aman antara tepi layar dan komponen formulir, sedangkan SizedBox(height: 14.0) dan SizedBox(width: 12.0) memberi jeda antar-field dan antar-tombol (Reset & Simpan) agar elemen tidak saling berhimpitan, pesan error validasi memiliki ruang tampil yang jelas, dan target sentuh jari tidak keliru.

4. Peran GlobalKey<FormState>, validator, dan validate() serta Mengapa Tipe Input Saja Tidak Cukup:

    - GlobalKey<FormState> berperan sebagai pengenal unik yang memegang referensi langsung ke objek FormState dari luar pohon widget Form, sehingga state formulir dapat diakses saat tombol Simpan ditekan.

    - validator adalah fungsi callback pada tiap TextFormField atau FormField yang menerima nilai input terkini, memeriksa aturan model, dan mengembalikan pesan String kesalahan jika tidak valid atau null jika valid.

    - validate() (dipanggil lewat _formKey.currentState!.validate()) mengeksekusi seluruh fungsi validator pada setiap field di dalam Form secara serentak, memicu tampilan pesan error merah di bawah kolom yang bermasalah, dan hanya mengembalikan true apabila seluruh field lolos validasi.

    - Contoh nilai yang ditolak oleh validasi: String yang hanya berisi spasi seperti "     " pada kolom Posisi / Peran, string "bukan-url" pada kolom Tautan Bukti, atau Tanggal Selesai yang dipilih lebih awal daripada Tanggal Mulai (misalnya mulai 10 Oktober 2026, selesai 1 Oktober 2026).

    - Mengapa jenis input atau papan ketik saja belum cukup: Pengaturan seperti keyboardType: TextInputType.url atau pemilih tanggal showDatePicker hanya membantu kenyamanan tampilan papan ketik/UI di sisi klien, tetapi tidak mencegah pengguna menempelkan (paste) teks sembarangan, mengetik spasi kosong, memasukkan teks terlalu pendek/panjang, atau memilih tanggal selesai yang secara logika mendahului tanggal mulai. Oleh karena itu, validasi eksplisit di dalam validator tetap wajib dilakukan untuk menjamin integritas data.

AI DISCLOSURE

1. Tools & Strategi Prompting

    - Tools yang digunakan: Gemini sebagai asisten pemrograman dan peninjau arsitektur kode Flutter.

    - Strategi Prompting: Menggunakan pendekatan context-grounded iterative prompting—menyertakan spesifikasi rubrik Tugas 8 dan seluruh berkas kode yang sudah ada dari Tutorial 9 (main.dart, menu.dart, project_form.dart, left_drawer.dart, item_card.dart, dan pubspec.yaml) sebelum meminta implementasi bertahap.

    - Ringkasan Log Prompting:

        - Prompt 1 (Konteks & Inventaris Berkas): Meminta daftar berkas yang dibutuhkan dari repositori Tutorial 9 agar implementasi Tugas 8 selaras dengan struktur proyek yang ada.

        - Prompt 2 (Implementasi Bertahap & Git Workflow): Meminta panduan langkah demi langkah pembuatan halaman ExperienceFormPage, pembaruan LeftDrawer, penambahan kartu aksi di ItemCard dan menu.dart, lengkap dengan checkpoint conventional commits secara berkala.

        - Prompt 3 (Refinement & Dokumentasi): Meninjau manajemen Git (git commit --amend) dan menyusun dokumentasi reflektif README.md.

    - Bagian Spesifik yang Dibantu AI:

        - Merancang kerangka halaman formulir baru ExperienceFormPage di lib/screens/experience_form.dart beserta pemisahan fungsi helper validasi dan pemformatan tanggal.

        - Menyusun integrasi opsi Add Experience pada LeftDrawer (lib/widgets/left_drawer.dart) dan rute navigasi Navigator.push() pada ItemCard (lib/widgets/item_card.dart).

        - Meninjau kejelasan struktur penjelasan konsep navigasi dan validasi formulir pada jawaban reflektif Tugas 8.

2.  Analisis Keterbatasan AI & Perbaikan Manual yang Dilakukan

    - Sinkronisasi State Saat Reset Formulir (DropdownButtonFormField & SwitchListTile): Pada pola standar formulir seperti di Tutorial 9, pemanggilan _formKey.currentState!.reset() hanya mengembalikan nilai widget turunan FormField, tetapi tidak otomatis mereset variabel state kustom seperti _isCurrent, _startDate, dan _endDate. Saya menambahkan metode khusus _resetForm() secara manual untuk membersihkan seluruh TextEditingController sekaligus menyinkronkan ulang state tanggal, switch status aktif, dan opsi dropdown di dalam setState().

    - Integrasi Validasi showDatePicker() ke dalam FormState: Pemilih tanggal showDatePicker() secara bawaan bukan merupakan TextFormField, sehingga tidak otomatis ikut tervalidasi saat _formKey.currentState!.validate() dipanggil. Saya membungkus input tanggal ke dalam widget FormField<DateTime> dan memanggil fieldState.didChange(picked) agar validasi tanggal wajib serta urutan tanggal (endDate.isBefore(startDate)) tampil konsisten layaknya kolom input teks lainnya.

    - Proporsi Tata Letak Kartu Aksi pada Layar Sempit: Penambahan kartu aksi ke-4 (Tambah Pengalaman) pada tata letak lama GridView.count(crossAxisCount: 3) membuat baris kedua hanya terisi satu kartu dan menyebabkan label teks terpotong pada lebar layar ponsel (360px). Saya mengubah konfigurasi grid secara manual menjadi kisi 2x2 (crossAxisCount: 2, childAspectRatio: 1.45) agar seluruh kartu tampil simetris dan mudah dibaca.

    - Kepatuhan API Flutter Terbaru & Manajemen Memori (flutter analyze): Beberapa draf kode Dart berpotensi memicu peringatan deprecated member use (seperti .withOpacity() atau value pada DropdownButtonFormField). Saya melakukan verifikasi melalui flutter analyze, menggantinya dengan .withValues(alpha: ...) dan initialValue, serta memastikan seluruh TextEditingController dibersihkan melalui metode dispose().