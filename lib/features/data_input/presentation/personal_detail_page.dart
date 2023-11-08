import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'package:sumeer/features/data_input/presentation/widget/text_input_field_widget.dart';
import 'package:sumeer/shared/shared.dart';
import '../../../utils/utils.dart';
import '../../../widgets/app_dialog_box.dart';
import '../../features.dart';
import '../infrastructure/firebase_function.dart';

@RoutePage()
class PersonalDetailPage extends ConsumerStatefulWidget {
  const PersonalDetailPage({super.key});

  @override
  ConsumerState<PersonalDetailPage> createState() => _PersonalDetailPageState();
}

class _PersonalDetailPageState extends ConsumerState<PersonalDetailPage> {
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
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

  String _selectedDateStr = '';
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
  String imageId = '';
  // String? imageUrl;

  @override
  void initState() {
    super.initState();
    setData();
  }

  Future<void> setData() async {
    wLog('setData Called');
    Future.microtask(() {
      final resumeData = ref.watch(resumeDataProvider);
      if (resumeData != null) {
        // wLog('setData $resumeData');
        firstNameController.text = resumeData.personalDetail?.firstName ?? '';
        lastNameController.text = resumeData.personalDetail?.lastName ?? '';
        phoneController.text = resumeData.personalDetail?.phone ?? '';
        addressController.text = resumeData.personalDetail?.address ?? '';
        jobTitleController.text = resumeData.personalDetail?.jobTitle ?? '';
        emailController.text = resumeData.personalDetail?.email ?? '';

        _selectedDateStr =
            resumeData.personalDetail?.personalInfo?.dateOfBirth ?? '';
        //gender
        genderController.text =
            resumeData.personalDetail?.personalInfo?.gender ?? '';
        _isAddGender = genderController.text.isEmptyOrNull ? false : true;
        // martial
        maritalController.text =
            resumeData.personalDetail?.personalInfo?.martialStatus ?? '';
        _isAddMarital = maritalController.text.isEmptyOrNull ? false : true;
        // nationality
        nationalityController.text =
            resumeData.personalDetail?.personalInfo?.nationality ?? '';
        passportController.text =
            resumeData.personalDetail?.personalInfo?.identityNo ?? '';
        _isAddNationality =
            nationalityController.text.isEmptyOrNull ? false : true;
        _isAddPassport = passportController.text.isEmptyOrNull ? false : true;
        // driving licence
        drivingController.text =
            resumeData.personalDetail?.personalInfo?.drivingLicense ?? '';
        _isAddDriving = drivingController.text.isEmptyOrNull ? false : true;

        //
        if (_selectedDateStr.isNotEmpty) {
          _selectedDate = DateFormat('dd-MMMM-yyyy').parse(_selectedDateStr);
          dayofDOBController.text = _selectedDateStr.split('-')[0];
          monthofDOBController.text = _selectedDateStr.split('-')[1];
          yearofDOBController.text = _selectedDateStr.split('-')[2];
        }

        // imageUrl = resumeData.profileImage ?? '';
        ref
            .read(imageDataProvider.notifier)
            .update((state) => resumeData.profileImage);

        // links
        var linkList = resumeData.personalDetail?.links ?? [];
        // print('link list length  ${linkList.length}');
        for (var i = 0; i < linkList.length; i++) {
          if (i == 0) {
            githubController.text = linkList[i].url;
            _isAddGithub = githubController.text.isEmptyOrNull ? false : true;
          }
          if (i == 1) {
            websiteController.text = linkList[i].url;
            _isAddWebsite = websiteController.text.isEmptyOrNull ? false : true;
          }
          if (i == 2) {
            skypeController.text = linkList[i].url;
            _isAddSkype = skypeController.text.isEmptyOrNull ? false : true;
          }
          if (i == 3) {
            linkInController.text = linkList[i].url;
            _isAddLinkIn = linkInController.text.isEmptyOrNull ? false : true;
          }
        }
      } else {
        imageId = const Uuid().v4();
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final imageData = ref.watch(imageDataProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Personal Detail'),
      ),
      body: Container(
        margin: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: formKey,
                child: Column(children: [
                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        CircularProfileAvatar(
                          '',
                          radius: 60,
                          child: (imageData != null && imageData.isNotEmpty)
                              ? Image.memory(base64.decode(imageData))
                              : Center(
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.grey.withOpacity(0.3),
                                    size: 50,
                                  ),
                                ),
                        ),
                        // CircularProfileAvatar(
                        //   '',
                        //   radius: 60,
                        //   child: CachedNetworkImage(
                        //     fit: BoxFit.fill,
                        //     imageUrl: imageUrl ?? '',
                        //     progressIndicatorBuilder:
                        //         (context, url, downloadProgress) =>
                        //             CircularProgressIndicator(
                        //                 value: downloadProgress.progress),
                        //     errorWidget: (context, url, error) => Icon(
                        //       Icons.camera_alt,
                        //       color: Colors.grey.withOpacity(0.3),
                        //       size: 50,
                        //     ),
                        //   ),
                        // ),
                        Positioned(
                          right: 1,
                          bottom: 2,
                          child: SizedBox(
                            width: 38,
                            height: 38,
                            child: InkWell(
                              onTap: () async {
                                // Uint8List imageFile =
                                //     await pickImage(ImageSource.gallery);
                                // setState(() {
                                //   _image = imageFile;
                                // });
                                File? file =
                                    await pickImageFromGallery(context);
                                dLog('Selected Image : $file');
                                if (file != null) {
                                  final bytes = await file.readAsBytes();
                                  final base64Image = base64.encode(bytes);
                                  ref
                                      .read(imageDataProvider.notifier)
                                      .update((state) => base64Image);
                                  // imageUrl = await storeFileToFirebase(
                                  //     "sumeer/$imageId", file, ref);
                                  // setState(() {});
                                  // dLog("ImageUrl : $imageUrl");
                                }
                              },
                              child: CircleAvatar(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.7),
                                child: Icon(
                                  Icons.drive_file_rename_outline,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    title: 'First Name',
                    controller: firstNameController,
                    validator: (v) =>
                        requiredValidator(v, 'Type your first name'),
                  ),
                  TextInputFieldWidget(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    title: 'Last Name',
                    controller: lastNameController,
                    validator: (v) =>
                        requiredValidator(v, 'Type your last name'),
                  ),
                  TextInputFieldWidget(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    title: 'Job Title',
                    controller: jobTitleController,
                    validator: (v) =>
                        requiredValidator(v, 'Type your job title'),
                  ),
                  TextInputFieldWidget(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    title: 'Email',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    // validator: (v) => requiredValidator(v, "Type your email"),
                  ),
                  TextInputFieldWidget(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    title: 'Phone no',
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    // validator: (v) => requiredValidator(v, "Type your phone"),
                  ),
                  TextInputFieldWidget(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    title: 'Address',
                    controller: addressController,
                    // validator: (v) => requiredValidator(v, "Type your address"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Personal Information',
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
                          'Date of Birth',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: TextInputFieldWidget(
                                title: '',
                                controller: dayofDOBController,
                                onTap: () => _showDatePicker(context),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: TextInputFieldWidget(
                                  title: '',
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
                                  title: '',
                                  controller: yearofDOBController,
                                  onTap: () => _showDatePicker(context),
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedDate = null;
                                    _selectedDateStr = '';
                                    dayofDOBController.text = '';
                                    monthofDOBController.text = '';
                                    yearofDOBController.text = '';
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
                            title: 'Gender',
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
                            title: 'Nationality',
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
                            title: 'Passport or ID',
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
                            title: 'Marital Status',
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
                            title: 'Driving License',
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
                            text: 'Date of Birth',
                            onTap: () => _showDatePicker(context),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !_isAddGender,
                        child: Expanded(
                          child: AddPersonalDetailButton(
                            text: 'Gender',
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
                            text: 'Nationality',
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
                            text: 'Passport or ID',
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
                            text: 'Marital Status',
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
                            text: 'Driving License',
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
                      'Links',
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
                            title: 'Website',
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
                            title: 'LinkedIn',
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
                            title: 'Github',
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
                            title: 'Skype',
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
                            text: 'Websites',
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
                            text: 'LinkIn',
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
                            text: 'GitHub',
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
                            text: 'Skype',
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
      ),
      bottomSheet: Container(
        height: 80,
        margin: const EdgeInsets.all(10),
        child: SaveBottomSheetWidget(
          routeTo: true,
          cancelOnTap: () {
            context.router.pop();
          },
          onTap: () {
            if (formKey.currentState!.validate()) {
              savePerson();
              savePersonalDetail();
              // AutoRouter.of(context).pop();
              setState(() {
                AutoRouter.of(context).push(const DetailRoute());
              });
            }
            // context.router.pop();
          },
        ),
      ),
    );
  }

  String? requiredValidator(value, String text) {
    if (value == null || value.isEmpty) {
      return text;
    }
    return null;
  }

  void savePerson() async {
    // UserProfile? profile = UserProfile(
    //   image: imageUrl,
    //   name: fullNameController.text,
    //   jobTitle: jobTitleController.text,
    //   email: emailController.text,
    //   phone: phoneController.text,
    //   address: addressController.text,
    //   dOB: _selectedDateStr,
    //   gender: genderController.text,
    //   nationality: nationalityController.text,
    //   passport: passportController.text,
    //   maritalStatus: maritalController.text,
    //   drivingLicense: drivingController.text,
    //   website: websiteController.text,
    //   linkIn: linkInController.text,
    //   gitHub: githubController.text,
    //   skype: skypeController.text,
    //   createdOn:
    //       DateFormat('yyyy/MM/dd hh:mm:ss').format(DateTime.now()).toString(),
    // );
  }

  void savePersonalDetail() async {
    // final currentUser = ref.watch(authRepositoryProvider).currentUser;

    final imageData = ref.watch(imageDataProvider);
    final base64Image = imageData.isEmptyOrNull
        ? ref.watch(resumeDataProvider)?.profileImage
        : imageData;

    final oldResumeData = ref.watch(resumeDataProvider);
    PersonalInformation personalInfo = PersonalInformation(
      dateOfBirth: _selectedDateStr,
      nationality: nationalityController.text,
      identityNo: passportController.text,
      martialStatus: maritalController.text,
      militaryService: '',
      drivingLicense: drivingController.text,
      gender: genderController.text,
    );
    ref
        .read(personalInformationProvider.notifier)
        .update((state) => personalInfo);
    log(personalInfo.toString());
    log(ref.watch(personalInformationProvider).toString());
    var personalDetail = PersonalDetailSection(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      // fullName: "${firstNameController.text} ${lastNameController.text}",
      jobTitle: jobTitleController.text,
      email: emailController.text,
      phone: phoneController.text,
      address: addressController.text,

      // imageData: base64Image,
      // personalInfo: PersonalInformation(
      //   dateOfBirth: _selectedDateStr,
      // ),
      personalInfo: personalInfo,
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
    ResumeData resumeData = ResumeData(
      templateId: ref.watch(templatelIdProvider),
      resumeId: ref.watch(resumeModelIdProvider),
      profileImage: base64Image,
      personalDetail: personalDetail,
      // profile: const ProfileSection(
      //   title: "Profile",
      //   contents: [
      //     'Senior Wev Developer specilizing in fornt end development. Experienced with all stages of the development cycle for dynamic web projects. Well-versed in numerous programming languages including HTMLS,PHP OOP, Javaspript, CSS, MySQL. Strong background in project management and customer relations.',
      //   ],
      // ),
      // profile: ref.watch(profileSectionProvider),
      profile: oldResumeData?.profile,
      education: oldResumeData?.education,
      project: oldResumeData?.project,
      experience: oldResumeData?.experience,
      skill: oldResumeData?.skill,
      languages: oldResumeData?.languages,
      // personalInformation: personalInfo,
    );
    ref.read(resumeDataProvider.notifier).update((state) => resumeData);
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
          'Select Date of Birth',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        content: DatePickerWidget(
          looping: false, // default is not looping
          firstDate: DateTime(1990, 01, 01),
          initialDate: DateTime.now(),
          dateFormat: 'dd-MMMM-yyyy',
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
                _selectedDateStr = DateFormat('dd-MMMM-yyyy')
                    .format(_selectedDate ?? DateTime.now());

                setState(() {
                  _selectedDate = _selectedDate ?? DateTime.now();
                  dayofDOBController.text = _selectedDateStr.split('-')[0];
                  monthofDOBController.text = _selectedDateStr.split('-')[1];
                  yearofDOBController.text = _selectedDateStr.split('-')[2];
                });
              },
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
              ),
              child: const Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}
