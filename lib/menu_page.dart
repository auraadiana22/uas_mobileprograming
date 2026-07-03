import 'package:flutter/material.dart';
import 'package:uas_toko_baju/detail_page.dart';
import 'package:uas_toko_baju/form_produk_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<Map<String, dynamic>> produk = [
    {
      "nama": "Cardigan pita",
      "harga": 65000,
      "stok": 20,
      "img": "assets/images/cardi pita.jpg",
      "desc": "Cardigan lucu premium stylish",
    },
    {
      "nama": "Cardigan list",
      "harga": 60000,
      "stok": 10,
      "img": "assets/images/cardi lis.jpg",
      "desc": "cardigan stylish anak muda",
    },
  ];

  void tambah() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const FormProdukPage()),
    );

    if (result != null) {
      setState(() => produk.add(result));
    }
  }

  void edit(int i) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => FormProdukPage(data: produk[i])),
    );

    if (result != null) {
      setState(() => produk[i] = result);
    }
  }

  void hapus(int i) {
    setState(() => produk.removeAt(i));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("aluraandco.fashion"),
        actions: [
          IconButton(
            onPressed: () => FirebaseAuth.instance.signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: tambah,
        child: const Icon(Icons.add),
      ),

      body: ListView.builder(
        itemCount: produk.length,
        itemBuilder: (context, i) {
          final p = produk[i];

          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  p['img'],
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                p['nama'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Rp ${p['harga']}"),
              trailing: PopupMenuButton(
                itemBuilder: (_) => [
                  PopupMenuItem(
                    child: const Text("Edit"),
                    onTap: () => Future(() => edit(i)),
                  ),
                  PopupMenuItem(
                    child: const Text("Hapus"),
                    onTap: () => Future(() => hapus(i)),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DetailPage(data: p)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
