import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:rabbit_converter/rabbit_converter.dart';

import 'package:sumeer/features/resume/feat_resume.dart';
import 'package:sumeer/shared/constants/asset_paths.dart';
import 'package:sumeer/utils/extensions/dart_extensions.dart';

Future<Uint8List> generateTemplate2(
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
  // final profileImage =
  //     (resumeData.profileImage != null && resumeData.profileImage!.isNotEmpty)
  //         ? await networkImage(resumeData.profileImage!)
  //         : null;
  final doc = pw.Document(
    title: params.title,
    author: params.author,
    creator: params.creator,
    subject: params.subject,
    keywords: params.keywords,
    producer: params.producer,
  );

  var regular =
      pw.Font.ttf(await rootBundle.load(AssetPaths.robotoslabRegular));
  var fall1 = await PdfGoogleFonts.notoSansThaiRegular();
  final font = await rootBundle.load('assets/fonts/Zawgyi-One_V3.1.ttf');
  final fall2 = pw.Font.ttf(font);
  final pageTheme = await _pageTheme(format);
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
                    pw.Text(
                        Rabbit.uni2zg(
                            resumeData.personalDetail?.fullName ?? ''),
                        textScaleFactor: 2,
                        style: pw.TextStyle(
                            color: PdfColors.white,
                            font: regular,
                            fontFallback: [fall1, fall2])),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      resumeData.personalDetail?.jobTitle ?? '',
                      textScaleFactor: 1.5,
                      style: pw.TextStyle(
                          color: PdfColors.white,
                          font: regular,
                          fontFallback: [fall1, fall2]),
                    ),
                    pw.SizedBox(height: 5),
                    if (profileImage != null)
                      pw.Container(
                        width: 130,
                        height: 130,
                        child: pw.ClipOval(
                          // child:
                          // pw.Image(resumeData.profileImage!,
                          //     width: 130, height: 130, fit: pw.BoxFit.cover),
                          // profileImage
                          child: pw.Image(profileImage, fit: pw.BoxFit.cover),
                        ),
                      ),
                    pw.SizedBox(height: 20),
                    buildContactTemp(
                      context,
                      'Email',
                      resumeData.personalDetail?.email ?? '',
                      0xe158,
                      pw.TextStyle(
                          color: PdfColors.white,
                          font: regular,
                          fontFallback: [fall1, fall2]),
                    ),
                    buildContactTemp(
                      context,
                      'Phone',
                      resumeData.personalDetail?.phone ?? '',
                      0xe0b0,
                      pw.TextStyle(
                          color: PdfColors.white,
                          font: regular,
                          fontFallback: [fall1, fall2]),
                    ),
                    buildContactTemp(
                      context,
                      'Address',
                      resumeData.personalDetail?.address ?? '',
                      0xe0c8,
                      pw.TextStyle(
                          color: PdfColors.white,
                          font: regular,
                          fontFallback: [fall1, fall2]),
                    ),
                    if (resumeData.personalDetail?.personalInfo?.dateOfBirth !=
                            null &&
                        resumeData.personalDetail!.personalInfo!.dateOfBirth!
                            .isNotEmpty) ...[
                      buildContactTemp(
                        context,
                        'Date of Birth',
                        resumeData.personalDetail?.personalInfo?.dateOfBirth ??
                            '',
                        0xe916,
                        pw.TextStyle(
                            color: PdfColors.white,
                            font: regular,
                            fontFallback: [fall1, fall2]),
                      )
                    ],
                    if (resumeData.personalDetail?.personalInfo?.gender !=
                            null &&
                        resumeData.personalDetail!.personalInfo!.gender!
                            .isNotEmpty) ...[
                      buildContactTemp(
                        context,
                        'Gender',
                        resumeData.personalDetail?.personalInfo?.gender ?? '',
                        0xe4eb,
                        pw.TextStyle(
                            color: PdfColors.white,
                            font: regular,
                            fontFallback: [fall1, fall2]),
                      )
                    ],
                    if (resumeData.personalDetail?.personalInfo?.nationality !=
                            null &&
                        resumeData.personalDetail!.personalInfo!.nationality!
                            .isNotEmpty) ...[
                      buildContactTemp(
                        context,
                        'Nationality',
                        resumeData.personalDetail?.personalInfo?.nationality ??
                            '',
                        0xe569,
                        pw.TextStyle(
                            color: PdfColors.white,
                            font: regular,
                            fontFallback: [fall1, fall2]),
                      )
                    ],
                    if (resumeData.personalDetail?.personalInfo?.identityNo !=
                            null &&
                        resumeData.personalDetail!.personalInfo!.identityNo!
                            .isNotEmpty) ...[
                      buildContactTemp(
                        context,
                        'Identity',
                        resumeData.personalDetail?.personalInfo?.identityNo ??
                            '',
                        0xe069,
                        pw.TextStyle(
                            color: PdfColors.white,
                            font: regular,
                            fontFallback: [fall1, fall2]),
                      )
                    ],
                    if (resumeData
                                .personalDetail?.personalInfo?.martialStatus !=
                            null &&
                        resumeData.personalDetail!.personalInfo!.martialStatus!
                            .isNotEmpty) ...[
                      buildContactTemp(
                        context,
                        'Martial Status',
                        resumeData
                                .personalDetail?.personalInfo?.martialStatus ??
                            '',
                        0xf1a2,
                        pw.TextStyle(
                            color: PdfColors.white,
                            font: regular,
                            fontFallback: [fall1, fall2]),
                      )
                    ],
                    if (resumeData.personalDetail?.links != null) ...[
                      for (int i = 0;
                          i < resumeData.personalDetail!.links.length;
                          i++) ...[
                        if (resumeData.personalDetail!.links[i].url.isNotEmpty)
                          buildContactTemp(
                            context,
                            resumeData.personalDetail!.links[i].name,
                            resumeData.personalDetail!.links[i].url,
                            0xe569,
                            pw.TextStyle(
                                color: PdfColors.white,
                                font: regular,
                                fontFallback: [fall1, fall2]),
                          )
                      ]
                    ],
                    pw.SizedBox(height: 20),
                    if (resumeData.profile != null &&
                        resumeData.profile?.contents != null &&
                        resumeData.profile!.contents.isNotEmpty) ...[
                      buildTitleWidget('PROFILE', const pw.IconData(0xea67),
                          PdfColor.fromHex('293F4E'), PdfColors.white),
                      pw.SizedBox(height: 10),
                      pw.Container(
                        height: 85,
                        child: pw.Text(
                          resumeData.profile!.contents[0],
                          style: pw.TextStyle(
                              color: PdfColors.white,
                              font: regular,
                              fontFallback: [fall1, fall2]),
                        ),
                      ),
                      pw.SizedBox(height: 30),
                    ],
                    if (resumeData.languages != null) ...[
                      buildTitleWidget('LANGUAGES', const pw.IconData(0xe894),
                          PdfColor.fromHex('293F4E'), PdfColors.white),
                      pw.SizedBox(height: 10),
                      pw.Column(
                        children: List.generate(
                            resumeData.languages!.languages.length, (index) {
                          final language =
                              resumeData.languages!.languages[index];

                          return pw.Row(children: [
                            pw.Expanded(
                              child: pw.Text(
                                language.title ?? '',
                                style: pw.Theme.of(context)
                                    .defaultTextStyle
                                    .copyWith(
                                      color: PdfColors.white,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                              ),
                            ),
                            if (language.level != null) ...[
                              if (language.level ==
                                  LanguageLevelEnum.beginner) ...[
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
                                  LanguageLevelEnum.elementary) ...[
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
                                  LanguageLevelEnum.limitedWorking) ...[
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
                                  LanguageLevelEnum.highlyProficient) ...[
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
                      buildTitleWidget('AWARDS', const pw.IconData(0xea23),
                          PdfColor.fromHex('293F4E'), PdfColors.white),
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
                                pw.Text('${award.award} ',
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        font: regular,
                                        fontFallback: [fall1, fall2])),
                                pw.Text('${award.issuer}',
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        font: regular,
                                        fontFallback: [fall1, fall2])),
                                pw.SizedBox(height: 20)
                              ],
                            );
                          },
                        ),
                      )
                    ],
                    if (resumeData.certificate != null) ...[
                      buildTitleWidget(
                          'CERTIFICATES',
                          const pw.IconData(0xea23),
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
                                pw.Text('${certificate.title} ',
                                    style: const pw.TextStyle(
                                        color: PdfColors.white)),
                                pw.Text('${certificate.school}',
                                    style: const pw.TextStyle(
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
                          'PROFESSIONAL EXPERIENCE',
                          const pw.IconData(0xeb3f),
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
                                  pw.Text(experience.employer?.name ?? '',
                                      style: pw.TextStyle(
                                          font: regular,
                                          fontFallback: [fall1, fall2])),
                                  pw.Text(experience.jobTitle,
                                      style: pw.TextStyle(
                                          font: regular,
                                          fontFallback: [fall1, fall2])),
                                  pw.SizedBox(height: 5),
                                  if (experience.startDate != null &&
                                      experience.endDate != null &&
                                      !experience.isPresent) ...[
                                    pw.Row(
                                      children: [
                                        pw.Text(
                                          DateFormat('MMMM yyyy')
                                              .format(experience.startDate!)
                                              .toUpperCase(),
                                          style: pw.TextStyle(
                                              font: regular,
                                              fontFallback: [fall1, fall2]),
                                        ),
                                        pw.SizedBox(width: 5),
                                        pw.Text('-'),
                                        pw.SizedBox(width: 5),
                                        pw.Text(
                                          DateFormat('MMMM yyyy')
                                              .format(experience.endDate!)
                                              .toUpperCase(),
                                          style: pw.TextStyle(
                                              font: regular,
                                              fontFallback: [fall1, fall2]),
                                        ),
                                      ],
                                    ),
                                  ],
                                  if (experience.startDate != null &&
                                      experience.isPresent) ...[
                                    pw.Row(
                                      children: [
                                        pw.Text(
                                          DateFormat('MMMM yyyy')
                                              .format(experience.startDate!)
                                              .toUpperCase(),
                                          style: const pw.TextStyle(),
                                        ),
                                        pw.SizedBox(width: 5),
                                        pw.Text('-'),
                                        pw.SizedBox(width: 5),
                                        pw.Text('Present',
                                            style: const pw.TextStyle()),
                                      ],
                                    ),
                                  ],
                                  pw.SizedBox(height: 5),
                                  pw.Text(experience.description ?? '',
                                      style: const pw.TextStyle()),
                                  pw.SizedBox(height: 20),
                                ]);
                          },
                        ),
                      ),
                    ],
                    if (resumeData.education != null) ...[
                      buildTitleWidget('EDUCATION', const pw.IconData(0xe80c),
                          PdfColor.fromHex('EFEFEF'), PdfColors.black),
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
                                pw.Text(education.degree ?? '',
                                    style: pw.TextStyle(
                                        font: regular,
                                        fontFallback: [fall1, fall2])),
                                pw.Text(education.school ?? '',
                                    style: pw.TextStyle(
                                        font: regular,
                                        fontFallback: [fall1, fall2])),
                                pw.Row(
                                  children: [
                                    education.startDate != null
                                        ? pw.Text(
                                            DateFormat('yyyy')
                                                .format(education.startDate!)
                                                .toUpperCase(),
                                            style: pw.TextStyle(
                                                font: regular,
                                                fontFallback: [fall1, fall2]),
                                          )
                                        : pw.SizedBox(),
                                    pw.SizedBox(width: 5),
                                    pw.Text(
                                        education.startDate != null ? '-' : ''),
                                    pw.SizedBox(width: 5),
                                    education.endDate != null
                                        ? pw.Text(
                                            "${DateFormat("yyyy").format(education.endDate!).toUpperCase()} | ${education.city ?? ""}",
                                            style: pw.TextStyle(
                                                font: regular,
                                                fontFallback: [fall1, fall2]),
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
                      buildTitleWidget('SKILLS', const pw.IconData(0xea4a),
                          PdfColor.fromHex('EFEFEF'), PdfColors.black),
                      pw.SizedBox(height: 10),
                      pw.Column(
                        children: List.generate(resumeData.skill!.skills.length,
                            (index) {
                          final skill = resumeData.skill!.skills[index];

                          return pw.Column(children: [
                            pw.Row(
                              children: [
                                pw.ClipOval(
                                    child: pw.Container(
                                        width: 5,
                                        height: 5,
                                        color: PdfColors.black)),
                                pw.Expanded(
                                  child: pw.Padding(
                                    padding: const pw.EdgeInsets.only(left: 5),
                                    child: pw.Text(
                                      skill.name,
                                      style: const pw.TextStyle(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
  var regular = await rootBundle.load(AssetPaths.robotoslabRegular);
  var bold = await rootBundle.load(AssetPaths.robotoslabBold);
  var fall1 = await PdfGoogleFonts.notoSansThaiRegular();
  var fall2 = await PdfGoogleFonts.notoSansMyanmarRegular();

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
      base: pw.Font.ttf(regular),
      bold: pw.Font.ttf(bold),
      fontFallback: [fall1, fall2],
      icons: await PdfGoogleFonts.materialIcons(),
    ),
  );
}

pw.Widget buildTitleWidget(
  String title,
  pw.IconData iconData,
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
                style: pw.TextStyle(color: textColor),
              ))
        ]),
  );
}

pw.Widget buildContactTemp(pw.Context context, String title, String value,
    int iconData, pw.TextStyle textSyle) {
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
              style: textSyle,
            ),
          ),
        )
      ]));
}
