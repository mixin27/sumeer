import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:sumeer/features/resume/feat_resume.dart';

Future<Uint8List> generateTemplate4(
  PdfPageFormat format,
  GenerateDocParams params,
  ResumeData resumeData,
) async {
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
              // Left Column
              pw.Partition(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                      // padding: const pw.EdgeInsets.only(left: 30, bottom: 20),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          // name
                          if (resumeData.personalDetail?.fullName != null)
                            pw.Text(
                              resumeData.personalDetail?.fullName ?? '',
                              textScaleFactor: 2,
                              style: pw.Theme.of(context)
                                  .defaultTextStyle
                                  .copyWith(fontWeight: pw.FontWeight.bold),
                            ),
                          // job
                          if (resumeData.personalDetail?.jobTitle != null) ...[
                            pw.Padding(
                              padding: const pw.EdgeInsets.only(top: 8),
                            ),
                            pw.Text(
                              resumeData.personalDetail?.jobTitle ?? '',
                              textScaleFactor: 1.2,
                              style: pw.Theme.of(context)
                                  .defaultTextStyle
                                  .copyWith(
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                            ),
                          ],

                          // address
                          if (resumeData.personalDetail?.address != null) ...[
                            pw.Padding(
                              padding: const pw.EdgeInsets.only(top: 8),
                            ),
                            pw.Text(
                              resumeData.personalDetail?.address ?? '',
                              textScaleFactor: 1.2,
                              style: pw.Theme.of(context).defaultTextStyle,
                            ),
                          ],
                          pw.SizedBox(height: 8),
                          pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                if (resumeData.personalDetail?.phone != null)
                                  pw.Text(
                                    resumeData.personalDetail?.phone ?? '',
                                    textScaleFactor: 2,
                                    style: pw.Theme.of(context)
                                        .defaultTextStyle
                                        .copyWith(fontSize: 8),
                                  ),
                                if (resumeData.personalDetail?.email != null)
                                  pw.Text(
                                    resumeData.personalDetail?.email ?? '',
                                    textScaleFactor: 2,
                                    style: pw.Theme.of(context)
                                        .defaultTextStyle
                                        .copyWith(fontSize: 8),
                                  ),
                              ]),
                          pw.SizedBox(height: 8),
                          pw.Divider(height: 2, thickness: 1),

                          // Profile
                          if (resumeData.profile != null) ...[
                            if (resumeData.profile?.title != null)
                              SectionDesign4(
                                  title: resumeData.profile?.title ?? ''),
                            if (resumeData.profile!.contents.isNotEmpty)
                              pw.Column(
                                children: List.generate(
                                  resumeData.profile!.contents.length,
                                  (index) => pw.Padding(
                                    padding: const pw.EdgeInsets.only(top: 4),
                                    child: pw.Text(
                                      resumeData.profile?.contents[index] ?? '',
                                      textScaleFactor: 2,
                                      textAlign: pw.TextAlign.justify,
                                      style: pw.Theme.of(context)
                                          .defaultTextStyle
                                          .copyWith(fontSize: 6),
                                    ),
                                  ),
                                ),
                              )
                          ],
                          pw.SizedBox(height: 8),
                          pw.Divider(height: 2, thickness: 1),

                          // Experience
                          if (resumeData.experience != null) ...[
                            if (resumeData.experience?.title != null)
                              SectionDesign4(
                                  title: resumeData.experience?.title ?? ''),
                            if (resumeData.experience!.experiences.isNotEmpty)
                              experienceList(resumeData, context),
                          ],

                          pw.SizedBox(height: 8),
                          pw.Divider(height: 2, thickness: 1),
                          // Education
                          if (resumeData.education != null) ...[
                            if (resumeData.education?.title != null)
                              SectionDesign4(
                                  title: resumeData.education?.title ?? ''),
                            if (resumeData.education!.educations.isNotEmpty)
                              eduationList(resumeData, context),
                          ],

                          pw.SizedBox(height: 8),
                          pw.Divider(height: 2, thickness: 1),

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
                                    pw.Text('Mingaladon, Yangon'),
                                    pw.Text('Myanmar'),
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

                    // Experience
                    if (resumeData.experience != null) ...[
                      SectionDesign1(title: resumeData.experience!.title),
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
                            );
                          },
                        ),
                      ),
                    ],
                    // Education
                    if (resumeData.education != null) ...[
                      pw.SizedBox(height: 20),
                      SectionDesign1(title: resumeData.education!.title),
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
                  ],
                ),
              ),

              // Right Column
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
              //             if (resumeData.profileImage != null)
              //               pw.ClipOval(
              //                 child: pw.Container(
              //                   width: 100,
              //                   height: 100,
              //                   color: lightGreen,
              //                   child: pw.Image(resumeData.profileImage!),
              //                 ),
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

pw.Column experienceList(ResumeData resumeData, pw.Context context) {
  return pw.Column(
    children: List.generate(
      resumeData.experience!.experiences.length,
      (index) => pw.Padding(
        padding: const pw.EdgeInsets.only(top: 6),
        child: pw.Column(
          children: [
            // jobTitle
            pw.Row(
              // mainAxisAlignment:
              //     pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Expanded(
                    child: pw.Text(
                  resumeData.experience!.experiences[index].jobTitle,
                  textScaleFactor: 2,
                  textAlign: pw.TextAlign.justify,
                  style: pw.Theme.of(context)
                      .defaultTextStyle
                      .copyWith(fontSize: 6, fontWeight: pw.FontWeight.bold),
                )),
                if (resumeData.experience!.experiences[index].startDate != null)
                  pw.Text(
                    resumeData.experience!.experiences[index].startDate
                        .toString()
                        .substring(0, 10),
                    textScaleFactor: 2,
                    textAlign: pw.TextAlign.justify,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontSize: 6),
                  ),
                if (resumeData.experience!.experiences[index].endDate !=
                    null) ...[
                  pw.Text(
                    " -- ",
                    textScaleFactor: 2,
                    textAlign: pw.TextAlign.justify,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontSize: 6),
                  ),
                  pw.Text(
                    resumeData.experience!.experiences[index].endDate
                        .toString()
                        .substring(0, 10),
                    textScaleFactor: 2,
                    textAlign: pw.TextAlign.justify,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontSize: 6),
                  ),
                ]
              ],
            ),
            // Company
            pw.Row(
              // mainAxisAlignment:
              //     pw.MainAxisAlignment.spaceBetween,
              children: [
                if (resumeData.experience!.experiences[index].employer != null)
                  pw.Expanded(
                      child: pw.Text(
                    resumeData.experience!.experiences[index].employer?.name ??
                        '',
                    textScaleFactor: 2,
                    textAlign: pw.TextAlign.justify,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontSize: 6),
                  )),
                if (resumeData.experience!.experiences[index].country != null)
                  pw.Text(
                    resumeData.experience!.experiences[index].country ?? '',
                    textScaleFactor: 2,
                    textAlign: pw.TextAlign.justify,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontSize: 6),
                  ),
                if (resumeData.experience!.experiences[index].city != null) ...[
                  pw.Text(
                    ", ",
                    textScaleFactor: 2,
                    textAlign: pw.TextAlign.justify,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontSize: 6),
                  ),
                  pw.Text(
                    resumeData.experience!.experiences[index].city ?? '',
                    textScaleFactor: 2,
                    textAlign: pw.TextAlign.justify,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontSize: 6),
                  ),
                ]
              ],
            ),
            if (resumeData.experience!.experiences[index].description != null)
              pw.Text(
                resumeData.experience!.experiences[index].description ?? '',
                textScaleFactor: 2,
                textAlign: pw.TextAlign.justify,
                style:
                    pw.Theme.of(context).defaultTextStyle.copyWith(fontSize: 6),
              ),
          ],
        ),
      ),
    ),
  );
}

pw.Column eduationList(ResumeData resumeData, pw.Context context) {
  return pw.Column(
    children: List.generate(
      resumeData.education!.educations.length,
      (index) => pw.Padding(
        padding: const pw.EdgeInsets.only(top: 6),
        child: pw.Column(
          children: [
            // degree
            pw.Row(
              // mainAxisAlignment:
              //     pw.MainAxisAlignment.spaceBetween,
              children: [
                if (resumeData.education!.educations[index].degree != null)
                  pw.Expanded(
                      child: pw.Text(
                    resumeData.education!.educations[index].degree ?? '',
                    textScaleFactor: 2,
                    textAlign: pw.TextAlign.justify,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontSize: 6, fontWeight: pw.FontWeight.bold),
                  )),
                if (resumeData.education!.educations[index].startDate != null)
                  pw.Text(
                    resumeData.education!.educations[index].startDate
                        .toString()
                        .substring(0, 10),
                    textScaleFactor: 2,
                    textAlign: pw.TextAlign.justify,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontSize: 6),
                  ),
                if (resumeData.education!.educations[index].endDate !=
                    null) ...[
                  pw.Text(
                    " -- ",
                    textScaleFactor: 2,
                    textAlign: pw.TextAlign.justify,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontSize: 6),
                  ),
                  pw.Text(
                    resumeData.education!.educations[index].endDate
                        .toString()
                        .substring(0, 10),
                    textScaleFactor: 2,
                    textAlign: pw.TextAlign.justify,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontSize: 6),
                  ),
                ]
              ],
            ),
            // Company
            // pw.Row(
            //   // mainAxisAlignment:
            //   //     pw.MainAxisAlignment.spaceBetween,
            //   children: [
            //     if (resumeData.experience!.experiences[index].employer != null)
            //       pw.Expanded(
            //           child: pw.Text(
            //         resumeData.experience!.experiences[index].employer?.name ??
            //             '',
            //         textScaleFactor: 2,
            //         textAlign: pw.TextAlign.justify,
            //         style: pw.Theme.of(context)
            //             .defaultTextStyle
            //             .copyWith(fontSize: 6),
            //       )),
            //     if (resumeData.experience!.experiences[index].country != null)
            //       pw.Text(
            //         resumeData.experience!.experiences[index].country ?? '',
            //         textScaleFactor: 2,
            //         textAlign: pw.TextAlign.justify,
            //         style: pw.Theme.of(context)
            //             .defaultTextStyle
            //             .copyWith(fontSize: 6),
            //       ),
            //     if (resumeData.experience!.experiences[index].city != null) ...[
            //       pw.Text(
            //         ", ",
            //         textScaleFactor: 2,
            //         textAlign: pw.TextAlign.justify,
            //         style: pw.Theme.of(context)
            //             .defaultTextStyle
            //             .copyWith(fontSize: 6),
            //       ),
            //       pw.Text(
            //         resumeData.experience!.experiences[index].city ?? '',
            //         textScaleFactor: 2,
            //         textAlign: pw.TextAlign.justify,
            //         style: pw.Theme.of(context)
            //             .defaultTextStyle
            //             .copyWith(fontSize: 6),
            //       ),
            //     ]
            //   ],
            // ),
            if (resumeData.education!.educations[index].description != null)
              pw.Text(
                resumeData.education!.educations[index].description ?? '',
                textScaleFactor: 2,
                textAlign: pw.TextAlign.justify,
                style:
                    pw.Theme.of(context).defaultTextStyle.copyWith(fontSize: 6),
              ),
          ],
        ),
      ),
    ),
  );
}

Future<pw.PageTheme> _pageTheme(PdfPageFormat format) async {
  format = format.applyMargin(
    left: 0,
    top: 0,
    right: 0,
    bottom: 0,
    // left: 2.0 * PdfPageFormat.cm,
    // top: 4.0 * PdfPageFormat.cm,
    // right: 2.0 * PdfPageFormat.cm,
    // bottom: 2.0 * PdfPageFormat.cm,
  );

  return pw.PageTheme(
    pageFormat: format,
    theme: pw.ThemeData.withFont(
      base: await PdfGoogleFonts.openSansRegular(),
      bold: await PdfGoogleFonts.openSansBold(),
      icons: await PdfGoogleFonts.materialIcons(),
    ),
  );
}
