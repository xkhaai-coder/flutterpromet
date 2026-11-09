import 'package:flutter/material.dart';

import '../models/shop_item.dart';
import '../widgets/item_spec_dialog.dart'; // <--- IMPORT WIDGET SPEC DIALOG

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  String selectedCategory = 'PC CASE';
  int userCoins = 1000;
  String searchQuery = '';

  final List<String> categories = [
    'PC CASE',
    'CPU',
    'MOTHERBOARD',
    'RAM',
    'VIDEOCARD',
    'POWER SUPPLY',
    'DRIVE',
    'COOLER',
  ];

  /// Menampilkan Dialog Spesifikasi Item
  void _showItemSpecification(ShopItem item) {
    showDialog(
      context: context,
      builder: (context) => ItemSpecDialog(
        item: item,
        userCoins: userCoins,
        onBuy: () => _processPurchase(item),
      ),
    );
  }

  /// Memproses Pembelian Barang
  void _processPurchase(ShopItem item) {
    if (userCoins >= item.price) {
      setState(() {
        userCoins -= item.price;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFF00FF88),
          content: Text(
            'Berhasil membeli ${item.name}!',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color(0xFFFF007A),
          content: Text(
            'Koin tidak cukup!',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = dummyShopItems.where((item) {
      final matchesCategory = item.category == selectedCategory;
      final matchesSearch = item.name.toLowerCase().contains(
        searchQuery.toLowerCase(),
      );
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1B243B), Color(0xFF0A0E1A)],
          ),
        ),
        child: SafeArea(
          child: Row(
            children: [
              // SIDEBAR KIRI
              Container(
                width: 220,
                decoration: const BoxDecoration(
                  color: Color(0xFF141929),
                  border: Border(
                    right: BorderSide(color: Color(0xFF00F0FF), width: 2),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    _buildNavButton('KEMBALI', Colors.pinkAccent, () {
                      Navigator.pop(context);
                    }),
                    const SizedBox(height: 12),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B243B),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.amber, width: 1.5),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.monetization_on,
                            color: Colors.amber,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '$userCoins',
                            style: const TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        itemCount: categories.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          final isSelected = selectedCategory == category;
                          return _buildCategoryButton(category, isSelected);
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // AREA UTAMA (GRID BARANG)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 100),
                          SizedBox(
                            width: 240,
                            height: 36,
                            child: TextField(
                              onChanged: (val) {
                                setState(() {
                                  searchQuery = val;
                                });
                              },
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                              decoration: InputDecoration(
                                hintText: 'SEARCH',
                                hintStyle: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 12,
                                ),
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.cyan,
                                  size: 18,
                                ),
                                filled: true,
                                fillColor: const Color(0xFF1B243B),
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: const BorderSide(
                                    color: Colors.cyan,
                                    width: 1,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide(
                                    color: Colors.cyan.withOpacity(0.5),
                                    width: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            'TOKO',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: filteredItems.isEmpty
                            ? const Center(
                                child: Text(
                                  'Belum ada barang di kategori ini',
                                  style: TextStyle(color: Colors.white54),
                                ),
                              )
                            : GridView.builder(
                                itemCount: filteredItems.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      crossAxisSpacing: 12,
                                      mainAxisSpacing: 12,
                                      childAspectRatio: 0.82,
                                    ),
                                itemBuilder: (context, index) {
                                  final item = filteredItems[index];
                                  return _buildShopCard(item);
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton(String label, Color borderColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF1B243B),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String category, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2A3655) : const Color(0xFF1B243B),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF00F0FF)
                : const Color(0xFF8C3AFF),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          category,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  /// Kartu Item Toko (Membedakan Tekan Body vs Tekan Tombol Beli)
  Widget _buildShopCard(ShopItem item) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1B243B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: item.isUnlocked
              ? const Color(0xFF00F0FF)
              : Colors.grey.shade700,
          width: item.isUnlocked ? 1.5 : 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            // AREA BODY KARTU (Klik untuk Buka Modal Spesifikasi)
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _showItemSpecification(item),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00DFFF),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          item.categoryTag,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        flex: 3,
                        child: Image.asset(
                          item.imagePath,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.desktop_windows,
                                color: Colors.white38,
                                size: 40,
                              ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),

            // AREA TOMBOL HARGA / BELI (Klik khusus untuk langsung Beli)
            GestureDetector(
              onTap: () => _processPurchase(item),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8C3AFF), Color(0xFF3B375F)],
                  ),
                  border: Border.all(color: const Color(0xFF8C3AFF)),
                ),
                child: Column(
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${item.price}\$',
                      style: const TextStyle(
                        color: Colors.amber,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
