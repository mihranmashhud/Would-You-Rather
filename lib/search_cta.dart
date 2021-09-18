import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({required this.onPressed});

  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.large(
        onPressed: () {
        },
        child: const Icon(Icons.search),
    );
  }
}
