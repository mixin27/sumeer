import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:sumeer/features/resume/feat_resume.dart';

Future<Uint8List> generateTemplate3(
  PdfPageFormat format,
  GenerateDocParams params,
  ResumeData resumeData,
) async {
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
  var nameFont = await PdfGoogleFonts.caveatSemiBold();
  var regular = await PdfGoogleFonts.nunitoSansRegular();
  var fall1 = await PdfGoogleFonts.notoSansThaiRegular();
  final font = await rootBundle.load("assets/fonts/Zawgyi-One_V3.1.ttf");
  final fall2 = pw.Font.ttf(font);
  doc.addPage(
    pw.MultiPage(
      pageTheme: pageTheme,
      build: (pw.Context context) {
        return [
          pw.Container(
            margin: const pw.EdgeInsets.all(30),
            child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(children: [
                    pw.Expanded(
                      child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(resumeData.personalDetail?.fullName ?? "",
                                textScaleFactor: 2.3,
                                style: pw.TextStyle(font: nameFont)),
                            pw.SizedBox(height: 5),
                            pw.Text(
                              resumeData.personalDetail?.jobTitle ?? "",
                              textScaleFactor: 1.8,
                              style: pw.Theme.of(context)
                                  .defaultTextStyle
                                  .copyWith(fontStyle: pw.FontStyle.italic),
                              // style: pw.TextStyle(font: nameFont),
                            ),
                            pw.SizedBox(height: 5),
                            buildContactTemp1(
                              context,
                              "Email",
                              resumeData.personalDetail?.email ?? "",
                              0xe158,
                              pw.TextStyle(
                                  font: regular, fontFallback: [fall1, fall2]),
                            ),
                            buildContactTemp1(
                              context,
                              "Phone",
                              resumeData.personalDetail?.phone ?? "",
                              0xe0b0,
                              pw.TextStyle(
                                  font: regular, fontFallback: [fall1, fall2]),
                            ),
                            buildContactTemp1(
                              context,
                              "Address",
                              resumeData.personalDetail?.address ?? "",
                              0xe0c8,
                              pw.TextStyle(
                                  font: regular, fontFallback: [fall1, fall2]),
                            ),
                            if (resumeData.personalDetail?.personalInfo
                                        ?.dateOfBirth !=
                                    null &&
                                resumeData.personalDetail!.personalInfo!
                                    .dateOfBirth!.isNotEmpty) ...[
                              buildContactTemp1(
                                context,
                                "Date of Birth",
                                resumeData.personalDetail?.personalInfo
                                        ?.dateOfBirth ??
                                    "",
                                0xe916,
                                pw.TextStyle(
                                    font: regular,
                                    fontFallback: [fall1, fall2]),
                              )
                            ],
                            if (resumeData
                                        .personalDetail?.personalInfo?.gender !=
                                    null &&
                                resumeData.personalDetail!.personalInfo!.gender!
                                    .isNotEmpty) ...[
                              buildContactTemp1(
                                context,
                                "Gender",
                                resumeData
                                        .personalDetail?.personalInfo?.gender ??
                                    "",
                                0xe4eb,
                                pw.TextStyle(
                                    font: regular,
                                    fontFallback: [fall1, fall2]),
                              )
                            ],
                            if (resumeData.personalDetail?.personalInfo
                                        ?.nationality !=
                                    null &&
                                resumeData.personalDetail!.personalInfo!
                                    .nationality!.isNotEmpty) ...[
                              buildContactTemp1(
                                context,
                                "Nationality",
                                resumeData.personalDetail?.personalInfo
                                        ?.nationality ??
                                    "",
                                0xe569,
                                pw.TextStyle(
                                    font: regular,
                                    fontFallback: [fall1, fall2]),
                              )
                            ],
                            if (resumeData.personalDetail?.personalInfo
                                        ?.identityNo !=
                                    null &&
                                resumeData.personalDetail!.personalInfo!
                                    .identityNo!.isNotEmpty) ...[
                              buildContactTemp1(
                                context,
                                "Identity",
                                resumeData.personalDetail?.personalInfo
                                        ?.identityNo ??
                                    "",
                                0xe069,
                                pw.TextStyle(
                                    font: regular,
                                    fontFallback: [fall1, fall2]),
                              )
                            ],
                            if (resumeData.personalDetail?.personalInfo
                                        ?.martialStatus !=
                                    null &&
                                resumeData.personalDetail!.personalInfo!
                                    .martialStatus!.isNotEmpty) ...[
                              buildContactTemp1(
                                context,
                                "Martial Status",
                                resumeData.personalDetail?.personalInfo
                                        ?.martialStatus ??
                                    "",
                                0xf1a2,
                                pw.TextStyle(
                                    font: regular,
                                    fontFallback: [fall1, fall2]),
                              )
                            ],
                            if (resumeData.personalDetail?.links != null) ...[
                              for (int i = 0;
                                  i < resumeData.personalDetail!.links.length;
                                  i++) ...[
                                if (resumeData
                                    .personalDetail!.links[i].url.isNotEmpty)
                                  buildContactTemp1(
                                    context,
                                    resumeData.personalDetail!.links[i].name,
                                    resumeData.personalDetail!.links[i].url,
                                    0xe569,
                                    pw.TextStyle(
                                        font: regular,
                                        fontFallback: [fall1, fall2]),
                                  )
                              ]
                            ],
                          ]),
                    ),
                    if (profileImage != null)
                      pw.Expanded(
                        child: pw.Container(
                          width: 130,
                          height: 130,
                          alignment: pw.Alignment.centerRight,
                          child: pw.ClipOval(
                            // child:
                            // pw.Image(resumeData.profileImage!,
                            //     width: 130, height: 130, fit: pw.BoxFit.cover),
                            // profileImage
                            child: pw.Image(profileImage,
                                width: 130, height: 130, fit: pw.BoxFit.cover),
                          ),
                        ),
                      ),
                  ]),
                  pw.SizedBox(height: 20),
                  if (resumeData.profile != null &&
                      resumeData.profile?.contents != null &&
                      resumeData.profile!.contents.isNotEmpty) ...[
                    _buildTitleWidget("PROFILE", context),
                    pw.SizedBox(height: 10),
                    pw.Container(
                      height: 85,
                      child: pw.Text(
                        resumeData.profile!.contents[0],
                      ),
                    ),
                    pw.SizedBox(height: 10),
                  ],
                  if (resumeData.experience != null) ...[
                    _buildTitleWidget("PROFESSIONAL EXPERIENCE", context),
                    pw.SizedBox(height: 10),
                    pw.Column(
                      children: List.generate(
                        resumeData.experience!.experiences.length,
                        (index) {
                          final experience =
                              resumeData.experience!.experiences[index];

                          return pw.Column(children: [
                            pw.Row(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Expanded(
                                    flex: 3,
                                    child: pw.Column(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          if (experience.startDate != null &&
                                              experience.endDate != null &&
                                              !experience.isPresent) ...[
                                            pw.Text(
                                                "${DateFormat("MMMM yyyy").format(experience.startDate!)} - ${DateFormat("MMMM yyyy").format(experience.endDate!)}"),
                                          ],
                                          if (experience.startDate != null &&
                                              experience.isPresent) ...[
                                            pw.Text(
                                                "${DateFormat("MMMM yyyy").format(experience.startDate!)} - Present"),
                                          ],
                                          pw.Text(
                                            "${experience.city}, ${experience.country}",
                                          ),
                                        ]),
                                  ),
                                  pw.Expanded(
                                      flex: 8,
                                      child: pw.Column(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.RichText(
                                            text: pw.TextSpan(
                                              children: [
                                                pw.TextSpan(
                                                  text:
                                                      "${experience.employer?.name}, ",
                                                  style: pw.Theme.of(context)
                                                      .defaultTextStyle
                                                      .copyWith(
                                                          fontWeight: pw
                                                              .FontWeight.bold),
                                                ),
                                                pw.TextSpan(
                                                  text: experience.jobTitle,
                                                ),
                                              ],
                                            ),
                                          ),
                                          pw.Text(
                                            experience.description ?? "",
                                          ),
                                        ],
                                      )),
                                ]),
                            pw.SizedBox(height: 10)
                          ]);
                        },
                      ),
                    ),
                    pw.SizedBox(height: 20),
                  ],
                  if (resumeData.education != null) ...[
                    _buildTitleWidget("EDUCATION", context),
                    pw.SizedBox(height: 10),
                    pw.Column(
                      children: List.generate(
                        resumeData.education!.educations.length,
                        (index) {
                          final education =
                              resumeData.education!.educations[index];

                          return pw.Column(children: [
                            pw.Row(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Expanded(
                                    flex: 3,
                                    child: pw.Column(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          if (education.startDate != null &&
                                              education.endDate != null &&
                                              !education.isPresent) ...[
                                            pw.Text(
                                                "${DateFormat("MMMM yyyy").format(education.startDate!)} - ${DateFormat("MMMM yyyy").format(education.endDate!)}"),
                                          ],
                                          if (education.startDate != null &&
                                              education.isPresent) ...[
                                            pw.Text(
                                                "${DateFormat("MMMM yyyy").format(education.startDate!)} - Present"),
                                          ],
                                        ]),
                                  ),
                                  pw.Expanded(
                                    flex: 8,
                                    child: pw.RichText(
                                      text: pw.TextSpan(
                                        children: [
                                          pw.TextSpan(
                                            text: "${education.school}, ",
                                            style: pw.Theme.of(context)
                                                .defaultTextStyle
                                                .copyWith(
                                                    fontWeight:
                                                        pw.FontWeight.bold),
                                          ),
                                          pw.TextSpan(
                                            text: education.degree,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                            pw.SizedBox(height: 10)
                          ]);
                        },
                      ),
                    ),
                    pw.SizedBox(height: 20),
                  ],
                  if (resumeData.languages != null) ...[
                    _buildTitleWidget("LANGUAGES", context),
                    pw.SizedBox(height: 10),
                    pw.Row(
                      children: List.generate(
                        resumeData.languages!.languages.length,
                        (index) {
                          final language =
                              resumeData.languages!.languages[index];
                          return pw.Container(
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(width: 1),
                                  borderRadius: const pw.BorderRadius.all(
                                      pw.Radius.circular(2))),
                              padding: const pw.EdgeInsets.all(4),
                              margin: const pw.EdgeInsets.only(right: 8),
                              child: pw.Text("${language.title}"));
                        },
                      ),
                    ),
                    pw.SizedBox(height: 20),
                  ],
                  if (resumeData.skill != null) ...[
                    _buildTitleWidget("SKILLS", context),
                    pw.SizedBox(height: 10),
                    pw.Wrap(
                      children: List.generate(
                        resumeData.skill!.skills.length,
                        (index) {
                          final skill = resumeData.skill!.skills[index];
                          return pw.Wrap(children: [
                            pw.Text(skill.name),
                            if (resumeData.skill!.skills.last != skill) ...[
                              pw.Container(
                                width: 6,
                                height: 6,
                                margin: const pw.EdgeInsets.only(
                                    top: 5.5, left: 5, right: 5),
                                decoration: const pw.BoxDecoration(
                                    shape: pw.BoxShape.circle,
                                    color: PdfColors.black),
                              ),
                            ],
                            pw.SizedBox(width: 10)
                          ]);
                        },
                      ),
                    ),
                    pw.SizedBox(height: 10),
                  ],
                  if (resumeData.interest != null) ...[
                    _buildTitleWidget("INTERESTS", context),
                    pw.SizedBox(height: 10),
                    pw.Wrap(
                      children: List.generate(
                        resumeData.interest!.interests.length,
                        (index) {
                          final interest =
                              resumeData.interest!.interests[index];
                          return pw.Wrap(children: [
                            pw.Text(interest.title ?? ""),
                            if (resumeData.interest!.interests.last !=
                                interest) ...[
                              pw.Container(
                                width: 6,
                                height: 6,
                                margin: const pw.EdgeInsets.only(
                                    top: 5.5, left: 5, right: 5),
                                decoration: const pw.BoxDecoration(
                                    shape: pw.BoxShape.circle,
                                    color: PdfColors.black),
                              ),
                            ],
                            pw.SizedBox(width: 10)
                          ]);
                        },
                      ),
                    ),
                    pw.SizedBox(height: 20),
                  ],
                  if (resumeData.award != null) ...[
                    _buildTitleWidget("AWARDS", context),
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
                                pw.Text(
                                  award.award ?? "",
                                  style: pw.Theme.of(context)
                                      .defaultTextStyle
                                      .copyWith(fontWeight: pw.FontWeight.bold),
                                ),
                                pw.Text(award.issuer ?? ""),
                                pw.SizedBox(height: 10)
                              ]);
                        },
                      ),
                    ),
                    pw.SizedBox(height: 20),
                  ],
                  if (resumeData.certificate != null) ...[
                    _buildTitleWidget("CERTIFICATE", context),
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
                                pw.Text(
                                  certificate.title ?? "",
                                  style: pw.Theme.of(context)
                                      .defaultTextStyle
                                      .copyWith(fontWeight: pw.FontWeight.bold),
                                ),
                                pw.Text(certificate.school ?? ""),
                                pw.SizedBox(height: 10)
                              ]);
                        },
                      ),
                    ),
                    pw.SizedBox(height: 20),
                  ],
                ]),
          ),
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
    buildBackground: (pw.Context context) =>
        pw.Container(color: PdfColor.fromHex('E8E8E8')),
    theme: pw.ThemeData.withFont(
      base: regular,
      italic: italic,
      bold: bold,
      boldItalic: boldItalic,
      icons: await PdfGoogleFonts.materialIcons(),
    ),
  );
}

pw.Widget buildContactTemp1(pw.Context context, String title, String value,
    int iconData, pw.TextStyle textSyle) {
  return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 8),
      child: pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        pw.Icon(
          pw.IconData(iconData),
          size: 18,
        ),
        pw.Flexible(
          child: pw.Padding(
            padding: const pw.EdgeInsets.only(left: 8),
            child: pw.Text(
              value,
              style: textSyle,
            ),
          ),
        )
      ]));
}

pw.Widget _buildTitleWidget(
  String title,
  pw.Context context,
) {
  return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      mainAxisAlignment: pw.MainAxisAlignment.start,
      children: [
        pw.Container(
            child: pw.Text(
          title,
          textScaleFactor: 1.5,
          style: pw.Theme.of(context)
              .defaultTextStyle
              .copyWith(fontWeight: pw.FontWeight.bold),
        )),
        pw.Container(width: 40, height: 3, color: PdfColors.black)
      ]);
}
