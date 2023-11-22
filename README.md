# README.md
**UPDATE: 08 Nov 2023. Jawaban Tugas 7 ditambahkan.**

**UPDATE: 15 Nov 2023. Jawaban Tugas 8 ditambahkan.**

**UPDATE: 22 Nov 2023. Jawaban Tugas 9 ditambahkan.**


Berikut jawaban README.md untuk tugas-tugas yang ada.

<br>

## TUGAS 9

### QUESTION 1.
Bisa, namun pendekatan ini tidak lebih baik daripada membuat model sebelum pengambilan data JSON. Saat menggunakan model, data akan menjadi lebih terstruktur dan lebih mudah untuk digunakan & diolah. Pengambilan data tanpa JSON tidak memiliki keuntungan ini, ia lebih rawan terhadap *human error* dalam penggunaannya.

<br>

### QUESTION 2.
CookieRequest adalah bagian dari pbp_django_auth yang berfungsi untuk mendapatkan cookie yang dibuat pada awal sesi pengguna (saat user login). Ia perlu dibagikan ke semua komponen di aplikasi Flutter agar cookie yang ada dijaga tetap sinkron pada keseluruhan aplikasi untuk mempertahankan sesi pengguna.

<br>

### QUESTION 3.
Sebelum mengambil data dari JSON, saya buat terlebih dahulu class Product dalam `product.dart` sebagai model untuk menyimpan data yang akan diambil. Method utama yang dipakai dari class Product ini untuk pengambilan data adalah kode berikut:

```
class Product {
  ...

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  ...
}
```

Pengambilan data-nya sendiri dilakukan pada `list_product.dart` seperti berikut:

```
Future<List<Product>> fetchProduct() async {
    var url =
        Uri.parse('http://url-name/json-by-username/$username_global/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Product> list_product = [];
    for (var d in data) {
      if (d != null) {
        list_product.add(Product.fromJson(d));
      }
    }
    return list_product;
  }
```

Setelah data diambil dan diconvert menjadi object dari class Product, objek-objek tersebut siap untuk digunakan dan ditampilkan pada aplikasi Flutter.

<br>

### QUESTION 4.
Mekanisme autentikasi dari input data akun pada Flutter ke Django dimulai dari inisiasi CookieRequest baru sebagai berikut:

```
final request = context.watch<CookieRequest>();
```

Setelahnya, user log in dari Flutter melalui `login.dart` dan dihubungkan dengan proses authentication pada aplikasi Django:

Kode login.dart di Flutter:
```
final response =
    await request.login("http://127.0.0.1:8000/auth/login/", {
  'username': username,
  'password': password,
});
```

Kode authentication/views.py di Django:

```
@csrf_exempt
def login(request):
    username = request.POST['username']
    password = request.POST['password']
    user = authenticate(username=username, password=password)
    if user is not None:
        if user.is_active:
            auth_login(request, user)
            # Status login sukses.
            return JsonResponse({
                "username": user.username,
                "status": True,
                "message": "Login sukses!",
                # "user": user,
                # Tambahkan data lainnya jika ingin mengirim data ke Flutter.
            }, status=200)
        else:
            return JsonResponse({
                "status": False,
                "message": "Login gagal, akun dinonaktifkan."
            }, status=401)

    else:
        return JsonResponse({
            "status": False,
            "message": "Login gagal, periksa kembali email atau kata sandi."
        }, status=401)
```

Setelah user log in dan proses authentication selesai, user di-redirect ke tampilan menu pada flutter.

<br>

### QUESTION 5.
##### Widget yang digunakan pada tugas ini:
- **Text**: Sebuah widget yang menampilkan teks dengan suatu gaya tertentu
- **TextField**: Sebuah widget yang memungkinkan pengguna untuk memasukkan teks dalam aplikasi Flutter
- **ElevatedButton**: Sebuah widget yang membuat tombol dengan tampilan sedikit lebih tinggi (*elevated*) di aplikasi flutter
- **SizedBox**: Sebuah widget yang membuat kotak dengan ukuran tertentu dalam aplikasi Flutter
- **ListView**: Sebuah layout widget yang digunakan untuk menampilkan sejumlah widget yang bisa digulir secara vertikal atau horizontal

<br>

### QUESTION 6.
##### Implementasi Checklist:
- Pertama, saya membuat aplikasi `authentication` pada project Django yang pernah saya buat dan saya mengatur `settings.py` pada project saya agar authentication masuk dalam INSTALLED_APPS. Saya juga menambahkan hal-hal lainnya pada settings.py seperti corsheaders, middleware, dan variabel-variabel lainnya.
- Menambahkan method login dan logout pada `authentication/views.py`, menambahkan routingnya kepada `authentication/urls.py` dan `sentimental_sylladex/urls.py`. 
- Install package provider dan pbp_django_auth pada aplikasi flutter.
- Menambahkan `Provider` pada main.dart, menghubungkan semua komponen aplikasi dengan `CookieRequest`.
- Membuat screen `login.dart` pada folder screens.
- Membuat model `product.dart` pada folder models sesuai dengan model yang digunakan pada project Django.
- Membuat page `list_product.dart` yang mengimport data yang didapatkan dari https://url/json-by-username/$username_global/ dan menambahkan dependensi http.
- Mengubah page `lihat_item.dart` agar menampilkan informasi khusus per-item dan menambahkan ElevatedButton pada list_product.dart agar bisa navigasi ke page tsb.
- Menyesuaikan left drawer dan shop card yang ada agar bisa redirect ke page list_product.dart.
- Menambahkan fungsi yang diperlukan pada app main dari project django, seperti method `show_json_by_username` pada `main/views.py`, menambahkan semua routing yang diperlukan.
- Menambahkan fungsi `create_product_flutter` pada `main/views.py`, menambahkan semua routing yang diperlukan.
- Merubah perintah onPressed pada shoplist_form.dart agar async dan terhubung dengan fungsi auth/login/ pada project Django.
- Mengimplementasikan fitur logout.
- **BONUS**: dikerjakan 1/2, hanya mengerjakan filter pada halaman daftar item dengan hanya menampilkan item yang terasosiasi dengan pengguna yang login.
- Mengerjakan README.md.

<br>
<br>
<br>

## TUGAS 8

### QUESTION 1.
##### Navigator.push()
`Navigator.push()` menambahkan route baru di posisi paling atas stack navigasi tanpa menghapus route di bawahnya. Oleh karena ini, kita bisa kembali ke route yang ada sebelum push dipanggil dengan menggunakan `Navigator.pop()`.

Salah satu contoh penggunaan metode ini adalah saat kita berpindah dari halaman Home ke halaman Profile dari suatu app. Saat user menekan tombol *back*, lebih masuk akal jika aplikasi kembali ke halaman Home terlebih dahulu daripada langsung keluar dari aplikasi yang digunakan.

##### Navigator.pushReplacement()
`Navigator.pushReplacement()` mengganti route yang sedang diakses dengan route baru, sehingga route yang sebelumnya dihapus dari stack navigasi. Oleh karena ini, saat user menggunakan `Navigator.pop()` ia tidak akan kembali ke route sebelumnya namun akan masuk ke route di bawah route sekarang dalam stack. Apabila route awal adalah Home kemudian pushReplacement digunakan untuk beralih ke route lain, saat user menekan tombol *back* ia akan keluar dari aplikasi.

Salah satu contoh dari penggunaan metode ini adalah saat menampilkan page login ataupun logout. Setelah user melakukan login, flow dari aplikasi akan menjadi janggal apabila ia dibawa balik ke page login saat menekan tombol *back*. User hanya diharapkan untuk log in sekali  dalam satu sesi, oleh karena itu setelah user selesai log in lebih baik untuk menggunakan pushReplacement saat berpindah ke route lain.

<br>

### QUESTION 2.
##### Flutter Layout Widgets:
- **Stack**: Sebuah layout widget yang digunakan untuk menumpuk sejumlah widget di atas satu sama lain
- **Row**: Sebuah layout widget yang digunakan untuk menata anak-anaknya secara horizontal
- **Column**: Sebuah layout widget yang menampilkan anak-anaknya dalam array vertikal
- **Align**: Sebuah layout widget yang digunakan untuk menyelaraskan anak-anaknya dalam dirinya sendiri (bisa juga menyesuaikan ukurannya sesuai ukuran anak-anaknya)
- **Center**: Sebuah layout widget yang memposisikan anak-anaknya pada titik tengah dirinya
- **ListView**: Sebuah layout widget yang digunakan untuk menampilkan sejumlah widget yang bisa digulir secara vertikal atau horizontal
- **GridView**: Sebuah layout widget yang menampilkan anak-anaknya dalam suatu array 2d yang scrollable
- **LayoutBuilder**: Sebuah layout widget yang digunakan untuk membuat anakn-anaknya bisa bergantung pada ukuran widget induknya
- **Padding**: Sebuah layout widget yang memberikan *padding* kepada anaknya
- **Container**: Sebuah layout widget yang menampung anak-anaknya dan dapat mengatur tampilan, posisi, serta ukuran dari anak-anak tsb

<br>

### QUESTION 3.
Pada form di tugas kali ini, saya menggunakan elemen input `TextFormField`. Saya menggunakan elemen ini untuk mengambil input dari form Flutter karena ia memiliki fitur validasi yang bisa mengecek apakah input user sudah sesuai dengan kriteria field input-nya. Hal ini berguna adalam Tugas 8 karena tugas ini memiliki kriteria di bawah ini:

```
Setiap elemen input di formulir juga harus divalidasi dengan ketentuan sebagai berikut:
- Setiap elemen input tidak boleh kosong.
- Setiap elemen input harus berisi data dengan tipe data atribut modelnya.
```

<br>

### QUESTION 4.
*Clean Architecture* adalah prinsip desain perangkat lunak yang mendorong adanya *separation of concerns* dan bertujuan untuk menciptakan basis kode yang modular, terukur, dan dapat diuji.

Dalam konteks Flutter, Clean Architecture biasanya terdiri dari 3 lapisan:

1. Lapisan Presentasi: berisi komponen UI seperti widget, layar, & tampilan, dan menangani interaksi pengguna serta renderingnya. Lapisan ini harus independen terhadap logika bisnis dan implementasi akses data.
2. Lapisan Domain (Logika Bisnis): merupakan logika bisnis inti dari aplikasi, berisi kasus penggunaan, entitas, dan aturan bisnis. Lapisan ini dibuat indepenen terhadap kerangka kerja dan teknologi yang digunakan.
3. Lapisan Data: bertanggung jawab atas pengambilan dan penyimpanan data, terdiri dari repositori dan sumber data. Sumber data dapat berupa *remote API*, database lokal, atau penyedia data eksternal lainnya. Lapisan data melindungi lapisan domain dari detail penyimpanan dan pengambilan data.

<br>

### QUESTION 5.
##### Implementasi Checklist:
- Sebelum menambahkan file .dart apapun, saya pertama membuat dua folder baru dalam folder lib saya, satu bernama `widgets` dan satu bernama `screens`. Saya kemudian memindahkan `menu.dart` ke dalam folder screens. Hal ini saya lakukan agar kode yang saya tulis setelahnya dalam pengerjaan Tugas 8 akan sesuai dengan penataan file yang terstruktur ini.
- Setelah membuat folder baru, saya membuat file baru bernama `shoplist_form.dart` dalam folder screens sebagai halaman form untuk mengambil input user. Di file ini saya menggunakan elemen input `TextFormField` dengan fitur validasinya untuk mengimplementasikan hal-hal yang diminta oleh checklist.
- Saat `shoplist_form.dart` sudah selesai, saya memindahkan `ShopItem` dan `ShopCard` dari dalam `menu.dart` menjadi filenya sendiri di dalam folder widgets. Saya menamakan file ini `shop_card.dart` dan menambahkan potongan kode baru agar tombol Tambah Item akan membawa user ke halaman yang ada di shoplist_form yang tadi saya buat.

```
import 'package:sylladex_mobile/screens/shoplist_form.dart';


...

Widget build(BuildContext context) {
    ...

      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));

        ...
          
        if (item.name == "Tambah Item") {
            // DO: Gunakan Navigator.push untuk melakukan navigasi ke MaterialPageRoute yang mencakup ShopFormPage.
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ShopFormPage(),
                ));
          }
        }
        ...
      )
    ...
}
```

- Untuk memunculkan data sesuai isi dari formulir dalam sebuah pop-up, saya menambahkan `AlertDialog` sebagai salah satu hal yang di-return dalam fungsi `onPressed()` tombol formulir saya.
- Setelah routing untuk masuk ke page form dari halaman utama selesai saya terapkan, saya kemudian membuat file baru di folder widgets bernama `left_drawer.dart`. Di file ini, saya mengimpor MyHomePage serta ShopFormPage dari menu.dart dan shoplist_form.dart kemudian menambahkan beberapa `ListTile` di dalam left drawer ini dengan fungsi `onTap()` yang membawa user ke page yang sesuai. Saat user memilih opsi Halaman utama, ia akan dibawa ke MyHomePage, sedangkan saat ia memilih opsi Tambah Item, ia akan diarahkan ke ShopFormPage yang telah dibuat tadi.
- Setelah menyelesaikan tugas inti, saya mengerjakan tugas bonus dengan menambahkan widget baru bernama `item_card.dart` dalam folder widgets. Di dalam file ini terdapat class Item beserta ItemCard. Implementasi dari Item dan ItemCard saya kurang lebih ambil dari implementasi ShopItem dan ShopCard pada menu, namun bedanya adalah pada Item, list allItems merupakan static attribute dari kelas-nya, bukan sebagai atribut dari sebuah page dalam screens.
- Saya menambahkan file di screens bernama `lihat_item.dart` dengan implementasi yang kurang lebih sama dengan `menu.dart`. Page di file baru ini bernama ItemListPage dan ia mengimpor class item dari item_card.dart. Dengan melakukan impor ini, ia bisa mengakses list allItems yang ada dan menampilkannya pada layar.
- Terakhir, saya menambahkan routing ke ItemListPage ini pada halaman menu dan pada left drawer, kemudian saya menambahkan fungsi di bawah ini pada fungsi onPressed() di ShopFormPage yang tadi telah selesai dibuat agar item hasil input user benar-benar disimpan ke dalam list allItems yang ditampilkan di ItemListPage.

```
Item.allItems.add(Item(_name, _amount, _description));
```

- Setelah semua ini selesai, saya menutup pengerjaan Tugas 8 dengan menyelesaikan bagian README.md saya.

<br>
<br>
<br>

## TUGAS 7

### QUESTION 1.
##### Stateless Widget:
- *Child Widget* akan mendapatkan isi dan deskripsinya dari *parent* yang ia miliki. Tidak akan berubah dengan sendirinya & tidak terpengaruhi saat user berinteraksi dengannya
- Hanya memiliki properti *final* saat dikonstruksi


##### Stateful Widget:
- Dapat mengubah isi dan deskripsinya sendiri secara dinamis daat user berinteraksi dengannya

<br>

### QUESTION 2.
##### Widgets yang Digunakan:
- **StatelessWidget**: Sebuah widget yang tidak membutuhkan *mutable state*
- **Text**: Sebuah widget yang menampilkan teks dengan suatu gaya tertentu
- **SingleChildScrollView**: Sebuah widget yang menampilkan satu anaknya secara scrollable, baik vertikal maupun horizontal
- **Padding**: Sebuah widget yang memberikan *padding* kepada anaknya
- **Column**: Sebuah widget yang menampilkan anak-anaknya dalam array vertikal
- **InkWell**: Sebuah material widget yang menangkap dan menanggapi touch user
- **Container**: Sebuah widget yang menampung anak-anaknya dan dapat mengatur tampilan, posisi, serta ukuran dari anak-anak tsb
- **Icon**: Sebuah widget yang menampilkan Icon
- **Center**: Sebuah widget yang memposisikan anak-anaknya pada titik tengah dirinya
- **GridView**: Sebuah widget yang menampilkan anak-anaknya dalam suatu array 2d yang scrollable

<br>

### QUESTION 3.
##### Implementasi Checklist:
Pertama-tama, saya menginisiasikan flutter project saya dengan command `flutter create sylladex_mobile`. Setelahnya, saya mengatur `main.dart` agar terkoneksi dengan `menu.dart` yang merupakan Stateless Widget. Isi kedua file ini saya sesuaikan dengan tutorial yang telah diberikan minggu lalu, ditambah dengan perubahan-perubahan berikut:
- "Lihat Produk" dan "Tambah Produk" saya ganti menjadi "Lihat Item" dan "Tambah Item".
- Class `ShopItem` saya tambahkan atribut color.
```
class ShopItem {
  final String name;
  final IconData icon;
  final Color color;

  ShopItem(this.name, this.icon, this.color);
}
```
- Saya ubah fungsi `build()` dalam class `ShopCard` agar menampilkan warna button sesuai dengan yang ditentukan saat `ShopItem` di-instansiasi.
```
@override
Widget build(BuildContext context) {
    return Material(
        color: item.color, // Saya ganti argumen ini
        ...
    )
}
```
- Saya ganti `List<ShopItem> items` agar meng-instansiasi semua button yang ada dengan warna yang berbeda-beda (BONUS Tugas 7).
```
final List<ShopItem> items = [
    ShopItem("Lihat Item", Icons.checklist, Color(0xff7f5478)),
    ShopItem("Tambah Item", Icons.add_shopping_cart, Color(0xff57b8a8)),
    ShopItem("Logout", Icons.logout, Color(0xffebba55)),
];
```

Setelah saya menyelesaikan semua tahap di atas, saya menyelesaikan Tugas 7 dengan menjawab pertanyaan-pertanyaan yang diberikan pada `README.md`.

<br>
<br>
<br>

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
