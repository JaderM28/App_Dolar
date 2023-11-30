import 'dart:convert';
import 'package:app_finca/screens/listarFinca.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class CrearFinca extends StatefulWidget {

  String dolar;

  CrearFinca({super.key, required this.dolar});

  @override
  State<CrearFinca> createState() => _CrearFincaState();
}

class _CrearFincaState extends State<CrearFinca> {
  
  final _formKey = GlobalKey<FormState>();

  TextEditingController txtNumero = TextEditingController();
  TextEditingController txtNombre = TextEditingController();
  TextEditingController txtDireccion = TextEditingController();
  TextEditingController txtValorFinca = TextEditingController();
  TextEditingController txtCantidad = TextEditingController();


  Future<bool> postPeticion(Map datos) async {
    try {
      final response = await http.post(Uri.parse("https://apifincas.onrender.com/ruta/fincas"),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(datos));

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Error durante la solicitud Post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF776B5D),
        centerTitle: true,
        title: const Text("App - Finca", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(     
                    color: Colors.black,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: Text(
                        "Registro de Finca",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: txtNumero,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFB0A695),
                      border: OutlineInputBorder(
                      borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none),
                      hintText: "Numero de la Finca",
                      hintStyle: TextStyle(
                      color: Color.fromARGB(255, 42, 42, 42)),
                      prefixIcon: Icon(Icons.lock),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Por Favor, Introduce Numero de la Finca";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: txtNombre,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFB0A695),
                      border: OutlineInputBorder(
                      borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none),
                      hintText: "Nombre de la Finca",
                      hintStyle: TextStyle(
                      color: Color.fromARGB(255, 42, 42, 42)),
                      prefixIcon: Icon(Icons.lock),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Por Favor, Introduce Nombre de la Finca";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: txtDireccion,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFB0A695),
                      border: OutlineInputBorder(
                      borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none),
                      hintText: "Direccion de la Finca",
                      hintStyle: TextStyle(
                      color: Color.fromARGB(255, 42, 42, 42)),
                      prefixIcon: Icon(Icons.lock),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Por Favor, Introduce Direccion de la Finca";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: txtValorFinca,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFB0A695),
                      border: OutlineInputBorder(
                      borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none),
                      hintText: "Valor de la Finca",
                      hintStyle: TextStyle(
                      color: Color.fromARGB(255, 42, 42, 42)),
                      prefixIcon: Icon(Icons.monetization_on),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Por Favor, Introduce Valor de la Finca";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: txtCantidad,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFB0A695),
                      border: OutlineInputBorder(
                      borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none),
                      hintText: "Cantidad de Dias Finca",
                      hintStyle: TextStyle(
                      color: Color.fromARGB(255, 42, 42, 42)),
                      prefixIcon: Icon(Icons.lock),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Por Favor, Introduce cantidad de Dias";
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                        const Size(double.infinity,
                            48.0), 
                      ),
                      backgroundColor: MaterialStateProperty.all(
                          const Color(
                              0xFF776B5D)),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final Map<String, dynamic> datos = {
                          "numero": txtNumero.text,
                          "nombreFinca": txtNombre.text,
                          "direccion": txtDireccion.text,
                          "valorAlquiler": (double.parse(txtValorFinca.text) / double.parse(widget.dolar)).toStringAsFixed(2),
                          "cantidadDias": txtCantidad.text,
                          
                        };
      
                        bool estado =
                            await postPeticion(datos);
      
                        if (estado) {
                          print("Registro Exitoso");
                          Future.delayed(const Duration(seconds: 3), () {
                              Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => const ListarFinca()));
                          });
                        } else {
                          print("Error Registro");
                        }
                        _formKey.currentState?.reset();
                      }
                    },
                    child: const Text("Registrar", style: TextStyle(color: Colors.white, fontSize: 18)))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
