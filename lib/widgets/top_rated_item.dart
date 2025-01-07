import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/api/api.dart';
import 'package:movies/widgets/index_number.dart';
import 'package:movies/models/actor.dart';
import 'package:movies/screens/details_screen_actor.dart';

class TopRatedItem extends StatelessWidget {
  const TopRatedItem({
    super.key,
    // Recibe un objeto actor que contiene la información del actor.
    required this.actor,
    required this.index,
  });
  // Definición de actor (objeto de tipo Actor).
  final Actor actor;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => Get.to(
            // Navega a la pantalla de detalles del actor.
            DetailsScreenActor(actor: actor),
          ),
          child: Container(
            margin: const EdgeInsets.only(left: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                // Obtenemos la imagen del actor
                Api.imageBaseUrl + actor.profilePath,
                fit: BoxFit.cover,
                height: 250,
                width: 180,
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
        ),
        Align(
          alignment: Alignment.bottomLeft,
          // Muestra el número de índice del actor.
          child: IndexNumber(number: index),
        )
      ],
    );
  }
}
