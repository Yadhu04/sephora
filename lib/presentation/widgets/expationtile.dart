import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class SimpleExpansionTile extends StatelessWidget {
  final String title;
  final String content;

  const SimpleExpansionTile({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final border = Border(
      top: BorderSide(color: Colors.grey.shade200),
      bottom: BorderSide(color: Colors.grey.shade200),
    );

    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      shape: border,
      collapsedShape: border,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Html(
            data: content,
          ),
        ),
      ],
    );
  }
}
