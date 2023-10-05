class CustomizeTextOption {
  double? fontSize;
  double? characterSpacing;

  CustomizeTextOption({
    required this.fontSize,
    required this.characterSpacing
});

  // CustomizeTextOption.fromJson(Map<String, dynamic> json) {
  //   fontSize = json['fontSize'];
  //   characterSpacing = json['characterSpacing'];
  // }

  static CustomizeTextOption fromJson(Map<String, dynamic> json) => CustomizeTextOption(
    fontSize: json['fontSize'].toDouble(),
    characterSpacing: json['characterSpacing'].toDouble()
  );
}