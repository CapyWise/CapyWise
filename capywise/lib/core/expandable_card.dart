import 'package:flutter/material.dart';

/// A compact ExpandableCard that displays:
/// - A formatted date/time label (e.g. "Tue, Jan 10 • 3:00 PM")
/// - An event title (e.g. "TIRADENTES")
/// - An optional tag
/// - A checkbox
/// - Edit / Delete icons on the right side when expanded
class ExpandableCard extends StatefulWidget {
  /// Example: "Tue, Jan 10 • 3:00 PM – 6:00 PM"
  final String dateTimeLabel;

  /// The event title.
  final String title;

  /// Optional tag (e.g. "ASTR132").
  final String? tag;

  /// If the event is checked (like “completed”).
  final bool isChecked;

  /// Pastel background color.
  final Color backgroundColor;

  /// Whether to start expanded.
  final bool initiallyExpanded;

  /// Callback when user taps edit (pencil).
  final VoidCallback? onEditPressed;

  /// Callback when user taps delete (trash).
  final VoidCallback? onDeletePressed;

  const ExpandableCard({
    Key? key,
    required this.dateTimeLabel,
    required this.title,
    this.tag,
    this.isChecked = false,
    required this.backgroundColor,
    this.initiallyExpanded = false,
    this.onEditPressed,
    this.onDeletePressed,
  }) : super(key: key);

  @override
  State<ExpandableCard> createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard>
    with SingleTickerProviderStateMixin {
  late bool _isExpanded;
  late bool _localChecked;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
    _localChecked = widget.isChecked;
  }

  void _toggleExpanded() {
    setState(() => _isExpanded = !_isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- Header row: date/time + arrow ----------
            InkWell(
              onTap: _toggleExpanded,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                child: Row(
                  children: [
                    // Show the date/time label
                    Expanded(
                      child: Text(
                        widget.dateTimeLabel,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Icon(
                      _isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      size: 22,
                    ),
                  ],
                ),
              ),
            ),

            // ---------- Collapsed row: checkbox + title + optional tag ----------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Row(
                children: [
                  Checkbox(
                    value: _localChecked,
                    onChanged: (bool? val) {
                      if (val == null) return;
                      setState(() => _localChecked = val);
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    visualDensity: VisualDensity.compact,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  if (widget.tag != null) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        widget.tag!,
                        style: const TextStyle(
                          fontSize: 11,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // ---------- Expanded row: icons on the right ----------
            if (_isExpanded)
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                child: Row(
                  children: [
                    const Text(
                      "More details here",
                      style: TextStyle(fontSize: 13),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.edit, size: 18),
                      onPressed: widget.onEditPressed,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, size: 18),
                      onPressed: widget.onDeletePressed,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
