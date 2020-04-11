class ContactModel {
  
  String guid;
  String name;
  String gender;
  String email;
  String phone;
  
  ContactModel({
    this.guid = '',
    this.name = '',
    this.gender = '',
    this.email = '',
    this.phone = '',
  });
  
  static ContactModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ContactModel(guid: map['guid'], name: map['name'], gender: map['gender'], email: map['name'], phone: map['phone']);
  }

}
