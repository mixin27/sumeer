import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:sumeer/features/resume/feat_resume.dart';

Future<Uint8List> generateTemplate10(
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
                        // child: pw.Image(resumeData.profileImage!,
                        //     fit: pw.BoxFit.cover),
                        // profileImage
                        child: pw.SizedBox(),
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
                                      skill.name,
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

  return doc.save();
}

pw.Widget buildContact(
  pw.Context context,
  String title,
  String value,
) {
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
