# myportofolio_mobile

Nama : Malvin Lionard
NPM : 2506591753
Kelas : PBP F

Log Progres Mingguan
- Tutorial 8 --> Inisialisasi proyek myportofolio_mobile, memisahkan menu.dart dari main.dart, mengonversi MyHomePage menjadi StatelessWidgets, dan membuat komponen dasar InfoCard dan ItemCard.
- Tugas 7 --> Mengedit identitas pemilik portofolio sesuai data pribadi saya, menambahkan atribut color di model ItemHomepage untuk membedakan warna dari setiap ItemCard, modularisasi arsitektur kode ke folder models/ dan widgets/, memperbaiki UX (terutama di bagian profile hero banner, floating snackbar, dan singlechildscrollview), dan mengisi dokumentasi serta pertanyaan reflektif di README.md

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