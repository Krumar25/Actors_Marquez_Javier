import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/models/actor.dart';

class Infos extends StatelessWidget {
  const Infos({super.key, required this.actor});
  final Actor actor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Nombre del actor
          SizedBox(
            width: 200,
            child: Text(
              actor.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Popularidad del actor, mostrando un ícono de estrella y su valor
              Row(
                children: [
                  SvgPicture.asset('assets/Star.svg'), // Ícono SVG de estrella
                  const SizedBox(width: 5),
                  Text(
                    actor.popularity == 0.0
                        ? 'N/A' // Si la popularidad es 0, muestra "N/A"
                        : actor.popularity.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                      color: Color(0xFFFF8700),
                    ),
                  ),
                ],
              ),
              // Lugar de nacimiento del actor, acompañado de un ícono de ciudad
              Row(
                children: [
                  Icon(Icons.location_city, color: Colors.white), // Ícono de ciudad
                  const SizedBox(width: 5),
                  Text(
                    actor.placeOfBirth,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ],
              ),
              // Fecha de nacimiento del actor, acompañado de un ícono de calendario
              Row(
                children: [
                  SvgPicture.asset('assets/calender.svg'),
                  const SizedBox(width: 5),
                  Text(
                    actor.birthday,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
