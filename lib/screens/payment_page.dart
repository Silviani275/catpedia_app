import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  final dynamic cat;
  final double total;

  const PaymentPage({super.key, required this.cat, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Total Pembayaran:', style: TextStyle(fontSize: 20)),
            Text(
              'Rp ${total.toInt()}',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Pembayaran Berhasil'),
                    content: const Text('Terima kasih sudah membeli! 🎉'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      )
                    ],
                  ),
                );
              },
              child: const Text('Bayar Sekarang'),
            )
          ],
        ),
      ),
    );
  }
}
