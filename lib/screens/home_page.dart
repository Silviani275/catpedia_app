// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:catpedia/delegates/cat_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/cat_model.dart';
import '../models/cart_item.dart';
import '../widgets/cat_card.dart';
import '../screens/cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<CartItem> cartItems = [];
  String searchQuery = '';

  final List<Cat> cats = [
    Cat(
      name: 'Abyssinian',
      image: 'assets/Images/abyssinian.jpg',
      price: 2500000,
      label: 'Favorit',
      description:
          'Ras aktif dan cerdas yang suka bermain serta berinteraksi dengan manusia.',
      breed: '',
    ),
    Cat(
      name: 'Bengal',
      image: 'assets/Images/bengal_cat.jpg',
      price: 3200000,
      label: 'Best Seller',
      description:
          'Kucing berpenampilan eksotis seperti macan tutul, energik, dan suka memanjat.',
      breed: '',
    ),
    Cat(
      name: 'British Shorthair',
      image: 'assets/Images/british_shorthair.jpg',
      price: 2800000,
      label: 'Favorit',
      description: 'Kucing dengan bulu tebal dan lembut, terkenal tenang dan ramah.',
      breed: '',
    ),
    Cat(
      name: 'Maine Coon',
      image: 'assets/Images/maine_coon.jpg',
      price: 3500000,
      label: 'Best Seller',
      description: 'Kucing besar dengan bulu lebat, penyayang dan ramah keluarga.',
      breed: '',
    ),
    Cat(
      name: 'Norwegian Forest Cat',
      image: 'assets/Images/norwegian_forest_cat.jpg',
      price: 3300000,
      label: 'Premium',
      description:
          'Kucing berbulu tebal, kuat, dan sangat adaptif dengan lingkungan dingin.',
      breed: '',
    ),
    Cat(
      name: 'Persian Cat',
      image: 'assets/Images/persian_cat.jpg',
      price: 3000000,
      label: 'Favorit',
      description: 'Kucing dengan wajah datar, bulu panjang, kalem, dan penyayang.',
      breed: '',
    ),
    Cat(
      name: 'Ragdoll',
      image: 'assets/Images/ragdoll.jpg',
      price: 3200000,
      label: 'Best Seller',
      description: 'Kucing besar dan lembut, terkenal jinak dan mudah dibawa.',
      breed: '',
    ),
    Cat(
      name: 'Russian Blue',
      image: 'assets/Images/russian_blue.jpg',
      price: 3100000,
      label: 'Premium',
      description:
          'Kucing elegan dengan bulu abu-abu kebiruan dan mata hijau tajam.',
      breed: '',
    ),
    Cat(
      name: 'Scottish Fold',
      image: 'assets/Images/scottish_fold_cat.jpg',
      price: 2900000,
      label: 'Favorit',
      description: 'Kucing dengan telinga melipat, manis, dan tenang.',
      breed: '',
    ),
    Cat(
      name: 'Siamese',
      image: 'assets/Images/siamese_cat.jpg',
      price: 2700000,
      label: 'Best Seller',
      description:
          'Kucing aktif dan sosial dengan warna khas pada wajah, telinga, dan ekor.',
      breed: '',
    ),
    Cat(
      name: 'Sphynx',
      image: 'assets/Images/sphynx.jpg',
      price: 3600000,
      label: 'Premium',
      description:
          'Kucing tanpa bulu yang ramah, energik, dan suka berinteraksi.',
      breed: '',
    ),
    Cat(
      name: 'Devon Rex',
      image: 'assets/Images/devon_rex.jpg',
      price: 3000000,
      label: 'Premium',
      description:
          'Kucing kecil bertelinga besar, bulu keriting, sangat sosial dan lucu.',
      breed: '',
    ),
  ];

  void addToCart(Cat cat) {
    final index = cartItems.indexWhere((item) => item.cat.name == cat.name);

    if (index >= 0) {
      cartItems[index].quantity++;
    } else {
      cartItems.add(CartItem(cat: cat));
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${cat.name} masuk keranjang 🛒'),
        backgroundColor: Colors.orange,
      ),
    );

    setState(() {});
  }

  void buyNow(Cat cat) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Beli Sekarang'),
        content: Text('Beli ${cat.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);

              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Pembayaran Berhasil'),
                  content: Text('${cat.name} berhasil dibeli!'),
                  actions: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            },
            child: Text('Beli'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredCats = cats
        .where((cat) =>
            cat.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('CatPedia', style: GoogleFonts.poppins(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
           icon: Icon(Icons.search, color: Colors.white),
           onPressed: () async {
        // ignore: unused_local_variable
        final result = await showSearch(
           context: context,
           delegate:  CatSearchDelegate(cats),
        );
      },
     ),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CartPage(
                    cartItems: cartItems,
                    onPaymentComplete: () {
                      setState(() => cartItems.clear());
                    },
                  ),
                ),
              ).then((_) => setState(() {}));
            },
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 20, top: 12),
                  child: Icon(Icons.shopping_cart,
                      size: 30, color: Colors.white),
                ),
                if (cartItems.isNotEmpty)
                  Container(
                    margin: EdgeInsets.only(right: 12, top: 8),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      cartItems
                          .fold<int>(0, (sum, item) => sum + item.quantity)
                          .toString(),
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: filteredCats.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.70,
          ),
          itemBuilder: (context, index) {
            final cat = filteredCats[index];

            return CatCard(
              cat: cat,
              onAddToCart: (c) => addToCart(c),
              onBuyNow: () => buyNow(cat),
            );
          },
        ),
      ),
    );
  }
}