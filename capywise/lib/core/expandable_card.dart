import 'package:flutter/material.dart';

/// A more compact ExpandableCard with left-justified, vertically-centered title.
class ExpandableCard extends StatefulWidget {
  final String dayLabel;       // e.g. "TODAY", "10 JAN, TUE"
  final String timeLabel;      // e.g. "All day", "3PM - 6PM"
  final String eventTitle;     // e.g. "TIRADENTES", "GREAT ALTERNATIVE"
  final String? tag;           // e.g. "ASTR132", "Docs.pdf"
  final bool isChecked;        // checkbox state
  final Color backgroundColor; // pastel background
  final Widget? expandedDetails;
  final bool initiallyExpanded;
  final ValueChanged<bool>? onCheckChanged;

  const ExpandableCard({
    Key? key,
    required this.dayLabel,
    required this.timeLabel,
    required this.eventTitle,
    this.tag,
    this.isChecked = false,
    required this.backgroundColor,
    this.expandedDetails,
    this.initiallyExpanded = false,
    this.onCheckChanged,
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

  void _toggleCheck(bool? value) {
    if (value == null) return;
    setState(() => _localChecked = value);
    widget.onCheckChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Slightly smaller margin between cards
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
            // HEADER: Day label + arrow
            InkWell(
              onTap: _toggleExpanded,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start, // left-justify
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.dayLabel,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const Spacer(),
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

            // COLLAPSED ROW: Checkbox + time + eventTitle + tag
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start, // left
                children: [
                  // Checkbox
                  Checkbox(
                    value: _localChecked,
                    onChanged: _toggleCheck,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    visualDensity: VisualDensity.compact,
                  ),
                  const SizedBox(width: 6),

                  // Time label
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.timeLabel,
                        style: const TextStyle(
                          fontSize: 13,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),

                  // Event title
                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.eventTitle,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),

                  // Optional tag
                  if (widget.tag != null) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 2,
                      ),
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

            // EXPANDED DETAILS (if any)
            if (_isExpanded && widget.expandedDetails != null) ...[
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                child: widget.expandedDetails!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
