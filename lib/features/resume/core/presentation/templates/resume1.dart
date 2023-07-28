import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:sumeer/features/resume/feat_resume.dart';

Future<Uint8List> generateResume1(
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

  var regular = await PdfGoogleFonts.nunitoSansRegular();
  var italic = await PdfGoogleFonts.nunitoSansItalic();
  var bold = await PdfGoogleFonts.nunitoSansBold();
  var boldItalic = await PdfGoogleFonts.nunitoSansBoldItalic();

  doc.addPage(
    pw.MultiPage(
      pageTheme: pw.PageTheme(
        margin: const pw.EdgeInsets.all(0),
        buildBackground: (pw.Context context) => pw.Row(children: [
          pw.Expanded(
            flex: 4,
            child: pw.Container(color: PdfColors.blueGrey),
          ),
          pw.Expanded(
              flex: 7,
              child: pw.Container(
                color: PdfColors.white,
              ))
        ]),
        theme: pw.ThemeData.withFont(
            base: regular, italic: italic, bold: bold, boldItalic: boldItalic),
      ),
      build: (pw.Context context) {
        return [
          pw.Partitions(children: [
            pw.Partition(
              flex: 4,
              child: pw.Container(
                padding: const pw.EdgeInsets.only(top: 20),
                child: pw.Column(
                  children: [
                    pw.Container(
                      width: 150,
                      height: 150,
                      child: pw.ClipOval(
                        child: pw.Image(resumeData.profileImage!,
                            fit: pw.BoxFit.cover),
                      ),
                    ),
                    pw.SizedBox(height: 25),
                    pw.Container(
                      padding: const pw.EdgeInsets.only(left: 20),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            "Contact",
                            textScaleFactor: 1.5,
                            style:
                                pw.Theme.of(context).defaultTextStyle.copyWith(
                                      color: PdfColors.white,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                          ),
                          pw.Divider(height: 1, color: PdfColors.white),
                          pw.SizedBox(height: 20),
                          buildContact(context, "Phone",
                              resumeData.personalDetail?.phone ?? ""),
                          buildContact(context, "Email",
                              resumeData.personalDetail?.email ?? ""),
                          buildContact(context, "Address",
                              resumeData.personalDetail?.address ?? ""),
                          pw.Text(
                            "Skill Heilights",
                            textScaleFactor: 1.5,
                            style:
                                pw.Theme.of(context).defaultTextStyle.copyWith(
                                      color: PdfColors.white,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                          ),
                          pw.Divider(height: 1, color: PdfColors.white),
                          pw.SizedBox(height: 10),
                          if (resumeData.skill != null)
                            pw.Column(
                              children: List.generate(
                                  resumeData.skill!.skills.length, (index) {
                                final skill = resumeData.skill!.skills[index];

                                return pw.Row(children: [
                                  pw.ClipOval(
                                      child: pw.Container(
                                          width: 5,
                                          height: 5,
                                          color: PdfColors.white)),
                                  pw.Padding(
                                    padding: const pw.EdgeInsets.only(left: 5),
                                    child: pw.Text(
                                      skill.skill,
                                      style: pw.Theme.of(context)
                                          .defaultTextStyle
                                          .copyWith(
                                            color: PdfColors.white,
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ]);
                              }),
                            ),
                          if (resumeData.languages != null) ...[
                            pw.SizedBox(height: 20),
                            pw.Text(
                              "Languages",
                              textScaleFactor: 1.5,
                              style: pw.Theme.of(context)
                                  .defaultTextStyle
                                  .copyWith(
                                    color: PdfColors.white,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                            ),
                            pw.Divider(height: 1, color: PdfColors.white),
                            pw.SizedBox(height: 10),
                            pw.Column(
                              children: List.generate(
                                  resumeData.languages!.languages.length,
                                  (index) {
                                final language =
                                    resumeData.languages!.languages[index];

                                return pw.Row(children: [
                                  pw.ClipOval(
                                      child: pw.Container(
                                          width: 5,
                                          height: 5,
                                          color: PdfColors.white)),
                                  pw.Padding(
                                    padding: const pw.EdgeInsets.only(left: 5),
                                    child: pw.Text(
                                      language.title ?? "",
                                      style: pw.Theme.of(context)
                                          .defaultTextStyle
                                          .copyWith(
                                            color: PdfColors.white,
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ]);
                              }),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            pw.Partition(
              flex: 7,
              child: pw.Container(
                padding: const pw.EdgeInsets.all(20.0),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      resumeData.personalDetail!.fullName,
                      textScaleFactor: 2,
                      style: pw.Theme.of(context)
                          .defaultTextStyle
                          .copyWith(fontWeight: pw.FontWeight.bold),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      resumeData.personalDetail!.jobTitle,
                      textScaleFactor: 1.5,
                      style: pw.Theme.of(context).defaultTextStyle,
                    ),
                    pw.SizedBox(height: 10),
                    pw.Container(
                      height: 85,
                      child: pw.Text(
                        resumeData.profile!.contents[0],
                        style: pw.Theme.of(context)
                            .defaultTextStyle
                            .copyWith(fontSize: 10),
                      ),
                    ),
                    pw.SizedBox(height: 20),
                    if (resumeData.experience != null) ...[
                      pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          "Experience",
                          textScaleFactor: 1.5,
                          style: pw.Theme.of(context).defaultTextStyle.copyWith(
                                fontWeight: pw.FontWeight.bold,
                              ),
                        ),
                      ),
                      pw.Divider(height: 1, color: PdfColors.black),
                      pw.SizedBox(height: 10),
                      pw.Column(
                        children: List.generate(
                          resumeData.experience!.experiences.length,
                          (index) {
                            final experience =
                                resumeData.experience!.experiences[index];

                            return BlockDesign2(
                              employeer: experience.employer != null
                                  ? experience.employer?.name
                                  : "",
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
                    if (resumeData.education != null) ...[
                      pw.SizedBox(height: 20),
                      pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          resumeData.education!.title,
                          textScaleFactor: 1.5,
                          style: pw.Theme.of(context).defaultTextStyle.copyWith(
                                fontWeight: pw.FontWeight.bold,
                              ),
                        ),
                      ),
                      pw.Divider(height: 1, color: PdfColors.black),
                      pw.SizedBox(height: 10),
                      pw.Column(
                        children: List.generate(
                          resumeData.education!.educations.length,
                          (index) {
                            final education =
                                resumeData.education!.educations[index];

                            return BlockDesign2(
                              employeer: education.school,
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
                      )
                    ],
                    if (resumeData.certificate != null) ...[
                      pw.SizedBox(height: 20),
                      pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          resumeData.certificate!.title,
                          textScaleFactor: 1.5,
                          style: pw.Theme.of(context).defaultTextStyle.copyWith(
                                fontWeight: pw.FontWeight.bold,
                              ),
                        ),
                      ),
                      pw.Divider(height: 1, color: PdfColors.black),
                      pw.SizedBox(height: 10),
                      pw.Column(
                        children: List.generate(
                          resumeData.certificate!.certificates.length,
                          (index) {
                            final education =
                                resumeData.certificate!.certificates[index];

                            return BlockDesign3(
                              title: education.title ?? '',
                              startDate: education.startDate,
                              endDate: education.endDate,
                              isPresent: education.isPresent,
                              description: education.description,
                              school: education.school,
                            );
                          },
                        ),
                      )
                    ],
                  ],
                ),
              ),
            ),
          ])
        ];
      },
    ),
  );

  doc.addPage(
    pw.MultiPage(
      pageTheme: pw.PageTheme(
        margin: const pw.EdgeInsets.all(0),
        buildBackground: (pw.Context context) => pw.Column(children: [
          pw.Expanded(
            flex: 2,
            child: pw.Row(children: [
              pw.Expanded(
                flex: 4,
                child: pw.Container(color: PdfColors.white),
              ),
              pw.Expanded(
                  flex: 7,
                  child: pw.Container(
                    color: PdfColors.grey100,
                  ))
            ]),
          ),
          pw.Expanded(
              flex: 8,
              child: pw.Row(children: [
                pw.Expanded(
                  flex: 4,
                  child: pw.Container(color: PdfColors.grey100),
                ),
                pw.Expanded(
                    flex: 7,
                    child: pw.Container(
                      color: PdfColors.white,
                    ))
              ]))
        ]),
        theme: pw.ThemeData.withFont(
            base: regular, italic: italic, bold: bold, boldItalic: boldItalic),
      ),
      build: (pw.Context context) {
        return [
          pw.Stack(children: [
            pw.Row(children: [
              pw.Expanded(
                flex: 4,
                child: pw.Container(
                  alignment: pw.Alignment.center,
                  color: PdfColors.white,
                  child: pw.Image(resumeData.profileImage!,
                      height: 170, width: 210, fit: pw.BoxFit.cover),
                ),
              ),
              pw.Expanded(
                flex: 7,
                child: pw.Container(
                  color: PdfColors.grey100,
                  padding: const pw.EdgeInsets.all(20),
                  child: pw.Text(
                    resumeData.profile!.contents[0],
                    style: pw.Theme.of(context).defaultTextStyle,
                  ),
                ),
              )
            ]),
            pw.Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: pw.Opacity(
                  opacity: 0.5,
                  child: pw.Container(
                      padding: const pw.EdgeInsets.only(left: 8),
                      color: PdfColors.black,
                      child: pw.Text(
                        resumeData.personalDetail!.fullName,
                        textScaleFactor: 2,
                        style: pw.Theme.of(context).defaultTextStyle.copyWith(
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.white),
                      ))),
            ),
            pw.Positioned(
              bottom: 0,
              child: pw.Padding(
                padding: const pw.EdgeInsets.only(left: 8),
                child: pw.Text(
                  resumeData.personalDetail!.fullName,
                  textScaleFactor: 2,
                  style: pw.Theme.of(context).defaultTextStyle.copyWith(
                      fontWeight: pw.FontWeight.bold, color: PdfColors.white),
                ),
              ),
            ),
          ]),
          pw.Partitions(children: [
            pw.Partition(
              flex: 4,
              child: pw.Container(
                child: pw.Column(
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.only(left: 20),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(height: 20),
                          buildContact1(context, "Phone :",
                              resumeData.personalDetail?.phone ?? ""),
                          buildContact1(context, "Email :",
                              resumeData.personalDetail?.email ?? ""),
                          buildContact1(context, "Address :",
                              resumeData.personalDetail?.address ?? ""),
                          pw.Text(
                            "Skill Heilights",
                            textScaleFactor: 1.5,
                            style:
                                pw.Theme.of(context).defaultTextStyle.copyWith(
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                          ),
                          pw.Divider(height: 1),
                          pw.SizedBox(height: 10),
                          if (resumeData.skill != null)
                            pw.Column(
                              children: List.generate(
                                  resumeData.skill!.skills.length, (index) {
                                final skill = resumeData.skill!.skills[index];

                                return pw.Row(children: [
                                  pw.ClipOval(
                                      child: pw.Container(
                                          width: 5,
                                          height: 5,
                                          color: PdfColors.black)),
                                  pw.Padding(
                                    padding: const pw.EdgeInsets.only(left: 5),
                                    child: pw.Text(
                                      skill.skill,
                                      style: pw.Theme.of(context)
                                          .defaultTextStyle
                                          .copyWith(
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ]);
                              }),
                            ),
                          if (resumeData.languages != null) ...[
                            pw.SizedBox(height: 20),
                            pw.Text(
                              "Languages",
                              textScaleFactor: 1.5,
                              style: pw.Theme.of(context)
                                  .defaultTextStyle
                                  .copyWith(
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                            ),
                            pw.Divider(height: 1),
                            pw.SizedBox(height: 10),
                            pw.Column(
                              children: List.generate(
                                  resumeData.languages!.languages.length,
                                  (index) {
                                final language =
                                    resumeData.languages!.languages[index];

                                return pw.Row(children: [
                                  pw.ClipOval(
                                      child: pw.Container(
                                    width: 5,
                                    height: 5,
                                    color: PdfColors.black,
                                  )),
                                  pw.Padding(
                                    padding: const pw.EdgeInsets.only(left: 5),
                                    child: pw.Text(
                                      language.title ?? "",
                                      style: pw.Theme.of(context)
                                          .defaultTextStyle
                                          .copyWith(
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ]);
                              }),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            pw.Partition(
              flex: 7,
              child: pw.Container(
                padding: const pw.EdgeInsets.all(20.0),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    if (resumeData.experience != null) ...[
                      pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          "Experience",
                          textScaleFactor: 1.5,
                          style: pw.Theme.of(context).defaultTextStyle.copyWith(
                                fontWeight: pw.FontWeight.bold,
                              ),
                        ),
                      ),
                      pw.Divider(height: 1, color: PdfColors.black),
                      pw.SizedBox(height: 10),
                      pw.Column(
                        children: List.generate(
                          resumeData.experience!.experiences.length,
                          (index) {
                            final experience =
                                resumeData.experience!.experiences[index];

                            return BlockDesign4(
                              employeer: experience.employer != null
                                  ? experience.employer?.name
                                  : "",
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
                    if (resumeData.education != null) ...[
                      pw.SizedBox(height: 20),
                      pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          resumeData.education!.title,
                          textScaleFactor: 1.5,
                          style: pw.Theme.of(context).defaultTextStyle.copyWith(
                                fontWeight: pw.FontWeight.bold,
                              ),
                        ),
                      ),
                      pw.Divider(height: 1, color: PdfColors.black),
                      pw.SizedBox(height: 10),
                      pw.Column(
                        children: List.generate(
                          resumeData.education!.educations.length,
                          (index) {
                            final education =
                                resumeData.education!.educations[index];

                            return BlockDesign4(
                              employeer: education.school,
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
                      )
                    ],
                    if (resumeData.certificate != null) ...[
                      pw.SizedBox(height: 20),
                      pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          resumeData.certificate!.title,
                          textScaleFactor: 1.5,
                          style: pw.Theme.of(context).defaultTextStyle.copyWith(
                                fontWeight: pw.FontWeight.bold,
                              ),
                        ),
                      ),
                      pw.Divider(height: 1, color: PdfColors.black),
                      pw.SizedBox(height: 10),
                      pw.Column(
                        children: List.generate(
                          resumeData.certificate!.certificates.length,
                          (index) {
                            final education =
                                resumeData.certificate!.certificates[index];

                            return BlockDesign3(
                              title: education.title ?? '',
                              startDate: education.startDate,
                              endDate: education.endDate,
                              isPresent: education.isPresent,
                              description: education.description,
                              school: education.school,
                              iconColor: PdfColors.black,
                            );
                          },
                        ),
                      )
                    ],
                  ],
                ),
              ),
            ),
          ])
        ];
      },
    ),
  );

  doc.addPage(
    pw.MultiPage(
      pageTheme: pw.PageTheme(
        margin: const pw.EdgeInsets.all(0),
        buildBackground: (pw.Context context) => pw.Column(children: [
          pw.Expanded(
            flex: 1,
            child: pw.Container(
              color: const PdfColor.fromInt(0xFF074566),
            ),
          ),
          pw.Expanded(
              flex: 9,
              child: pw.Container(
                color: PdfColors.white,
              ))
        ]),
        theme: pw.ThemeData.withFont(
            base: regular, italic: italic, bold: bold, boldItalic: boldItalic),
      ),
      build: (pw.Context context) {
        return [
          pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.center, children: [
            pw.Expanded(
              flex: 3,
              child: pw.Container(
                alignment: pw.Alignment.centerRight,
                padding: const pw.EdgeInsets.only(top: 20),
                child: pw.ClipOval(
                  child: pw.Image(
                    resumeData.profileImage!,
                    fit: pw.BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
            ),
            pw.Expanded(
              flex: 7,
              child: pw.Container(
                margin: const pw.EdgeInsets.only(left: 30),
                child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(
                      height: 30,
                    ),
                    pw.Text(
                      resumeData.personalDetail!.fullName,
                      textScaleFactor: 2,
                      style: pw.Theme.of(context).header4.copyWith(
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.white),
                    ),
                    pw.SizedBox(
                      height: 30,
                    ),
                    pw.Row(children: [
                      pw.Text(
                        resumeData.personalDetail?.phone ?? "",
                        textAlign: pw.TextAlign.center,
                        style: pw.Theme.of(context).defaultTextStyle.copyWith(
                              fontWeight: pw.FontWeight.bold,
                            ),
                      ),
                      pw.SizedBox(width: 40),
                      pw.Text(
                        resumeData.personalDetail?.email ?? "",
                        style: pw.Theme.of(context).defaultTextStyle.copyWith(
                              fontWeight: pw.FontWeight.bold,
                            ),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ]),
          pw.Container(
            margin: const pw.EdgeInsets.all(20),
            child: pw.Text(
              resumeData.profile?.contents[0] ?? "",
              style: pw.Theme.of(context).defaultTextStyle.copyWith(
                    fontWeight: pw.FontWeight.bold,
                  ),
            ),
          ),
          pw.Container(
            margin: const pw.EdgeInsets.all(20),
            child: pw.Divider(height: 1),
          ),
          pw.Row(children: [
            pw.Expanded(
              child: pw.Container(
                decoration: const pw.BoxDecoration(
                  border: pw.Border(
                    left: pw.BorderSide(color: blueGrey, width: 2),
                  ),
                ),
                child: pw.Column(
                  children: [
                    if (resumeData.experience != null) ...[
                      pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          "Experience",
                          textScaleFactor: 1.5,
                          style: pw.Theme.of(context).defaultTextStyle.copyWith(
                                fontWeight: pw.FontWeight.bold,
                              ),
                        ),
                      ),
                      pw.Divider(height: 1, color: PdfColors.black),
                      pw.SizedBox(height: 10),
                      pw.Column(
                        children: List.generate(
                          resumeData.experience!.experiences.length,
                          (index) {
                            final experience =
                                resumeData.experience!.experiences[index];

                            return BlockDesign2(
                              employeer: experience.employer != null
                                  ? experience.employer?.name
                                  : "",
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
                  ],
                ),
              ),
            ),
            pw.Expanded(child: pw.Column(children: []))
          ]),
          // pw.Partitions(children: [
          //   pw.Partition(
          //     flex: 4,
          //     child: pw.Container(
          //       child: pw.Column(
          //         children: [
          //           pw.Container(
          //             padding: const pw.EdgeInsets.only(left: 20),
          //             child: pw.Column(
          //               crossAxisAlignment: pw.CrossAxisAlignment.start,
          //               children: [
          //                 pw.SizedBox(height: 20),
          //                 buildContact1(context, "Phone :",
          //                     resumeData.personalDetail?.phone ?? ""),
          //                 buildContact1(context, "Email :",
          //                     resumeData.personalDetail?.email ?? ""),
          //                 buildContact1(context, "Address :",
          //                     resumeData.personalDetail?.address ?? ""),
          //                 pw.Text(
          //                   "Skill Heilights",
          //                   textScaleFactor: 1.5,
          //                   style:
          //                       pw.Theme.of(context).defaultTextStyle.copyWith(
          //                             fontWeight: pw.FontWeight.bold,
          //                           ),
          //                 ),
          //                 pw.Divider(height: 1),
          //                 pw.SizedBox(height: 10),
          //                 if (resumeData.skill != null)
          //                   pw.Column(
          //                     children: List.generate(
          //                         resumeData.skill!.skills.length, (index) {
          //                       final skill = resumeData.skill!.skills[index];

          //                       return pw.Row(children: [
          //                         pw.ClipOval(
          //                             child: pw.Container(
          //                                 width: 5,
          //                                 height: 5,
          //                                 color: PdfColors.black)),
          //                         pw.Padding(
          //                           padding: const pw.EdgeInsets.only(left: 5),
          //                           child: pw.Text(
          //                             skill.skill,
          //                             style: pw.Theme.of(context)
          //                                 .defaultTextStyle
          //                                 .copyWith(
          //                                   fontWeight: pw.FontWeight.bold,
          //                                 ),
          //                           ),
          //                         ),
          //                       ]);
          //                     }),
          //                   ),
          //                 if (resumeData.languages != null) ...[
          //                   pw.SizedBox(height: 20),
          //                   pw.Text(
          //                     "Languages",
          //                     textScaleFactor: 1.5,
          //                     style: pw.Theme.of(context)
          //                         .defaultTextStyle
          //                         .copyWith(
          //                           fontWeight: pw.FontWeight.bold,
          //                         ),
          //                   ),
          //                   pw.Divider(height: 1),
          //                   pw.SizedBox(height: 10),
          //                   pw.Column(
          //                     children: List.generate(
          //                         resumeData.languages!.languages.length,
          //                         (index) {
          //                       final language =
          //                           resumeData.languages!.languages[index];

          //                       return pw.Row(children: [
          //                         pw.ClipOval(
          //                             child: pw.Container(
          //                           width: 5,
          //                           height: 5,
          //                           color: PdfColors.black,
          //                         )),
          //                         pw.Padding(
          //                           padding: const pw.EdgeInsets.only(left: 5),
          //                           child: pw.Text(
          //                             language.title ?? "",
          //                             style: pw.Theme.of(context)
          //                                 .defaultTextStyle
          //                                 .copyWith(
          //                                   fontWeight: pw.FontWeight.bold,
          //                                 ),
          //                           ),
          //                         ),
          //                       ]);
          //                     }),
          //                   ),
          //                 ],
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          //   pw.Partition(
          //     flex: 7,
          //     child: pw.Container(
          //       padding: const pw.EdgeInsets.all(20.0),
          //       child: pw.Column(
          //         crossAxisAlignment: pw.CrossAxisAlignment.start,
          //         children: [
          //           if (resumeData.experience != null) ...[
          //             pw.Align(
          //               alignment: pw.Alignment.centerLeft,
          //               child: pw.Text(
          //                 "Experience",
          //                 textScaleFactor: 1.5,
          //                 style: pw.Theme.of(context).defaultTextStyle.copyWith(
          //                       fontWeight: pw.FontWeight.bold,
          //                     ),
          //               ),
          //             ),
          //             pw.Divider(height: 1, color: PdfColors.black),
          //             pw.SizedBox(height: 10),
          //             pw.Column(
          //               children: List.generate(
          //                 resumeData.experience!.experiences.length,
          //                 (index) {
          //                   final experience =
          //                       resumeData.experience!.experiences[index];

          //                   return BlockDesign4(
          //                     employeer: experience.employer != null
          //                         ? experience.employer?.name
          //                         : "",
          //                     title: experience.jobTitle,
          //                     city: experience.city,
          //                     country: experience.country,
          //                     startDate: experience.startDate,
          //                     endDate: experience.endDate,
          //                     isPresent: experience.isPresent,
          //                     description: experience.description,
          //                   );
          //                 },
          //               ),
          //             ),
          //           ],
          //           if (resumeData.education != null) ...[
          //             pw.SizedBox(height: 20),
          //             pw.Align(
          //               alignment: pw.Alignment.centerLeft,
          //               child: pw.Text(
          //                 resumeData.education!.title,
          //                 textScaleFactor: 1.5,
          //                 style: pw.Theme.of(context).defaultTextStyle.copyWith(
          //                       fontWeight: pw.FontWeight.bold,
          //                     ),
          //               ),
          //             ),
          //             pw.Divider(height: 1, color: PdfColors.black),
          //             pw.SizedBox(height: 10),
          //             pw.Column(
          //               children: List.generate(
          //                 resumeData.education!.educations.length,
          //                 (index) {
          //                   final education =
          //                       resumeData.education!.educations[index];

          //                   return BlockDesign4(
          //                     employeer: education.school,
          //                     title: education.degree ?? '',
          //                     city: education.city,
          //                     country: education.country,
          //                     startDate: education.startDate,
          //                     endDate: education.endDate,
          //                     isPresent: education.isPresent,
          //                     description: education.description,
          //                     school: education.school,
          //                   );
          //                 },
          //               ),
          //             )
          //           ],
          //           if (resumeData.certificate != null) ...[
          //             pw.SizedBox(height: 20),
          //             pw.Align(
          //               alignment: pw.Alignment.centerLeft,
          //               child: pw.Text(
          //                 resumeData.certificate!.title,
          //                 textScaleFactor: 1.5,
          //                 style: pw.Theme.of(context).defaultTextStyle.copyWith(
          //                       fontWeight: pw.FontWeight.bold,
          //                     ),
          //               ),
          //             ),
          //             pw.Divider(height: 1, color: PdfColors.black),
          //             pw.SizedBox(height: 10),
          //             pw.Column(
          //               children: List.generate(
          //                 resumeData.certificate!.certificates.length,
          //                 (index) {
          //                   final education =
          //                       resumeData.certificate!.certificates[index];

          //                   return BlockDesign3(
          //                     title: education.title ?? '',
          //                     startDate: education.startDate,
          //                     endDate: education.endDate,
          //                     isPresent: education.isPresent,
          //                     description: education.description,
          //                     school: education.school,
          //                     iconColor: PdfColors.black,
          //                   );
          //                 },
          //               ),
          //             )
          //           ],
          //         ],
          //       ),
          //     ),
          //   ),
          // ])
        ];
      },
    ),
  );

  return doc.save();
}

pw.Widget buildContact1(pw.Context context, String title, String value) {
  return pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
    pw.Text(
      title,
      textScaleFactor: 1.2,
      style: pw.Theme.of(context).defaultTextStyle.copyWith(
            fontWeight: pw.FontWeight.bold,
          ),
    ),
    pw.Text(
      value,
      style: pw.Theme.of(context).defaultTextStyle.copyWith(),
    ),
    pw.SizedBox(height: 20),
  ]);
}

pw.Widget buildContact(pw.Context context, String title, String value) {
  return pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
    pw.Text(
      title,
      textScaleFactor: 1.2,
      style: pw.Theme.of(context).defaultTextStyle.copyWith(
            color: PdfColors.white,
            fontWeight: pw.FontWeight.bold,
          ),
    ),
    pw.Text(
      value,
      style: pw.Theme.of(context).defaultTextStyle.copyWith(
            color: PdfColors.white,
          ),
    ),
    pw.SizedBox(height: 20),
  ]);
}
