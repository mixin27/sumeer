import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:sumeer/features/resume/feat_resume.dart';
import 'package:sumeer/utils/utils.dart';

Future<Uint8List> generateTemplate7(
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

  final sourceCodeFontRegular = await PdfGoogleFonts.sourceCodeProRegular();

  doc.addPage(
    pw.MultiPage(
      pageTheme: pageTheme,
      build: (pw.Context context) {
        return [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Partitions(
                children: [
                  if (resumeData.personalDetail != null) ...[
                    pw.Partition(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          // image
                          if (profileImage != null)
                            pw.Container(
                              height: 100,
                              width: 100,
                              decoration: const pw.BoxDecoration(
                                color: PdfColors.blue300,
                              ),
                              child: pw.Image(
                                profileImage,
                                fit: pw.BoxFit.cover,
                              ),
                            ),
                          pw.SizedBox(height: 10),
                          pw.Text(
                            resumeData.personalDetail?.jobTitle ?? '',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          pw.Text(
                            resumeData.personalDetail?.email ?? '',
                            // style: pw.TextStyle(
                            //   fontWeight: pw.FontWeight.bold,
                            //   fontSize: 16,
                            // ),
                          ),
                          pw.Text(
                            "${resumeData.personalDetail?.address}",
                            // style: pw.TextStyle(
                            //   fontWeight: pw.FontWeight.bold,
                            //   fontSize: 16,
                            // ),
                          ),
                          pw.SizedBox(height: 20),
                          if (resumeData.personalDetail?.personalInfo
                                      ?.dateOfBirth !=
                                  null &&
                              resumeData.personalDetail!.personalInfo!
                                  .dateOfBirth!.isNotEmpty) ...[
                            pw.Text(
                              "Date of Birth",
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            pw.Text(
                              resumeData.personalDetail?.personalInfo
                                      ?.dateOfBirth ??
                                  '',
                              style: pw.TextStyle(
                                font: sourceCodeFontRegular,
                              ),
                            ),
                          ]
                        ],
                      ),
                    ),
                  ],
                  pw.Partition(
                    flex: 2,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          resumeData.personalDetail?.firstName ?? '',
                          style: pw.TextStyle(
                            fontSize: 40,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text(
                          resumeData.personalDetail?.lastName ?? '',
                          style: pw.TextStyle(
                            fontSize: 40,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 10),
                        if (resumeData.profile != null)
                          pw.Container(
                            padding: const pw.EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            decoration: pw.BoxDecoration(
                              color: PdfColor.fromHex('EEEEEE'),
                              borderRadius: const pw.BorderRadius.all(
                                pw.Radius.circular(20),
                              ),
                            ),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                              children: [
                                pw.Text(
                                  resumeData.profile?.title ?? "Profile",
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                pw.SizedBox(height: 10),
                                pw.Column(
                                  children: List.generate(
                                    resumeData.profile!.contents.length,
                                    (index) {
                                      final content =
                                          resumeData.profile!.contents[index];
                                      return pw.Text(
                                        content,
                                        // "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                        // style: pw.TextStyle(
                                        //   fontSize: 14,
                                        // ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 5),
                child: pw.Divider(color: PdfColors.grey200),
              ),
              pw.Partitions(
                children: [
                  pw.Partition(
                    flex: 3,
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.only(right: 10),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                        children: [
                          if (resumeData.experience != null) ...[
                            pw.Text(
                              resumeData.experience?.title ?? 'Experience',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            // pw.SizedBox(height: 5),
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: List.generate(
                                resumeData.experience!.experiences.length,
                                (index) {
                                  final exp =
                                      resumeData.experience!.experiences[index];
                                  return pw.Padding(
                                    padding: const pw.EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        ItemTitle(
                                          title:
                                              "${exp.jobTitle} at ${exp.employer?.name} ${exp.city != null ? ", ${exp.city}" : ''}${exp.country != null ? ", ${exp.country}" : ''}",
                                        ),
                                        pw.SizedBox(height: 5),
                                        if (exp.startDate != null &&
                                            exp.endDate != null &&
                                            !exp.isPresent) ...[
                                          pw.Text(
                                            '${DateFormat('MM/yyyy').format(exp.startDate!)}-${DateFormat('MM/yyyy').format(exp.endDate!)}',
                                            style: pw.TextStyle(
                                              font: sourceCodeFontRegular,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                        if (exp.startDate != null &&
                                            exp.isPresent) ...[
                                          pw.Text(
                                            '${DateFormat('MM/yyyy').format(exp.startDate!)}-present',
                                            style: pw.TextStyle(
                                              font: sourceCodeFontRegular,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                        pw.SizedBox(height: 5),
                                        pw.Text(
                                          exp.description ?? "",
                                          style: const pw.TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                          if (resumeData.education != null) ...[
                            pw.Text(
                              resumeData.education?.title ?? 'Education',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            // pw.SizedBox(height: 10),
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: List.generate(
                                resumeData.education!.educations.length,
                                (index) {
                                  final edu =
                                      resumeData.education!.educations[index];
                                  return pw.Padding(
                                    padding: const pw.EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        ItemTitle(
                                          title:
                                              "${edu.degree}, ${edu.school} ${edu.city != null ? ", ${edu.city}" : ''}${edu.country != null ? ", ${edu.country}" : ''}",
                                        ),
                                        pw.SizedBox(height: 5),
                                        if (edu.startDate != null &&
                                            edu.endDate != null &&
                                            !edu.isPresent) ...[
                                          pw.Text(
                                            '${DateFormat('MM/yyyy').format(edu.startDate!)}-${DateFormat('MM/yyyy').format(edu.endDate!)}',
                                            style: pw.TextStyle(
                                              font: sourceCodeFontRegular,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                        if (edu.startDate != null &&
                                            edu.isPresent) ...[
                                          pw.Text(
                                            '${DateFormat('MM/yyyy').format(edu.startDate!)}-present',
                                            style: pw.TextStyle(
                                              font: sourceCodeFontRegular,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                        pw.SizedBox(height: 5),
                                        pw.Text(
                                          edu.description ?? "",
                                          style: const pw.TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  pw.Partition(
                    flex: 2,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                      children: [
                        if (resumeData.personalDetail?.links != null)
                          pw.Container(
                            padding: const pw.EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            decoration: pw.BoxDecoration(
                              color: PdfColor.fromHex('EEEEEE'),
                              borderRadius: const pw.BorderRadius.all(
                                pw.Radius.circular(20),
                              ),
                            ),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  "Links",
                                  style: pw.TextStyle(
                                    fontSize: 20,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                                pw.SizedBox(height: 5),
                                pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: List.generate(
                                    resumeData.personalDetail!.links.length,
                                    (index) {
                                      final link = resumeData
                                          .personalDetail!.links[index];

                                      if (link.url.isEmpty) {
                                        return pw.SizedBox();
                                      }

                                      return pw.Padding(
                                        padding: const pw.EdgeInsets.symmetric(
                                          vertical: 5,
                                        ),
                                        child: pw.UrlLink(
                                          destination: link.url,
                                          child: pw.Text(
                                            link.name,
                                            style: const pw.TextStyle(
                                              fontSize: 14,
                                              decoration:
                                                  pw.TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        pw.SizedBox(height: 10),
                        if (resumeData.skill != null)
                          pw.Container(
                            padding: const pw.EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            decoration: pw.BoxDecoration(
                              color: PdfColor.fromHex('EEEEEE'),
                              borderRadius: const pw.BorderRadius.all(
                                pw.Radius.circular(20),
                              ),
                            ),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  resumeData.skill!.title.isEmptyOrNull
                                      ? "Skills"
                                      : resumeData.skill!.title,
                                  style: pw.TextStyle(
                                    fontSize: 20,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                                pw.SizedBox(height: 5),
                                pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: List.generate(
                                    resumeData.skill!.skills.length,
                                    (index) {
                                      final skill =
                                          resumeData.skill!.skills[index];

                                      return pw.Padding(
                                        padding: const pw.EdgeInsets.symmetric(
                                            vertical: 2),
                                        child: pw.Row(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.spaceBetween,
                                          children: [
                                            pw.Expanded(
                                              child: pw.Text(
                                                skill.name,
                                              ),
                                            ),
                                            pw.SizedBox(width: 10),
                                            pw.Text(
                                              "${getSkillLevelIndex(skill.level ?? SkillLevelEnum.novice)} / 5",
                                              style: pw.TextStyle(
                                                fontWeight: pw.FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        pw.SizedBox(height: 10),
                        if (resumeData.languages != null)
                          pw.Container(
                            padding: const pw.EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            decoration: pw.BoxDecoration(
                              color: PdfColor.fromHex('EEEEEE'),
                              borderRadius: const pw.BorderRadius.all(
                                pw.Radius.circular(20),
                              ),
                            ),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  resumeData.languages!.title.isEmptyOrNull
                                      ? "Languages"
                                      : resumeData.languages!.title,
                                  style: pw.TextStyle(
                                    fontSize: 20,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                                pw.SizedBox(height: 5),
                                pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: List.generate(
                                    resumeData.languages!.languages.length,
                                    (index) {
                                      final lang = resumeData
                                          .languages!.languages[index];

                                      return pw.Padding(
                                        padding: const pw.EdgeInsets.symmetric(
                                            vertical: 2),
                                        child: pw.Row(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.spaceBetween,
                                          children: [
                                            pw.Expanded(
                                              child: pw.Text(
                                                lang.title ?? '',
                                              ),
                                            ),
                                            pw.SizedBox(
                                              width: 10,
                                              height: 1,
                                            ),
                                            pw.Text(
                                              lang.level != null
                                                  ? getLanguageLevel(
                                                      lang.level!)
                                                  : "",
                                              style: pw.TextStyle(
                                                fontWeight: pw.FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        pw.SizedBox(height: 10),
                        if (resumeData.interest != null)
                          pw.Container(
                            padding: const pw.EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            decoration: pw.BoxDecoration(
                              color: PdfColor.fromHex('EEEEEE'),
                              borderRadius: const pw.BorderRadius.all(
                                pw.Radius.circular(20),
                              ),
                            ),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  resumeData.interest!.title.isEmptyOrNull
                                      ? "Hobbies"
                                      : resumeData.interest!.title,
                                  style: pw.TextStyle(
                                    fontSize: 20,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                                pw.SizedBox(height: 5),
                                pw.Text(
                                  getHobbiesString(
                                      resumeData.interest!.interests),
                                  textAlign: pw.TextAlign.justify,
                                ),
                                // pw.Wrap(
                                //   crossAxisAlignment:
                                //       pw.WrapCrossAlignment.start,
                                //   spacing: 10,
                                //   children: List.generate(
                                //     resumeData.interest!.interests.length,
                                //     (index) {
                                //       final hobby =
                                //           resumeData.interest!.interests[index];

                                //       return pw.Text(hobby.title ?? "");
                                //     },
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
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
  // format = format.applyMargin(
  // left: PdfPageFormat.cm,
  //   top: PdfPageFormat.cm,
  //   right: PdfPageFormat.cm,
  //   bottom: PdfPageFormat.cm,
  // );

  return pw.PageTheme(
    pageFormat: format,
    margin: const pw.EdgeInsets.all(20),
    theme: pw.ThemeData.withFont(
      base: await PdfGoogleFonts.sourceSansProRegular(),
      bold: await PdfGoogleFonts.sourceSansProBold(),
      icons: await PdfGoogleFonts.materialIcons(),
    ),
    buildBackground: (pw.Context context) {
      return pw.FullPage(
        ignoreMargins: true,
        child: pw.Container(
          color: PdfColors.white,
        ),
      );
    },
  );
}

class ItemTitle extends pw.StatelessWidget {
  ItemTitle({
    required this.title,
  });

  final String title;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: pw.BoxDecoration(
        color: PdfColor.fromHex('232323'),
      ),
      child: pw.Text(
        title,
        style: pw.TextStyle(
          color: PdfColors.white,
          fontSize: 16,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }
}

String getHobbiesString(List<Interest> interests) {
  List<String> result = [];
  for (var hobby in interests) {
    result.add(hobby.title ?? '');
  }

  return result.join(', ');
}
