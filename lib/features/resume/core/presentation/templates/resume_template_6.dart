import 'dart:convert';
import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:sumeer/features/resume/feat_resume.dart';
import 'package:sumeer/utils/extensions/dart_extensions.dart';

Future<Uint8List> generateTemplate6(
  PdfPageFormat format,
  GenerateDocParams params,
  ResumeData resumeData,
) async {
  // get network image
  // ignore: prefer_typing_uninitialized_variables
  var profileImage;
  if (resumeData.profileImage.isEmptyOrNull) {
    profileImage = null;
  } else {
    final bytes = base64.decode(resumeData.profileImage!);
    profileImage = pw.MemoryImage(bytes);
  }

  final doc = pw.Document(
    title: params.title,
    author: params.author,
    creator: params.creator,
    subject: params.subject,
    keywords: params.keywords,
    producer: params.producer,
  );

  final pageTheme = await _pageTheme(format);

  final font = await PdfGoogleFonts.bungeeShadeRegular();

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
                    if (resumeData.personalDetail != null) ...[
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            resumeData.personalDetail?.firstName ?? '',
                            style: pw.TextStyle(
                              font: font,
                              fontSize: 35,
                            ),
                          ),
                          pw.Text(
                            resumeData.personalDetail?.lastName ?? '',
                            style: pw.TextStyle(
                              font: font,
                              fontSize: 35,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        resumeData.personalDetail?.jobTitle ?? '',
                        style: pw.TextStyle(
                          fontSize: 20,
                          color: PdfColor.fromHex('54448D'),
                        ),
                      ),
                      pw.SizedBox(height: 5),
                      if (profileImage != null)
                        pw.Container(
                          width: 100,
                          height: 100,
                          child: pw.ClipOval(
                            child: pw.Image(profileImage, fit: pw.BoxFit.cover),
                          ),
                        ),
                      pw.Row(
                        children: [
                          pw.Icon(
                            const pw.IconData(0xe158),
                            color: PdfColor.fromHex('54448D'),
                            size: 20,
                          ),
                          pw.SizedBox(width: 5),
                          pw.Text(
                            resumeData.personalDetail?.email ?? '',
                            style: pw.TextStyle(
                              color: PdfColor.fromHex('54448D'),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 5),
                      pw.Row(
                        children: [
                          pw.Icon(
                            const pw.IconData(0xe0b0),
                            color: PdfColor.fromHex('54448D'),
                            size: 20,
                          ),
                          pw.SizedBox(width: 5),
                          pw.Text(
                            resumeData.personalDetail?.phone ?? '',
                            style: pw.TextStyle(
                              color: PdfColor.fromHex('54448D'),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 5),
                      pw.Row(
                        children: [
                          pw.Icon(
                            const pw.IconData(0xe0c8),
                            color: PdfColor.fromHex('54448D'),
                            size: 20,
                          ),
                          pw.SizedBox(width: 5),
                          pw.Text(
                            resumeData.personalDetail?.address ?? '',
                            style: pw.TextStyle(
                              color: PdfColor.fromHex('54448D'),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      if (resumeData.personalDetail!.links.isNotEmpty)
                        pw.Column(
                          children: List.generate(
                            resumeData.personalDetail!.links.length,
                            (index) {
                              final link =
                                  resumeData.personalDetail!.links[index];

                              if (link.url.isEmpty) return pw.SizedBox();

                              return pw.Column(
                                children: [
                                  pw.SizedBox(height: 5),
                                  pw.Row(
                                    children: [
                                      pw.Icon(
                                        pw.IconData(link.codePoint ?? 0xe157),
                                        color: PdfColor.fromHex('54448D'),
                                        size: 20,
                                      ),
                                      pw.SizedBox(width: 5),
                                      pw.Text(
                                        link.url,
                                        style: pw.TextStyle(
                                          color: PdfColor.fromHex('54448D'),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                    ],
                    pw.SizedBox(height: 20),
                    if (resumeData.skill != null) ...[
                      pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Icon(
                            const pw.IconData(0xea4a),
                            color: PdfColor.fromHex('54448D'),
                          ),
                          pw.SizedBox(width: 10),
                          pw.Text(
                            resumeData.skill!.title.isNotEmpty
                                ? resumeData.skill!.title
                                : 'Skills',
                            style: pw.TextStyle(
                              color: PdfColor.fromHex('54448D'),
                              fontSize: 18,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 20),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: List.generate(
                          resumeData.skill!.skills.length,
                          (index) {
                            final skill = resumeData.skill!.skills[index];

                            return pw.Container(
                              width: 200,
                              padding:
                                  const pw.EdgeInsets.symmetric(vertical: 5),
                              child: pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Expanded(
                                    child: pw.Text(skill.name),
                                  ),
                                  pw.SizedBox(width: 10),
                                  pw.Expanded(
                                    child: pw.LinearProgressIndicator(
                                      value: skill.percentage ?? 0.0,
                                      minHeight: 3,
                                      backgroundColor:
                                          PdfColor.fromHex('C5C4E9'),
                                      valueColor: PdfColor.fromHex('54448D'),
                                    ),
                                  ),
                                  // pw.Expanded(
                                  //   child: pw.Row(
                                  //     children: List.generate(
                                  //       5,
                                  //       (index) {
                                  //         // (((skill.percentage ?? 0) / 10) / 2).ceil()
                                  //         final value =
                                  //             (((skill.percentage ?? 0) / 10) /
                                  //                     2)
                                  //                 .floor();
                                  //         print(
                                  //             "Percentage${skill.percentage}");

                                  //         return pw.Container(
                                  //           margin:
                                  //               const pw.EdgeInsets.symmetric(
                                  //                   horizontal: 5),
                                  //           width: 10,
                                  //           height: 10,
                                  //           decoration: pw.BoxDecoration(
                                  //             // DBDBF9
                                  //             color: index < value
                                  //                 ? PdfColor.fromHex('54448D')
                                  //                 : PdfColor.fromHex('DBDBF9'),
                                  //             border: pw.Border.all(
                                  //               width: 1,
                                  //               color:
                                  //                   PdfColor.fromHex('54448D'),
                                  //             ),
                                  //             borderRadius:
                                  //                 const pw.BorderRadius.all(
                                  //               pw.Radius.circular(5),
                                  //             ),
                                  //           ),
                                  //         );
                                  //       },
                                  //     ),
                                  //   ),
                                  //   // child: ProgressDesignLinear(
                                  //   //   value: skill.percentage ?? 0.0,
                                  //   // ),
                                  // ),
                                  pw.SizedBox(width: 20),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                    pw.SizedBox(height: 20),
                    if (resumeData.languages != null) ...[
                      pw.Row(
                        children: [
                          pw.Icon(
                            const pw.IconData(0xe894),
                            color: PdfColor.fromHex('54448D'),
                          ),
                          pw.SizedBox(width: 10),
                          pw.Text(
                            resumeData.languages!.title.isNotEmpty
                                ? resumeData.languages!.title
                                : 'Languages',
                            style: pw.TextStyle(
                              color: PdfColor.fromHex('54448D'),
                              fontSize: 18,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 20),
                      pw.Column(
                        children: List.generate(
                          resumeData.languages!.languages.length,
                          (index) {
                            final language =
                                resumeData.languages!.languages[index];

                            return pw.Container(
                              width: 200,
                              padding:
                                  const pw.EdgeInsets.symmetric(vertical: 5),
                              child: pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Expanded(
                                    child: pw.Text(language.title ?? ''),
                                  ),
                                  pw.SizedBox(width: 10),
                                  pw.Expanded(
                                      child: pw.LinearProgressIndicator(
                                    value: language.percentage ?? 0.0,
                                    minHeight: 3,
                                    backgroundColor: PdfColor.fromHex('C5C4E9'),
                                    valueColor: PdfColor.fromHex('54448D'),
                                  )
                                      // pw.Row(
                                      //   children: List.generate(
                                      //     5,
                                      //     (index) {
                                      //       // (((skill.percentage ?? 0) / 10) / 2).ceil()
                                      //       final value =
                                      //           (((language.percentage ?? 0) /
                                      //                       10) /
                                      //                   2)
                                      //               .floor();

                                      //       return pw.Container(
                                      //         margin:
                                      //             const pw.EdgeInsets.symmetric(
                                      //                 horizontal: 5),
                                      //         width: 10,
                                      //         height: 10,
                                      //         decoration: pw.BoxDecoration(
                                      //           // DBDBF9
                                      //           color: index < value
                                      //               ? PdfColor.fromHex('54448D')
                                      //               : PdfColor.fromHex('DBDBF9'),
                                      //           border: pw.Border.all(
                                      //             width: 1,
                                      //             color:
                                      //                 PdfColor.fromHex('54448D'),
                                      //           ),
                                      //           borderRadius:
                                      //               const pw.BorderRadius.all(
                                      //             pw.Radius.circular(5),
                                      //           ),
                                      //         ),
                                      //       );
                                      //     },
                                      //   ),
                                      // ),
                                      // child: ProgressDesignLinear(
                                      //   value: language.percentage ?? 0.0,
                                      // ),
                                      ),
                                  pw.SizedBox(width: 20),
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
              pw.Partition(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    if (resumeData.profile != null &&
                        resumeData.profile!.contents.isNotEmpty) ...[
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: List.generate(
                          resumeData.profile!.contents.length,
                          (index) {
                            final item = resumeData.profile!.contents[index];
                            return pw.Text(
                              item,
                              style: const pw.TextStyle(
                                color: PdfColors.white,
                              ),
                              textAlign: pw.TextAlign.justify,
                            );
                          },
                        ),
                      ),
                    ],

                    pw.SizedBox(height: 20),
                    if (resumeData.experience != null) ...[
                      pw.Row(
                        children: [
                          pw.Icon(
                            const pw.IconData(0xeb3f),
                            color: PdfColors.white,
                          ),
                          pw.SizedBox(width: 10),
                          pw.Text(
                            resumeData.experience!.title.isNotEmpty
                                ? resumeData.experience!.title
                                : 'Professional Experience',
                            style: pw.TextStyle(
                              color: PdfColors.white,
                              fontSize: 18,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 20),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: List.generate(
                          resumeData.experience!.experiences.length,
                          (index) {
                            final experience =
                                resumeData.experience!.experiences[index];

                            return pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  '${experience.employer?.name}, ${experience.jobTitle}',
                                  style: pw.TextStyle(
                                    color: PdfColors.white,
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                                pw.SizedBox(height: 2),
                                pw.Row(
                                  children: [
                                    if (experience.startDate != null &&
                                        experience.endDate != null &&
                                        !experience.isPresent) ...[
                                      pw.Text(
                                        '${DateFormat('MM/yyyy').format(experience.startDate!)}-${DateFormat('MM/yyyy').format(experience.endDate!)}',
                                        style: const pw.TextStyle(
                                          color: PdfColors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                    if (experience.startDate != null &&
                                        experience.isPresent) ...[
                                      pw.Text(
                                        '${DateFormat('MM/yyyy').format(experience.startDate!)}-present',
                                        style: const pw.TextStyle(
                                          color: PdfColors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                    if (experience.city != null ||
                                        experience.country != null) ...[
                                      pw.SizedBox(width: 2),
                                      pw.Text(
                                        '|',
                                        style: const pw.TextStyle(
                                          color: PdfColors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                      pw.SizedBox(width: 2),
                                      if (experience.city != null &&
                                          experience.country == null)
                                        pw.Text(
                                          '${experience.city}',
                                          style: const pw.TextStyle(
                                            color: PdfColors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      if (experience.city == null &&
                                          experience.country != null)
                                        pw.Text(
                                          '${experience.country}',
                                          style: const pw.TextStyle(
                                            color: PdfColors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      if (experience.city != null &&
                                          experience.country != null)
                                        pw.Text(
                                          '${experience.city}, ${experience.country}',
                                          style: const pw.TextStyle(
                                            color: PdfColors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                    ],
                                  ],
                                ),
                                pw.SizedBox(height: 5),
                                pw.Text(
                                  experience.description ?? '',
                                  style: const pw.TextStyle(
                                    color: PdfColors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                pw.SizedBox(height: 10),
                              ],
                            );
                          },
                        ),
                      ),
                    ],

                    // Education
                    if (resumeData.education != null) ...[
                      pw.SizedBox(height: 20),
                      pw.Row(
                        children: [
                          pw.Icon(
                            const pw.IconData(0xe80c),
                            color: PdfColors.white,
                          ),
                          pw.SizedBox(width: 10),
                          pw.Text(
                            resumeData.education!.title.isNotEmpty
                                ? resumeData.education!.title
                                : 'Education',
                            style: pw.TextStyle(
                              color: PdfColors.white,
                              fontSize: 18,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 20),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: List.generate(
                          resumeData.education!.educations.length,
                          (index) {
                            final education =
                                resumeData.education!.educations[index];

                            return pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  '${education.degree} ${education.school != null ? ',' : ''} ${education.school}',
                                  style: pw.TextStyle(
                                    color: PdfColors.white,
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                                pw.SizedBox(height: 2),
                                if (education.startDate != null &&
                                    education.isPresent) ...[
                                  pw.Text(
                                    '${DateFormat('MM/yyyy').format(education.startDate!)}-present}',
                                    style: const pw.TextStyle(
                                      color: PdfColors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                                if (education.startDate != null &&
                                    education.endDate != null &&
                                    !education.isPresent) ...[
                                  pw.Text(
                                    '${DateFormat('MM/yyyy').format(education.startDate!)}-${DateFormat('MM/yyyy').format(education.endDate!)}',
                                    style: const pw.TextStyle(
                                      color: PdfColors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                                pw.SizedBox(height: 5),
                                pw.Text(
                                  education.description ?? '',
                                  style: const pw.TextStyle(
                                    color: PdfColors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                pw.SizedBox(height: 10),
                              ],
                            );
                          },
                        ),
                      ),
                    ],

                    // Interests
                    if (resumeData.interest != null) ...[
                      pw.SizedBox(height: 20),
                      pw.Row(
                        children: [
                          pw.Icon(
                            const pw.IconData(0xea28),
                            color: PdfColors.white,
                          ),
                          pw.SizedBox(width: 10),
                          pw.Text(
                            resumeData.interest!.title.isNotEmpty
                                ? resumeData.interest!.title
                                : 'Interests',
                            style: pw.TextStyle(
                              color: PdfColors.white,
                              fontSize: 18,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 20),
                      pw.Wrap(
                        spacing: 10,
                        crossAxisAlignment: pw.WrapCrossAlignment.start,
                        children: List.generate(
                          resumeData.interest!.interests.length,
                          (index) {
                            final interest =
                                resumeData.interest!.interests[index];

                            return pw.Container(
                              padding: const pw.EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                  width: 1,
                                  color: PdfColors.white,
                                ),
                                borderRadius: const pw.BorderRadius.all(
                                  pw.Radius.circular(5),
                                ),
                                color: PdfColor.fromHex('54448D'),
                              ),
                              child: pw.Text(
                                interest.title ?? '',
                                style: const pw.TextStyle(
                                  color: PdfColors.white,
                                  fontSize: 13,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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
  format = format.applyMargin(
    left: 2.0 * PdfPageFormat.cm,
    top: 2.0 * PdfPageFormat.cm,
    right: 2.0 * PdfPageFormat.cm,
    bottom: 2.0 * PdfPageFormat.cm,
  );

  return pw.PageTheme(
    pageFormat: format,
    theme: pw.ThemeData.withFont(
      base: await PdfGoogleFonts.sourceSansProRegular(),
      bold: await PdfGoogleFonts.sourceSansProBold(),
      icons: await PdfGoogleFonts.materialIcons(),
    ),
    buildBackground: (pw.Context context) {
      return pw.FullPage(
        ignoreMargins: true,
        child: pw.Row(
          children: [
            pw.Expanded(
              flex: 4,
              child: pw.Container(
                color: PdfColor.fromHex('DBDBF9'),
              ),
            ),
            pw.Expanded(
              flex: 5,
              child: pw.Container(
                color: PdfColor.fromHex('54448D'),
              ),
            ),
          ],
        ),
      );
    },
  );
}
