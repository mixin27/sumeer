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
  bool showPersonalDetail = resumeData.personalDetail?.personalInfo?.dateOfBirth
              .toString() !=
          '' ||
      resumeData.personalDetail?.personalInfo?.drivingLicense.toString() !=
          '' ||
      resumeData.personalDetail?.personalInfo?.gender.toString() != '' ||
      resumeData.personalDetail?.personalInfo?.identityNo.toString() != '' ||
      resumeData.personalDetail?.personalInfo?.martialStatus.toString() != '' ||
      resumeData.personalDetail?.personalInfo?.militaryService.toString() !=
          '' ||
      resumeData.personalDetail?.personalInfo?.nationality.toString() != '';

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
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    // name
                    if (resumeData.personalDetail?.fullName != null)
                      pw.Text(
                        resumeData.personalDetail?.fullName ?? '',
                        textScaleFactor: 1.5,
                        style: pw.Theme.of(context)
                            .defaultTextStyle
                            .copyWith(fontWeight: pw.FontWeight.bold),
                      ),
                    // job
                    if (resumeData.personalDetail?.jobTitle != null) ...[
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(top: 4),
                      ),
                      pw.Text(
                        resumeData.personalDetail?.jobTitle ?? '',
                        textScaleFactor: 1.2,
                        style: pw.Theme.of(context).defaultTextStyle.copyWith(
                              fontWeight: pw.FontWeight.bold,
                            ),
                      ),
                    ],

                    // address
                    if (resumeData.personalDetail?.address != null) ...[
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(top: 4),
                      ),
                      pw.Text(
                        resumeData.personalDetail?.address ?? '',
                        textScaleFactor: 1.2,
                        style: pw.Theme.of(context).defaultTextStyle,
                      ),
                    ],
                    pw.SizedBox(height: 4),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          if (resumeData.personalDetail?.phone != null)
                            pw.Text(
                              resumeData.personalDetail?.phone ?? '',
                              textScaleFactor: 1.5,
                              style: pw.Theme.of(context)
                                  .defaultTextStyle
                                  .copyWith(fontSize: 8),
                            ),
                          if (resumeData.personalDetail?.email != null)
                            pw.Text(
                              resumeData.personalDetail?.email ?? '',
                              textScaleFactor: 1.5,
                              style: pw.Theme.of(context)
                                  .defaultTextStyle
                                  .copyWith(fontSize: 8),
                            ),
                        ]),
                    pw.SizedBox(height: 8),
                    pw.Divider(height: 2, thickness: 1),

                    if (showPersonalDetail) ...[
                      SectionDesign4(title: 'Personal Detail'),
                      if (resumeData.personalDetail?.personalInfo != null)
                        _personalDetail(resumeData, context)
                    ],

                    pw.SizedBox(height: 8),
                    // pw.Divider(height: 2, thickness: 1),

                    // Profile
                    if (resumeData.profile != null) ...[
                      if (resumeData.profile?.title != null)
                        SectionDesign4(title: resumeData.profile?.title ?? ''),
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
                    // pw.Divider(height: 2, thickness: 1),

                    // Experience
                    if (resumeData.experience?.experiences != null) ...[
                      // if (resumeData.experience?.title != null)
                      SectionDesign4(
                        title: resumeData.experience?.title.toString() == ''
                            ? 'Experience'
                            : resumeData.experience?.title.toString() ?? '',
                      ),
                      if (resumeData.experience!.experiences.isNotEmpty)
                        _experienceList(resumeData, context),
                    ],

                    pw.SizedBox(height: 8),
                    // pw.Divider(height: 2, thickness: 1),
                    // Education
                    if (resumeData.education?.educations != null) ...[
                      // if (resumeData.education?.title != null)
                      SectionDesign4(
                        title: resumeData.education?.title.toString() == ''
                            ? 'Education'
                            : resumeData.education?.title.toString() ?? '',
                      ),
                      if (resumeData.education!.educations.isNotEmpty)
                        _eduationList(resumeData, context),
                    ],

                    pw.SizedBox(height: 8),
                    // pw.Divider(height: 2, thickness: 1),

                    // Skill
                    if (resumeData.skill?.skills != null) ...[
                      // if (resumeData.skill?.title != null)
                      SectionDesign4(
                        title: resumeData.skill?.title.toString() == ''
                            ? 'Skill'
                            : resumeData.skill?.title.toString() ?? '',
                      ),
                      if (resumeData.skill!.skills.isNotEmpty)
                        _skillList(resumeData, context),
                    ],

                    pw.SizedBox(height: 8),
                    // pw.Divider(height: 2, thickness: 1),
                    // Language
                    if (resumeData.languages != null) ...[
                      if (resumeData.languages?.title != null)
                        SectionDesign4(title: 'Languages'),
                      if (resumeData.languages!.languages.isNotEmpty)
                        _languageList(resumeData, context),
                    ],

                    pw.SizedBox(height: 8),
                    // pw.Divider(height: 2, thickness: 1),
                    // Language
                    if (resumeData.certificate != null) ...[
                      if (resumeData.certificate?.title != null)
                        SectionDesign4(
                            title: resumeData.certificate?.title ?? ''),
                      if (resumeData.certificate!.certificates.isNotEmpty)
                        _certificateList(resumeData, context),
                    ],

                    pw.SizedBox(height: 8),
                    // pw.Divider(height: 2, thickness: 1),

                    // interest
                    if (resumeData.interest != null) ...[
                      if (resumeData.interest?.title != null)
                        SectionDesign4(title: resumeData.interest?.title ?? ''),
                      if (resumeData.interest!.interests.isNotEmpty)
                        _interestList(resumeData, context),
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

pw.Wrap _personalDetail(ResumeData resumeData, pw.Context context) {
  PersonalInformation? info = resumeData.personalDetail!.personalInfo;
  bool showPersonalLink =
      resumeData.personalDetail?.links[0].url.toString() != '' ||
          resumeData.personalDetail?.links[1].url.toString() != '' ||
          resumeData.personalDetail?.links[2].url.toString() != '' ||
          resumeData.personalDetail?.links[3].url.toString() != '';
  return pw.Wrap(
    // crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      if (info?.dateOfBirth.toString() != '')
        _personalDetailItem(context, 'Date Of Birth', info?.dateOfBirth),
      if (info?.drivingLicense.toString() != '')
        _personalDetailItem(context, 'Driving License', info?.drivingLicense),
      if (info?.gender.toString() != '')
        _personalDetailItem(context, 'Gender', info?.gender),
      if (info?.identityNo.toString() != '')
        _personalDetailItem(context, 'Identity No.', info?.identityNo),
      if (info?.martialStatus.toString() != '')
        _personalDetailItem(context, 'Martial Status', info?.martialStatus),
      if (info?.nationality.toString() != '')
        _personalDetailItem(context, 'Nationality', info?.nationality),
      if (info?.militaryService.toString() != '')
        _personalDetailItem(context, 'Military Service', info?.militaryService),
      if (showPersonalLink) ...[
        if (resumeData.personalDetail!.links[0].url.toString() != '')
          _personalDetailLinkItem(
            context,
            resumeData.personalDetail!.links[0].name,
            resumeData.personalDetail!.links[0].url,
          ),
        if (resumeData.personalDetail!.links[1].url.toString() != '')
          _personalDetailLinkItem(
            context,
            resumeData.personalDetail!.links[1].name,
            resumeData.personalDetail!.links[1].url,
          ),
        if (resumeData.personalDetail!.links[2].url.toString() != '')
          _personalDetailLinkItem(
            context,
            resumeData.personalDetail!.links[2].name,
            resumeData.personalDetail!.links[2].url,
          ),
        if (resumeData.personalDetail!.links[3].url.toString() != '')
          _personalDetailLinkItem(
            context,
            resumeData.personalDetail!.links[3].name,
            resumeData.personalDetail!.links[3].url,
          ),
      ]
    ],
  );
}

pw.SizedBox _personalDetailItem(
    pw.Context context, String? title, String? text) {
  return pw.SizedBox(
      width: 230,
      child: pw.Row(
        children: [
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

pw.Row _personalDetailLinkItem(pw.Context context, String? name, String? url) {
  return pw.Row(
    children: [
      pw.SizedBox(
        width: 90,
        child: pw.Text(
          name ?? '',
          // 'Date Of Birth',
          textScaleFactor: 2,
          style: pw.Theme.of(context).defaultTextStyle.copyWith(fontSize: 6),
        ),
      ),
      pw.Text(
        " : ${url ?? ''}",
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
              // mainAxisAlignment:
              //     pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Expanded(
                  child: pw.Row(children: [
                    pw.Transform.rotate(
                      angle: 65,
                      child: pw.Icon(
                        const pw.IconData(0xe9b0),
                        color: PdfColor.fromHex('000000'),
                        size: 12,
                      ),
                    ),
                    pw.SizedBox(width: 4),
                    pw.Text(
                      resumeData.experience!.experiences[index].jobTitle,
                      textScaleFactor: 2,
                      textAlign: pw.TextAlign.justify,
                      style: pw.Theme.of(context).defaultTextStyle.copyWith(
                          fontSize: 6, fontWeight: pw.FontWeight.bold),
                    ),
                  ]),
                ),
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
                    ' -- ',
                    textScaleFactor: 2,
                    textAlign: pw.TextAlign.justify,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontSize: 6),
                  ),
                  pw.Text(
                    resumeData.experience!.experiences[index].isPresent
                        ? 'Present'
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
                    ', ',
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
                    child: pw.Row(children: [
                      pw.Transform.rotate(
                        angle: 65,
                        child: pw.Icon(
                          const pw.IconData(0xe9b0),
                          color: PdfColor.fromHex('000000'),
                          size: 12,
                        ),
                      ),
                      pw.SizedBox(width: 4),
                      pw.Text(
                        resumeData.education!.educations[index].degree ?? '',
                        textScaleFactor: 2,
                        textAlign: pw.TextAlign.justify,
                        style: pw.Theme.of(context).defaultTextStyle.copyWith(
                            fontSize: 6, fontWeight: pw.FontWeight.bold),
                      ),
                    ]),
                  ),
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
                    ' -- ',
                    textScaleFactor: 2,
                    textAlign: pw.TextAlign.justify,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontSize: 6),
                  ),
                  pw.Text(
                    resumeData.education!.educations[index].isPresent
                        ? 'Present'
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
                if (resumeData.education!.educations[index].school != null)
                  pw.Expanded(
                      child: pw.Text(
                    resumeData.education!.educations[index].school ?? '',
                    textScaleFactor: 2,
                    textAlign: pw.TextAlign.justify,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontSize: 6),
                  )),
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
                    ', ',
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

pw.Column _skillList(ResumeData resumeData, pw.Context context) {
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
                pw.Transform.rotate(
                  angle: 65,
                  child: pw.Icon(
                    const pw.IconData(0xe9b0),
                    color: PdfColor.fromHex('000000'),
                    size: 12,
                  ),
                ),
                pw.SizedBox(width: 4),
                pw.Text(
                  resumeData.skill!.skills[index].name,
                  textScaleFactor: 2,
                  textAlign: pw.TextAlign.justify,
                  style: pw.Theme.of(context)
                      .defaultTextStyle
                      .copyWith(fontSize: 6, fontWeight: pw.FontWeight.bold),
                ),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'Level : ${getSkillLevel(
                    resumeData.skill!.skills[index].level ??
                        SkillLevelEnum.novice,
                  )}',
                  textScaleFactor: 2,
                  textAlign: pw.TextAlign.justify,
                  style: pw.Theme.of(context)
                      .defaultTextStyle
                      .copyWith(fontSize: 6),
                ),
                if (resumeData.skill!.skills[index].percentage != null)
                  pw.Text(
                    '${(resumeData.skill!.skills[index].percentage! * 100).toStringAsFixed(0)} %',
                    textScaleFactor: 2,
                    textAlign: pw.TextAlign.left,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontSize: 6),
                  ),
              ],
            ),
            if (resumeData.skill!.skills[index].information != null &&
                resumeData.skill!.skills[index].information != '')
              pw.Text(
                'Information : ${resumeData.skill!.skills[index].information!}',
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

pw.Column _languageList(ResumeData resumeData, pw.Context context) {
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
              children: [
                if (resumeData.languages!.languages[index].title != null) ...[
                  pw.Transform.rotate(
                    angle: 65,
                    child: pw.Icon(
                      const pw.IconData(0xe9b0),
                      color: PdfColor.fromHex('000000'),
                      size: 12,
                    ),
                  ),
                  pw.SizedBox(width: 4),
                  pw.Text(
                    resumeData.languages!.languages[index].title ?? '',
                    textScaleFactor: 2,
                    textAlign: pw.TextAlign.justify,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontSize: 6, fontWeight: pw.FontWeight.bold),
                  ),
                ],
              ],
            ),

            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    "Level : ${resumeData.languages!.languages[index].level.toString().split(".")[1].toUpperCase()}",
                    textScaleFactor: 2,
                    textAlign: pw.TextAlign.justify,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontSize: 6),
                  ),
                  if (resumeData.languages!.languages[index].percentage != null)
                    pw.Text(
                      '${resumeData.languages!.languages[index].percentage!.toStringAsFixed(0)} %',
                      textScaleFactor: 2,
                      textAlign: pw.TextAlign.left,
                      style: pw.Theme.of(context)
                          .defaultTextStyle
                          .copyWith(fontSize: 6),
                    ),
                ]),
            if (resumeData.languages!.languages[index].description != null &&
                resumeData.languages!.languages[index].description != '')
              pw.Text(
                'Description : ${resumeData.languages!.languages[index].description!}',
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
                if (resumeData.certificate!.certificates[index].title !=
                    null) ...[
                  pw.Transform.rotate(
                    angle: 65,
                    child: pw.Icon(
                      const pw.IconData(0xe9b0),
                      color: PdfColor.fromHex('000000'),
                      size: 12,
                    ),
                  ),
                  pw.SizedBox(width: 4),
                  pw.Text(
                    resumeData.certificate!.certificates[index].title ?? '',
                    textScaleFactor: 2,
                    textAlign: pw.TextAlign.justify,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontSize: 6, fontWeight: pw.FontWeight.bold),
                  ),
                ]
              ],
            ),
            // School
            pw.Row(
              // mainAxisAlignment:
              //     pw.MainAxisAlignment.spaceBetween,
              children: [
                if (resumeData.certificate!.certificates[index].school != null)
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
                    ' -- ',
                    textScaleFactor: 2,
                    textAlign: pw.TextAlign.justify,
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(fontSize: 6),
                  ),
                  pw.Text(
                    resumeData.certificate!.certificates[index].isPresent
                        ? 'Present'
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

            // pw.Text(
            //   "Level : ${resumeData.certificate!.certificates[index].level.toString().split(".")[1].toUpperCase()}",
            //   textScaleFactor: 2,
            //   textAlign: pw.TextAlign.justify,
            //   style:
            //       pw.Theme.of(context).defaultTextStyle.copyWith(fontSize: 6),
            // ),
            if (resumeData.certificate!.certificates[index].description != null)
              pw.Text(
                'Description : ${resumeData.certificate!.certificates[index].description!}',
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
                  const pw.IconData(0xe9b0),
                  color: PdfColor.fromHex('000000'),
                  size: 12,
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
              )
            ]),
        ]),
      ),
    ),
  );
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
      base: await PdfGoogleFonts.loraRegular(),
      bold: await PdfGoogleFonts.loraBold(),
      italic: await PdfGoogleFonts.loraItalic(),
      icons: await PdfGoogleFonts.materialIcons(),
    ),
  );
}
