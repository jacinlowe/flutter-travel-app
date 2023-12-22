import 'package:flutter/material.dart';
import 'package:travel_app/features/trip/presentation/widgets/custom_image_loader.dart';

class TravelCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String date;
  final String location;
  final VoidCallback onDelete;

  const TravelCard(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.description,
      required this.date,
      required this.location,
      required this.onDelete});

  void showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext alertContext) {
          return AlertDialog(
              title: const Text('Description'),
              backgroundColor: Theme.of(context).cardColor,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [Text(description)],
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      padding: const EdgeInsets.all(12),
      child: Card(
        elevation: 15,
        surfaceTintColor: Colors.blue[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(children: [
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                showAlertDialog(context);
              },
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  child: MyImageLoader(
                    imageSrc: imageUrl,
                    height: double.infinity,
                    width: double.infinity,
                    loaderType: LoaderType.linear,
                  )),
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          location,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          date,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: IconButton(
                              onPressed: onDelete,
                              splashRadius: 1,
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red[700],
                              )),
                        )
                      ],
                    )
                  ],
                ),
              ))
        ]),
      ),
    );
  }
}
