import 'package:flutter/material.dart';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:sumeer/features/data_input/feat_data_input.dart';
import 'package:sumeer/features/data_input/presentation/widget/text_input_field_widget.dart';
import '../../../utils/utils.dart';
import '../../../widgets/app_dialog_box.dart';
import '../../features.dart';

import 'package:pdf/widgets.dart' as pw;

@RoutePage()
class PersonalDetailPage extends ConsumerStatefulWidget {
  const PersonalDetailPage({super.key});

  @override
  ConsumerState<PersonalDetailPage> createState() => _PersonalDetailPageState();
}

class _PersonalDetailPageState extends ConsumerState<PersonalDetailPage> {
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final jobTitleController = TextEditingController();
  final emailController = TextEditingController();
  final dayofDOBController = TextEditingController();
  final monthofDOBController = TextEditingController();
  final yearofDOBController = TextEditingController();
  final genderController = TextEditingController();
  final genderFocusNode = FocusNode();
  final nationalityController = TextEditingController();
  final nationalityFocusNode = FocusNode();
  final passportController = TextEditingController();
  final passportFocusNode = FocusNode();
  final maritalController = TextEditingController();
  final maritalFocusNode = FocusNode();
  final drivingController = TextEditingController();
  final drivingFocusNode = FocusNode();
  final websiteController = TextEditingController();
  final websiteFocusNode = FocusNode();
  final linkInController = TextEditingController();
  final linkInFocusNode = FocusNode();
  final githubController = TextEditingController();
  final githubFocusNode = FocusNode();
  final skypeController = TextEditingController();
  final skypeFocusNode = FocusNode();

  final ImagePicker _picker = ImagePicker();

  String _selectedDateStr = "";
  DateTime? _selectedDate;
  bool _isAddGender = false;
  bool _isAddNationality = false;
  bool _isAddPassport = false;
  bool _isAddMarital = false;
  bool _isAddDriving = false;
  bool _isAddWebsite = false;
  bool _isAddLinkIn = false;
  bool _isAddGithub = false;
  bool _isAddSkype = false;

  Uint8List? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Personal Detail"),
      ),
      body: Container(
        margin: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: [
                Align(
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      _image == null
                          ? CircularProfileAvatar(
                              '',
                              radius: 60,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.grey.withOpacity(0.3),
                                size: 50,
                              ),
                            )
                          : CircularProfileAvatar(
                              '',
                              radius: 60,
                              child: Image.memory(
                                _image!,
                                fit: BoxFit.cover,
                              ),
                            ),
                      Positioned(
                        right: 1,
                        bottom: 2,
                        child: SizedBox(
                          width: 38,
                          height: 38,
                          child: InkWell(
                            onTap: () async {
                              Uint8List imageFile =
                                  await pickImage(ImageSource.gallery);
                              setState(() {
                                _image = imageFile;
                              });
                            },
                            child: CircleAvatar(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.7),
                              child: Icon(
                                Icons.drive_file_rename_outline,
                                color: Theme.of(context).colorScheme.onPrimary,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                TextInputFieldWidget(
                  title: "Full Name",
                  controller: fullNameController,
                ),
                TextInputFieldWidget(
                  title: "Job title",
                  controller: jobTitleController,
                ),
                TextInputFieldWidget(
                  title: "Email",
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                TextInputFieldWidget(
                  title: "Phone no",
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                ),
                TextInputFieldWidget(
                  title: "Address",
                  controller: addressController,
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Personal Information",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: _selectedDateStr.isEmpty ? false : true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Date of Birth",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextInputFieldWidget(
                              title: "",
                              controller: dayofDOBController,
                              onTap: () => _showDatePicker(context),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextInputFieldWidget(
                                title: "",
                                controller: monthofDOBController,
                                onTap: () => _showDatePicker(context),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextInputFieldWidget(
                                title: "",
                                controller: yearofDOBController,
                                onTap: () => _showDatePicker(context),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  _selectedDate = null;
                                  _selectedDateStr = "";
                                  dayofDOBController.text = "";
                                  monthofDOBController.text = "";
                                  yearofDOBController.text = "";
                                });
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Theme.of(context).colorScheme.error,
                              ))
                        ],
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: _isAddGender,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextInputFieldWidget(
                          title: "Gender",
                          controller: genderController,
                          focusNode: genderFocusNode,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                _isAddGender = false;
                              });
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Theme.of(context).colorScheme.error,
                            )),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: _isAddNationality,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextInputFieldWidget(
                          title: "Nationality",
                          controller: nationalityController,
                          focusNode: nationalityFocusNode,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                _isAddNationality = false;
                              });
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Theme.of(context).colorScheme.error,
                            )),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: _isAddPassport,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextInputFieldWidget(
                          title: "Passport or ID",
                          controller: passportController,
                          focusNode: passportFocusNode,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                _isAddPassport = false;
                              });
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Theme.of(context).colorScheme.error,
                            )),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: _isAddMarital,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextInputFieldWidget(
                          title: "Marital Status",
                          controller: maritalController,
                          focusNode: maritalFocusNode,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                _isAddMarital = false;
                              });
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Theme.of(context).colorScheme.error,
                            )),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: _isAddDriving,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextInputFieldWidget(
                          title: "Driving License",
                          controller: drivingController,
                          focusNode: drivingFocusNode,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                _isAddDriving = false;
                              });
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Theme.of(context).colorScheme.error,
                            )),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Visibility(
                      visible: _selectedDate != null ? false : true,
                      child: Expanded(
                        child: AddPersonalDetailButton(
                          text: "Date of Birth",
                          onTap: () => _showDatePicker(context),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !_isAddGender,
                      child: Expanded(
                        child: AddPersonalDetailButton(
                          text: "Gender",
                          onTap: () {
                            setState(() {
                              _isAddGender = true;
                              genderFocusNode.requestFocus();
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Visibility(
                      visible: !_isAddNationality,
                      child: Expanded(
                        child: AddPersonalDetailButton(
                          text: "Nationality",
                          onTap: () {
                            setState(() {
                              _isAddNationality = true;
                              nationalityFocusNode.requestFocus();
                            });
                          },
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !_isAddPassport,
                      child: Expanded(
                        child: AddPersonalDetailButton(
                          text: "Passport or ID",
                          onTap: () {
                            setState(() {
                              _isAddPassport = true;
                              passportFocusNode.requestFocus();
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Visibility(
                      visible: !_isAddMarital,
                      child: Expanded(
                        child: AddPersonalDetailButton(
                          text: "Marital Status",
                          onTap: () {
                            setState(() {
                              _isAddMarital = true;
                              maritalFocusNode.requestFocus();
                            });
                          },
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !_isAddDriving,
                      child: Expanded(
                        child: AddPersonalDetailButton(
                          text: "Driving License",
                          onTap: () {
                            setState(() {
                              _isAddDriving = true;
                              drivingFocusNode.requestFocus();
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Links",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: _isAddWebsite,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextInputFieldWidget(
                          title: "Website",
                          controller: websiteController,
                          focusNode: websiteFocusNode,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                _isAddWebsite = false;
                              });
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Theme.of(context).colorScheme.error,
                            )),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: _isAddLinkIn,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextInputFieldWidget(
                          title: "LinkedIn",
                          controller: linkInController,
                          focusNode: linkInFocusNode,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                _isAddLinkIn = false;
                              });
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Theme.of(context).colorScheme.error,
                            )),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: _isAddGithub,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextInputFieldWidget(
                          title: "Github",
                          controller: githubController,
                          focusNode: githubFocusNode,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                _isAddGithub = false;
                              });
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Theme.of(context).colorScheme.error,
                            )),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: _isAddSkype,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextInputFieldWidget(
                          title: "Skype",
                          controller: skypeController,
                          focusNode: skypeFocusNode,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                _isAddSkype = false;
                              });
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Theme.of(context).colorScheme.error,
                            )),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Visibility(
                      visible: !_isAddWebsite,
                      child: Expanded(
                        child: AddPersonalDetailButton(
                          text: "Websites",
                          onTap: () {
                            setState(() {
                              _isAddWebsite = true;
                              websiteFocusNode.requestFocus();
                            });
                          },
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !_isAddLinkIn,
                      child: Expanded(
                        child: AddPersonalDetailButton(
                          text: "LinkIn",
                          onTap: () {
                            setState(() {
                              _isAddLinkIn = true;
                              linkInFocusNode.requestFocus();
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Visibility(
                      visible: !_isAddGithub,
                      child: Expanded(
                        child: AddPersonalDetailButton(
                          text: "GitHub",
                          onTap: () {
                            setState(() {
                              _isAddGithub = true;
                              githubFocusNode.requestFocus();
                            });
                          },
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !_isAddSkype,
                      child: Expanded(
                        child: AddPersonalDetailButton(
                          text: "Skype",
                          onTap: () {
                            setState(() {
                              _isAddSkype = true;
                              skypeFocusNode.requestFocus();
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 80,
                )
              ]),
            ),
          ),
        ),
      ),
      bottomSheet: SizedBox(
          height: 80,
          child: SaveBottomSheetWidget(
            onTap: () {
              savePersonalDetail();
              context.router.pop();
            },
          )),
    );
  }

  void savePersonalDetail() async {
    var personalDetail = PersonalDetailSection(
      fullName: fullNameController.text,
      jobTitle: jobTitleController.text,
      email: emailController.text,
      phone: phoneController.text,
      address: addressController.text,
      personalInfo: PersonalInformation(
        dateOfBirth: _selectedDateStr,
      ),
      links: [
        PersonalLink(
          name: 'GitHub',
          url: githubController.text,
        ),
        PersonalLink(
          name: 'Website',
          url: websiteController.text,
        ),
        PersonalLink(
          name: 'Skype',
          url: skypeController.text,
        ),
        PersonalLink(
          name: 'LinkedIn',
          url: linkInController.text,
        ),
      ],
    );

    ref.read(resumeDataProvider.notifier).state = ResumeData(
      profileImage: _image == null
          ? ref.watch(resumeDataProvider)?.profileImage
          : pw.MemoryImage(_image!),
      personalDetail: personalDetail,
      profile: const ProfileSection(
        title: "Profile",
        contents: [
          'Senior Wev Developer specilizing in fornt end development. Experienced with all stages of the development cycle for dynamic web projects. Well-versed in numerous programming languages including HTMLS,PHP OOP, Javaspript, CSS, MySQL. Strong background in project management and customer relations.',
        ],
      ),
      education: ref.watch(resumeDataProvider)?.education,
      project: ref.watch(resumeDataProvider)?.project,
      experience: ref.watch(resumeDataProvider)?.experience,
    );
  }

  /// Get from gallery
  pickImage(ImageSource source) async {
    XFile? file = await _picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      return await file.readAsBytes();
    }
  }

  void _showDatePicker(BuildContext context) {
    showAnimatedDialog(
      context,
      barrierDismissible: true,
      barrierLabel: '',
      dialog: AppDialogBox(
        header: Text(
          "Select Date of Birth",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        content: DatePickerWidget(
          looping: false, // default is not looping
          firstDate: DateTime(1990, 01, 01),
          // lastDate: DateTime(2030, 1, 1),
          initialDate: DateTime.now(),
          dateFormat: "dd-MMMM-yyyy",
          onChange: (DateTime newDate, _) {
            _selectedDate = newDate;
          },
          locale: DateTimePickerLocale.en_us,
          pickerTheme: DateTimePickerTheme(
              itemTextStyle: const TextStyle(color: Colors.black, fontSize: 19),
              dividerColor: Colors.blue,
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.02)),
        ),
        footer: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                context.router.pop();
              },
              style: TextButton.styleFrom(
                foregroundColor:
                    Theme.of(context).colorScheme.onSurface.withAlpha(90),
              ),
              child: const Text('Cancel'),
            ),
            // Gap(ALC.getWidth(10)),
            TextButton(
              onPressed: () {
                context.router.pop();
                _selectedDateStr = DateFormat("dd-MMMM-yyyy")
                    .format(_selectedDate ?? DateTime.now());

                setState(() {
                  _selectedDate = _selectedDate ?? DateTime.now();
                  dayofDOBController.text = _selectedDateStr.split("-")[0];
                  monthofDOBController.text = _selectedDateStr.split("-")[1];
                  yearofDOBController.text = _selectedDateStr.split("-")[2];
                });
              },
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
              ),
              child: const Text("Confirm"),
            ),
          ],
        ),
      ),
    );
  }
}
