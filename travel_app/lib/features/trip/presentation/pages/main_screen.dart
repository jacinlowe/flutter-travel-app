import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/features/trip/presentation/pages/map_view_screen.dart';
import 'package:travel_app/features/trip/presentation/widgets/custom_image_loader.dart';
import 'package:travel_app/features/trip/presentation/widgets/custom_searchbar.dart';
import 'add_trip_screen.dart';
import '../providers/trip_provider.dart';

import 'my_trip_screen.dart';

class MainScreen extends ConsumerWidget {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentPage = ValueNotifier(0);
  final ValueNotifier<bool> _searchbarVisablity = ValueNotifier(true);
  String profilePic =
      'https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=3776&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(tripListNotifierProvider.notifier).loadTrips();
    _pageController.addListener(() {
      _currentPage.value = _pageController.page!.round();
      print(_currentPage.value);
    });

    _currentPage
        .addListener(() => _searchbarVisablity.value = _currentPage.value == 0);

    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        backgroundColor: Colors.amber[50],
        toolbarHeight: 100,
        shadowColor: Colors.black45,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        centerTitle: false,
        title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi there 👋',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(
                'Traveling Today?',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ]),
        actions: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: MyImageLoader(
                  height: 60,
                  width: 60,
                  imageSrc: profilePic,
                )),
          )
        ],
      ),
      body: PageView(controller: _pageController, children: [
        const MyTripScreen(),
        AddTripScreen(),
        const MapViewScreen(),
      ]),
      bottomNavigationBar: ValueListenableBuilder(
          valueListenable: _currentPage,
          builder: (context, pageIndex, child) {
            return BottomNavigationBar(
              currentIndex: pageIndex,
              elevation: 50,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.list), label: 'My Trips'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.add), label: 'Add Trip'),
                BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Maps'),
              ],
              onTap: (index) {
                _pageController.jumpToPage(index);
              },
            );
          }),
    );
  }
}
