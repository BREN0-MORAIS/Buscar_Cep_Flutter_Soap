import 'dart:convert';

import 'package:cep_soap/model/cep.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class CepServices {
 Uri url = Uri.parse('https://apps.correios.com.br/SigepMasterJPA/AtendeClienteService/AtendeCliente?');
 
 
 Future<Cep> getCep(String cep) async{
   String envelope = 
   '''
      <soapenv:Envelope 
          xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
          xmlns:cli="http://cliente.bean.master.sigep.bsb.correios.com.br/">
          <soapenv:Header/><soapenv:Body>
          <cli:consultaCEP>
          <cep>${cep}</cep>
          </cli:consultaCEP></soapenv:Body>
      </soapenv:Envelope>

   ''';
   
   final resposta = await http.post(url, 
   headers: {"Content-Type": "text/xml"},
   body: envelope);
   
    var objXml = xml.parse(utf8.decode(resposta.bodyBytes));
    
     Cep objCep = Cep(
        bairro: cleanXml(objXml.findAllElements('bairro').toString(),'bairro'), 
        cep:  cleanXml(objXml.findAllElements('cep').toString(),'cep'), 
        complemento:  cleanXml(objXml.findAllElements('complemento',).toString(),'complemento'), 
        complemento2:  cleanXml(objXml.findAllElements('complemento2').toString(),'complemento2'), 
        cidade:  cleanXml(objXml.findAllElements('cidade').toString(),'cidade')
    );
    return objCep;

 }

 
 String  cleanXml(String objXml, String parametro) {
   return objXml.replaceAll('<$parametro>', '').replaceAll('</$parametro>', '').replaceAll('(', '').replaceAll(')', '').toString();
 }
 
}
