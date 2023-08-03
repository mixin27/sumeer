import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:sumeer/features/resume/feat_resume.dart';

Future<Uint8List> generateTemplate2(
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
  final resumeData = await getDummyResumeData();
  final font = await PdfGoogleFonts.robotoSlabBold();
  final fontRegular = await PdfGoogleFonts.robotoSlabRegular();
  doc.addPage(
    pw.MultiPage(
      pageTheme: pageTheme,
      build: (pw.Context context) {
        return [
          pw.Partitions(children: [
            pw.Partition(
              flex: 5,
              child: pw.Container(
                padding: const pw.EdgeInsets.only(top: 20, left: 20, right: 20),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(resumeData.personalDetail?.fullName ?? "",
                        textScaleFactor: 2,
                        style:
                            pw.TextStyle(font: font, color: PdfColors.white)),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      resumeData.personalDetail!.jobTitle,
                      textScaleFactor: 1.5,
                      style: pw.TextStyle(font: font, color: PdfColors.white),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Container(
                      width: 130,
                      height: 130,
                      child: pw.ClipOval(
                        // child:
                        // pw.Image(resumeData.profileImage!,
                        //     width: 130, height: 130, fit: pw.BoxFit.cover),
                        // TODO: profileImage
                        child: pw.SizedBox(),
                      ),
                    ),
                    pw.SizedBox(height: 20),
                    buildContactTemp(
                        context,
                        "Email",
                        resumeData.personalDetail?.email ?? "",
                        0xe158,
                        fontRegular),
                    buildContactTemp(
                        context,
                        "Phone",
                        resumeData.personalDetail?.phone ?? "",
                        0xe0b0,
                        fontRegular),
                    buildContactTemp(
                        context,
                        "Address",
                        resumeData.personalDetail?.address ?? "",
                        0xe0c8,
                        fontRegular),
                    if (resumeData.personalDetail?.links != null) ...[
                      for (int i = 0;
                          i < resumeData.personalDetail!.links.length;
                          i++) ...[
                        buildContactTemp(
                            context,
                            resumeData.personalDetail!.links[i].name,
                            resumeData.personalDetail!.links[i].url,
                            0xe250,
                            fontRegular)
                      ]
                    ],
                    pw.SizedBox(height: 20),
                    if (resumeData.profile!.contents.isNotEmpty) ...[
                      buildTitleWidget("PROFILE", const pw.IconData(0xea67),
                          font, PdfColor.fromHex('293F4E'), PdfColors.white),
                      pw.SizedBox(height: 10),
                      pw.Container(
                        height: 85,
                        child: pw.Text(
                          resumeData.profile!.contents[0],
                          style: pw.TextStyle(
                              font: fontRegular, color: PdfColors.white),
                        ),
                      ),
                      pw.SizedBox(height: 30),
                    ],
                    if (resumeData.languages != null) ...[
                      buildTitleWidget("LANGUAGES", const pw.IconData(0xe894),
                          font, PdfColor.fromHex('293F4E'), PdfColors.white),
                      pw.SizedBox(height: 10),
                      pw.Column(
                        children: List.generate(
                            resumeData.languages!.languages.length, (index) {
                          final language =
                              resumeData.languages!.languages[index];

                          return pw.Row(children: [
                            pw.Expanded(
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
                            if (language.level != null) ...[
                              if (language.level == LanguageLevel.beginner) ...[
                                pw.Expanded(
                                  child: pw.Row(
                                    children: [
                                      pw.ClipOval(
                                          child: pw.Container(
                                              width: 5,
                                              height: 5,
                                              color:
                                                  PdfColor.fromHex('D3C0B9'))),
                                      pw.SizedBox(width: 10),
                                      pw.ClipOval(
                                          child: pw.Container(
                                        width: 5,
                                        height: 5,
                                        color: PdfColor.fromHex('293F4E'),
                                      )),
                                      pw.SizedBox(width: 10),
                                      pw.ClipOval(
                                          child: pw.Container(
                                        width: 5,
                                        height: 5,
                                        color: PdfColor.fromHex('293F4E'),
                                      )),
                                      pw.SizedBox(width: 10),
                                      pw.ClipOval(
                                          child: pw.Container(
                                        width: 5,
                                        height: 5,
                                        color: PdfColor.fromHex('293F4E'),
                                      )),
                                      pw.SizedBox(width: 10),
                                      pw.ClipOval(
                                          child: pw.Container(
                                        width: 5,
                                        height: 5,
                                        color: PdfColor.fromHex('293F4E'),
                                      )),
                                    ],
                                  ),
                                ),
                              ] else if (language.level ==
                                  LanguageLevel.elementary) ...[
                                pw.Expanded(
                                  child: pw.Row(
                                    children: [
                                      pw.ClipOval(
                                          child: pw.Container(
                                              width: 5,
                                              height: 5,
                                              color:
                                                  PdfColor.fromHex('D3C0B9'))),
                                      pw.SizedBox(width: 10),
                                      pw.ClipOval(
                                          child: pw.Container(
                                        width: 5,
                                        height: 5,
                                        color: PdfColor.fromHex('D3C0B9'),
                                      )),
                                      pw.SizedBox(width: 10),
                                      pw.ClipOval(
                                          child: pw.Container(
                                        width: 5,
                                        height: 5,
                                        color: PdfColor.fromHex('293F4E'),
                                      )),
                                      pw.SizedBox(width: 10),
                                      pw.ClipOval(
                                          child: pw.Container(
                                        width: 5,
                                        height: 5,
                                        color: PdfColor.fromHex('293F4E'),
                                      )),
                                      pw.SizedBox(width: 10),
                                      pw.ClipOval(
                                          child: pw.Container(
                                        width: 5,
                                        height: 5,
                                        color: PdfColor.fromHex('293F4E'),
                                      )),
                                      pw.SizedBox(width: 10),
                                    ],
                                  ),
                                ),
                              ] else if (language.level ==
                                  LanguageLevel.limitedWorking) ...[
                                pw.Expanded(
                                  child: pw.Row(
                                    children: [
                                      pw.ClipOval(
                                          child: pw.Container(
                                              width: 5,
                                              height: 5,
                                              color:
                                                  PdfColor.fromHex('D3C0B9'))),
                                      pw.SizedBox(width: 10),
                                      pw.ClipOval(
                                          child: pw.Container(
                                        width: 5,
                                        height: 5,
                                        color: PdfColor.fromHex('D3C0B9'),
                                      )),
                                      pw.SizedBox(width: 10),
                                      pw.ClipOval(
                                          child: pw.Container(
                                        width: 5,
                                        height: 5,
                                        color: PdfColor.fromHex('D3C0B9'),
                                      )),
                                      pw.SizedBox(width: 10),
                                      pw.ClipOval(
                                          child: pw.Container(
                                        width: 5,
                                        height: 5,
                                        color: PdfColor.fromHex('293F4E'),
                                      )),
                                      pw.SizedBox(width: 10),
                                      pw.ClipOval(
                                          child: pw.Container(
                                        width: 5,
                                        height: 5,
                                        color: PdfColor.fromHex('293F4E'),
                                      )),
                                    ],
                                  ),
                                ),
                              ] else if (language.level ==
                                  LanguageLevel.highlyProficient) ...[
                                pw.Expanded(
                                  child: pw.Row(
                                    children: [
                                      pw.ClipOval(
                                          child: pw.Container(
                                              width: 5,
                                              height: 5,
                                              color:
                                                  PdfColor.fromHex('D3C0B9'))),
                                      pw.SizedBox(width: 10),
                                      pw.ClipOval(
                                          child: pw.Container(
                                        width: 5,
                                        height: 5,
                                        color: PdfColor.fromHex('D3C0B9'),
                                      )),
                                      pw.SizedBox(width: 10),
                                      pw.ClipOval(
                                          child: pw.Container(
                                        width: 5,
                                        height: 5,
                                        color: PdfColor.fromHex('D3C0B9'),
                                      )),
                                      pw.SizedBox(width: 10),
                                      pw.ClipOval(
                                          child: pw.Container(
                                        width: 5,
                                        height: 5,
                                        color: PdfColor.fromHex('D3C0B9'),
                                      )),
                                      pw.SizedBox(width: 10),
                                      pw.ClipOval(
                                          child: pw.Container(
                                        width: 5,
                                        height: 5,
                                        color: PdfColor.fromHex('293F4E'),
                                      )),
                                    ],
                                  ),
                                ),
                              ] else ...[
                                pw.Expanded(
                                  child: pw.Row(
                                    children: [
                                      pw.ClipOval(
                                          child: pw.Container(
                                              width: 5,
                                              height: 5,
                                              color:
                                                  PdfColor.fromHex('D3C0B9'))),
                                      pw.SizedBox(width: 10),
                                      pw.ClipOval(
                                          child: pw.Container(
                                        width: 5,
                                        height: 5,
                                        color: PdfColor.fromHex('D3C0B9'),
                                      )),
                                      pw.SizedBox(width: 10),
                                      pw.ClipOval(
                                          child: pw.Container(
                                        width: 5,
                                        height: 5,
                                        color: PdfColor.fromHex('D3C0B9'),
                                      )),
                                      pw.SizedBox(width: 10),
                                      pw.ClipOval(
                                          child: pw.Container(
                                        width: 5,
                                        height: 5,
                                        color: PdfColor.fromHex('D3C0B9'),
                                      )),
                                      pw.SizedBox(width: 10),
                                      pw.ClipOval(
                                          child: pw.Container(
                                        width: 5,
                                        height: 5,
                                        color: PdfColor.fromHex('D3C0B9'),
                                      )),
                                    ],
                                  ),
                                ),
                              ]
                            ],
                          ]);
                        }),
                      ),
                      pw.SizedBox(height: 20),
                    ],
                    if (resumeData.award != null) ...[
                      buildTitleWidget("AWARDS", const pw.IconData(0xea23),
                          font, PdfColor.fromHex('293F4E'), PdfColors.white),
                      pw.SizedBox(height: 10),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: List.generate(
                          resumeData.award!.awards.length,
                          (index) {
                            final award = resumeData.award!.awards[index];

                            return pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text("${award.award} ",
                                    style: pw.TextStyle(
                                        font: font, color: PdfColors.white)),
                                pw.Text("${award.issuer}",
                                    style: pw.TextStyle(
                                        font: fontRegular,
                                        color: PdfColors.white)),
                                pw.SizedBox(height: 20)
                              ],
                            );
                          },
                        ),
                      )
                    ],
                    if (resumeData.certificate != null) ...[
                      buildTitleWidget(
                          "CERTIFICATES",
                          const pw.IconData(0xea23),
                          font,
                          PdfColor.fromHex('293F4E'),
                          PdfColors.white),
                      pw.SizedBox(height: 10),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: List.generate(
                          resumeData.certificate!.certificates.length,
                          (index) {
                            final certificate =
                                resumeData.certificate!.certificates[index];

                            return pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text("${certificate.title} ",
                                    style: pw.TextStyle(
                                        font: font, color: PdfColors.white)),
                                pw.Text("${certificate.school}",
                                    style: pw.TextStyle(
                                        font: fontRegular,
                                        color: PdfColors.white)),
                                pw.SizedBox(height: 20)
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  ],
                ),
              ),
            ),
            pw.Partition(
              flex: 7,
              child: pw.Container(
                margin: const pw.EdgeInsets.all(20.0),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(height: 20),
                    if (resumeData.experience != null) ...[
                      buildTitleWidget(
                          "PROFESSIONAL EXPERIENCE",
                          const pw.IconData(0xeb3f),
                          font,
                          PdfColor.fromHex('EFEFEF'),
                          PdfColors.black),
                      pw.SizedBox(height: 10),
                      pw.Column(
                        children: List.generate(
                          resumeData.experience!.experiences.length,
                          (index) {
                            final experience =
                                resumeData.experience!.experiences[index];

                            return pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text("${experience.employer?.name}",
                                      style: pw.TextStyle(font: font)),
                                  pw.Text(experience.jobTitle,
                                      style: pw.TextStyle(
                                        font: fontRegular,
                                      )),
                                  pw.SizedBox(height: 5),
                                  if (experience.startDate != null &&
                                      experience.endDate != null &&
                                      !experience.isPresent) ...[
                                    pw.Row(
                                      children: [
                                        pw.Text(
                                          DateFormat("E yyyy")
                                              .format(experience.startDate!)
                                              .toUpperCase(),
                                          style: pw.TextStyle(
                                            font: fontRegular,
                                          ),
                                        ),
                                        pw.SizedBox(width: 5),
                                        pw.Text('-'),
                                        pw.SizedBox(width: 5),
                                        pw.Text(
                                          DateFormat("E yyyy")
                                              .format(experience.endDate!)
                                              .toUpperCase(),
                                          style: pw.TextStyle(
                                            font: fontRegular,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                  if (experience.startDate != null &&
                                      experience.isPresent) ...[
                                    pw.Row(
                                      children: [
                                        pw.Text(
                                          DateFormat("E yyyy")
                                              .format(experience.startDate!)
                                              .toUpperCase(),
                                          style: pw.TextStyle(
                                            font: fontRegular,
                                          ),
                                        ),
                                        pw.SizedBox(width: 5),
                                        pw.Text('-'),
                                        pw.SizedBox(width: 5),
                                        pw.Text('Present',
                                            style: pw.TextStyle(
                                              font: fontRegular,
                                            )),
                                      ],
                                    ),
                                  ],
                                  pw.SizedBox(height: 5),
                                  pw.Text(experience.description ?? "",
                                      style: pw.TextStyle(
                                        font: fontRegular,
                                      )),
                                  pw.SizedBox(height: 20),
                                ]);
                          },
                        ),
                      ),
                    ],
                    if (resumeData.education != null) ...[
                      buildTitleWidget("EDUCATION", const pw.IconData(0xe80c),
                          font, PdfColor.fromHex('EFEFEF'), PdfColors.black),
                      pw.SizedBox(height: 10),
                      pw.Column(
                        children: List.generate(
                          resumeData.education!.educations.length,
                          (index) {
                            final education =
                                resumeData.education!.educations[index];

                            return pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text("${education.degree} ",
                                    style: pw.TextStyle(font: font)),
                                pw.Text("${education.school}",
                                    style: pw.TextStyle(
                                      font: fontRegular,
                                    )),
                                pw.Row(
                                  children: [
                                    education.startDate != null
                                        ? pw.Text(
                                            DateFormat("yyyy")
                                                .format(education.startDate!)
                                                .toUpperCase(),
                                            style: pw.TextStyle(
                                              font: fontRegular,
                                            ),
                                          )
                                        : pw.SizedBox(),
                                    pw.SizedBox(width: 5),
                                    pw.Text(
                                        education.startDate != null ? '-' : ""),
                                    pw.SizedBox(width: 5),
                                    education.endDate != null
                                        ? pw.Text(
                                            "${DateFormat("yyyy").format(education.endDate!).toUpperCase()} | ${education.city}",
                                            style: pw.TextStyle(
                                              font: fontRegular,
                                            ),
                                          )
                                        : pw.SizedBox(),
                                  ],
                                ),
                                pw.SizedBox(height: 20)
                              ],
                            );
                          },
                        ),
                      )
                    ],
                    if (resumeData.skill != null) ...[
                      buildTitleWidget("SKILLS", const pw.IconData(0xea23),
                          font, PdfColor.fromHex('EFEFEF'), PdfColors.black),
                      pw.SizedBox(height: 10),
                      pw.Column(
                        children: List.generate(resumeData.skill!.skills.length,
                            (index) {
                          final skill = resumeData.skill!.skills[index];

                          return pw.Column(children: [
                            pw.Row(children: [
                              pw.ClipOval(
                                  child: pw.Container(
                                      width: 5,
                                      height: 5,
                                      color: PdfColors.black)),
                              pw.Padding(
                                padding: const pw.EdgeInsets.only(left: 5),
                                child: pw.Text(
                                  skill.skill,
                                  style: pw.TextStyle(
                                    font: fontRegular,
                                  ),
                                ),
                              ),
                            ]),
                            pw.SizedBox(height: 5),
                          ]);
                        }),
                      ),
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

Future<pw.PageTheme> _pageTheme(PdfPageFormat format) async {
  var regular = await PdfGoogleFonts.nunitoSansRegular();
  var italic = await PdfGoogleFonts.nunitoSansItalic();
  var bold = await PdfGoogleFonts.nunitoSansBold();
  var boldItalic = await PdfGoogleFonts.nunitoSansBoldItalic();

  return pw.PageTheme(
    margin: const pw.EdgeInsets.all(0),
    buildBackground: (pw.Context context) => pw.Row(children: [
      pw.Expanded(
        flex: 5,
        child: pw.Container(color: PdfColor.fromHex('1B3142')),
      ),
      pw.Expanded(
          flex: 7,
          child: pw.Container(
            color: PdfColors.white,
          ))
    ]),
    theme: pw.ThemeData.withFont(
      base: regular,
      italic: italic,
      bold: bold,
      boldItalic: boldItalic,
      icons: await PdfGoogleFonts.materialIcons(),
    ),
  );
}

pw.Widget buildTitleWidget(
  String title,
  pw.IconData iconData,
  pw.Font font,
  PdfColor backgroundColor,
  PdfColor textColor,
) {
  return pw.Container(
    color: backgroundColor,
    child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        mainAxisAlignment: pw.MainAxisAlignment.center,
        children: [
          pw.Icon(
            iconData,
            color: textColor,
            size: 20,
          ),
          pw.Container(
              padding: const pw.EdgeInsets.only(left: 8, top: 4, bottom: 4),
              child: pw.Text(
                title,
                textScaleFactor: 1.5,
                style: pw.TextStyle(font: font, color: textColor),
              ))
        ]),
  );
}

pw.Widget buildContactTemp(
  pw.Context context,
  String title,
  String value,
  int iconData,
  pw.Font fontRegular,
) {
  return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 8),
      child: pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Icon(
          pw.IconData(iconData),
          color: PdfColors.white,
          size: 18,
        ),
        pw.Flexible(
          child: pw.Padding(
            padding: const pw.EdgeInsets.only(left: 8),
            child: pw.Text(
              value,
              style: pw.TextStyle(font: fontRegular, color: PdfColors.white),
            ),
          ),
        )
      ]));
}
