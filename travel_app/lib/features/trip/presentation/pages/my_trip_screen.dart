import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/trip_provider.dart';
import '../widgets/custom_searchbar.dart';
import '../widgets/travel_card.dart';

class MyTripScreen extends ConsumerWidget {
  const MyTripScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripList = ref.watch(tripListNotifierProvider);
    print('tripList: $tripList');

    return Column(
      children: [
        CustomSearchBar(),
        Expanded(
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(children: [
              Container(
                color: Colors.amber[10],
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: tripList.length,
                    itemBuilder: (context, index) {
                      final trip = tripList[index];
                      return TravelCard(
                          imageUrl: trip.photos[0],
                          title: trip.title,
                          description: trip.description,
                          date:
                              DateFormat.yMMMEd().format(trip.date).toString(),
                          location: trip.location,
                          onDelete: () {
                            ref
                                .read(tripListNotifierProvider.notifier)
                                .removeTrip(index);
                            ref
                                .read(tripListNotifierProvider.notifier)
                                .loadTrips();
                          });
                    }),
              )
            ]),
          ),
        ),
      ],
    );
  }
}
