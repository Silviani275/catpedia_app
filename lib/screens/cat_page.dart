import 'package:flutter/material.dart';
import 'package:catpedia/models/cat_model.dart';
import 'package:catpedia/models/cart_item.dart';
import 'package:catpedia/screens/cart_page.dart';

// ignore: duplicate_import
import 'cart_page.dart';

class CatPage extends StatefulWidget {
  final Cat cat;
  final List<CartItem> cartItems;

  const CatPage({
    super.key,
    required this.cat,
    required this.cartItems,
  });

  @override
  State<CatPage> createState() => _CatPageState();
}

class _CatPageState extends State<CatPage> {
  void addToCart() {
    // cek apakah sudah ada
    final existing = widget.cartItems.where((i) => i.cat.name == widget.cat.name);

    if (existing.isNotEmpty) {
      existing.first.quantity++;
    } else {
      widget.cartItems.add(CartItem(cat: widget.cat));
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.cat.name} ditambahkan ke keranjang')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cat.name),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          Image.asset(widget.cat.image),
          const SizedBox(height: 10),

          ElevatedButton(
            onPressed: addToCart,
            child: const Text('Tambah ke Keranjang'),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CartPage(
                    cartItems: widget.cartItems,
                    onPaymentComplete: () {
                      setState(() {
                        widget.cartItems.clear(); 
                      });
                    },
                  ),
                ),
              );
            },
            child: const Text('Lihat Keranjang'),
          ),
        ],
      ),
    );
  }
}
