import 'package:flutter/material.dart';

class FormProdukPage extends StatefulWidget {
  final Map<String, dynamic>? data;

  const FormProdukPage({super.key, this.data});

  @override
  State<FormProdukPage> createState() => _FormProdukPageState();
}

class _FormProdukPageState extends State<FormProdukPage> {
  final nama = TextEditingController();
  final harga = TextEditingController();
  final stok = TextEditingController();
  final img = TextEditingController();
  final desc = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      nama.text = widget.data!['nama'] ?? '';
      harga.text = widget.data!['harga'].toString();
      stok.text = widget.data!['stok'].toString();
      img.text = widget.data!['img'] ?? '';
      desc.text = widget.data!['desc'] ?? '';
    }
  }

  void simpan() {
    if (nama.text.isEmpty || harga.text.isEmpty || stok.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Data wajib diisi")));
      return;
    }

    Navigator.pop(context, {
      "nama": nama.text,
      "harga": int.tryParse(harga.text) ?? 0,
      "stok": int.tryParse(stok.text) ?? 0,
      "img": img.text,
      "desc": desc.text,
    });
  }

  InputDecoration inputStyle(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Produk")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: nama, decoration: inputStyle("Nama")),
            const SizedBox(height: 10),
            TextField(
              controller: harga,
              keyboardType: TextInputType.number,
              decoration: inputStyle("Harga"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: stok,
              keyboardType: TextInputType.number,
              decoration: inputStyle("Stok"),
            ),
            const SizedBox(height: 10),
            TextField(controller: img, decoration: inputStyle("Path Gambar")),
            const SizedBox(height: 10),
            TextField(
              controller: desc,
              maxLines: 3,
              decoration: inputStyle("Deskripsi"),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: simpan,
                child: const Text("Simpan"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
