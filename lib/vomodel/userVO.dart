class User {
  final String id;
  final String pw;
  final String nick;

  User({required this.id, required this.pw, required this.nick});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pw': pw,
      'nick': nick,
    };
  }

  @override
  String toString() {
    return '{id: $id, pw: $pw, nick: $nick}';
  }
}
