import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:samastha/modules/student/bloc/leave_controller.dart';
import 'package:samastha/modules/student/models/leave_type_model.dart';
import 'package:samastha/modules/student/screens/leave_of_absence/leave_received_screen.dart';
import 'package:samastha/theme/color_resources.dart';
import 'package:samastha/theme/t_style.dart';
import 'package:samastha/utils/error_reload.dart';
import 'package:samastha/widgets/app_bars_custom.dart';
import 'package:samastha/widgets/custom_form_elements.dart';
import 'package:samastha/widgets/default_loading_widget.dart';

class RequestLeaveForm extends StatefulWidget {
  const RequestLeaveForm({super.key});
  static const String path = '/request-leave';

  @override
  State<RequestLeaveForm> createState() => _RequestLeaveFormState();
}

class _RequestLeaveFormState extends State<RequestLeaveForm> {
  final formKey = GlobalKey<FormState>();

  DateTimeRange? leaveDate;

  LeaveController bloc = LeaveController();

  late Future<List<LeaveTypeModel>> leaveTypeFuture;

  var leaveDescriptionTC = TextEditingController();

  LeaveTypeModel? selectedLeaveReason;

  var numOfDaysTC = TextEditingController();

  @override
  void initState() {
    leaveTypeFuture = bloc.fetchLeaveTypes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: pagePadding.copyWith(bottom: 30),
        child: SubmitButton(
          'Apply for Leave',
          onTap: (loader) async {
            if (formKey.currentState?.validate() ?? false) {
              final bool result = await bloc.applyLeave(selectedLeaveReason,
                  numOfDaysTC.text, leaveDate, leaveDescriptionTC.text);
              if (result) {
                Navigator.popAndPushNamed(context, LeaveReceivedScreen.path);
              }
            }
          },
        ),
      ),
      appBar: const SimpleAppBar(title: 'Apply for leave'),
      body: FutureBuilder<List<LeaveTypeModel>>(
          future: leaveTypeFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return errorReload(snapshot.error.toString());
            }
            if (snapshot.hasData) {
              List<LeaveTypeModel> data = snapshot.data ?? [];
              return SingleChildScrollView(
                padding: pagePadding,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomDropdownButtonFormField(
                        hintText: 'Select a reason for leave',
                        items: data,
                        onChanged: (value) {
                          selectedLeaveReason = value;
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Choose a item ';
                          }
                          return null;
                        },
                      ),
                      const Gap(24),
                      DateRangePickerTextField(
                        onChanged: (value) {
                          leaveDate = value;
                          var gap = leaveDate?.end.difference(leaveDate!.start);
                          numOfDaysTC.text = (gap!.inDays.abs()+1).toString();
                        },
                        value: leaveDate,
                        hintText: 'Leave dates',
                        labelText: 'Leave dates DD-MM-YYYY',
                        validator: (value) {
                          if (value?.isEmpty ?? false) {
                            return 'Select a date';
                          }
                          return null;
                        },
                      ),
                      const Gap(24),
                      TextFieldCustom(
                        controller: numOfDaysTC,
                        hintText: 'Number of days',
                        labelText: 'Number of days',
                        readOnlyField: true,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || (value.isEmpty ?? false)) {
                            return 'Enter number of days';
                          }
                          return null;
                        },
                      ),
                      const Gap(24),
                      TextFieldCustom(
                        controller: leaveDescriptionTC,
                        minLines: 5,
                        maxLines: 10,
                        hintText: 'Description',
                        textAlign: TextAlign.start,
                        hintStyle:
                            labelLarge.copyWith(color: ColorResources.darkBG),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return const LoadingWidget();
            }
          }),
    );
  }
}
