class AssemblyOption {
  final String id;
  final String name;
  final String imagePath;
  final bool isCorrect;

  AssemblyOption({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.isCorrect,
  });
}

class AssemblyQuestion {
  final int id;
  final String targetComponentName;
  final String beforeBoardImage;
  final String afterBoardImage;
  final List<AssemblyOption> options;
  final String wrongExplanation;

  AssemblyQuestion({
    required this.id,
    required this.targetComponentName,
    required this.beforeBoardImage,
    required this.afterBoardImage,
    required this.options,
    required this.wrongExplanation,
  });
}
