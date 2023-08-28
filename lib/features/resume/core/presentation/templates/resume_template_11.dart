import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import 'package:sumeer/features/resume/feat_resume.dart';

Future<Uint8List> generateTemplate11(
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

  PdfColor color = PdfColor.fromHex('063841');
  // PdfColor fontColor = PdfColor.fromHex('063841');

  final pageTheme = await _pageTheme(format, color);

  final font = await PdfGoogleFonts.sourceSerifProItalic();
  bool showPersonalDetail = false;
  if (resumeData.personalDetail != null &&
      resumeData.personalDetail?.personalInfo != null) {
    showPersonalDetail = resumeData.personalDetail?.personalInfo?.dateOfBirth
                .toString() !=
            "" ||
        resumeData.personalDetail?.personalInfo?.drivingLicense.toString() !=
            "" ||
        resumeData.personalDetail?.personalInfo?.gender.toString() != "" ||
        resumeData.personalDetail?.personalInfo?.identityNo.toString() != "" ||
        resumeData.personalDetail?.personalInfo?.martialStatus.toString() !=
            "" ||
        resumeData.personalDetail?.personalInfo?.militaryService.toString() !=
            "" ||
        resumeData.personalDetail?.personalInfo?.nationality.toString() != "";
  }

  bool showPersonalLink = false;
  if (resumeData.personalDetail != null &&
      resumeData.personalDetail?.links != null &&
      resumeData.personalDetail!.links.isNotEmpty) {
    showPersonalLink =
        resumeData.personalDetail?.links[0].url.toString() != "" ||
            resumeData.personalDetail?.links[1].url.toString() != "" ||
            resumeData.personalDetail?.links[2].url.toString() != "" ||
            resumeData.personalDetail?.links[3].url.toString() != "";
  }

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

                      // Personal Detail
                      if (showPersonalDetail || showPersonalLink) ...[
                        SectionDesign11(
                            lineColor: color, title: 'Personal Detail'),
                        if (resumeData.profile!.contents.isNotEmpty)
                          _personalDetail(resumeData, context),
                      ],
                      pw.SizedBox(height: 8),

                      // Profile
                      if (resumeData.profile != null)
                        ..._personalProfile(resumeData, color, context),
                      pw.SizedBox(height: 8),

                      // Experience
                      if (resumeData.experience != null &&
                          resumeData.experience?.experiences != null) ...[
                        // if (resumeData.experience?.title != null)
                        SectionDesign11(
                          lineColor: color,
                          title: resumeData.experience?.title.toString() == ""
                              ? "Experience"
                              : resumeData.experience?.title.toString() ?? "",
                          // title: resumeData.experience?.title ?? '',
                        ),
                        if (resumeData.experience!.experiences.isNotEmpty)
                          _experienceList(resumeData, context),
                      ],
                      pw.SizedBox(height: 8),

                      // Education
                      if (resumeData.education != null &&
                          resumeData.education?.educations != null) ...[
                        // if (resumeData.education?.title != null)
                        SectionDesign11(
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
                      if (resumeData.skill != null &&
                          resumeData.skill?.skills != null) ...[
                        // if (resumeData.skill?.title != null)
                        SectionDesign11(
                          lineColor: color,
                          title: resumeData.skill?.title.toString() == ""
                              ? "Skill"
                              : resumeData.skill?.title.toString() ?? "",
                          // title: resumeData.skill?.title ?? '',
                        ),
                        if (resumeData.skill!.skills.isNotEmpty)
                          _skillList(resumeData, context, color),
                      ],
                      pw.SizedBox(height: 8),

                      // Language
                      if (resumeData.languages != null) ...[
                        if (resumeData.languages?.title != null)
                          SectionDesign11(
                              lineColor: color,
                              title: resumeData.languages?.title ?? ''),
                        if (resumeData.languages!.languages.isNotEmpty)
                          _languageList(resumeData, context, color),
                      ],
                      pw.SizedBox(height: 8),

                      // Language
                      if (resumeData.certificate != null) ...[
                        if (resumeData.certificate?.title != null)
                          SectionDesign11(
                              lineColor: color,
                              title: resumeData.certificate?.title ?? ''),
                        if (resumeData.certificate!.certificates.isNotEmpty)
                          _certificateList(resumeData, context),
                      ],
                      pw.SizedBox(height: 8),

                      // interest
                      if (resumeData.interest != null) ...[
                        if (resumeData.interest?.title != null)
                          SectionDesign11(
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
      SectionDesign11(lineColor: color, title: resumeData.profile?.title ?? ''),
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
      // crossAxisAlignment: pw.CrossAxisAlignment.,
      children: [
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
          ),
        pw.SizedBox(width: 8),
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
                    _personalInfoItem(context, 0xe56a,
                        resumeData.personalDetail?.address ?? ''),
                  if (resumeData.personalDetail?.email != null)
                    _personalInfoItem(context, 0xe158,
                        resumeData.personalDetail?.email ?? ''),
                  if (resumeData.personalDetail?.phone != null)
                    _personalInfoItem(context, 0xe0b0,
                        resumeData.personalDetail?.phone ?? ''),
                ]),
              ]),
        ),
      ]);
}

pw.Padding _personalInfoItem(pw.Context context, int codePoint, String text) {
  return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 3),
      child: pw.Wrap(
        children: [
          pw.Icon(
            pw.IconData(codePoint),
            color: PdfColor.fromHex('063841'),
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

pw.Wrap _personalDetail(ResumeData resumeData, pw.Context context) {
  PersonalInformation? info = resumeData.personalDetail!.personalInfo;
  return pw.Wrap(
    // crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      if (info?.dateOfBirth.toString() != "")
        _personalDetailItem(
            context, 0xe7e9, 'Date Of Birth', info?.dateOfBirth),
      if (info?.drivingLicense.toString() != "")
        _personalDetailItem(
            context, 0xe531, 'Driving License', info?.drivingLicense),
      if (info?.gender.toString() != "")
        _personalDetailItem(context, 0xe63d, 'Gender', info?.gender),
      if (info?.identityNo.toString() != "")
        _personalDetailItem(context, 0xea67, 'Identity No.', info?.identityNo),
      if (info?.martialStatus.toString() != "")
        _personalDetailItem(
            context, 0xefdf, 'Martial Status', info?.martialStatus),
      if (info?.nationality.toString() != "")
        _personalDetailItem(context, 0xe153, 'Nationality', info?.nationality),
      if (info?.militaryService.toString() != "")
        _personalDetailItem(
            context, 0xea3f, 'Military Service', info?.militaryService),
      if (resumeData.personalDetail!.links[0].url.toString() != "")
        _personalDetailLinkItem(
          context,
          resumeData.personalDetail!.links[0].name,
          resumeData.personalDetail!.links[0].url,
        ),
      if (resumeData.personalDetail!.links[1].url.toString() != "")
        _personalDetailLinkItem(
          context,
          resumeData.personalDetail!.links[1].name,
          resumeData.personalDetail!.links[1].url,
        ),
      if (resumeData.personalDetail!.links[2].url.toString() != "")
        _personalDetailLinkItem(
          context,
          resumeData.personalDetail!.links[2].name,
          resumeData.personalDetail!.links[2].url,
        ),
      if (resumeData.personalDetail!.links[3].url.toString() != "")
        _personalDetailLinkItem(
          context,
          resumeData.personalDetail!.links[3].name,
          resumeData.personalDetail!.links[3].url,
        ),
      // if (resumeData.personalDetail!.links.isNotEmpty)
      //   ...List.generate(
      //     resumeData.personalDetail!.links.length,
      //     (index) => _personalDetailLinkItem(
      //         context,
      //         resumeData.personalDetail!.links[index].name,
      //         resumeData.personalDetail!.links[index].url),
      //   )
    ],
  );
}

pw.SizedBox _personalDetailItem(
    pw.Context context, int codePoint, String? title, String? text) {
  return pw.SizedBox(
      width: 230,
      child: pw.Row(
        children: [
          pw.Icon(
            pw.IconData(codePoint),
            color: PdfColor.fromHex('063841'),
            size: 20,
          ),
          pw.SizedBox(width: 4),
          pw.SizedBox(
            width: 90,
            child: pw.Text(
              title ?? '',
              textScaleFactor: 2,
              style:
                  pw.Theme.of(context).defaultTextStyle.copyWith(fontSize: 6),
            ),
          ),
          pw.Text(
            " : ${text ?? ''}",
            textScaleFactor: 2,
            textAlign: pw.TextAlign.justify,
            style: pw.Theme.of(context).defaultTextStyle.copyWith(fontSize: 6),
          ),
        ],
      ));
}

pw.Row _personalDetailLinkItem(
    pw.Context context, String? title, String? text) {
  return pw.Row(
    children: [
      pw.SizedBox(
        width: 90,
        child: pw.Text(
          title ?? '',
          // 'Date Of Birth',
          textScaleFactor: 2,
          style: pw.Theme.of(context).defaultTextStyle.copyWith(fontSize: 6),
        ),
      ),
      pw.Text(
        " : ${text ?? ''}",
        // " : ${info?.dateOfBirth ?? ''}",
        textScaleFactor: 2,
        textAlign: pw.TextAlign.justify,
        style: pw.Theme.of(context).defaultTextStyle.copyWith(fontSize: 6),
      ),
    ],
  );
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
                  // pw.SizedBox(
                  //   width: 100,
                  //   child: pw.LinearProgressIndicator(
                  //     value: resumeData.skill!.skills[index].percentage ?? 0.0,
                  //     minHeight: 6,
                  //     backgroundColor: PdfColor.fromHex('999999'),
                  //     valueColor: color,
                  //   ),
                  // ),
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
            if (resumeData.skill!.skills[index].information != null)
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
                // pw.SizedBox(
                //   width: 100,
                //   child: pw.LinearProgressIndicator(
                //     value: resumeData.skill!.skills[index].percentage ?? 0.0,
                //     minHeight: 6,
                //     backgroundColor: PdfColor.fromHex('999999'),
                //     valueColor: color,
                //   ),
                // ),
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

            if (resumeData.languages!.languages[index].description != null)
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
      base: await PdfGoogleFonts.workSansRegular(),
      bold: await PdfGoogleFonts.workSansBold(),
      icons: await PdfGoogleFonts.materialIcons(),
    ),
    buildBackground: (pw.Context context) {
      return pw.FullPage(
        ignoreMargins: true,
        child: pw.Stack(
          children: [
            pw.Container(
              color: PdfColor.fromHex('D7EAEE'),
            ),
          ],
        ),
      );
    },
  );
}
