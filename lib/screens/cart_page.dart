import 'package:catpedia/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPage extends StatefulWidget {
  final List<CartItem> cartItems;
  final VoidCallback onPaymentComplete;

  const CartPage({
    super.key,
    required this.cartItems,
    required this.onPaymentComplete,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double get totalPrice => widget.cartItems
      .fold(0, (sum, item) => sum + item.cat.price * item.quantity);

  void increment(CartItem item) {
    setState(() {
      item.quantity++;
    });
  }

  void decrement(CartItem item) {
    setState(() {
      if (item.quantity > 1) {
        item.quantity--;
      } else {
        widget.cartItems.remove(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: widget.cartItems.isEmpty
          ? Center(
              child: Text(
                'Keranjang kosong',
                style: GoogleFonts.poppins(fontSize: 18),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = widget.cartItems[index];
                      return ListTile(
                        leading: Image.asset(
                          item.cat.image,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          item.cat.name,
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Row(
                          children: [
                            // TOMBOL -
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () => decrement(item),
                            ),

                            Text(
                              item.quantity.toString(),
                              style: GoogleFonts.poppins(fontSize: 16),
                            ),

                            // TOMBOL +
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () => increment(item),
                            ),
                          ],
                        ),
                        trailing: Text(
                          'Subtotal: Rp ${(item.cat.price * item.quantity).toStringAsFixed(0)}',
                        ),
                      );
                    },
                  ),
                ),

                // Footer
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Total: Rp ${totalPrice.toStringAsFixed(0)}',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Konfirmasi Pembayaran'),
                              content: Text(
                                'Bayar Rp ${totalPrice.toStringAsFixed(0)}?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Batal'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    widget.onPaymentComplete();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Pembayaran berhasil! 🎉'),
                                      ),
                                    );
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Bayar'),
                                ),
                              ],
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        child: const Text('Bayar Sekarang'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
