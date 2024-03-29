import 'package:flutter/material.dart';

class RadioModel {
  bool isSelected;
  final Icon radioIcon;
  final String text;
  final Color selectedColor;

  RadioModel(this.isSelected, this.radioIcon, this.text, this.selectedColor);

}

List<RadioModel> incidentTypeList = [
  new RadioModel(false,
        Icon(
        Icons.whatshot,
        color: Colors.white,
        ),
        'Incendit',
        Colors.red),
  new RadioModel(
      false,
      Icon(
      Icons.face,
      color: Colors.white,
      ),
      'Enfant Introuvable',
      Colors.deepPurple),
      new RadioModel(
      false,
      Icon(
      Icons.directions_car,
      color: Colors.white,
      ),
      'Accident',
      Colors.blueAccent),
    new RadioModel(
      false,
      Icon(
      Icons.directions_run,
      color: Colors.white,
      ),
      'Vole',
      Colors.deepOrange),
    new RadioModel(
    false,
    Icon(
    Icons.airline_seat_flat_angled,
    color: Colors.white,
    ),
    'Inondation',
    Colors.greenAccent),
  new RadioModel(
      false,
      Icon(
        Icons.business,
        color: Colors.white,
      ),
      'Violence Conjugale',
      Colors.amber),
  new RadioModel(
      false,
      Icon(
        Icons.business,
        color: Colors.white,
      ),
      'Braquage',
      Colors.indigo),
  new RadioModel(
      false,
      Icon(
        Icons.directions_bus,
        color: Colors.white,
      ),
      'Muvaise Conduite',
      Colors.deepPurple),
  new RadioModel(
      false,
      Icon(
        Icons.perm_identity,
        color: Colors.white,
      ),
      'Enfant maltraité',
      Colors.blueAccent),
  new RadioModel(
      false,
      Icon(
        Icons.pregnant_woman,
        color: Colors.white,
      ),
      'Viole',
      Colors.green.shade900)

];

List<RadioModel> mapRubrique = [
  new RadioModel(false,
      Icon(
        Icons.hotel,
        color: Colors.red,
      ),
      'Hotêl',
      Colors.white),
  new RadioModel(
      false,
      Icon(
        Icons.person,
        color: Colors.green,
      ),
      'Poste police',
      Colors.white),
  new RadioModel(
      false,
      Icon(
        Icons.local_hospital,
        color: Colors.blue,
      ),
      'Hopital',
      Colors.white),
  new RadioModel(
      false,
      Icon(
        Icons.directions_run,
        color: Colors.green,
      ),
      'Pharmacie',
      Colors.white),
  new RadioModel(
      false,
      Icon(
        Icons.airline_seat_flat_angled,
        color: Colors.pink,
      ),
      'Clinique',
      Colors.white),
  new RadioModel(
      false,
      Icon(
        Icons.home,
        color: Colors.indigo,
      ),
      'Eglise',
      Colors.white),
  new RadioModel(
      false,
      Icon(
        Icons.monetization_on,
        color: Colors.indigo,
      ),
      'Banque',
      Colors.white),

];
