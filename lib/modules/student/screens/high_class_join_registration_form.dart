import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:samastha/gen/assets.gen.dart';
import 'package:samastha/modules/general/bloc/core_bloc.dart';
import 'package:samastha/modules/general/model/category_model.dart';
import 'package:samastha/modules/general/model/country_model.dart';
import 'package:samastha/modules/general/screens/common_search_result.dart';
import 'package:samastha/modules/student/bloc/admission_bloc.dart';
import 'package:samastha/modules/student/models/register_student_model.dart';
import 'package:samastha/modules/student/models/student_register_model.dart';
import 'package:samastha/modules/student/screens/application_started_screen.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/image_picker.dart';
import 'package:samastha/widgets/alert_box_widgets.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_form_elements.dart';
import 'package:samastha/widgets/custom_snackbar.dart';
import 'package:samastha/widgets/default_loading_widget.dart';
import 'package:samastha/widgets/dotted_border_custom.dart';

class HighClassJoinRegistrationForm extends StatefulWidget {
  static const path = '/high-class-join-registration-form';
  const HighClassJoinRegistrationForm({super.key, required this.enableTC});

  final bool enableTC;

  @override
  State<HighClassJoinRegistrationForm> createState() =>
      _HighClassJoinRegistrationFormState();
}

class _HighClassJoinRegistrationFormState
    extends State<HighClassJoinRegistrationForm> {
  DateTime? dob;

  List<CategoryModel> time = [];

  CoreBloc coreBloc = CoreBloc();

  String? gender = 'Male';

  CountryModel? selectedCountry;
  CountryModel? selectedState;

  AdmissionBloc bloc = AdmissionBloc();

  bool isLoading = true;

  CategoryModel? selectedClass;

  CategoryModel? selectedSlot;

  File? tcFile;
  File? photoFile;
  File? birthCertificateFile;

  String? studentName;
  String? email;

  String? tcNumber;
  var formKey = GlobalKey<FormState>();

  int selectedClassId = 0;

  @override
  void initState() {
    getInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(
        title: 'Student Registration',
      ),
      body: isLoading
          ? const LoadingWidget()
          : SingleChildScrollView(
              padding: pagePadding,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomDropdownButtonFormField<CategoryModel>(
                        validator: (value) {
                          if (value == null) {
                            return 'Choose a class to continue';
                          }
                          return null;
                        },
                        hintText: 'Select class',
                        items: bloc.classes,
                        value: selectedClass,
                        onChanged: (val) async {
                          selectedClass = val;
                          if (selectedClass?.id != null)
                            await bloc.fetchSlots(selectedClass?.id);
                          setState(() {});
                        }),
                    const Gap(16),
                    TextFieldCustom(
                      labelText: 'Student Full Name',
                      hintText: 'Enter student full name',
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter full name of student';
                        }
                        return null;
                      },
                      onChanged: (text) {
                        studentName = text;
                      },
                    ),
                    // const Gap(16),
                    // TextFieldCustom(
                    //   labelText: 'Student email ',
                    //   hintText: 'Enter student email',
                    //   keyboardType: TextInputType.emailAddress,
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Enter email of student';
                    //     }
                    //     return null;
                    //   },
                    //   onChanged: (text) {
                    //     email = text;
                    //   },
                    // ),
                    const Gap(16),
                    DatePickerTextField(
                      onChanged: (value) {
                        dob = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Choose Date of Birth';
                        }
                        return null;
                      },
                      value: dob,
                      labelText: 'Date of Birth DD-MM-YYYY',
                      hintText: 'Select date of birth',
                      pickFromFuture: false,
                      initialDate: DateTime(DateTime.now().year - 5,
                          DateTime.now().month, DateTime.now().day),
                      lastDate: DateTime(DateTime.now().year - 5,
                          DateTime.now().month, DateTime.now().day),
                      // initialDate: DateTime(DateTime.now().year - 5),
                      // lastDate: DateTime(DateTime.now().year - 5, 12, 31),
                    ),
                    const Gap(16),
                    CustomDropdownButtonFormField(
                        hintText: 'Gender',
                        value: gender,
                        items: const ['Male', 'Female'],
                        onChanged: (val) {
                          gender = val;
                        }),
                    const Gap(16),
                    TextFieldCustom(
                      controller:
                          TextEditingController(text: selectedCountry?.title),
                      readOnlyField: true,

                      validator: (value) {
                        if (selectedCountry == null) {
                          return 'Choose a country';
                        }
                        return null;
                      },
                      onTap: () async {
                        final CountryModel? result = //open country list
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CustomSearchResult<CountryModel>(
                                    title: 'Countries',
                                    search: (p0) {
                                      return coreBloc.fetchCountriesList(p0);
                                    },
                                  ),
                                ));
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (result != null) {
                          setState(() {
                            selectedCountry = result;
                            selectedState = null;
                          });
                        }
                      },
                      // isEnabled: false,
                      labelText: 'Country',
                      suffixWidget: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Assets.svgs.dropdown.svg(),
                      ),
                    ),
                    const Gap(16),
                    TextFieldCustom(
                      validator: (value) {
                        if (selectedState == null) {
                          return 'Choose a state';
                        }
                        return null;
                      },
                      controller:
                          TextEditingController(text: selectedState?.title),
                      onTap: () async {
                        if (selectedCountry == null) {
                          return SnackBarCustom.success(
                              'Choose a country first');
                        }
                        final CountryModel? result = //open state list
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CustomSearchResult<CountryModel>(
                                    title: 'State',
                                    search: (p0) {
                                      return coreBloc.fetchStateList(
                                          selectedCountry!.id!, p0);
                                    },
                                  ),
                                ));
                        if (result != null) {
                          setState(() {
                            selectedState = result;
                          });
                        }
                      },
                      readOnlyField: true,
                      labelText: 'State',
                      suffixWidget: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Assets.svgs.dropdown.svg(),
                      ),
                    ),
                    const Gap(16),
                    CustomDropdownButtonFormField<CategoryModel>(
                        hintText: 'Select your time slot',
                        items: bloc.slots,
                        value: selectedSlot,
                        validator: (value) {
                          if (value == null) {
                            return 'Choose atleast one time slot';
                          }
                          return null;
                        },
                        onChanged: (val) {
                          selectedSlot = val;

                          setState(() {
                            if (!time.contains(val)) time.add(val!);
                          });
                        }),
                    const Gap(16),
                    Wrap(
                      spacing: 5,
                      children: time
                          .map((CategoryModel e) => Chip(
                                label: Text(
                                  e.title ?? '',
                                  style: labelMedium.darkBG,
                                ),
                                onDeleted: () {
                                  setState(() {
                                    time.remove(e);
                                  });
                                },
                                deleteIcon: Assets.svgs.closeBlue.svg(),
                                visualDensity:
                                    VisualDensity.adaptivePlatformDensity,
                                deleteIconColor: Colors.amber,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                  horizontal: 0,
                                ),
                              ))
                          .toList(),
                    ),
                    if (widget.enableTC) ...[
                      const Gap(16),
                      TextFieldCustom(
                        onChanged: (text) {
                          tcNumber = text;
                        },
                        labelText: 'TC Number',
                        hintText: 'TC Number',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter TC number of student';
                          }
                          return null;
                        },
                      ),
                    ],
                    const Gap(16),
                    Row(
                      children: [
                        if (widget.enableTC) ...[
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: [
                                    'jpg',
                                    'pdf',
                                  ],
                                );

                                if (result != null) {
                                  tcFile = File(result.files.single.path!);
                                  setState(() {});
                                } else {
                                  // User canceled the picker
                                  //
                                }
                              },
                              child: DottedBorderCustom(
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: tcFile == null
                                        ? [
                                            Center(
                                                child: Assets
                                                    .svgs.cloudComputing
                                                    .svg()),
                                            Text(
                                              'Upload TC',
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.inter(
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                                color: ColorResources.darkBG
                                                    .withOpacity(.5),
                                              ),
                                            ),
                                            Text(
                                              'jpeg or pdf',
                                              style: labelSmall.s12.darkBG,
                                            )
                                          ]
                                        : [
                                            Center(
                                                child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  tcFile = null;
                                                });
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.red[200],
                                                size: 42,
                                              ),
                                            )),
                                            Text(
                                              tcFile?.path.split('/').last ??
                                                  "",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.inter(
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                                color: ColorResources.darkBG
                                                    .withOpacity(.5),
                                              ),
                                            ),
                                            Text(
                                              'Tap to change',
                                              style: labelSmall.s12.darkBG,
                                            )
                                          ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Gap(16),
                        ],
                        Expanded(
                            child: GestureDetector(
                          onTap: () async {
                            ImageSource? source =
                                await AlertBoxWidgets.getSource(context);
                            if (source != null) {
                              File? file = await pickImage(
                                source,
                                enableCrop: true,
                              );

                              if (file != null) {
                                setState(() {
                                  photoFile = file;
                                });
                              }
                            }
                          },
                          child: DottedBorderCustom(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: photoFile == null ? 20 : 10),
                              child: Column(
                                children: photoFile == null
                                    ? [
                                        Center(
                                            child: Assets.svgs.cloudComputing
                                                .svg()),
                                        Text(
                                          'Upload Photo',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.inter(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            color: ColorResources.darkBG
                                                .withOpacity(.5),
                                          ),
                                        ),
                                        Text(
                                          'jpeg or png',
                                          style: labelSmall.s12.darkBG,
                                        )
                                      ]
                                    : [
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Image.file(
                                              photoFile!,
                                              height: 65,
                                              width: 65,
                                              opacity:
                                                  const AlwaysStoppedAnimation(
                                                      0.5),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Center(
                                                    child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      photoFile = null;
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Colors.red[200],
                                                    size: 42,
                                                  ),
                                                )),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Text(
                                          photoFile?.path.split('/').last ?? "",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.inter(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            color: ColorResources.darkBG
                                                .withOpacity(.5),
                                          ),
                                        ),
                                        Text(
                                          'Tap to change',
                                          style: labelSmall.s12.darkBG,
                                        )
                                      ],
                              ),
                            ),
                          ),
                        )),
                        const Gap(16),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowedExtensions: [
                                  'jpg',
                                  'pdf',
                                ],
                              );

                              if (result != null) {
                                setState(() {
                                  birthCertificateFile =
                                      File(result.files.single.path!);
                                });
                              } else {
                                // User canceled the picker
                                //
                              }
                            },
                            child: DottedBorderCustom(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Column(
                                  children: birthCertificateFile == null
                                      ? [
                                          Center(
                                              child: Assets.svgs.cloudComputing
                                                  .svg()),
                                          Text(
                                            'Upload B.C',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.inter(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              color: ColorResources.darkBG
                                                  .withOpacity(.5),
                                            ),
                                          ),
                                          Text(
                                            'jpeg or pdf',
                                            style: labelSmall.s12.darkBG,
                                          )
                                        ]
                                      : [
                                          Center(
                                              child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                birthCertificateFile = null;
                                              });
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.red[200],
                                              size: 42,
                                            ),
                                          )),
                                          Text(
                                            birthCertificateFile?.path
                                                    .split('/')
                                                    .last ??
                                                "",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.inter(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              color: ColorResources.darkBG
                                                  .withOpacity(.5),
                                            ),
                                          ),
                                          Text(
                                            'Tap to change',
                                            style: labelSmall.s12.darkBG,
                                          )
                                        ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(16),
                    SubmitButton(
                      'Submit',
                      onTap: (loader) async {
                        if (formKey.currentState!.validate()) {
                          // if(birthCertificateFile!=null && tcFile!=null && photoFile!=null ){
                          //submit api
                          loader();
                          final StudentRegisterModel? model =
                              await bloc.registerStudent(RegisterStudentModel(
                                  birthCertificate: birthCertificateFile,
                                  classId: selectedClass?.id,
                                  countryId: selectedCountry?.id,
                                  dob: dob,
                                  // email: email,
                                  gender: gender,
                                  isFirstStandard: 0,
                                  name: studentName,
                                  stateId: selectedState?.id,
                                  studentPhoto: photoFile,
                                  tcFile: tcFile,
                                  tcNumber: tcNumber,
                                  timeslotId: time.map((e) => e.id!).toList()));
                          loader();

                          if (model != null) {
                            Navigator.popAndPushNamed(
                                context, ApplicationStartedScreen.path,
                                arguments: model);
                          }
                          // } else {
                          //   showErrorMessage('Upload all required files');
                          // }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void getInitialData() async {
    await bloc.fetchClasses(true);
    // bloc.classes.removeWhere((element) => element.isFirstStandard == 1);
    if (selectedClass?.id != null) await bloc.fetchSlots(selectedClass?.id);
    setState(() {
      isLoading = false;
    });
  }
}

class TimeOfDayCustom extends TimeOfDay {
  const TimeOfDayCustom({required super.hour, required super.minute});

  @override
  String toString() {
    return '$hour:$minute AM';
  }
}
