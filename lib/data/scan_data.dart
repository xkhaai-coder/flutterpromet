import '../models/scan_case.dart';

class ScanData {
  static final List<ScanCase> cases = [
    ScanCase(
      id: 'case_ram_dirty',
      title: 'RAM KOTOR / NO DISPLAY',
      description: 'Komputer menyala tetapi tidak memunculkan gambar di layar. Konektor RAM diduga kotor atau teroksidasi.',
      type: ScanCaseType.ram,
      hintMessage: 'Lepas baut casing, buka panel, buka pengunci RAM, lepas modul RAM, gosok pin emas dengan kuas hingga bersih, pasang kembali, lalu kunci slot.',
    ),
    ScanCase(
      id: 'case_cpu_overheat',
      title: 'CPU OVERHEAT / THERMAL PASTE KERING',
      description: 'Komputer sering mati mendadak karena suhu CPU terlalu tinggi. Thermal paste lama sudah mengering.',
      type: ScanCaseType.cpu,
      hintMessage: 'Buka casing, lepas CPU cooler, hapus sisa thermal paste kering dengan kain pembersih, oleskan thermal paste baru, lalu pasang kembali cooler.',
    ),
  ];
}
