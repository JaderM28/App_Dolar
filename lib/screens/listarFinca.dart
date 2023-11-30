import 'dart:convert';
import 'package:app_finca/request/dolar_get.dart';
import 'package:app_finca/screens/insertarFinca.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ListarFinca extends StatefulWidget {
  const ListarFinca({super.key});

  @override
  State<ListarFinca> createState() => _ListarFincaState();
}

class _ListarFincaState extends State<ListarFinca> {
  String selectedDay = 'Todos';
  List<dynamic> listData = [];
  List<dynamic> originalData = [];
  List<String> listaDias = [];
  String? dolarData;
  double valorTotal = 0.0;
  int cantidadTotal = 0;

  Future<List<dynamic>> getPeticion() async {
    final response =
        await http.get(Uri.parse("https://apifincas.onrender.com/ruta/fincas"));

    if (response.statusCode == 200) {
      Map<String, dynamic> codeData = json.decode(response.body);
      return codeData["finca"] ?? [];
    } else {
      throw Exception(
          'Faild to load data. Status Code: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    _initData(
        'Todos');
    fetchGet(); // Inicializar con 'Todos' o cualquier otro valor predeterminado
  }

  Future<void> fetchGet() async {
    DateTime now = DateTime.now();
    String date = "${now.year}-${now.month}-${now.day}";

    final response = await http.get(Uri.parse(
        'https://www.datos.gov.co/resource/mcec-87by.json?vigenciadesde=$date'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      setState(() {
        final data = jsonData.map((e) => FetchGet.fromJson(e)).toList();
        dolarData = data[0].valor;
      });
    } else {
      throw Exception("Error: Peticion Get Fail");
    }
  }

  Future<void> _initData(String selectedDay) async {
    listData = await getPeticion();
    originalData = List.from(listData);

    listaDias = listData
        .map((item) => item['cantidadDias'].toString())
        .toSet()
        .toList();
    listaDias.insert(0, 'Todos');
    // Filtrar la lista por el día seleccionado
    _filterByDay(selectedDay);

    for(int i = 0; i < listData.length; i++){
      valorTotal += double.parse(listData[i]['valorAlquiler']);
      
    }
    valorTotal = valorTotal * double.parse(dolarData!);

    for(int i = 0; i < listData.length; i++){
      cantidadTotal += int.parse(listData[i]['cantidadDias']);
    }
    
    setState(() {});
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("App - Finca", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: DropdownButton<String>(
              value: selectedDay,
              onChanged: (String? newValue) {
                setState(() {
                  selectedDay = newValue!;
                  _filterByDay(
                      selectedDay); // Llamar al método de filtrado al cambiar el día seleccionado
                });
              },
              items: listaDias.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
                //este builder se comporta como un foreach
                itemCount: listData.length, //Obtiene la cantidad de elementos
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ExpansionTile(
                      backgroundColor: const Color.fromARGB(255, 191, 190, 188),
                      title: Text(
                          "N° Finca: ${listData[index]['numero'].toString()}",),
                      subtitle: Text(
                          "Nombre Finca: ${listData[index]['nombreFinca'].toString()}"),
                      leading: const Icon(Icons.person),
                      expandedAlignment: Alignment.centerLeft,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            color: const Color.fromARGB(255, 221, 217, 217),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Center(
                                      child: Text(
                                    "Datos de la Finca",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                        "Numero: ${listData[index]['numero'].toString()}"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                        "Nombre Finca: ${listData[index]['nombreFinca'].toString()}"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                        "Direccion: ${listData[index]['direccion'].toString()}"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                        "Alquiler: ${listData[index]['valorAlquiler'].toString()}"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                        "Cantida Dias: ${listData[index]['cantidadDias'].toString()}"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          Text("Cantidad Total Dias: $cantidadTotal"),
          Text("Valor Total: ${valorTotal.toStringAsFixed(2)}")
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => CrearFinca(dolar: dolarData!)));
        },
        child: const Icon(Icons.add),),
    );
  }

  void _filterByDay(selectedDay) {
    if (selectedDay == 'Todos') {
      // Si se selecciona 'Todos', mostrar la lista original
      setState(() {
        listData = List.from(originalData);
      });
    } else {
      // Filtrar la lista por el día seleccionado
      setState(() {
        listData = originalData
            .where((item) =>
                item['cantidadDias'].toString().toLowerCase() ==
                selectedDay.toLowerCase())
            .toList();
      });
    }
  }
}
