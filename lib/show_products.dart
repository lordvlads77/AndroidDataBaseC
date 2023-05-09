import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Productos extends StatefulWidget {
  const Productos({Key? key}) : super(key: key);

  @override
  State<Productos> createState() => _ProductosState();
}

class _ProductosState extends State<Productos> {

  Future productos_show()async {
     var url = Uri.parse('https://www.fictionsearch.net/AndroidDatabaseConnect/mostrarProductos.php');
     var response = await http.post(url).timeout(Duration(seconds: 90));
     
     print(response.body);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productos_show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
      ),
      body: ListView(
        children: [

        ],
      ),
    );
  }
}
