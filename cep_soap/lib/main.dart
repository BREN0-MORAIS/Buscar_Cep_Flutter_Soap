import 'package:cep_soap/services/cep_services.dart';
import 'package:flutter/material.dart';

import 'model/cep.dart';

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var cepController = TextEditingController();

  var cepService = CepServices();
  Cep? cep;

    Future<void> _getCep() async{
         
          Cep? cep = await cepService.getCep(cepController.text);

           setState(() {
             this.cep = cep;
           });
        }

  @override
  Widget build(BuildContext context) {



  
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Buscar Cep SOAP'),
          shadowColor:Colors.red ,
        ),
        body: Column(
          children: [
            cep != null ? 
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListBody(children: [
                   Text('Cep: ${cep!.cep }'),
                   Text('Bairro: ${cep!.bairro}'),
                   Text('Complemento: ${cep!.complemento}'),
                   Text('Complemento2: ${cep!.complemento2}'),
                   Text('Cidade: ${cep!.cidade}'),
                  ],),
                ),
              ),
            )
            
            : Text('')
            ,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: cepController,
                    decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Cep'),
                  ),
                ),
                ElevatedButton(onPressed: () async{ await _getCep();}, child: Text('Buscar')),
          ],
        ),
      ),
    );
  }
}
