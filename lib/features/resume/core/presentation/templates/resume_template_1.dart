import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:sumeer/features/resume/feat_resume.dart';
import 'package:sumeer/shared/shared.dart';

Future<Uint8List> generateTemplate1(
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
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.only(bottom: 20),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          if (resumeData.personalDetail?.fullName != null)
                            pw.Text(
                              resumeData.personalDetail?.fullName ?? '',
                              textScaleFactor: 2,
                              style: pw.Theme.of(context)
                                  .defaultTextStyle
                                  .copyWith(fontWeight: pw.FontWeight.bold),
                            ),
                          if (resumeData.personalDetail?.jobTitle != null) ...[
                            pw.Padding(
                              padding: const pw.EdgeInsets.only(top: 10),
                            ),
                            pw.Text(
                              resumeData.personalDetail?.jobTitle ?? '',
                              textScaleFactor: 1.5,
                              style: pw.Theme.of(context)
                                  .defaultTextStyle
                                  .copyWith(
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                            ),
                          ],
                          if (resumeData.personalDetail?.address != null) ...[
                            pw.Padding(
                                padding: const pw.EdgeInsets.only(top: 20)),
                            pw.Row(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(resumeData.personalDetail!.address),
                                  ],
                                ),
                                pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                      resumeData.personalDetail?.phone ?? '',
                                    ),
                                    LinkDesign1(
                                      text: resumeData.personalDetail?.email ??
                                          '',
                                      url: resumeData.personalDetail?.email ??
                                          '',
                                    ),
                                  ],
                                ),
                                pw.Padding(padding: pw.EdgeInsets.zero),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (resumeData.profile != null &&
                        resumeData.profile?.contents != null &&
                        resumeData.profile!.contents.isNotEmpty) ...[
                      SectionDesign1(title: "PROFILE"),
                      pw.SizedBox(height: 10),
                      pw.Container(
                        height: 85,
                        child: pw.Text(
                          resumeData.profile!.contents[0],
                        ),
                      ),
                      pw.SizedBox(height: 20),
                    ],
                    if (resumeData.experience != null) ...[
                      SectionDesign1(title: "PROFESSIONAL EXPERIENCE"),
                      pw.Column(
                        children: List.generate(
                          resumeData.experience!.experiences.length,
                          (index) {
                            final experience =
                                resumeData.experience!.experiences[index];

                            return BlockDesign1(
                                title: experience.jobTitle,
                                city: experience.city,
                                country: experience.country,
                                startDate: experience.startDate,
                                endDate: experience.endDate,
                                isPresent: experience.isPresent,
                                description: experience.description,
                                school: experience.employer?.name);
                          },
                        ),
                      ),
                    ],
                    if (resumeData.education != null) ...[
                      pw.SizedBox(height: 20),
                      SectionDesign1(title: "EDUCATION"),
                      pw.Column(
                        children: List.generate(
                          resumeData.education!.educations.length,
                          (index) {
                            final education =
                                resumeData.education!.educations[index];

                            return BlockDesign1(
                              title: education.degree ?? '',
                              city: education.city,
                              country: education.country,
                              startDate: education.startDate,
                              endDate: education.endDate,
                              isPresent: education.isPresent,
                              description: education.description,
                              school: education.school,
                            );
                          },
                        ),
                      ),
                    ],
                    if (resumeData.languages != null) ...[
                      pw.SizedBox(height: 20),
                      SectionDesign1(title: "LANGUAGES"),
                      pw.Column(
                        children: List.generate(
                          resumeData.education!.educations.length,
                          (index) {
                            final language =
                                resumeData.languages!.languages[index];

                            return pw.Row(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Container(
                                  width: 6,
                                  height: 6,
                                  margin: const pw.EdgeInsets.only(
                                      top: 5.5, left: 2, right: 5),
                                  decoration: const pw.BoxDecoration(
                                    color: green,
                                    shape: pw.BoxShape.circle,
                                  ),
                                ),
                                pw.Expanded(
                                  child: pw.Text(
                                    language.title ?? "",
                                    style: pw.Theme.of(context)
                                        .defaultTextStyle
                                        .copyWith(
                                          fontWeight: pw.FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              pw.Partition(
                width: sep,
                child: pw.Column(
                  children: [
                    pw.Container(
                      height: pageTheme.pageFormat.availableHeight / 1.08,
                      child: pw.Stack(
                        children: [
                          if (profileImage != null)
                            pw.Container(
                              width: 100,
                              height: 100,
                              child: pw.ClipOval(
                                // child:
                                // pw.Image(resumeData.profileImage!,
                                //     width: 130, height: 130, fit: pw.BoxFit.cover),
                                // profileImage
                                child: pw.Image(profileImage,
                                    fit: pw.BoxFit.cover),
                              ),
                            ),
                          if (resumeData.skill != null)
                            pw.Positioned(
                              top: 110,
                              bottom: 80,
                              left: 0,
                              child: pw.Column(
                                children: List.generate(
                                  resumeData.skill!.skills.length,
                                  (index) {
                                    final skill =
                                        resumeData.skill!.skills[index];

                                    return pw.Center(
                                        child: ProgressDesignCircular1(
                                      size: 60,
                                      value: skill.percentage ?? 0.0,
                                      title: pw.Text(skill.name),
                                    ));
                                  },
                                ),
                              ),
                            ),
                          if (resumeData.personalDetail != null &&
                              resumeData.personalDetail!.links.isNotEmpty)
                            pw.Positioned(
                              bottom: 0,
                              right: 0,
                              child: pw.BarcodeWidget(
                                data: resumeData.personalDetail!.links[0].url,
                                width: 60,
                                height: 60,
                                barcode: pw.Barcode.qrCode(),
                                drawText: false,
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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

  return pw.PageTheme(
    theme: pw.ThemeData.withFont(
      base: await PdfGoogleFonts.openSansRegular(),
      bold: await PdfGoogleFonts.openSansBold(),
      icons: await PdfGoogleFonts.materialIcons(),
    ),
    buildBackground: (pw.Context context) {
      return pw.FullPage(
        ignoreMargins: true,
        child: pw.Stack(
          children: [
            pw.Positioned(
              child: pw.SvgImage(svg: bgShape),
              left: 0,
              top: 0,
            ),
            pw.Positioned(
              child: pw.Transform.rotate(
                angle: pi,
                child: pw.SvgImage(svg: bgShape),
              ),
              right: 0,
              bottom: 0,
            ),
          ],
        ),
      );
    },
  );
}
