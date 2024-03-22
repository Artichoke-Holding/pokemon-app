import 'package:flutter/material.dart';
import '../utils/string_utils.dart'; // Assuming this exists for the capitalize function

class PokemonDetailSection extends StatelessWidget {
  final String title;
  final List<String> items;
  final Widget Function(String)? itemBuilder;

  const PokemonDetailSection({
    Key? key,
    required this.title,
    required this.items,
    this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$title:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: itemBuilder != null
                ? items.map((item) => itemBuilder!(item)).toList()
                : items.map((item) => Container(
              margin: EdgeInsets.only(top: 8.0),
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                capitalize(item),
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}
