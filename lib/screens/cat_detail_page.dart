import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/cat_model.dart';
import '../models/cart_item.dart';

class CatDetailPage extends StatefulWidget {
  final Cat cat;
  final List<CartItem> cartItems;

  const CatDetailPage({
    super.key,
    required this.cat,
    required this.cartItems,
  });

  @override
  State<CatDetailPage> createState() => _CatDetailPageState();
}

class _CatDetailPageState extends State<CatDetailPage> {
  void addToCart() {
    final index = widget.cartItems.indexWhere(
      (item) => item.cat.name == widget.cat.name,
    );

    if (index >= 0) {
      widget.cartItems[index].quantity++;
    } else {
      widget.cartItems.add(CartItem(cat: widget.cat));
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.cat.name} masuk keranjang 🛒'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String description = widget.cat.description;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.orange[400],
        title: Text(widget.cat.name, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==================== IMAGE ====================
            Hero(
              tag: widget.cat.name,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(25)),
                child: Image.asset(
                  widget.cat.image,
                  width: double.infinity,
                  height: 280,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ==================== CONTENT ====================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // NAMA KUCING
                  Text(
                    widget.cat.name,
                    style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  // LABEL (IF AVAILABLE)
                  if (widget.cat.label.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        widget.cat.label,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.orange[800],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                  const SizedBox(height: 12),

                  // HARGA
                  Text(
                    'Harga: Rp ${widget.cat.price.toStringAsFixed(0)}',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.orange[800],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // DESKRIPSI
                  Text(
                    'Karakteristik Kucing:',
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.poppins(fontSize: 15, height: 1.5),
                  ),

                  const SizedBox(height: 25),

                  // ==================== BUTTONS ====================
                  Row(
                    children: [
                      // ADD TO CART
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: addToCart,
                          child: Text(
                            'Tambah ke Keranjang',
                            style: GoogleFonts.poppins(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      // BUY NOW
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(
                                  'Konfirmasi Pembelian',
                                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                                ),
                                content: Text(
                                  'Apakah kamu ingin membeli ${widget.cat.name}?',
                                  style: GoogleFonts.poppins(),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Batal'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Pembayaran ${widget.cat.name} berhasil 🎉',
                                            style: GoogleFonts.poppins(),
                                          ),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    },
                                    child: const Text('Konfirmasi'),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Text(
                            'Beli Sekarang',
                            style: GoogleFonts.poppins(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
