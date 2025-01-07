import 'package:get/get.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/models/actor.dart';

class ActorsController extends GetxController {
  var isLoading = false.obs;
  var topTenActors = <Actor>[].obs;
  var favouriteList = <Actor>[].obs;

  @override
  void onInit() async {
    isLoading.value = true;
    topTenActors.value = (await ApiService.topTenActors())!;
    isLoading.value = false;
    // Llama al método onInit de la clase padre.
    super.onInit();
  }
  // Verifica si un actor está en la lista de favoritos.
  bool isInFavouriteList(Actor actor) {
    return favouriteList.any((m) => m.id == actor.id);
  }
  // Añade o elimina un actor de la lista de favoritos.
  void addToFavouriteList(Actor actor) {
    // Si el actor ya está en la lista, lo elimina y muestra una notificación.
    if (favouriteList.any((m) => m.id == actor.id)) {
      favouriteList.remove(actor);
      Get.snackbar(
        'Success',
        'removed from favourite list',
        snackPosition: SnackPosition.BOTTOM,
        animationDuration: const Duration(milliseconds: 1000),
        duration: const Duration(milliseconds: 1000),
      );
    } else {
      // Si el actor no está en la lista, lo añade y muestra una notificación.
      favouriteList.add(actor);
      Get.snackbar(
        'Success',
        'added to favourite list',
        snackPosition: SnackPosition.BOTTOM,
        animationDuration: const Duration(milliseconds: 1000),
        duration: const Duration(milliseconds: 1000),
      );
    }
  }
}
