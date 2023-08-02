import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:sumeer/features/resume/feat_resume.dart';

class BlockDesign2 extends pw.StatelessWidget {
  BlockDesign2({
    required this.title,
    this.city,
    this.country,
    this.startDate,
    this.endDate,
    this.isPresent = false,
    this.description,
    this.icon,
    this.school,
    this.employeer,
  });

  final String title;
  final String? employeer;
  final String? city;
  final String? country;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isPresent;
  final String? description;
  final pw.IconData? icon;
  final String? school;

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
              decoration: const pw.BoxDecoration(
                color: green,
                shape: pw.BoxShape.circle,
              ),
            ),
            pw.Flexible(
              child: pw.Text(
                "$title - $employeer, $city",
                style: pw.Theme.of(context)
                    .defaultTextStyle
                    .copyWith(fontWeight: pw.FontWeight.bold),
              ),
            ),
            // pw.Spacer(),
            // if (icon != null) pw.Icon(icon!, color: lightGreen, size: 18),
          ],
        ),
        pw.Container(
          decoration: const pw.BoxDecoration(
            border: pw.Border(
              left: pw.BorderSide(color: blueGrey, width: 2),
            ),
          ),
          padding: const pw.EdgeInsets.only(left: 10, top: 5, bottom: 5),
          margin: const pw.EdgeInsets.only(left: 5),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              if (startDate != null && endDate != null && !isPresent) ...[
                pw.Row(
                  children: [
                    pw.Text(
                      DateFormat("E yyyy").format(startDate!).toUpperCase(),
                      style: pw.Theme.of(context).defaultTextStyle.copyWith(
                            fontWeight: pw.FontWeight.normal,
                            fontStyle: pw.FontStyle.italic,
                            color: PdfColors.blueGrey,
                          ),
                    ),
                    pw.SizedBox(width: 5),
                    pw.Text('-'),
                    pw.SizedBox(width: 5),
                    pw.Text(
                      DateFormat("E yyyy").format(endDate!).toUpperCase(),
                      style: pw.Theme.of(context).defaultTextStyle.copyWith(
                            fontWeight: pw.FontWeight.normal,
                            fontStyle: pw.FontStyle.italic,
                          ),
                    ),
                  ],
                ),
              ],
              if (startDate != null && isPresent) ...[
                pw.Row(
                  children: [
                    pw.Text(
                      DateFormat("E yyyy").format(startDate!).toUpperCase(),
                      style: pw.Theme.of(context).defaultTextStyle.copyWith(
                            fontWeight: pw.FontWeight.normal,
                            fontStyle: pw.FontStyle.italic,
                            color: PdfColors.blueGrey,
                          ),
                    ),
                    pw.SizedBox(width: 5),
                    pw.Text('-'),
                    pw.SizedBox(width: 5),
                    pw.Text(
                      'Present',
                      style: pw.Theme.of(context).defaultTextStyle.copyWith(
                            fontWeight: pw.FontWeight.normal,
                            fontStyle: pw.FontStyle.italic,
                            color: PdfColors.green600,
                          ),
                    ),
                  ],
                ),
              ],
              if (description != null)
                pw.Text(
                  description!,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
