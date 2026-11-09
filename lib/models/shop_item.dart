class ShopItem {
  final String id;
  final String name;
  final String categoryTag;
  final String category;
  final String manufacturer;
  final int price;
  final String imagePath;
  final bool isUnlocked;
  final Map<String, String> specs;

  ShopItem({
    required this.id,
    required this.name,
    required this.categoryTag,
    required this.category,
    required this.manufacturer,
    required this.price,
    required this.imagePath,
    required this.specs,
    this.isUnlocked = true,
  });
}

// DATA DUMMY TOKO TERHUBUNG LANGSUNG KE ASET GAMBAR LENGKAP
final List<ShopItem> dummyShopItems = [
  // 1. PC CASE
  ShopItem(
    id: 'case_1',
    name: 'HS FLOW',
    categoryTag: 'MID TOWER',
    category: 'PC CASE',
    manufacturer: 'NZXT',
    price: 100,
    imagePath: 'assets/images/case1.png', // Aset case1.png
    isUnlocked: true,
    specs: {
      'MANUFACTURER': 'NZXT',
      'MODEL': 'HS FLOW',
      'CASE TYPE': 'MID TOWER',
      'SUPPORT': 'ATX, MICRO-ATX, MINI-ITX',
      'INC FAN': '2x 120MM',
    },
  ),

  // 2. CPU
  ShopItem(
    id: 'cpu_1',
    name: 'I5-10400F',
    categoryTag: 'LGA 1200',
    category: 'CPU',
    manufacturer: 'INTEL',
    price: 150,
    imagePath: 'assets/images/cpu1.png', // Aset cpu1.png
    isUnlocked: true,
    specs: {
      'MANUFACTURER': 'INTEL',
      'MODEL': 'I5-10400F',
      'SOCKET': 'LGA 1200',
      'CORES / THREADS': '6 / 12',
      'BASE CLOCK': '2.9 GHz',
      'BOOST CLOCK': '4.3 GHz',
    },
  ),

  // 3. MOTHERBOARD
  ShopItem(
    id: 'mobo_1',
    name: 'B560-M',
    categoryTag: 'LGA 1200',
    category: 'MOTHERBOARD',
    manufacturer: 'ASUS',
    price: 100,
    imagePath: 'assets/images/motherboard1.png', // Aset motherboard1.png
    isUnlocked: true,
    specs: {
      'MANUFACTURER': 'ASUS',
      'MODEL': 'B560-M',
      'CHIPSET': 'INTEL B560',
      'SOCKET': 'LGA 1200',
      'MAX MEMORY': '128GB',
    },
  ),

  // 4. RAM
  ShopItem(
    id: 'ram_1',
    name: 'PC4-1600',
    categoryTag: 'DDR4',
    category: 'RAM',
    manufacturer: 'GOLDVN',
    price: 50,
    imagePath: 'assets/images/ram1.png', // Aset ram1.png
    isUnlocked: true,
    specs: {
      'MANUFACTURER': 'GOLDVN',
      'MODEL': 'PC4-1600',
      'TYPE': 'DDR4',
      'CAPACITY': '8GB',
      'SPEED': '1600 MHz',
    },
  ),

  // 5. VIDEOCARD
  ShopItem(
    id: 'gpu_1',
    name: 'GTX 1060',
    categoryTag: 'GDDR4',
    category: 'VIDEOCARD',
    manufacturer: 'NVIDIA',
    price: 100,
    imagePath: 'assets/images/vga1.png', // Aset vga1.png
    isUnlocked: true,
    specs: {
      'MANUFACTURER': 'NVIDIA',
      'MODEL': 'GEFORCE GTX 1060',
      'VRAM': '4GB',
      'MEMORY': 'GDDR4',
      'CORE CLOCK': '800 MHZ',
    },
  ),

  // 6. POWER SUPPLY
  ShopItem(
    id: 'psu_1',
    name: 'CV650',
    categoryTag: '650W',
    category: 'POWER SUPPLY',
    manufacturer: 'CORSAIR',
    price: 80,
    imagePath: 'assets/images/psu1.png', // Aset psu1.png
    isUnlocked: true,
    specs: {
      'MANUFACTURER': 'CORSAIR',
      'MODEL': 'CV650',
      'WATTAGE': '650W',
      'EFFICIENCY': '80 PLUS BRONZE',
      'MODULAR': 'NON-MODULAR',
    },
  ),

  // 7. DRIVE
  ShopItem(
    id: 'drive_1',
    name: '970 EVO PLUS',
    categoryTag: 'NVME M.2',
    category: 'DRIVE',
    manufacturer: 'SAMSUNG',
    price: 120,
    imagePath: 'assets/images/drive1.png', // Aset drive1.png
    isUnlocked: true,
    specs: {
      'MANUFACTURER': 'SAMSUNG',
      'MODEL': '970 EVO PLUS',
      'TYPE': 'NVME M.2 SSD',
      'CAPACITY': '1 TB',
      'WRITE SPEED': '3500 MB/S',
    },
  ),

  // 8. COOLER
  ShopItem(
    id: 'cooler_1',
    name: 'AK400',
    categoryTag: 'AIR COOLER',
    category: 'COOLER',
    manufacturer: 'DEEPCOOL',
    price: 45,
    imagePath: 'assets/images/hsf1.png', // Aset hsf1.png
    isUnlocked: true,
    specs: {
      'MANUFACTURER': 'DEEPCOOL',
      'MODEL': 'AK400',
      'TYPE': 'SINGLE TOWER AIR COOLER',
      'FAN SPEED': '500-1850 RPM',
      'TDP SUPPORT': '220W',
    },
  ),

  // ITEM MISTERIUS
  ShopItem(
    id: 'mystery_item',
    name: '???',
    categoryTag: '???',
    category: 'PC CASE',
    manufacturer: '???',
    price: 0,
    imagePath: 'assets/images/case1.png',
    isUnlocked: false,
    specs: {
      'MANUFACTURER': '???',
      'MODEL': '???',
      'CASE TYPE': '???',
      'SUPPORT': '???',
      'INC FAN': '???',
    },
  ),
];
