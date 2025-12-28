import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ExpandableHtml extends StatefulWidget {
  final String html;
  final int maxLines;

  const ExpandableHtml({
    super.key,
    required this.html,
    this.maxLines = 4,
  });

  @override
  State<ExpandableHtml> createState() => _ExpandableHtmlState();
}

class _ExpandableHtmlState extends State<ExpandableHtml>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final textStyle = DefaultTextStyle.of(context).style;
    final fontSize = textStyle.fontSize ?? 14;
    final collapsedHeight = fontSize * 1.5 * widget.maxLines;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRect(
          child: AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: _expanded
                  ? const BoxConstraints() // unbounded, but NOT animated
                  : BoxConstraints(maxHeight: collapsedHeight),
              child: Html(
                data: widget.html.isNotEmpty
                    ? widget.html
                    : 'No information available.',
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () {
            setState(() => _expanded = !_expanded);
          },
          child: Text(
            _expanded ? 'Show less' : 'Show more',
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
