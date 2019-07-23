import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mapa',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Controlador de google maps
  GoogleMapController mapController;

  String buscarDireccion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
      children: <Widget>[
        GoogleMap(
          //Creacion del mapa
          onMapCreated: onMapCreated,
          //Posicion inicial de la camara que transmitirá el mapa
          initialCameraPosition: CameraPosition(
            //Latitud y longitud de la posicion o georeferencia
                  target: LatLng(40.7128, -74.0060), zoom: 10.0
                  ),
        ),
        Positioned(
          top: 30.0,
          right: 15.0,
          left: 15.0,
          child: Container(
            height: 50.0,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0), color: Colors.white),
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Ingresa una direccion o nombre de un lugar',
                  hintStyle: TextStyle(fontSize: 10.0),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                  suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: buscarNavegar,
                      iconSize: 30.0)),
              onChanged: (val) {
                setState(() {
                  buscarDireccion = val;
                });
              },
            ),
          ),
        )
      ],
    )
                );
              }

  //Método de busqueda por direccion
  buscarNavegar() {
    //primero debemos importar la libreria
    Geolocator().placemarkFromAddress(buscarDireccion).then((result) {
      //Animacion de acercamiento de la camara desde el satelite hasta la tierra
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target:
              LatLng(result[0].position.latitude, result[0].position.longitude),
          zoom: 10.0)));
    });
  }
  //Método que crea el mapa
  void onMapCreated(controller) {
    setState(() {
      //instanciamos
      mapController = controller;
    });
  }
}