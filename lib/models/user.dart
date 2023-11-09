class User {
  final String email;
  final String uid;
  final String imageUrl;
  final String fullname;
  final String phoneNumber;
  final double fontSize;
  final double letterSpacing;
  final double wordSpacing;
  final double lineSpacing;
  final String fontFamily;
  final String backgroundColor;
  final String textColor;
  final bool isFirstTimeLogin;
  final List<dynamic> doneExams;
  final List<dynamic> resultDoneExams;
  final List<dynamic> errorWords;

  const User(
      {required this.email,
        required this.uid,
        required this.imageUrl,
        required this.fullname,
        required this.phoneNumber,
        required this.fontSize,
        required this.letterSpacing,
        required this.wordSpacing,
        required this.lineSpacing,
        required this.fontFamily,
        required this.backgroundColor,
        required this.textColor,
        required this.isFirstTimeLogin,
        required this.doneExams,
        required this.resultDoneExams,
        required this.errorWords
        });

  Map<String, dynamic> toJson() => {
    "fullname": fullname,
    "uid": uid,
    "email": email,
    "imageUrl": imageUrl,
    "phoneNumber": phoneNumber,
    "fontSize" : fontSize,
    "letterSpacing" : letterSpacing,
    "wordSpacing" : wordSpacing,
    "lineSpacing" : lineSpacing,
    "fontFamily" : fontFamily,
    "backgroundColor" : backgroundColor,
    "textColor" : textColor,
    "isFirstTimeLogin" : isFirstTimeLogin,
    "doneExams" : doneExams,
    "resultDoneExams" : resultDoneExams,
    "errorWords" : errorWords
  };

  static User fromJson(Map<String, dynamic> json) => User(
      uid: json['uid'],
      fullname: json['fullname'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      phoneNumber: json['phoneNumber'],
      fontSize: json['fontSize'],
      letterSpacing: json['letterSpacing'],
      wordSpacing: json['wordSpacing'],
      lineSpacing: json['lineSpacing'],
      fontFamily: json['fontFamily'],
      backgroundColor: json['backgroundColor'],
      textColor: json['textColor'],
      isFirstTimeLogin: json['isFirstTimeLogin'],
      doneExams: json['doneExams'],
      resultDoneExams: json['resultDoneExams'],
      errorWords: json['errorWords']
  );
}