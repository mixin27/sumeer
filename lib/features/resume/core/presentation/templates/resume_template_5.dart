import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import 'package:sumeer/features/resume/feat_resume.dart';

Future<Uint8List> generateTemplate5(
  PdfPageFormat format,
  GenerateDocParams params,
  ResumeData resumeData,
) async {
  // get network image
  final profileImage =
      (resumeData.profileImage != null && resumeData.profileImage!.isNotEmpty)
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

  PdfColor color = PdfColor.fromHex('DFB17F');

  final pageTheme = await _pageTheme(format, color);

  final font = await PdfGoogleFonts.sourceSerifProItalic();

  doc.addPage(
    pw.MultiPage(
      pageTheme: pageTheme,
      build: (pw.Context context) {
        return [
          pw.Partitions(
            children: [
              // Left Column
              pw.Partition(
                child: pw.Container(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      // info
                      _personalInfo(resumeData, context, font, profileImage),
                      pw.SizedBox(height: 8),

                      // Profile
                      if (resumeData.profile != null)
                        ..._personalProfile(resumeData, color, context),
                      pw.SizedBox(height: 8),

                      // Experience
                      if (resumeData.experience != null &&
                          resumeData.experience?.experiences != null) ...[
                        // if (resumeData.experience?.title != null)
                        SectionDesign5(
                          lineColor: color,
                          title: resumeData.experience?.title.toString() == ""
                              ? "Experience"
                              : resumeData.experience?.title.toString() ?? "",
                        ),
                        if (resumeData.experience!.experiences.isNotEmpty)
                          _experienceList(resumeData, context),
                      ],
                      pw.SizedBox(height: 8),

                      // Education
                      if (resumeData.education != null &&
                          resumeData.education?.educations != null) ...[
                        if (resumeData.education?.title != null)
                          SectionDesign5(
                            lineColor: color,
                            title: resumeData.education?.title.toString() == ""
                                ? "Education"
                                : resumeData.education?.title.toString() ?? "",
                          ),
                        if (resumeData.education!.educations.isNotEmpty)
                          _eduationList(resumeData, context),
                      ],
                      pw.SizedBox(height: 8),

                      // Skill
                      if (resumeData.skill?.skills != null) ...[
                        if (resumeData.skill?.title != null)
                          SectionDesign5(
                            lineColor: color,
                            title: resumeData.skill?.title.toString() == ""
                                ? "Skill"
                                : resumeData.skill?.title.toString() ?? "",
                          ),
                        if (resumeData.skill!.skills.isNotEmpty)
                          _skillList(resumeData, context, color),
                      ],
                      pw.SizedBox(height: 8),

                      // Language
                      if (resumeData.languages != null) ...[
                        if (resumeData.languages?.title != null)
                          SectionDesign5(
                            lineColor: color,
                            title: resumeData.languages?.title.toString() == ""
                                ? "Languages"
                                : resumeData.languages?.title.toString() ?? "",
                          ),
                        if (resumeData.languages!.languages.isNotEmpty)
                          _languageList(resumeData, context, color),
                      ],
                      pw.SizedBox(height: 8),

                      // Language
                      if (resumeData.certificate != null) ...[
                        if (resumeData.certificate?.title != null)
                          SectionDesign5(
                              lineColor: color,
                              title: resumeData.certificate?.title ?? ''),
                        if (resumeData.certificate!.certificates.isNotEmpty)
                          _certificateList(resumeData, context),
                      ],
                      pw.SizedBox(height: 8),

                      // interest
                      if (resumeData.interest != null) ...[
                        if (resumeData.interest?.title != null)
                          SectionDesign5(
                              lineColor: color,
                              title: resumeData.interest?.title ?? ''),
                        if (resumeData.interest!.interests.isNotEmpty)
                          _interestList(resumeData, context),
                      ],
                    ],
                  ),
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

List<pw.Widget> _personalProfile(
    ResumeData resumeData, PdfColor color, pw.Context context) {
  return [
    if (resumeData.profile?.title != null)
      SectionDesign5(lineColor: color, title: resumeData.profile?.title ?? ''),
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
              style:
                  pw.Theme.of(context).defaultTextStyle.copyWith(fontSize: 6),
            ),
          ),
        ),
      )
  ];
}

pw.Row _personalInfo(ResumeData resumeData, pw.Context context, pw.Font font,
    ImageProvider? profileImage) {
  return pw.Row(
      // mainAxisAlignment: pw.MainAxisAlignment.end,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 6,
          child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // name & position
                pw.Container(
                  child: pw.RichText(
                    text: pw.TextSpan(
                      // baseline: -0.9,
                      children: [
                        if (resumeData.personalDetail?.fullName != null)
                          pw.TextSpan(
                            text: resumeData.personalDetail?.fullName ?? '',
                            style:
                                pw.Theme.of(context).defaultTextStyle.copyWith(
                                      fontSize: 20,
                                      // font: font,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                          ),
                        const pw.TextSpan(text: "  "),
                        if (resumeData.personalDetail?.jobTitle != null)
                          pw.TextSpan(
                            text: resumeData.personalDetail?.jobTitle ?? '',
                            style: pw.TextStyle(
                              font: font,
                              fontSize: 15,
                              fontStyle: pw.FontStyle.italic,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                pw.Wrap(children: [
                  if (resumeData.personalDetail?.address != null)
                    _personalDetialItem(context, 0xe56a,
                        resumeData.personalDetail?.address ?? ''),
                  if (resumeData.personalDetail?.email != null)
                    _personalDetialItem(context, 0xe158,
                        resumeData.personalDetail?.email ?? ''),
                  if (resumeData.personalDetail?.phone != null)
                    _personalDetialItem(context, 0xe0b0,
                        resumeData.personalDetail?.phone ?? ''),
                  //
                  if (resumeData.personalDetail?.personalInfo != null)
                    if (resumeData.personalDetail?.personalInfo?.dateOfBirth
                            .toString() !=
                        "")
                      _personalDetialItem(
                          context,
                          0xe7e9,
                          resumeData
                                  .personalDetail?.personalInfo?.dateOfBirth ??
                              ''),
                  if (resumeData.personalDetail?.personalInfo?.drivingLicense !=
                          null &&
                      resumeData.personalDetail?.personalInfo?.drivingLicense
                              .toString() !=
                          '')
                    _personalDetialItem(
                        context,
                        0xe531,
                        resumeData
                                .personalDetail?.personalInfo?.drivingLicense ??
                            ''),
                  if (resumeData.personalDetail?.personalInfo?.gender != null &&
                      resumeData.personalDetail?.personalInfo?.gender
                              .toString() !=
                          "")
                    _personalDetialItem(context, 0xe63d,
                        resumeData.personalDetail?.personalInfo?.gender ?? ''),
                  if (resumeData.personalDetail?.personalInfo?.identityNo !=
                          null &&
                      resumeData.personalDetail?.personalInfo?.identityNo
                              .toString() !=
                          "")
                    _personalDetialItem(
                        context,
                        0xea67,
                        resumeData.personalDetail?.personalInfo?.identityNo ??
                            ''),
                  if (resumeData.personalDetail?.personalInfo?.martialStatus !=
                          null &&
                      resumeData.personalDetail?.personalInfo?.martialStatus
                              .toString() !=
                          "")
                    _personalDetialItem(
                        context,
                        0xefdf,
                        resumeData
                                .personalDetail?.personalInfo?.martialStatus ??
                            ''),
                  if (resumeData.personalDetail?.personalInfo?.nationality !=
                          null &&
                      resumeData.personalDetail?.personalInfo?.nationality
                              .toString() !=
                          "")
                    _personalDetialItem(
                        context,
                        0xe153,
                        resumeData.personalDetail?.personalInfo?.nationality ??
                            ''),
                  if (resumeData
                              .personalDetail?.personalInfo?.militaryService !=
                          null &&
                      resumeData.personalDetail?.personalInfo?.militaryService
                              .toString() !=
                          "")
                    _personalDetialItem(
                        context,
                        0xea3f,
                        resumeData.personalDetail?.personalInfo
                                ?.militaryService ??
                            ''),
                  //
                  if (resumeData.personalDetail!.links.isNotEmpty) ...[
                    if (resumeData.personalDetail!.links[0].url.toString() !=
                        "")
                      _personalDetialItem(context, 0xe157,
                          resumeData.personalDetail!.links[0].url),
                    if (resumeData.personalDetail!.links[1].url.toString() !=
                        "")
                      _personalDetialItem(context, 0xe157,
                          resumeData.personalDetail!.links[1].url),
                    if (resumeData.personalDetail!.links[2].url.toString() !=
                        "")
                      _personalDetialItem(context, 0xe157,
                          resumeData.personalDetail!.links[2].url),
                    if (resumeData.personalDetail!.links[3].url.toString() !=
                        "")
                      _personalDetialItem(context, 0xe157,
                          resumeData.personalDetail!.links[3].url),
                  ]

                  // if (resumeData.personalDetail != null &&
                  //     resumeData.personalDetail!.links.isNotEmpty)
                  //   ...
                  //   List.generate(
                  //     resumeData.personalDetail!.links.length,
                  //     (index) => _personalDetialItem(context, 0xe157,
                  //         resumeData.personalDetail!.links[index].url),
                  //   )
                ]),
              ]),
        ),
        if (profileImage != null)
          pw.Expanded(
            flex: 2,
            child: pw.Container(
              width: 130,
              height: 120,
              child: pw.ClipOval(
                child: pw.Image(profileImage, fit: pw.BoxFit.cover),
              ),
            ),
          )
      ]);
}

pw.Padding _personalDetialItem(pw.Context context, int codePoint, String text) {
  return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 3),
      child: pw.Wrap(
        children: [
          pw.Icon(
            pw.IconData(codePoint),
            color: PdfColor.fromHex('DFB17F'),
            size: 20,
          ),
          pw.SizedBox(width: 4),
          pw.Text(
            text,
            // resumeData.personalDetail?.address ?? '',
            textScaleFactor: 1.2,
            style: pw.Theme.of(context).defaultTextStyle,
          ),
          pw.SizedBox(width: 6),
        ],
      ));
}

pw.Column _experienceList(ResumeData resumeData, pw.Context context) {
  return pw.Column(
    children: List.generate(
      resumeData.experience!.experiences.length,
      (index) => pw.Padding(
        padding: const pw.EdgeInsets.only(top: 6),
        child: pw.Column(
          children: [
            // jobTitle
            pw.Row(
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
                if (resumeData.experience!.experiences[index].endDate != null ||
                    resumeData.experience!.experiences[index].isPresent) ...[
                  pw.Text(
                    " -- ",
                    textScaleFactor: 2,
                    textAlign: pw.TextAlign.justify,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontSize: 6),
                  ),
                  pw.Text(
                    resumeData.experience!.experiences[index].isPresent
                        ? "Present"
                        : resumeData.experience!.experiences[index].endDate
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
              children: [
                if (resumeData.experience!.experiences[index].employer !=
                    null) ...[
                  pw.Transform.rotate(
                    angle: 65,
                    child: pw.Icon(
                      const pw.IconData(0xe061),
                      color: PdfColor.fromHex('606060'),
                      size: 10,
                    ),
                  ),
                  pw.SizedBox(width: 4),
                  pw.Text(
                    resumeData.experience!.experiences[index].employer?.name ??
                        '',
                    textScaleFactor: 2,
                    textAlign: pw.TextAlign.justify,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontSize: 6),
                  )
                ],
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
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Transform.rotate(
                    angle: 65,
                    child: pw.Icon(
                      const pw.IconData(0xe061),
                      color: PdfColor.fromHex('606060'),
                      size: 10,
                    ),
                  ),
                  pw.SizedBox(width: 4),
                  pw.Expanded(
                      child: pw.Text(
                    resumeData.experience!.experiences[index].description ?? '',
                    textScaleFactor: 2,
                    maxLines: 3,
                    // textAlign: pw.TextAlign.justify,
                    style: const pw.TextStyle(fontSize: 6),
                  )),
                ],
              )
          ],
        ),
      ),
    ),
  );
}

pw.Column _eduationList(ResumeData resumeData, pw.Context context) {
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
                if (resumeData.education!.educations[index].endDate != null ||
                    resumeData.education!.educations[index].isPresent) ...[
                  pw.Text(
                    " -- ",
                    textScaleFactor: 2,
                    textAlign: pw.TextAlign.justify,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontSize: 6),
                  ),
                  pw.Text(
                    resumeData.education!.educations[index].isPresent
                        ? "Present"
                        : resumeData.education!.educations[index].endDate
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
            // School
            pw.Row(
              // mainAxisAlignment:
              //     pw.MainAxisAlignment.spaceBetween,
              children: [
                if (resumeData.education!.educations[index].school != null) ...[
                  pw.Transform.rotate(
                    angle: 65,
                    child: pw.Icon(
                      const pw.IconData(0xe061),
                      color: PdfColor.fromHex('606060'),
                      size: 10,
                    ),
                  ),
                  pw.SizedBox(width: 4),
                  pw.Text(
                    resumeData.education!.educations[index].school ?? '',
                    textScaleFactor: 2,
                    textAlign: pw.TextAlign.justify,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontSize: 6),
                  )
                ],
                // pw.Expanded(
                //     child: pw.Text(
                //   resumeData.education!.educations[index].school ?? '',
                //   textScaleFactor: 2,
                //   textAlign: pw.TextAlign.justify,
                //   style: pw.Theme.of(context)
                //       .defaultTextStyle
                //       .copyWith(fontSize: 6),
                // )),
                if (resumeData.education!.educations[index].country != null)
                  pw.Text(
                    resumeData.education!.educations[index].country ?? '',
                    textScaleFactor: 2,
                    textAlign: pw.TextAlign.justify,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontSize: 6),
                  ),
                if (resumeData.education!.educations[index].city != null) ...[
                  pw.Text(
                    ", ",
                    textScaleFactor: 2,
                    textAlign: pw.TextAlign.justify,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontSize: 6),
                  ),
                  pw.Text(
                    resumeData.education!.educations[index].city ?? '',
                    textScaleFactor: 2,
                    textAlign: pw.TextAlign.justify,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontSize: 6),
                  ),
                ]
              ],
            ),
            if (resumeData.education!.educations[index].description != null)
              pw.Row(
                children: [
                  pw.Transform.rotate(
                    angle: 65,
                    child: pw.Icon(
                      const pw.IconData(0xe061),
                      color: PdfColor.fromHex('606060'),
                      size: 10,
                    ),
                  ),
                  pw.SizedBox(width: 4),
                  pw.Expanded(
                    child: pw.Text(
                      resumeData.education!.educations[index].description ?? '',
                      textScaleFactor: 2,
                      textAlign: pw.TextAlign.justify,
                      style: pw.Theme.of(context)
                          .defaultTextStyle
                          .copyWith(fontSize: 6),
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    ),
  );
}

pw.Column _skillList(
    ResumeData resumeData, pw.Context context, PdfColor color) {
  return pw.Column(
    children: List.generate(
      resumeData.skill!.skills.length,
      (index) => pw.Padding(
        padding: const pw.EdgeInsets.only(top: 6),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // degree
            pw.Row(
              // mainAxisAlignment:
              //     pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Expanded(
                  child: pw.Text(
                    resumeData.skill!.skills[index].name,
                    textScaleFactor: 2,
                    textAlign: pw.TextAlign.justify,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontSize: 6, fontWeight: pw.FontWeight.bold),
                  ),
                ),
                if (resumeData.skill!.skills[index].percentage != null) ...[
                  pw.Text(
                    "${(resumeData.skill!.skills[index].percentage! * 100).toStringAsFixed(0)} %",
                    textScaleFactor: 2,
                    textAlign: pw.TextAlign.left,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontSize: 6),
                  ),
                  pw.SizedBox(width: 8),
                  pw.SizedBox(
                    width: 100,
                    child: pw.LinearProgressIndicator(
                      value: resumeData.skill!.skills[index].percentage ?? 0.0,
                      minHeight: 6,
                      backgroundColor: PdfColor.fromHex('999999'),
                      valueColor: color,
                    ),
                  ),
                ]
              ],
            ),
            if (resumeData.skill!.skills[index].level != null)
              pw.Row(children: [
                pw.Transform.rotate(
                  angle: 65,
                  child: pw.Icon(
                    const pw.IconData(0xe061),
                    color: PdfColor.fromHex('606060'),
                    size: 10,
                  ),
                ),
                pw.SizedBox(width: 4),
                pw.Text(
                  "Level : ${resumeData.skill!.skills[index].level.toString().split(".")[1].toUpperCase()}",
                  textScaleFactor: 2,
                  textAlign: pw.TextAlign.justify,
                  style: pw.Theme.of(context)
                      .defaultTextStyle
                      .copyWith(fontSize: 6),
                ),
              ]),
            if (resumeData.skill!.skills[index].information != null &&
                resumeData.skill!.skills[index].information != "")
              pw.Text(
                "Information : ${resumeData.skill!.skills[index].information!}",
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

pw.Column _languageList(
    ResumeData resumeData, pw.Context context, PdfColor color) {
  return pw.Column(
    children: List.generate(
      resumeData.languages!.languages.length,
      (index) => pw.Padding(
        padding: const pw.EdgeInsets.only(top: 6),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // degree
            pw.Row(
              // mainAxisAlignment:
              //     pw.MainAxisAlignment.spaceBetween,
              children: [
                if (resumeData.languages!.languages[index].title != null)
                  pw.Expanded(
                    child: pw.Text(
                      resumeData.languages!.languages[index].title ?? '',
                      textScaleFactor: 2,
                      textAlign: pw.TextAlign.justify,
                      style: pw.Theme.of(context).defaultTextStyle.copyWith(
                          fontSize: 6, fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                if (resumeData.languages!.languages[index].percentage != null)
                  pw.Text(
                    "${resumeData.languages!.languages[index].percentage!.toStringAsFixed(0)} %",
                    textScaleFactor: 2,
                    textAlign: pw.TextAlign.left,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontSize: 6),
                  ),
                pw.SizedBox(width: 8),
                pw.SizedBox(
                  width: 100,
                  child: pw.LinearProgressIndicator(
                    value: resumeData.skill!.skills[index].percentage ?? 0.0,
                    minHeight: 6,
                    backgroundColor: PdfColor.fromHex('999999'),
                    valueColor: color,
                  ),
                ),
              ],
            ),
            if (resumeData.languages!.languages[index].level != null)
              pw.Row(children: [
                pw.Transform.rotate(
                  angle: 65,
                  child: pw.Icon(
                    const pw.IconData(0xe061),
                    color: PdfColor.fromHex('606060'),
                    size: 10,
                  ),
                ),
                pw.SizedBox(width: 4),
                pw.Text(
                  "Level : ${resumeData.languages!.languages[index].level.toString().split(".")[1].toUpperCase()}",
                  textScaleFactor: 2,
                  textAlign: pw.TextAlign.justify,
                  style: pw.Theme.of(context)
                      .defaultTextStyle
                      .copyWith(fontSize: 6),
                ),
              ]),

            if (resumeData.languages!.languages[index].description != null &&
                resumeData.languages!.languages[index].description != "")
              pw.Row(children: [
                pw.Transform.rotate(
                  angle: 65,
                  child: pw.Icon(
                    const pw.IconData(0xe061),
                    color: PdfColor.fromHex('606060'),
                    size: 10,
                  ),
                ),
                pw.SizedBox(width: 4),
                pw.Text(
                  "Description : ${resumeData.languages!.languages[index].description!}",
                  textScaleFactor: 2,
                  textAlign: pw.TextAlign.justify,
                  style: pw.Theme.of(context)
                      .defaultTextStyle
                      .copyWith(fontSize: 6),
                ),
              ])
          ],
        ),
      ),
    ),
  );
}

pw.Column _certificateList(ResumeData resumeData, pw.Context context) {
  return pw.Column(
    children: List.generate(
      resumeData.certificate!.certificates.length,
      (index) => pw.Padding(
        padding: const pw.EdgeInsets.only(top: 6),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // degree
            pw.Row(
              children: [
                if (resumeData.certificate!.certificates[index].title != null)
                  pw.Expanded(
                    child: pw.Text(
                      resumeData.certificate!.certificates[index].title ?? '',
                      textScaleFactor: 2,
                      textAlign: pw.TextAlign.justify,
                      style: pw.Theme.of(context).defaultTextStyle.copyWith(
                          fontSize: 6, fontWeight: pw.FontWeight.bold),
                    ),
                  ),
              ],
            ),
            // School
            pw.Row(
              // mainAxisAlignment:
              //     pw.MainAxisAlignment.spaceBetween,
              children: [
                if (resumeData.certificate!.certificates[index].school != null)
                  pw.Transform.rotate(
                    angle: 65,
                    child: pw.Icon(
                      const pw.IconData(0xe061),
                      color: PdfColor.fromHex('606060'),
                      size: 10,
                    ),
                  ),
                pw.SizedBox(width: 4),
                pw.Expanded(
                    child: pw.Text(
                  resumeData.certificate!.certificates[index].school ?? '',
                  textScaleFactor: 2,
                  textAlign: pw.TextAlign.justify,
                  style: pw.Theme.of(context)
                      .defaultTextStyle
                      .copyWith(fontSize: 6, fontWeight: pw.FontWeight.bold),
                )),
                if (resumeData.certificate!.certificates[index].startDate !=
                    null)
                  pw.Text(
                    resumeData.certificate!.certificates[index].startDate
                        .toString()
                        .substring(0, 10),
                    textScaleFactor: 2,
                    textAlign: pw.TextAlign.justify,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontSize: 6),
                  ),
                if (resumeData.certificate!.certificates[index].endDate !=
                        null ||
                    resumeData.certificate!.certificates[index].isPresent) ...[
                  pw.Text(
                    " -- ",
                    textScaleFactor: 2,
                    textAlign: pw.TextAlign.justify,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontSize: 6),
                  ),
                  pw.Text(
                    resumeData.certificate!.certificates[index].isPresent
                        ? "Present"
                        : resumeData.certificate!.certificates[index].endDate
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

            if (resumeData.certificate!.certificates[index].description != null)
              pw.Row(children: [
                pw.Transform.rotate(
                  angle: 65,
                  child: pw.Icon(
                    const pw.IconData(0xe061),
                    color: PdfColor.fromHex('606060'),
                    size: 10,
                  ),
                ),
                pw.SizedBox(width: 4),
                pw.Expanded(
                  child: pw.Text(
                    "Description : ${resumeData.certificate!.certificates[index].description!}",
                    textScaleFactor: 2,
                    textAlign: pw.TextAlign.justify,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontSize: 6),
                  ),
                ),
              ])
          ],
        ),
      ),
    ),
  );
}

pw.Column _interestList(ResumeData resumeData, pw.Context context) {
  return pw.Column(
    children: List.generate(
      resumeData.interest!.interests.length,
      (index) => pw.Padding(
        padding: const pw.EdgeInsets.only(top: 6),
        child: pw.Row(children: [
          if (resumeData.interest!.interests[index].title != null)
            pw.Row(children: [
              pw.Transform.rotate(
                angle: 65,
                child: pw.Icon(
                  const pw.IconData(0xe061),
                  color: PdfColor.fromHex('606060'),
                  size: 10,
                ),
              ),
              pw.SizedBox(width: 4),
              pw.Text(
                resumeData.interest!.interests[index].title ?? '',
                textScaleFactor: 2,
                textAlign: pw.TextAlign.left,
                style: pw.Theme.of(context)
                    .defaultTextStyle
                    .copyWith(fontSize: 6, fontWeight: pw.FontWeight.bold),
              ),
            ]),
        ]),
      ),
    ),
  );
}

Future<pw.PageTheme> _pageTheme(PdfPageFormat format, PdfColor color) async {
  format = format.applyMargin(
    left: 2.0 * PdfPageFormat.cm,
    top: 2.0 * PdfPageFormat.cm,
    right: 2.0 * PdfPageFormat.cm,
    bottom: 2.0 * PdfPageFormat.cm,
  );

  return pw.PageTheme(
    pageFormat: format,
    theme: pw.ThemeData.withFont(
      base: await PdfGoogleFonts.alegreyaRegular(),
      bold: await PdfGoogleFonts.alegreyaBold(),
      icons: await PdfGoogleFonts.materialIcons(),
    ),
    buildBackground: (pw.Context context) {
      return pw.FullPage(
        ignoreMargins: true,
        child: pw.Stack(
          children: [
            pw.Container(
              color: PdfColor.fromHex('F8F2EB'),
            ),
            // pw.Positioned(
            //   top: -10,
            //   left: 100,
            //   child: pw.Container(
            //     color: PdfColor.fromHex('F8F2EB'),
            //   ),
            // ),
            // pw.Expanded(
            //   flex: 5,
            //   child: pw.Container(
            //     color: PdfColor.fromHex('54448D'),
            //   ),
            // ),
          ],
        ),
      );
    },
  );
}
