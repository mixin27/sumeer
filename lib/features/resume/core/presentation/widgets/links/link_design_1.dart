import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class LinkDesign1 extends pw.StatelessWidget {
  LinkDesign1({
    required this.text,
    required this.url,
    this.color,
    this.decoration,
  });

  final String text;
  final String url;
  final PdfColor? color;
  final pw.TextDecoration? decoration;

  @override
  pw.Widget build(pw.Context context) {
    return pw.UrlLink(
      destination: url,
      child: pw.Text(
        text,
        style: pw.TextStyle(
          decoration: decoration ?? pw.TextDecoration.underline,
          color: color ?? PdfColors.blue,
        ),
      ),
    );
  }
}
