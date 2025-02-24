import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart' as latlong;

class UnitList extends StatefulWidget {
  final Function(Marker) addMarker;
  final Function emptyMarkers;

  const UnitList({required this.addMarker, required this.emptyMarkers, super.key});

  @override
  State<UnitList> createState() => _UnitListState();
}

class _UnitListState extends State<UnitList> {
  List<Map<String, dynamic>> gpsUnits = [];

  void listenToGpsUnits() {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) return;
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection('gpsUnits')
        .snapshots()
        .listen((snapshot) {

      if (mounted) widget.emptyMarkers();
      List<Map<String, dynamic>> newGpsUnits = snapshot.docs.map((doc) {
        final data = {"id": doc.id, ...doc.data()};
        Marker marker = Marker(
          width: 80.0,
          height: 80.0,
          point: latlong.LatLng(
              double.parse(data['latitude']), double.parse(data['longitude'])),
          child:
              const Icon(FontAwesomeIcons.gem, size: 40, color: Colors.black),
        );
        print(data['longitude']);
        widget.addMarker(marker);
        return data;
      }).toList();
      setState(() {
        gpsUnits = newGpsUnits;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    listenToGpsUnits();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(45), // radius here
      ),
      child: Column(
        children: [
          Text("Valuables", style: Theme.of(context).textTheme.titleMedium),
          Divider(
            thickness: 0.4,
          ),
          Column(children: [
            ListView.builder(
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount: gpsUnits.length,
                itemBuilder: (context, index) {
                  final Map<String, dynamic> data = gpsUnits[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/unit');
                    },
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 15),
                      child: Column(children: [
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.gem,
                              size: 25,
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: SizedBox(
                                height: 80,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 5),
                                      Text(
                                        data['name'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      Text(
                                        "${data['latitude']}, ${data['longitude']}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                      Divider(
                                        thickness: 0.4,
                                      ),
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ),
                  );
                })
          ])
        ],
      ),
    );
  }
}
