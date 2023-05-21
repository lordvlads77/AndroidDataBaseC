import 'dart:convert';
import 'package:apps/editar.dart';
import 'package:apps/registros.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'customloading.dart';

class Productos extends StatefulWidget {
  const Productos({Key? key}) : super(key: key);

  @override
  State<Productos> createState() => _ProductosState();
}

class _ProductosState extends State<Productos> {

  bool loading = true;

  List<Registros> reg = [];

  Future<List<Registros>> productos_show()async {
     var url = Uri.parse('https://www.fictionsearch.net/AndroidDatabaseConnect/mostrarProductos.php');
     var response = await http.post(url).timeout(Duration(seconds: 90));

     final datos = jsonDecode(response.body);

     List<Registros> registros = [];

     for (var datos in datos){
       registros.add(Registros.fromJson(datos));
     }

     return registros;
     
     print(response.body);
  }


  msn_eliminar(id, nombre){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Amazon'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text('Realmente quieres eliminar?'),
                  Text(nombre),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.of(context).pop();


                eliminar_producto(id);

              },
                  child: Text('Aceptar')),
              TextButton(onPressed: (){
                _onItem('No Junciona');
                Navigator.of(context).pop();
              },
                  child: Text('Cancelar'))
            ],
          );
        }
    );
  }

  mostrar_alerta(mensaje){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Amazon'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(mensaje),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.of(context).pop();
              },
                  child: Text('Aceptar'))
            ],
          );
        }
    );
  }

  void _onItem (String msg) async {
    SmartDialog.showLoading(
      animationType: SmartAnimationType.scale,
      builder: (_) => CustomLoading(type: 1),
    );
    await Future.delayed(Duration(seconds: 5));
    SmartDialog.dismiss(status: SmartStatus.loading);
  }

  Future eliminar_producto(id) async {

    var url = Uri.parse('https://www.fictionsearch.net/AndroidDatabaseConnect/eliminar_Productos.php');

    var response = await http.post(url, body: {
      'id' : id
    }).timeout(const Duration(seconds: 90));
    if (response.body == '1'){
      mostrar_alerta('Tu producto se elimino correctamente');
      setState(() {
        loading = true;
        reg = [];
        productos_show().then((value){
          setState(() {
            reg.addAll(value);
            loading = false;
          });
          // El set state sirve para redibujar las variables que han cambiado
        });
      });
    }else {
      mostrar_alerta(response.body);
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productos_show().then((value){
      setState(() {
        reg.addAll(value);
        loading = false;
      });
      // El set state sirve para redibujar las variables que han cambiado
      //print(reg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
      ),
      body: loading == true ?

          const Center(
              child: CircularProgressIndicator(),
          )

      : reg.isEmpty ?

      Center(
        child: Text('No tienes ningun producto registrado'),
      )

      : ListView.builder(
        itemCount: reg.length,
          itemBuilder: (BuildContext context, int index){
          return Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Colors.grey
                )
              ),
            ),
            child: Padding(padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(reg[index].nombre!,
                      style: TextStyle(
                        fontSize: 16
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){

                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context){
                          return Editar(reg[index].id!);
                        }
                      )).then((value){

                        setState(() {
                          loading = true;
                          reg = [];
                          productos_show().then((value){
                            setState(() {
                              reg.addAll(value);
                              loading = false;
                            });
                            // El set state sirve para redibujar o refreshear las variables que han cambiado
                          });
                        });
                      });

                    },
                    child: Icon(Icons.edit, color: Colors.green,),
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: (){
                      SmartDialog.showLoading(builder: (_) => CustomLoading(type: 1));
                      msn_eliminar(reg[index].id, reg[index].nombre);
                    },
                    child: Icon(Icons.delete, color: Colors.red,),
                  ),
                ],
              ),
            ),
          );
      }
      ),
    );
  }
}
