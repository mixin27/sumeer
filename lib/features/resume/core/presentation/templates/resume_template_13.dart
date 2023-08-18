import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:rabbit_converter/rabbit_converter.dart';

import 'package:sumeer/features/resume/feat_resume.dart';
import 'package:sumeer/shared/shared.dart';

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
  final mmFont2 = await PdfGoogleFonts.notoSansMyanmarMedium();
  final mmFontBold = await PdfGoogleFonts.notoSansMyanmarBold();

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
                        // Rabbit.zg2uni(''),
                        "ကိုယ် ‌ေရး ရာဇ၀င်အကျဉ်း",
                        textScaleFactor: 2,

                        style: pw.TextStyle(font: mmFont2),
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
                prefixTitle(mmFontBold, '၁။ အမည်', data: 'ဇူး ရတနာ'),
                prefixTitle(mmFontBold, '၂။ အလုပ်အကိုင် ရာထူး', data: 'စာရေး'),
                prefixTitle(mmFontBold, '၃။ အဘအမည်', data: 'ဉီး အေး သောင်း'),
                prefixTitle(mmFontBold, '၄။ နိုင်ငံသားစိစစ်ရေးကတ်ြပားအမှတ်',
                    data: '၁၄/၀ခမ(နိုင်)၂၃၂၂၃'),
                prefixTitle(mmFontBold, '၅။ အသက် / မွေးသက္ကရာဇ်',
                    data: '၀၆/၁၁/၂၀၀၃'),
                prefixTitle(mmFontBold, '၆။ လူမျိုး / ဘာသာ', data: 'ဗုဓ္ဒ'),
                prefixTitle(mmFontBold, '၇။ ပညာ အရည်အချင်း',
                    data: 'ဆယ်တန်း အောင်'),
                prefixTitle(mmFontBold, '၈။ လုပ်ငန်းအတွေ. အကြုံ',
                    data: '၃ နှစ်'),
                prefixTitle(mmFontBold, '၉။ အခြားတက်ရောက်ခဲ့သည်.သင်တန်းများ',
                    data: 'စက်ချူပ်'),
                prefixTitle(mmFontBold, '၁၀။ ။ အပခာူးကျွမ်ူးက င်သညဲ့်ဘာသာစကာူ',
                    data: 'အင်္ဂ လိပ်'),
                prefixTitle(mmFontBold, '၁၁။ အခြားကျွမ်းကျင်သည့် ဘာသာစကား',
                    data: ''),
                prefixTitle(mmFontBold, '၁၂။ အိမ်ထောင်ရှိ/မရှိ', data: 'မရှိ'),
                prefixTitle(mmFontBold, '၁၃။ ဆက်သွယ်ရန်နေရပ်လိပ်စာ',
                    data: 'ဆက်သွယ်ရန်နေရပ်လိပ်စာ'),
                prefixTitle(mmFontBold, '၁၄။ ဖုန်းနံပတ်', data: '၀၉၈၈၃၂၉၇၈၂၃'),
                prefixTitle(mmFontBold, '၁၅။ အီးမေ(လ်) လိပ်စာ',
                    data: 'email@gamil.com'),
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
    {required String? data}) {
  return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        children: [
          pw.Expanded(
            flex: 4,
            child: pw.Text(
              prefixText,
              textScaleFactor: 1.2,
              style: pw.TextStyle(font: mmFontBold),
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
            child: pw.Text(textAlign: pw.TextAlign.center, data ?? ''),
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
