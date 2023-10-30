class User {
  final String email;
  final String uid;
  final String imageUrl;
  final String fullname;
  final String phoneNumber;
  final double fontSize;
  final double letterSpacing;
  final double wordSpacing;
  final String fontFamily;
  final bool isFirstTimeLogin;

  const User(
      {required this.email,
        required this.uid,
        required this.imageUrl,
        required this.fullname,
        required this.phoneNumber,
        required this.fontSize,
        required this.letterSpacing,
        required this.wordSpacing,
        required this.fontFamily,
        required this.isFirstTimeLogin
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
    "fontFamily" : fontFamily,
    "isFirstTimeLogin" : isFirstTimeLogin
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
      fontFamily: json['fontFamily'],
      isFirstTimeLogin: json['isFirstTimeLogin']
  );
}