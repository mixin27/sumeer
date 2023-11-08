import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:sumeer/features/resume/feat_resume.dart';

class BlockDesign6 extends pw.StatelessWidget {
  BlockDesign6({
    required this.title,
    this.city,
    this.country,
    this.startDate,
    this.endDate,
    this.isPresent = false,
    this.description,
    this.icon,
    this.school,
    this.iconColor,
  });

  final String title;
  final String? city;
  final String? country;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isPresent;
  final String? description;
  final pw.IconData? icon;
  final String? school;
  final PdfColor? iconColor;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Container(
              width: 6,
              height: 6,
              margin: const pw.EdgeInsets.only(top: 5.5, left: 2, right: 5),
              decoration: pw.BoxDecoration(
                color: iconColor ?? green,
                shape: pw.BoxShape.circle,
              ),
            ),
            pw.Text(
              title,
              style: pw.Theme.of(context)
                  .defaultTextStyle
                  .copyWith(fontWeight: pw.FontWeight.bold),
            ),
            pw.Text('-', style: pw.Theme.of(context).defaultTextStyle),
            pw.Flexible(
              child: pw.Text(
                school ?? '',
                style: pw.Theme.of(context).defaultTextStyle,
              ),
            ),
            // pw.Spacer(),
            // if (icon != null) pw.Icon(icon!, color: lightGreen, size: 18),
          ],
        ),
      ],
    );
  }
}
