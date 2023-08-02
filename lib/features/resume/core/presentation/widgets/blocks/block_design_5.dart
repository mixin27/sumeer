import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class BlockDesign5 extends pw.StatelessWidget {
  BlockDesign5({
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
    this.textColor,
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
  final PdfColor? textColor;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          "$title - ${DateFormat("MM/yyyy").format(endDate ?? startDate!)}",
          style: pw.Theme.of(context)
              .defaultTextStyle
              .copyWith(fontWeight: pw.FontWeight.bold),
        ),
        pw.Text(
          "$school,$city",
          style: pw.Theme.of(context)
              .defaultTextStyle
              .copyWith(fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 20)
      ],
    );
  }
}
