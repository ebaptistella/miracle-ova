import 'package:miracle_ova/models/contact_model.dart';
import 'package:miracle_ova/utils/custom_dio.dart';

class ContactRepository {
  
  Future<List<ContactModel>> findAll() {
    var dio = CustomDio.withAuthentication().instance;
    return dio.get('http://192.168.1.11:3000/contact').then((res) {
      return res.data.map<ContactModel>((c) => ContactModel.fromMap(c)).toList() as List<ContactModel>;
    }).catchError((err) => print(err));
  }

  Future<List<ContactModel>> findByName(String name) {
    var dio = CustomDio.withAuthentication().instance;
    return dio.get('http://192.168.1.11:3000/contact/find?name=$name').then((res) {
      return res.data.map<ContactModel>((c) => ContactModel.fromMap(c)).toList() as List<ContactModel>;
    }).catchError((err) => print(err));
  }
  
}