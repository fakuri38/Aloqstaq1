class Field {
  String id;
  String name;
  String description;

  bool selected;

  Field();

  Field.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      name = jsonMap['name'];
      description = jsonMap['description'];
      selected = jsonMap['selected'] ?? false;
    } catch (e) {
      id = '';
      name = '';
      description = '';
      selected = false;
      print(e);
    }
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = id;
    return map;
  }

  @override
  bool operator ==(dynamic other) {
    return other.id == this.id;
  }

  @override
  int get hashCode => super.hashCode;
}
