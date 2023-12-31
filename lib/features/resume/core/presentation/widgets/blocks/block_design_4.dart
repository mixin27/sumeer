import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;

class BlockDesign4 extends pw.StatelessWidget {
  BlockDesign4({
    required this.title,
    this.city,
    this.country,
    this.startDate,
    this.endDate,
    this.isPresent = false,
    this.isSplit = false,
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
  final bool isSplit;
  final String? description;
  final pw.IconData? icon;
  final String? school;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 10),
        if (startDate != null && endDate != null && !isPresent) ...[
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Text(
                DateFormat('MM/yyyy').format(startDate!).toUpperCase(),
                style: pw.Theme.of(context).defaultTextStyle.copyWith(
                      fontWeight: pw.FontWeight.bold,
                    ),
              ),
              pw.SizedBox(width: 5),
              pw.Text('to'),
              pw.SizedBox(width: 5),
              pw.Text(
                DateFormat('MM/yyyy').format(endDate!).toUpperCase(),
                style: pw.Theme.of(context)
                    .defaultTextStyle
                    .copyWith(fontWeight: pw.FontWeight.bold),
              ),
            ],
          ),
        ],
        if (startDate != null && isPresent) ...[
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Text(
                DateFormat('MM/yyyy').format(startDate!).toUpperCase(),
                style: pw.Theme.of(context)
                    .defaultTextStyle
                    .copyWith(fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(width: 5),
              pw.Text('to'),
              pw.SizedBox(width: 5),
              pw.Text(
                'Present',
                style: pw.Theme.of(context)
                    .defaultTextStyle
                    .copyWith(fontWeight: pw.FontWeight.bold),
              ),
            ],
          ),
        ],
        isSplit
            ? pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                    pw.Text(
                      title,
                      style: pw.Theme.of(context)
                          .defaultTextStyle
                          .copyWith(fontWeight: pw.FontWeight.bold),
                    ),
                    pw.Text(
                      '$employeer, $city',
                      style: pw.Theme.of(context)
                          .defaultTextStyle
                          .copyWith(fontWeight: pw.FontWeight.bold),
                    ),
                  ])
            : pw.Text(
                '$title - $employeer, $city',
                style: pw.Theme.of(context)
                    .defaultTextStyle
                    .copyWith(fontWeight: pw.FontWeight.bold),
              ),
        pw.Text(
          description ?? '',
        ),
      ],
    );
  }
}
