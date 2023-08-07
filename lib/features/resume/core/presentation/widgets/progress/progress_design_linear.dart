import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ProgressDesignLinear extends pw.StatelessWidget {
  ProgressDesignLinear({
    this.value = 0.0,
  });

  final double value;

  @override
  pw.Widget build(pw.Context context) {
    return pw.LinearProgressIndicator(
      value: value,
      minHeight: 3,
      valueColor: PdfColor.fromHex('54448D'),
    );
  }
}
