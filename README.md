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

### Assignment 9

1. Penggunaan `@JsonSerializable(fieldRename: FieldRename.snake)` dan `@JsonKey(includeToJson: false)` serta Bug yang Dicegah:

    - Pemisahan Lapisan Data dan Compile-Time Type Safety: Dengan mendefinisikan kelas model bertipe kuat (`Experience` di `lib/models/experience.dart` dan `Award` di `lib/models/award.dart`) menggunakan `@JsonSerializable`, logika serialisasi dan deserialisasi dipisahkan dari lapisan antarmuka pengguna (widget). Pendekatan ini memberikan pemeriksaan tipe saat kompilasi (*compile-time type safety*), sehingga kesalahan tipe data atau salah ketik nama atribut langsung terdeteksi oleh Dart analyzer sebelum aplikasi dijalankan—berbeda dengan `Map<String, dynamic>` mentah yang baru ketahuan gagal saat *runtime*.

    - Konversi Otomatis `camelCase` ke `snake_case`: Parameter `fieldRename: FieldRename.snake` secara otomatis memetakan konvensi penamaan variabel *camelCase* pada Dart (seperti `categoryDisplay`, `startedAt`, `endedAt`, `isOngoing`, `certificateUrl`, `isWinner`, `starCount`, dan `starredByNames`) ke kunci JSON *snake_case* yang digunakan oleh `ExperienceSerializer` dan `AwardSerializer` di Django REST Framework (`category_display`, `started_at`, `ended_at`, `is_ongoing`, `certificate_url`, `is_winner`, `star_count`, dan `starred_by_names`).

    - Pengecualian Field Read-Only Server dengan `@JsonKey(includeToJson: false)`: Anotasi ini memastikan atribut yang dibuat atau dihitung sepenuhnya oleh server—seperti `id` (UUID), `started_at`, `created_at`, `category_display`, `is_ongoing`, `star_count`, `is_starred`, dan `starred_by_names`—tidak ikut dikirim ke dalam payload JSON saat aplikasi melakukan permintaan `POST` atau `PATCH`.

    - Contoh Bug Konkret yang Dicegah pada Model `Experience` dan `Award`: Pada `ExperienceSerializer` dan `AwardSerializer`, atribut seperti `ended_at`, `certificate_url`, dan `is_winner` bersifat opsional (`required=False` atau memiliki nilai default). Jika widget mengirim `Map<String, dynamic>` mentah menggunakan penamaan *camelCase* (`{"endedAt": "2026-11-25"}` atau `{"certificateUrl": "https://..."}`), DRF akan mengabaikan kunci yang tidak dikenal tersebut tanpa mengembalikan error dan tetap merespons `201 Created`, sehingga data tanggal selesai pengalaman atau tautan sertifikat penghargaan tersimpan kosong (`null`) secara diam-diam (*silent data loss*). Selain itu, mengecualikan `id` melalui `@JsonKey(includeToJson: false)` mencegah pengiriman `"id": null` di body request yang berpotensi memicu error validasi primary key pada serializer.

2. Inisialisasi `Future` di dalam `initState()` dan Penggunaan `ApiException` pada `ApiClient`:

    - Alasan `Future` Diinisialisasi di dalam `initState()`: Di Flutter, metode `build()` bersifat deklaratif dan dapat dipanggil berulang kali secara cepat setiap kali terjadi perubahan ukuran layar, kemunculan keyboard, animasi, atau pembaruan state widget induk. Jika pemanggilan HTTP seperti `context.read<ApiClient>().getExperiences()` atau `getAwards()` diletakkan langsung di dalam `build()`, setiap *rebuild* akan memicu permintaan jaringan baru dan mengembalikan `FutureBuilder` ke `ConnectionState.waiting`, yang menyebabkan tampilan berkedip (*flickering*), pemborosan kuota jaringan, dan beban berulang ke server Django. Dengan menyimpan `_experiencesFuture` dan `_awardsFuture` satu kali di dalam `initState()` (dan hanya memperbaruinya secara eksplisit di dalam metode `_reload()` saat pengguna menarik `RefreshIndicator` atau menekan tombol *Retry*), siklus pemanggilan API terpisah bersih dari siklus *rendering* UI.

    - Alasan `ApiClient` Melempar `ApiException` Alih-alih Mengembalikan `null`: Mengembalikan nilai `null` ketika server merespons status non-2xx akan menyamarkan perbedaan antara "permintaan berhasil tetapi daftar memang kosong" dan "permintaan gagal karena error jaringan/otorisasi", sekaligus menghilangkan informasi kode status HTTP. Dengan melempar `ApiException(statusCode, message)` di dalam `_ensureSuccess()`, `FutureBuilder` dapat menangkap kegagalan melalui `snapshot.hasError` untuk merender pesan kesalahan beserta tombol *Retry*, sementara halaman form dan detail (`ExperienceFormPage`, `AwardFormPage`, `ExperienceDetailScreen`, dan `AwardDetailScreen`) dapat menangani status `401 Unauthorized` secara spesifik—yaitu menghapus sesi lokal melalui `AuthState.clearSession()` dan mengarahkan pengguna kembali ke `LoginScreen`—terpisah dari error validasi `400` atau error server `500`.

3. Perbandingan `SessionAuthentication` Django dengan `TokenAuthentication` DRF serta Penggunaan Keduanya:

    - Cara Kerja `SessionAuthentication` (Tutorial 04/07): Mekanisme ini bersifat *stateful* di sisi server. Saat pengguna login melalui browser, Django membuat entri sesi di database/cache dan mengirimkan cookie `sessionid` ke browser. Pada setiap permintaan berikutnya, browser otomatis menyertakan cookie tersebut, sehingga server wajib memvalidasi token CSRF (`X-CSRFToken`) pada setiap request non-GET untuk mencegah serangan *Cross-Site Request Forgery*.

    - Cara Kerja `TokenAuthentication` (Tutorial 10): Mekanisme ini bersifat *stateless* terhadap cookie dan sesi browser. Klien mengirimkan kredensial (`username` dan `password`) satu kali ke endpoint `/api/v1/auth/token/` untuk mendapatkan kunci token unik, lalu menyisipkan kunci tersebut secara eksplisit pada header HTTP `Authorization: Token <key>` di setiap permintaan terautentikasi (`POST`, `PATCH`, `DELETE`, maupun `POST .../star/`), dan mencabutnya melalui `/api/v1/auth/logout/`.

    - Alasan `myportfolio_mobile` Menggunakan `TokenAuthentication` Sementara `SessionAuthentication` Tetap Aktif di Django: Aplikasi mobile berbasis Flutter berjalan di luar lingkungan browser sehingga tidak mengelola cookie sesi dan token CSRF secara otomatis; autentikasi berbasis header `Authorization: Token <key>` jauh lebih eksplisit, lintas platform (Android, iOS, maupun Flutter Web), dan bebas dari kendala sinkronisasi cookie-CSRF lintas origin. Di sisi lain, `SessionAuthentication` tetap dipertahankan pada `REST_FRAMEWORK["DEFAULT_AUTHENTICATION_CLASSES"]` (diurutkan setelah `TokenAuthentication`) agar aplikasi web Django dari Tutorial 04/07—termasuk halaman HTML, Django Admin, dan panggilan AJAX `fetch` berbasis cookie—tetap berfungsi normal tanpa perlu diubah, sementara klien mobile yang tidak mengirim token tetap menerima respons `401 Unauthorized` yang sesuai.

4. Peran Job `build` dan `build_apk` pada CI/CD serta Alasan `*.g.dart` Diabaikan di `.gitignore`:

    - Peran Job `build` (`VeryGoodOpenSource/very_good_workflows`): Job ini berfungsi sebagai gerbang Continuous Integration (CI) otomatis setiap kali ada `push` ke branch `main` atau `pull_request`. Di balik layar, `flutter_package.yml@v2` menjalankan langkah persiapan (`setup: dart run build_runner build --delete-conflicting-outputs`), memeriksa konsistensi pemformatan kode (`dart format --output=none --set-exit-if-changed .`), melakukan analisis statis untuk mendeteksi warning atau error (`flutter analyze`), mengeksekusi seluruh unit test dan widget test beserta perhitungan *code coverage* (`flutter test --coverage` dengan mengecualikan `**/*.g.dart`), serta memverifikasi ambang `min_coverage`.

    - Peran Job `build_apk`: Job ini berfungsi sebagai tahap Continuous Delivery (CD) yang dikonfigurasi dengan `needs: build` sehingga hanya dieksekusi apabila seluruh pemeriksaan kualitas di job `build` dinyatakan lulus. Job ini menyiapkan lingkungan Flutter channel `stable`, mengunduh dependensi (`flutter pub get`), menghasilkan ulang berkas serialisasi JSON (`dart run build_runner build --delete-conflicting-outputs`), mengompilasi paket rilis Android (`flutter build apk --release`), dan mengunggah `build/app/outputs/flutter-apk/app-release.apk` sebagai artefak bernama `app-release-apk` melalui `actions/upload-artifact@v4` agar dapat diunduh langsung dari halaman ringkasan GitHub Actions.

    - Alasan Berkas `*.g.dart` Dimasukkan ke `.gitignore`: Berkas `*.g.dart` (`experience.g.dart` dan `award.g.dart`) merupakan kode hasil generasi mesin yang bersifat deterministik berdasarkan anotasi pada `lib/models/*.dart` dan versi dependensi di `pubspec.lock`. Mengecualikan berkas tersebut dari Git menjaga riwayat *commit* tetap ringkas dan berfokus pada kode yang ditulis manusia, menghindari konflik penggabungan (*merge conflict*) antar-branch pada kode turunan, serta mencegah *diff* yang berisik setiap kali atribut model diperbarui—sementara lingkungan CI/CD tetap dapat merekonstruksi berkas `*.g.dart` yang identik secara otomatis melalui perintah `build_runner`.

AI DISCLOSURE

1. Tools & Strategi Prompting

    - Tools yang digunakan: Gemini sebagai asisten pemrograman dan peninjau arsitektur integrasi backend Flutter dan Django REST Framework.

    - Strategi Prompting: Menggunakan pendekatan *context-grounded iterative prompting*—memberikan spesifikasi rubrik Tugas 9, berkas serializer dan routing backend Django (`serializers.py`, `api_urls.py`, `api_views.py`), serta berkas proyek Flutter yang sudah ada dari Tutorial 10 sebelum meminta implementasi bertahap yang dipecah ke dalam *conventional commits* berkala.

    - Ringkasan Log Prompting:

        - Prompt 1 (Inventaris & Rencana Kerja Bertahap): Memetakan berkas yang dibutuhkan dari `myportofolio_mobile` dan backend Django, lalu menyusun urutan pengerjaan per tahap dengan checkpoint *conventional commits*.

        - Prompt 2 (Pemodelan JSON & Layanan API): Melengkapi atribut model `Experience` (`star_count`, `is_starred`, `starred_by_names`), membuat model `Award` beserta code generation `build_runner`, dan memperluas `ApiClient` dengan operasi `GET`, `POST`, `PATCH`, `DELETE`, serta `star/`.

        - Prompt 3 (Antarmuka List, Detail, Form Terautentikasi, & Pengujian): Memperbarui halaman daftar/detail `Experience`, menambahkan halaman daftar/detail/formulir `Award`, menerapkan penanganan sesi `401`, serta menyusun unit test `MockClient` di `test/api_client_test.dart`.

        - Prompt 4 (Refinement Dokumentasi): Menyusun jawaban reflektif dan analisis keterbatasan AI pada `README.md` sesuai gaya dokumentasi proyek.

    - Bagian Spesifik yang Dibantu AI:

        - Menyusun pemetaan `@JsonSerializable` pada `lib/models/award.dart` dan pembaruan `lib/models/experience.dart` agar selaras dengan serializer DRF.

        - Merancang metode CRUD dan fitur *star* terautentikasi pada `lib/services/api_client.dart` serta komponen layar `AwardListScreen`, `AwardDetailScreen`, dan `AwardFormPage`.

        - Menyusun kerangka pengujian otomatis menggunakan `MockClient` (`package:http/testing.dart`) pada `test/api_client_test.dart` untuk memverifikasi serialisasi *snake_case* dan penanganan status `401`.

2. Analisis Keterbatasan AI & Perbaikan Manual yang Dilakukan

    - Ketidaksesuaian Nullability pada Model vs Layar Detail Lama: Setelah atribut `thumbnail` pada model `Experience` diubah menjadi tipe non-nullable `String` dengan `@JsonKey(defaultValue: '')`, kode lama di `lib/screens/experience_detail_screen.dart` masih memeriksa `experience.thumbnail != null` dan memakai operator `!`. Hal ini memicu peringatan `unnecessary_null_comparison` dan `unnecessary_non_null_assertion` saat dijalankan `flutter analyze`. Saya membersihkan pemeriksaan null yang redundan tersebut secara manual hingga `flutter analyze` lulus tanpa isu.

    - Pemisahan Pembersihan Sesi Lokal Saat Respons `401 Unauthorized`: Pada draf awal penanganan error `401`, pemanggilan `context.read<AuthState>().logout()` di blok `catch` ikut mengirimkan permintaan HTTP `POST` ke `/api/v1/auth/logout/` menggunakan token yang sebenarnya sudah kedaluwarsa atau dicabut di Django Admin. Saya menambahkan metode khusus `clearSession()` pada `lib/services/auth_state.dart` untuk langsung menghapus token di memori dan memberi tahu *listener* tanpa melakukan panggilan jaringan yang pasti gagal sebelum mengarahkan pengguna ke `LoginScreen`.

    - Sinkronisasi Refresh Daftar Setelah Mutasi Data (Create, Edit, Delete, Star): Navigasi standar `Navigator.push()` ke layar detail atau formulir tidak otomatis memperbarui state daftar pada `ExperienceListScreen` dan `AwardListScreen` ketika pengguna kembali. Saya menambahkan callback `onDataChanged` pada layar detail serta meneruskan hasil objek tersimpan melalui `Navigator.pop(context, saved)` pada layar formulir agar daftar langsung memanggil `_reload()` begitu terjadi perubahan data.

    - Kepatuhan Pemformatan CI (`very_good_workflows`): Beberapa baris kode hasil pengeditan memiliki panjang baris atau indentasi yang tidak sesuai standar formatter Dart sehingga berpotensi menggagalkan job `build` di GitHub Actions. Saya menjalankan `dart format .`, `dart format --output=none --set-exit-if-changed .`, `flutter analyze`, dan `flutter test` secara lokal sebelum melakukan *merge* dan *push* ke branch `main`.