import '../models/assembly_question.dart';

final List<AssemblyQuestion> level2AssemblyData = [
  // 1. MISI 1: CPU
  AssemblyQuestion(
    id: 1,
    targetComponentName: 'CPU Processor (AMD Ryzen)',
    beforeBoardImage: 'assets/images/board_0_empty.png',
    afterBoardImage: 'assets/images/board_1_cpu.png',
    wrongExplanation: 'Processor ini tidak kompatibel! Socket motherboard AM4 membutuhkan Processor AMD Ryzen, bukan seri Intel.',
    options: [
      AssemblyOption(
        id: 'cpu_correct',
        name: 'AMD Ryzen 5 (Kompatibel)',
        imagePath: 'assets/images/cpu_correct.png',
        isCorrect: true,
      ),
      AssemblyOption(
        id: 'cpu_wrong_1',
        name: 'Intel Core i5 (Socket Beda)',
        imagePath: 'assets/images/cpu_wrong_1.png',
        isCorrect: false,
      ),
      AssemblyOption(
        id: 'cpu_wrong_2',
        name: 'Intel Core i7 (Socket Beda)',
        imagePath: 'assets/images/cpu_wrong_2.png',
        isCorrect: false,
      ),
      AssemblyOption(
        id: 'cpu_wrong_3',
        name: 'AMD FX Series (Tipe Lama)',
        imagePath: 'assets/images/cpu_wrong_3.png',
        isCorrect: false,
      ),
    ],
  ),

  // 2. MISI 2: RAM
  AssemblyQuestion(
    id: 2,
    targetComponentName: 'RAM Stick (DDR4 Desktop)',
    beforeBoardImage: 'assets/images/board_1_cpu.png',
    afterBoardImage: 'assets/images/board_2_ram.png',
    wrongExplanation: 'RAM tidak cocok! Motherboard ini membutuhkan RAM DDR4 Desktop (Long-DIMM), bukan RAM Laptop (SO-DIMM) atau versi DDR3.',
    options: [
      AssemblyOption(
        id: 'ram_wrong_1',
        name: 'RAM Laptop SO-DIMM',
        imagePath: 'assets/images/ram_wrong_1.png',
        isCorrect: false,
      ),
      AssemblyOption(
        id: 'ram_correct',
        name: 'RAM DDR4 8GB Desktop',
        imagePath: 'assets/images/ram_correct.png',
        isCorrect: true,
      ),
      AssemblyOption(
        id: 'ram_wrong_2',
        name: 'RAM DDR3 Desktop',
        imagePath: 'assets/images/ram_wrong_2.png',
        isCorrect: false,
      ),
      AssemblyOption(
        id: 'ram_wrong_3',
        name: 'RAM Server ECC',
        imagePath: 'assets/images/ram_wrong_3.png',
        isCorrect: false,
      ),
    ],
  ),

  // 3. MISI 3: NVMe SSD
  AssemblyQuestion(
    id: 3,
    targetComponentName: 'NVMe M.2 SSD',
    beforeBoardImage: 'assets/images/board_2_ram.png',
    afterBoardImage: 'assets/images/board_3_nvme.png',
    wrongExplanation: 'Storage ini salah! Slot M.2 Motherboard memerlukan NVMe M.2 Form Factor, bukan SSD SATA 2.5 inch atau HDD 3.5 inch.',
    options: [
      AssemblyOption(
        id: 'nvme_wrong_1',
        name: 'Harddisk 3.5 Inch',
        imagePath: 'assets/images/nvme_wrong_1.png',
        isCorrect: false,
      ),
      AssemblyOption(
        id: 'nvme_wrong_2',
        name: 'SSD SATA 2.5 Inch',
        imagePath: 'assets/images/nvme_wrong_2.png',
        isCorrect: false,
      ),
      AssemblyOption(
        id: 'nvme_correct',
        name: 'NVMe M.2 SSD 512GB',
        imagePath: 'assets/images/nvme_correct.png',
        isCorrect: true,
      ),
      AssemblyOption(
        id: 'nvme_wrong_3',
        name: 'mSATA SSD Old',
        imagePath: 'assets/images/nvme_wrong_3.png',
        isCorrect: false,
      ),
    ],
  ),

  // 4. MISI 4: VGA CARD
  AssemblyQuestion(
    id: 4,
    targetComponentName: 'VGA / GPU Graphics Card',
    beforeBoardImage: 'assets/images/board_3_nvme.png',
    afterBoardImage: 'assets/images/board_4_vga.png',
    wrongExplanation: 'Kartu ekspansi salah! Pasang Kartu Grafis (VGA PCIe x16) untuk menampilkan output visual ke layar.',
    options: [
      AssemblyOption(
        id: 'vga_wrong_1',
        name: 'PCIe Wi-Fi Card',
        imagePath: 'assets/images/vga_wrong_1.png',
        isCorrect: false,
      ),
      AssemblyOption(
        id: 'vga_correct',
        name: 'NVIDIA RTX VGA Card',
        imagePath: 'assets/images/vga_correct.png',
        isCorrect: true,
      ),
      AssemblyOption(
        id: 'vga_wrong_2',
        name: 'PCI Sound Card',
        imagePath: 'assets/images/vga_wrong_2.png',
        isCorrect: false,
      ),
      AssemblyOption(
        id: 'vga_wrong_3',
        name: 'PCIe Capture Card',
        imagePath: 'assets/images/vga_wrong_3.png',
        isCorrect: false,
      ),
    ],
  ),

  // 5. MISI 5: BATERAI CMOS
  AssemblyQuestion(
    id: 5,
    targetComponentName: 'Baterai CMOS CR2032',
    beforeBoardImage: 'assets/images/board_4_vga.png',
    afterBoardImage: 'assets/images/board_5_full.png',
    wrongExplanation: 'Komponen ini bukan Baterai CMOS! Baterai CMOS CR2032 berbentuk koin pipih untuk menyimpan daya BIOS.',
    options: [
      AssemblyOption(
        id: 'cmos_correct',
        name: 'Baterai CMOS CR2032',
        imagePath: 'assets/images/cmos_correct.png',
        isCorrect: true,
      ),
      AssemblyOption(
        id: 'cmos_wrong_1',
        name: 'Baterai AA 1.5V',
        imagePath: 'assets/images/cmos_wrong_1.png',
        isCorrect: false,
      ),
      AssemblyOption(
        id: 'cmos_wrong_2',
        name: 'Jumper Cap BIOS',
        imagePath: 'assets/images/cmos_wrong_2.png',
        isCorrect: false,
      ),
      AssemblyOption(
        id: 'cmos_wrong_3',
        name: 'Baterai AAA 1.5V',
        imagePath: 'assets/images/cmos_wrong_3.png',
        isCorrect: false,
      ),
    ],
  ),
];
