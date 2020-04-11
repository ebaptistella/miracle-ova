import 'package:flutter/material.dart';
import 'package:miracle_ova/models/contact_model.dart';
import 'package:miracle_ova/repositories/contact_repository.dart';
import 'package:miracle_ova/repositories/login_repository.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<List<ContactModel>> contactFuture;
  ContactRepository _contactRepository;
  TextEditingController _buscaController = TextEditingController();


  @override
  void initState() { 
    super.initState();
    
    LoginRepository().login();

    _contactRepository = ContactRepository();
    contactFuture = _contactRepository.findAll();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Example using DIO')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _buscaController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder()
                  ),
                ),
              )),
              Container(
                padding: EdgeInsets.all(10),
                child: RaisedButton(
                onPressed: (){
                  setState(() {
                    if(_buscaController.text.isEmpty) {
                      contactFuture = _contactRepository.findAll();
                    } else {
                      contactFuture = _contactRepository.findByName(_buscaController.text);
                    }
                  });
                },
                child: Text('Search'),
              ))
            ],
          ),

          Expanded(child: FutureBuilder(
            future: this.contactFuture,
            builder: (BuildContext  context, AsyncSnapshot<List<ContactModel>> snapshot) {
              if (snapshot.data == null) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError){
                return Center(
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 60,
                      ),
                      Text('Error ${snapshot.error}'),
                    ],
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    var item = snapshot.data[index];
                    return ListTile(
                      title: Text(item.name),
                      subtitle: Text(item.email)
                    );
                  });
              }
            })
          )

        ],
      )
    );
  }
}