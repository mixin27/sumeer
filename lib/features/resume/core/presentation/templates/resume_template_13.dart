import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:rabbit_converter/rabbit_converter.dart';

import 'package:sumeer/features/resume/feat_resume.dart';

Future<Uint8List> generateTemplate13(
  PdfPageFormat format,
  GenerateDocParams params,
  ResumeData resumeData,
) async {
  // get network image
  final profileImage = resumeData.profileImage != null
      ? await networkImage(resumeData.profileImage!)
      : null;

  final doc = pw.Document(
    title: params.title,
    author: params.author,
    creator: params.creator,
    subject: params.subject,
    keywords: params.keywords,
    producer: params.producer,
  );

  final pageTheme = await _pageTheme(format);
  var regular = await PdfGoogleFonts.robotoSlabRegular();
  // final mmFont2 = await PdfGoogleFonts.notoSansMyanmarMedium();
  // final mmFontBold = await PdfGoogleFonts.notoSansMyanmarBold();
  final font = await rootBundle.load("assets/fonts/Zawgyi-One_V3.1.ttf");
  final fall2 = pw.Font.ttf(font);

  doc.addPage(
    pw.MultiPage(
      pageTheme: pageTheme,
      build: (pw.Context context) {
        return [
          pw.Partition(
            flex: 3,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Container(
                  padding:
                      const pw.EdgeInsets.only(left: 30, top: 10, bottom: 20),
                  child: pw.Row(
                    // crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      // if (resumeData.personalDetail?.fullName != null)
                      pw.Text(
                        // resumeData.personalDetail?.fullName ?? '',
                        Rabbit.uni2zg("ကိုယ် ရေး ရာဇ၀င်အကျဉ်း"),
                        // " ကိုယ် ရေး ရာဇ၀င်အကျဉ်း",
                        textScaleFactor: 2,

                        style:
                            pw.TextStyle(font: regular, fontFallback: [fall2]),
                      ),
                      pw.SizedBox(width: 150),
                      if (profileImage != null)
                        pw.Container(
                          margin: const pw.EdgeInsets.only(right: 10),
                          width: 130,
                          height: 130,
                          decoration: pw.BoxDecoration(
                            color: PdfColors.amber,
                            borderRadius: pw.BorderRadius.circular(8),
                          ),
                          child: pw.Image(profileImage, fit: pw.BoxFit.cover),
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
          pw.Partition(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                prefixTitle(regular, '၁။ အမည်',
                    data: resumeData.personalDetail?.fullName ?? '',
                    font: fall2),
                prefixTitle(regular, '၂။ အလုပ်အကိုင် ရာထူး',
                    data: resumeData.personalDetail?.jobTitle ?? '',
                    font: fall2),
                prefixTitle(regular, '၃။ အဘအမည်', data: '', font: fall2),
                prefixTitle(regular, '၄။ နိုင်ငံသားစိစစ်ရေးကတ်ြပားအမှတ်',
                    data: 'NRC', font: fall2),
                prefixTitle(regular, '၅။ အသက် / မွေးသက္ကရာဇ်',
                    data:
                        resumeData.personalDetail?.personalInfo?.dateOfBirth ??
                            '',
                    font: fall2),
                prefixTitle(regular, '၆။ လူမျိုး / ဘာသာ',
                    data: 'ဗုဓ္ဒ', font: fall2),
                prefixTitle(regular, '၇။ ပညာ အရည်အချင်း',
                    data: resumeData.education?.educations.first.degree ?? '',
                    font: fall2),
                prefixTitle(regular, '၈။ လုပ်ငန်းအတွေ. အကြုံ',
                    data: resumeData.experience?.experiences.first.jobTitle,
                    font: fall2),
                prefixTitle(regular, '၉။ အခြားတက်ရောက်ခဲ့သည်.သင်တန်းများ',
                    data: '', font: fall2),
                prefixTitle(regular, '၁၀။ ။ အခြားတတ်ကျွမ်းသညဲ့်ဘာသာစကား',
                    data: resumeData.languages?.languages.first.title ?? '',
                    font: fall2),
                prefixTitle(regular, '၁၁။ အိမ်ထောင်ရှိ/မရှိ',
                    data: resumeData
                            .personalDetail?.personalInfo?.martialStatus ??
                        '',
                    font: fall2),
                prefixTitle(regular, '၁၂။ ဆက်သွယ်ရန်နေရပ်လိပ်စာ',
                    data: resumeData.personalDetail?.address, font: fall2),
                prefixTitle(regular, '၁၃။ ဖုန်းနံပတ်',
                    data: resumeData.personalDetail?.phone, font: fall2),
                prefixTitle(regular, '၁၄။ အီးမေ(လ်) လိပ်စာ',
                    data: resumeData.personalDetail?.email, font: fall2),
              ],
            ),
          )
        ];
      },
    ),
  );

  return doc.save();
}

pw.Widget prefixTitle(pw.Font mmFontBold, String prefixText,
    {required String? data, required pw.Font font}) {
  return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        children: [
          pw.Expanded(
            flex: 4,
            child: pw.Text(
              Rabbit.uni2zg(prefixText),
              textScaleFactor: 1.2,
              style: pw.TextStyle(font: mmFontBold, fontFallback: [font]),
            ),
          ),
          pw.SizedBox(width: 10),
          // flex: 4,
          pw.Text(
            'း',
            textScaleFactor: 1.2,
          ),

          pw.Expanded(
            flex: 4,
            child: pw.Text(
              textAlign: pw.TextAlign.center,
              Rabbit.uni2zg(data ?? ''),
              style: pw.TextStyle(font: mmFontBold, fontFallback: [font]),
            ),
          ),
        ],
      ));
}

Future<pw.PageTheme> _pageTheme(PdfPageFormat format) async {
  // final bgShape = await rootBundle.loadString(AssetPaths.resumeSvg);
  // final mmFont = await PdfGoogleFonts.notoSansMyanmarRegular();
  final mmFont2 = await PdfGoogleFonts.notoSansMyanmarMedium();

  format = format.applyMargin(
    left: 2.0 * PdfPageFormat.cm,
    top: 0 * PdfPageFormat.cm,
    right: 2.0 * PdfPageFormat.cm,
    bottom: 2.0 * PdfPageFormat.cm,
  );

  return pw.PageTheme(
    margin: const pw.EdgeInsets.only(top: 0, left: 16, right: 4),
    // pageFormat: format,
    theme: pw.ThemeData.withFont(
      base: await PdfGoogleFonts.notoSansMyanmarRegular(),
      bold: await PdfGoogleFonts.notoSansMyanmarBold(),
      icons: await PdfGoogleFonts.materialIcons(),
      fontFallback: [mmFont2],
    ),
    buildBackground: (pw.Context context) {
      return pw.FullPage(
        ignoreMargins: true,
        // child: pw.Stack(
        //   children: [
        //     pw.Positioned(
        //       child: pw.SvgImage(svg: bgShape),
        //       left: 0,
        //       top: 0,
        //     ),
        //     pw.Positioned(
        //       child: pw.Transform.rotate(
        //         angle: pi,
        //         child: pw.SvgImage(svg: bgShape),
        //       ),
        //       right: 0,
        //       bottom: 0,
        //     ),
        //   ],
        // ),
        child: pw.Container(color: PdfColors.white),
      );
    },
  );
}
