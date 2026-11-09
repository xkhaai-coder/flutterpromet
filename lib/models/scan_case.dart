enum ScanCaseType { ram, cpu }

class ScanCase {
  final String id;
  final String title;
  final String description;
  final ScanCaseType type;
  final String hintMessage;

  ScanCase({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.hintMessage,
  });
}

class ScanProgressState {
  // Status Casing & Baut
  int boltsRemovedCount;
  bool isCaseOpened;

  // Status Kasus RAM
  bool ramLeftClipUnlocked;
  bool ramRightClipUnlocked;
  bool ramRemoved;
  bool ramCleaned;
  bool ramReinstalled;
  bool ramLeftClipLocked;
  bool ramRightClipLocked;

  // Status Kasus CPU
  bool cpuCoolerRemoved;
  bool oldThermalPasteCleaned;
  bool newThermalPasteApplied;
  bool cpuCoolerReinstalled;

  ScanProgressState({
    this.boltsRemovedCount = 0,
    this.isCaseOpened = false,
    this.ramLeftClipUnlocked = false,
    this.ramRightClipUnlocked = false,
    this.ramRemoved = false,
    this.ramCleaned = false,
    this.ramReinstalled = false,
    this.ramLeftClipLocked = false,
    this.ramRightClipLocked = false,
    this.cpuCoolerRemoved = false,
    this.oldThermalPasteCleaned = false,
    this.newThermalPasteApplied = false,
    this.cpuCoolerReinstalled = false,
  });

  void reset() {
    boltsRemovedCount = 0;
    isCaseOpened = false;
    ramLeftClipUnlocked = false;
    ramRightClipUnlocked = false;
    ramRemoved = false;
    ramCleaned = false;
    ramReinstalled = false;
    ramLeftClipLocked = false;
    ramRightClipLocked = false;
    cpuCoolerRemoved = false;
    oldThermalPasteCleaned = false;
    newThermalPasteApplied = false;
    cpuCoolerReinstalled = false;
  }
}
