class User {
  User({this.name = '', this.count});
  String? name;
  int? count;

  @override
  String toString() => 'User { name: $name, count: $count }';
}
