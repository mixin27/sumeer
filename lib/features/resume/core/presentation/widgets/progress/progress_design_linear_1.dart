import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:sumeer/features/resume/feat_resume.dart';

class ProgressDesignLinear1 extends pw.StatelessWidget {
  ProgressDesignLinear1({
    required this.size,
    required this.value,
    required this.title,
  });

  final double size;
  final double value;
  final pw.Widget title;

  static const fontSize = 1.2;

  PdfColor get color => green;

  static const backgroundColor = PdfColors.grey300;

  static const strokeWidth = 5.0;

  @override
  pw.Widget build(pw.Context context) {
    final widgets = <pw.Widget>[
      pw.LinearProgressIndicator(
        value: value,
        backgroundColor: backgroundColor,
        valueColor: color,
        // strokeWidth: strokeWidth,
      ),
      pw.SizedBox(
        height: 10,
      ),
    ];

    // widgets.add(title);

    return pw.Column(children: widgets);
  }
}
