// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/cat_model.dart';
import '../screens/cat_detail_page.dart';

class CatCard extends StatelessWidget {
  final Cat cat;
  final void Function(Cat)? onAddToCart;
  final VoidCallback? onBuyNow;

  const CatCard({
    super.key,
    required this.cat,
    this.onAddToCart,
    this.onBuyNow,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CatDetailPage(cat: cat, cartItems: [],)),
        );
      },
      child: Container(
        width: 220,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: cat.name,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.asset(
                  cat.image,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cat.name,
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),

                  Container(
                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                   decoration: BoxDecoration(
                    color: Colors.orange[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                    child: Text(
                     cat.label,
                    style: GoogleFonts.poppins(
                     fontSize: 12,
                    color: Colors.orange[800],
                     fontWeight: FontWeight.w500,
                  ),
                 ),
                ),


                  const SizedBox(height: 8),

                  Text(
                    'Rp ${cat.price.toStringAsFixed(0)}',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.orange[800],
                    ),
                  ),

                  const SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: onBuyNow,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[400],
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 36),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      shadowColor: Colors.transparent,
                      elevation: 0,
                    ),
                    child: const Text('Beli Sekarang'),
                  ),

                  const SizedBox(height: 6),

                  OutlinedButton(
                    onPressed: () {
                      if (onAddToCart != null) {
                        onAddToCart!(cat);
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.orange[400],
                      foregroundColor: Colors.white,
                      side: BorderSide.none,
                      minimumSize: const Size(double.infinity, 36),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Tambah ke Keranjang'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}