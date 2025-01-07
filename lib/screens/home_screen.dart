import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/controllers/bottom_navigator_controller.dart';
import 'package:movies/controllers/movies_controller.dart';
import 'package:movies/controllers/search_controller.dart';
import 'package:movies/widgets/search_box.dart';
import 'package:movies/widgets/top_rated_item.dart';
import 'package:movies/controllers/actors_controller.dart';
import 'package:movies/widgets/tab_builder_actor.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final MoviesController controller = Get.put(MoviesController());
  final SearchController1 searchController = Get.put(SearchController1());
  // Controlador de Actores
  final ActorsController actorsController = Get.put(ActorsController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 42,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Título principal que pregunta qué desea ver el usuario.
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'What do you want to watch?',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Caja para buscar actores o películas.
            SearchBox(
              onSumbit: () {
                String search =
                    Get.find<SearchController1>().searchController.text;
                Get.find<SearchController1>().searchController.text = '';
                Get.find<SearchController1>().search(search);
                Get.find<BottomNavigatorController>().setIndex(1);
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
            const SizedBox(height: 34),

            // Listado horizontal con los 10 actores principales.
            Obx(
              (() => actorsController.isLoading.value
                  ? const CircularProgressIndicator()
                  : SizedBox(
                height: 300,
                child: ListView.separated(
                  itemCount: actorsController.topTenActors.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (_, __) => const SizedBox(width: 24),
                  itemBuilder: (_, index) => TopRatedItem(
                      actor: actorsController.topTenActors[index], // Muestra detalles de cada actor.
                      index: index + 1),
                ),
              )),
            ),

            const SizedBox(height: 20),

            // Pestañas para mostrar actores en tendencia o populares.
            DefaultTabController(
              length: 2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TabBar(
                    indicatorWeight: 3,
                    indicatorColor: Color(0xFF3A3F47),
                    labelStyle: TextStyle(fontSize: 11.0),
                    tabs: [
                      Tab(text: 'Trending'), // Pestaña para actores en tendencia.
                      Tab(text: 'Popular'), // Pestaña para actores populares.
                    ],
                  ),

                  // Contenido de las pestañas: muestra actores en tendencia y populares usando TabBuilderActor.
                  SizedBox(
                    height: 400,
                    child: TabBarView(
                      children: [
                        TabBuilderActor(
                          future: ApiService.trendingActors(), // Obtiene datos de actores en tendencia.
                        ),
                        TabBuilderActor(
                          future: ApiService.popularActors(), // Obtiene datos de actores populares.
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
