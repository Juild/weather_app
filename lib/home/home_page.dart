import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/home/controllers/home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              toolbarHeight: 100,
              floating: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              pinned: true,
              title: SearchBar(
                onChanged: (text) => controller.addCityWeathers(text),
                elevation: const MaterialStatePropertyAll(8),
                constraints: const BoxConstraints(maxWidth: 300),
                hintText: 'Search for a city',
                textStyle: MaterialStatePropertyAll(Theme.of(context).textTheme.bodyMedium),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 12),
            ),
            Obx(() => SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 1,
                                offset: const Offset(0, 3), // changes the position of the shadow
                              ),
                            ],
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12),
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(controller.cityWeathers[index].name),
                                  Text(
                                    controller.cityWeathers[index].country.toString(),
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.thermostat),
                                    Text('${controller.cityWeathers[index].temperature} Cº'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.air),
                                    Text('${controller.cityWeathers[index].windspeed} km/h'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: controller.cityWeathers.length,
                  ),
                )),
          ],
        ),
      )),
    );
  }
}
