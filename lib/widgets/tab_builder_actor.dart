import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/api/api.dart';
import 'package:movies/models/actor.dart';
import 'package:movies/screens/details_screen_actor.dart';

class TabBuilderActor extends StatelessWidget {
  const TabBuilderActor({
    required this.future,
    super.key,
  });
  final Future<List<Actor>?> future;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 12.0),
      child: FutureBuilder<List<Actor>?>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              // shrinkWrap: true,
              // Genera un 'GridView' que muestra los actores en un formato de cuadrícula.
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 15.0,
                childAspectRatio: 0.6,
              ),
              // Número de elementos en la cuadrícula (cantidad de actores).
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  // Al hacer clic en un actor, se navega a la pantalla de detalles del actor.
                  Get.to(DetailsScreenActor(actor: snapshot.data![index]));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    // Carga la imagen del actor utilizando su perfil.
                    Api.imageBaseUrl+snapshot.data![index].profilePath,
                    height: 300,
                    width: 180,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.broken_image,
                      size: 180,
                    ),
                    loadingBuilder: (_, __, ___) {
                      // ignore: no_wildcard_variable_uses
                      if (___ == null) return __;
                      return const FadeShimmer(
                        width: 180,
                        height: 250,
                        highlightColor: Color(0xff22272f),
                        baseColor: Color(0xff20252d),
                      );
                    },
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}