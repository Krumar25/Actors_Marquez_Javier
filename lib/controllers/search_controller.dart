import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/models/actor.dart';

class SearchController1 extends GetxController {
  TextEditingController searchController = TextEditingController();
  var searchText = ''.obs;
  var foundActors = <Actor>[].obs;
  var isLoading = false.obs;

  // Actualiza el texto de búsqueda con el valor proporcionado.
  void setSearchText(text) => searchText.value = text;

  // Realiza la búsqueda de actores según la consulta proporcionada.
  void search(String query) async {
    isLoading.value = true;
    // Obtiene los actores encontrados a través del servicio API.
    foundActors.value = (await ApiService.getSearchedActors(query)) ?? [];
    isLoading.value = false;
  }
}
