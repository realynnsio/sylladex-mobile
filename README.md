# README.md
**UPDATE: 08 Nov 2023. Jawaban Tugas 7 ditambahkan.**

Berikut jawaban README.md untuk tugas-tugas yang ada.

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
