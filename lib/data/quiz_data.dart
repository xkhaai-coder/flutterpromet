import '../models/quiz_question.dart';

/// Master Data 20 Soal Kuis Komponen PC
final List<QuizQuestion> level1QuizData = const [
  QuizQuestion(
    question: 'Komponen pada gambar di atas berfungsi sebagai otak utama komputer yang mengolah instruksi dan data. Komponen tersebut adalah...',
    image: 'assets/images/img_cpu.png',
    options: ['RAM', 'CPU / Processor', 'Power Supply', 'Motherboard'],
    correctAnswer: 'CPU / Processor',
    explanation: 'CPU (Central Processing Unit) berfungsi mengolah data dan instruksi sistem.',
  ),
  QuizQuestion(
    question: 'Fungsi dari komponen pada gambar di atas adalah...',
    image: 'assets/images/img_ram.png',
    options: [
      'Menyimpan data secara permanen',
      'Menyuplai listrik ke semua komponen',
      'Menyimpan data sementara saat komputer dinyalakan',
      'Menampilkan gambar ke layar monitor',
    ],
    correctAnswer: 'Menyimpan data sementara saat komputer dinyalakan',
    explanation: 'RAM adalah memori penyimpanan sementara (volatile).',
  ),
  QuizQuestion(
    question: 'Papan sirkuit utama yang menghubungkan seluruh komponen hardware PC pada gambar di atas disebut...',
    image: 'assets/images/img_motherboard.png',
    options: ['Chassis', 'Sound Card', 'Expansion Card', 'Motherboard'],
    correctAnswer: 'Motherboard',
    explanation:
        'Motherboard adalah papan induk penampung seluruh komponen PC.',
  ),
  QuizQuestion(
    question: 'Komponen ini bertanggung jawab untuk mengolah dan menampilkan grafik visual ke layar monitor. Komponen tersebut adalah...',
    image: 'assets/images/img_vga.png',
    options: [
      'Sound Card',
      'VGA Card / GPU',
      'NIC / LAN Card',
      'Power Supply Unit',
    ],
    correctAnswer: 'VGA Card / GPU',
    explanation: 'VGA Card/GPU memproses sinyal gambar ke layar monitor.',
  ),
  QuizQuestion(
    question: 'Komponen pada gambar berfungsi mengubah arus listrik AC dari stopkontak menjadi arus DC untuk semua komponen PC. Komponen ini adalah...',
    image: 'assets/images/img_psu.png',
    options: [
      'Power Supply Unit (PSU)',
      'Stabilizer / UPS',
      'Converter DC',
      'Adaptor Monitor',
    ],
    correctAnswer: 'Power Supply Unit (PSU)',
    explanation:
        'PSU mengonversi arus AC menjadi DC sesuai kebutuhan komponen.',
  ),
  QuizQuestion(
    question: 'Media penyimpanan internal berbasis piringan magnetik yang menyimpan data secara permanen pada gambar di atas adalah...',
    image: 'assets/images/img_hdd.png',
    options: ['SSD M.2', 'Harddisk (HDD)', 'Flashdisk', 'RAM'],
    correctAnswer: 'Harddisk (HDD)',
    explanation: 'Harddisk (HDD) menggunakan piringan magnetik untuk menyimpan data non-volatile.',
  ),
  QuizQuestion(
    question: 'Perangkat penyimpanan pada gambar menggunakan teknologi flash memory tanpa bagian berputar (mekanis) dengan form-factor 2.5 inch. Perangkat tersebut adalah...',
    image: 'assets/images/img_ssd_sata.png',
    options: ['HDD SATA', 'SSD SATA', 'SSD M.2 NVMe', 'NVRAM'],
    correctAnswer: 'SSD SATA',
    explanation: 'SSD SATA 2.5 inch menggunakan chip flash memory dan menggunakan kabel SATA.',
  ),
  QuizQuestion(
    question: 'Penyimpanan kecepatan tinggi pada gambar di atas yang dipasang langsung ke slot khusus pada motherboard adalah...',
    image: 'assets/images/img_ssd_m2.png',
    options: ['RAM DDR4', 'SSD M.2', 'Sound Card PCIe', 'Wi-Fi Card'],
    correctAnswer: 'SSD M.2',
    explanation: 'SSD M.2 berbentuk kepingan kecil yang langsung terpasang pada slot M.2 motherboard.',
  ),
  QuizQuestion(
    question: 'Perangkat pendingin yang dipasang tepat di atas Processor untuk menyerap dan membuang panas pada gambar di atas dinamakan...',
    image: 'assets/images/img_hsf.png',
    options: [
      'Fan Casing',
      'Liquid Cooler Radiator',
      'Heatsink Fan (HSF)',
      'Heatpipe Fan',
    ],
    correctAnswer: 'Heatsink Fan (HSF)',
    explanation: 'HSF menyerap panas processor melalui dasar tembaga/alumunium dan dibuang oleh kipas.',
  ),
  QuizQuestion(
    question: 'Cairan/pasta konduktif panas yang dioleskan di antara permukaan CPU dan Heatsink pada gambar di atas adalah...',
    image: 'assets/images/img_thermal_paste.png',
    options: ['Glue Gun', 'Thermal Paste', 'Flux Solder', 'Silicon Grease'],
    correctAnswer: 'Thermal Paste',
    explanation: 'Thermal paste mengisi celah mikro antara CPU dan HSF agar hantaran panas maksimal.',
  ),
  QuizQuestion(
    question: 'Komponen luar yang berfungsi menampung, melindungi, serta menjaga sirkulasi udara seluruh komponen PC pada gambar di atas adalah...',
    image: 'assets/images/img_casing.png',
    options: ['Motherboard', 'Casing PC (Case)', 'Rak Server', 'Frame Metal'],
    correctAnswer: 'Casing PC (Case)',
    explanation:
        'Casing PC menjadi rumah bagi seluruh komponen keras komputer.',
  ),
  QuizQuestion(
    question: 'Komponen berbentuk baterai kancing pada motherboard di atas berfungsi untuk...',
    image: 'assets/images/img_cmos.png',
    options: [
      'Memberi daya pada Processor saat listrik padam',
      'Menyimpan pengaturan BIOS dan waktu (jam/tanggal) sistem',
      'Menyalakan lampu LED Casing',
      'Menambah kecepatan RAM',
    ],
    correctAnswer: 'Menyimpan pengaturan BIOS dan waktu (jam/tanggal) sistem',
    explanation: 'Baterai CMOS menyuplai daya ke chip CMOS untuk mempertahankan setting BIOS dan waktu.',
  ),
  QuizQuestion(
    question: 'Dudukan pada motherboard yang ditunjukkan pada gambar di atas khusus digunakan untuk memasang...',
    image: 'assets/images/img_socket_cpu.png',
    options: ['RAM', 'VGA Card', 'CPU / Processor', 'Kabel Power'],
    correctAnswer: 'CPU / Processor',
    explanation: 'Socket CPU (seperti LGA atau AM4/AM5) adalah tempat mendudukkan processor.',
  ),
  QuizQuestion(
    question: 'Slot memanjang pada motherboard yang digunakan untuk menancapkan keping memori utama (RAM) disebut...',
    image: 'assets/images/img_slot_ram.png',
    options: ['Slot PCIe', 'Slot DIMM / Slot RAM', 'Port SATA', 'Socket CPU'],
    correctAnswer: 'Slot DIMM / Slot RAM',
    explanation: 'Slot DIMM (Dual In-line Memory Module) adalah slot penancap keping RAM.',
  ),
  QuizQuestion(
    question: 'Slot ekspansi pada motherboard di atas yang umumnya digunakan untuk memasang kartu grafis (VGA Card) adalah...',
    image: 'assets/images/img_slot_pcie.png',
    options: [
      'Slot PCIe x16',
      'Slot M.2',
      'Slot PCI Lama',
      'Connector ATX 24 Pin',
    ],
    correctAnswer: 'Slot PCIe x16',
    explanation: 'Slot PCIe x16 memiliki bandwidth tertinggi untuk kartu grafis tambahan.',
  ),
  QuizQuestion(
    question: 'Kabel pada gambar di atas berfungsi untuk menghubungkan data antara motherboard dengan...',
    image: 'assets/images/img_kabel_sata.png',
    options: [
      'Power Supply',
      'HDD / SSD SATA dan Optical Drive',
      'Monitor',
      'Kipas Casing',
    ],
    correctAnswer: 'HDD / SSD SATA dan Optical Drive',
    explanation:
        'Kabel data SATA menghubungkan drive penyimpanan SATA ke motherboard.',
  ),
  QuizQuestion(
    question: 'Kabel utama dari Power Supply pada gambar di atas berfungsi memberikan daya ke...',
    image: 'assets/images/img_kabel_24pin.png',
    options: ['Harddisk', 'VGA Card secara khusus', 'Motherboard', 'Monitor'],
    correctAnswer: 'Motherboard',
    explanation:
        'Konektor ATX 24-Pin memberikan pasokan listrik utama ke motherboard.',
  ),
  QuizQuestion(
    question: 'Kartu tambahan pada gambar di atas yang digunakan agar PC dapat terhubung ke jaringan kabel (LAN) adalah...',
    image: 'assets/images/img_lan_card.png',
    options: [
      'Sound Card',
      'Network Interface Card (NIC) / LAN Card',
      'Capture Card',
      'USB Expansion Card',
    ],
    correctAnswer: 'Network Interface Card (NIC) / LAN Card',
    explanation: 'NIC/LAN Card berfungsi menghubungkan komputer ke jaringan ethernet RJ-45.',
  ),
  QuizQuestion(
    question: 'Deretan port di bagian belakang motherboard pada gambar di atas dinamakan...',
    image: 'assets/images/img_backpanel_io.png',
    options: [
      'Front Panel Header',
      'Back Panel I/O Ports',
      'Power Management',
      'Expansion Slots',
    ],
    correctAnswer: 'Back Panel I/O Ports',
    explanation: 'Back Panel I/O berisi port USB, Audio, LAN, HDMI, dll., untuk perangkat eksternal.',
  ),
  QuizQuestion(
    question: 'Komponen pada gambar di atas berfungsi untuk menjaga sirkulasi udara (airflow) di dalam casing komputer. Komponen ini adalah...',
    image: 'assets/images/img_fan_casing.png',
    options: [
      'Fan Processor',
      'Case Fan / Kipas Casing',
      'Blower PSU',
      'Air Cooler Radiator',
    ],
    correctAnswer: 'Case Fan / Kipas Casing',
    explanation: 'Case Fan dipasang di casing untuk memasukkan udara dingin (intake) dan mengeluarkan udara panas (exhaust).',
  ),
];
