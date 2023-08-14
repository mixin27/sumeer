import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

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

  doc.addPage(
    pw.MultiPage(
      pageTheme: pageTheme,
      build: (pw.Context context) {
        return [
          pw.Partitions(
            children: [
              pw.Partition(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.only(left: 30, bottom: 20),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          if (resumeData.personalDetail?.fullName != null)
                            pw.Text(
                              resumeData.personalDetail?.fullName ?? '',
                              textScaleFactor: 2,
                              style: pw.Theme.of(context)
                                  .defaultTextStyle
                                  .copyWith(fontWeight: pw.FontWeight.bold),
                            ),
                          if (profileImage != null)
                            pw.Container(
                              width: 130,
                              height: 130,
                              child: pw.ClipOval(
                                // child:
                                // pw.Image(resumeData.profileImage!,
                                //     width: 130, height: 130, fit: pw.BoxFit.cover),
                                // profileImage
                                child: pw.Image(profileImage,
                                    fit: pw.BoxFit.cover),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // pw.Partition(
              //   width: sep,
              //   child: pw.Column(
              //     children: [
              //       pw.Container(
              //         height: pageTheme.pageFormat.availableHeight,
              //         child: pw.Column(
              //           crossAxisAlignment: pw.CrossAxisAlignment.center,
              //           mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              //           children: [
              //             if (profileImage != null)
              //               pw.ClipOval(
              //                 child: pw.Container(
              //                     width: 100,
              //                     height: 100,
              //                     color: lightGreen,
              //                     // child: pw.Image(resumeData.profileImage!),
              //                     // profileImage
              //                     child: pw.Image(profileImage)),
              //               ),
              //             if (resumeData.skill != null)
              //               pw.Column(
              //                 children: List.generate(
              //                   resumeData.skill!.skills.length,
              //                   (index) {
              //                     final skill = resumeData.skill!.skills[index];

              //                     return ProgressDesignCircular1(
              //                       size: 60,
              //                       value: skill.percentage ?? 0.0,
              //                       title: pw.Text(skill.skill),
              //                     );
              //                   },
              //                 ),
              //               ),
              //             if (resumeData.personalDetail != null &&
              //                 resumeData.personalDetail!.links.isNotEmpty)
              //               pw.BarcodeWidget(
              //                 data: resumeData.personalDetail!.links[0].url,
              //                 width: 60,
              //                 height: 60,
              //                 barcode: pw.Barcode.qrCode(),
              //                 drawText: false,
              //               ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ];
      },
    ),
  );

  return doc.save();
}

Future<pw.PageTheme> _pageTheme(PdfPageFormat format) async {
  final bgShape = await rootBundle.loadString(AssetPaths.resumeSvg);

  format = format.applyMargin(
    left: 2.0 * PdfPageFormat.cm,
    top: 4.0 * PdfPageFormat.cm,
    right: 2.0 * PdfPageFormat.cm,
    bottom: 2.0 * PdfPageFormat.cm,
  );

  return pw.PageTheme(
    pageFormat: format,
    theme: pw.ThemeData.withFont(
      base: await PdfGoogleFonts.openSansRegular(),
      bold: await PdfGoogleFonts.openSansBold(),
      icons: await PdfGoogleFonts.materialIcons(),
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