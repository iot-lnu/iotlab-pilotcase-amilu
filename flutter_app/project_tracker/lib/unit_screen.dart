import 'package:flutter/material.dart';

class UnitScreen extends StatelessWidget {
  const UnitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
        ),
        body: const Center(
          child: Text('Unit Screen'),
        ),
      ),
    );
  }
}
