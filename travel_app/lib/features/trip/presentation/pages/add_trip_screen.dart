import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/features/trip/presentation/providers/trip_provider.dart';

import '../../domain/entities/trip.dart';

class AddTripScreen extends ConsumerWidget {
  AddTripScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController(text: 'Family Trip 2034');
  final _descriptionController =
      TextEditingController(text: 'We are going on a trip baby');
  final _locationController = TextEditingController(text: 'Paris');
  final _pictureController = TextEditingController(
      text:
          'https://images.unsplash.com/photo-1703028408833-ff4033ce37ab?q=80&w=3774&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D');

  List<String> pictures = [];

  void showAlertDialog(BuildContext context, description) {
    showDialog(
        context: context,
        builder: (BuildContext alertContext) {
          return AlertDialog(
              title: const Text('Success! Trip added!'),
              backgroundColor: Theme.of(context).cardColor,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(description),
                  MyProgressIndicator(),
                ],
              ));
        });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            TextFormField(
              controller: _pictureController,
              decoration: InputDecoration(labelText: 'Photo'),
            ),
            ElevatedButton(
                onPressed: () {
                  pictures.add(_pictureController.text);
                  if (_formKey.currentState!.validate()) {
                    final newTrip = Trip(
                      title: _titleController.text,
                      description: _descriptionController.text,
                      date: DateTime.now(),
                      location: _locationController.text,
                      photos: pictures,
                    );
                    ref
                        .read(tripListNotifierProvider.notifier)
                        .addNewTrip(newTrip);
                    ref.read(tripListNotifierProvider.notifier).loadTrips();
                    _formKey.currentState!.reset();
                    showAlertDialog(context, 'You Added a new trip! 🎉');
                  }
                },
                child: Text('Add trip'))
          ],
        ),
      ),
    );
  }
}

class MyProgressIndicator extends StatefulWidget {
  const MyProgressIndicator({super.key});

  @override
  State<MyProgressIndicator> createState() => _MyProgressIndicatorState();
}

class _MyProgressIndicatorState extends State<MyProgressIndicator>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {});
      });
    controller.addListener(() {
      if (controller.value == 0.0) print(controller.value);
    });
    controller.reverse(from: 100);
    // controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          LinearProgressIndicator(
            value: controller.value,
            semanticsLabel: 'Linear Progress indicator',
          )
        ],
      ),
    );
  }
}

// final progressIndicatorSuccessProvider = Provider<bool>((ref,) {
//   final state = ref.watch(provider)
//   return ref.state;
// });
