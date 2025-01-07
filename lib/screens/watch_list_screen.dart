import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/api/api.dart';
import 'package:movies/controllers/bottom_navigator_controller.dart';
import 'package:movies/widgets/infos.dart';
import 'package:movies/controllers/actors_controller.dart';
import 'package:movies/screens/details_screen_actor.dart';

class WatchList extends StatelessWidget {
  const WatchList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(34.0),
        child: Column(
          children: [
            // Barra superior con botón para regresar al inicio
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  tooltip: 'Back to home',
                  onPressed: () =>
                      Get.find<BottomNavigatorController>().setIndex(0),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'Watch list',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  width: 33,
                  height: 33,
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Mostrar actores favoritos si la lista no está vacía
            if (Get.find<ActorsController>().favouriteList.isNotEmpty)
              ...Get.find<ActorsController>().favouriteList.map(
                    (actor) => Column(
                  children: [
                    GestureDetector(
                      // Navegación a los detalles del actor
                      onTap: () => Get.to(DetailsScreenActor(actor: actor)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Imagen del actor
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              Api.imageBaseUrl + actor.profilePath,
                              height: 180,
                              width: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const Icon(
                                Icons.broken_image,
                                size: 180,
                              ),
                              loadingBuilder: (_, __, ___) {
                                if (___ == null) return __;
                                return const FadeShimmer(
                                  width: 150,
                                  height: 150,
                                  highlightColor: Color(0xff22272f),
                                  baseColor: Color(0xff20252d),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 5),

                          // Información del actor
                          Infos(actor: actor),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20), // Espacio entre elementos
                  ],
                ),
              ),

            // Mensaje si la lista de favoritos está vacía
            if (Get.find<ActorsController>().favouriteList.isEmpty)
              const Column(
                children: [
                  SizedBox(height: 200), // Espacio para separar visualmente
                  Text(
                    'No actors in your watch list', // Mensaje de lista vacía
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    ));
  }
}
