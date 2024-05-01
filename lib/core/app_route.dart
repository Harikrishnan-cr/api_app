import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:samastha/core/app_constants.dart';
import 'package:samastha/modules/authentication/screens/forgot_password.dart';
import 'package:samastha/modules/authentication/screens/password_reset_screen.dart';
import 'package:samastha/modules/authentication/screens/register_screen.dart';
import 'package:samastha/modules/cart/screen/cart_screen.dart';
import 'package:samastha/modules/courses/screens/chapter_details_screen.dart';
import 'package:samastha/modules/courses/screens/course_detail_screen.dart';
import 'package:samastha/modules/courses/screens/courses_search_screen.dart';
import 'package:samastha/modules/courses/screens/video_player_screen.dart';
import 'package:samastha/modules/dashboard/screens/about_screen.dart';
import 'package:samastha/modules/dashboard/screens/faq_screen.dart';
import 'package:samastha/modules/dashboard/screens/my_courses_screen.dart';
import 'package:samastha/modules/kids/modules/classroom/screen/kids_classroom_screen.dart';
import 'package:samastha/modules/kids/modules/dashboard/screen/kids_dashboard_screen.dart';
import 'package:samastha/modules/kids/modules/exam/screen/kids_exam_screen.dart';
import 'package:samastha/modules/kids/modules/home/screen/kids_home_parent.dart';
import 'package:samastha/modules/kids/modules/home/screen/kids_home_screen.dart';

import 'package:samastha/modules/kids/modules/test_and_assignments/screen/kids_test_and_assignments_screen.dart';
import 'package:samastha/modules/madrasa/models/subjects_model.dart';
import 'package:samastha/modules/madrasa/screens/class_room_screen.dart';
import 'package:samastha/modules/madrasa/screens/course_materials.dart';
import 'package:samastha/modules/madrasa/screens/regular_class_screen.dart';
import 'package:samastha/modules/madrasa/screens/time_table_screen.dart';
import 'package:samastha/modules/parent/screens/certificate_detail_screen.dart';
import 'package:samastha/modules/parent/screens/certificates_list_screen.dart';
import 'package:samastha/modules/parent/screens/parent_profile_edit_screen.dart';
import 'package:samastha/modules/parent/screens/profile_edit_screen.dart';

import 'package:samastha/modules/dashboard/screens/dashbaord_screen.dart';
import 'package:samastha/modules/dashboard/screens/home_screen.dart';
import 'package:samastha/modules/dashboard/screens/my_profile_screen.dart';
import 'package:samastha/modules/notification/screens/notification_list_screen.dart';
import 'package:samastha/modules/parent/screens/applications_screen.dart';

import 'package:samastha/modules/parent/screens/my_kids_list_screen.dart';
import 'package:samastha/modules/parent/screens/parent_home_screen.dart';
import 'package:samastha/modules/parent/screens/parent_module_login.dart';
import 'package:samastha/modules/parent/screens/rewards_screen.dart';
import 'package:samastha/modules/parent/screens/user_profile_edit_screen.dart';
import 'package:samastha/modules/parent/screens/video_saved_screen.dart';
import 'package:samastha/modules/student/models/assignment_model.dart';
import 'package:samastha/modules/student/models/mark_sheet_model.dart';
import 'package:samastha/modules/student/models/mcq_exam_result_model.dart';
import 'package:samastha/modules/student/models/student_login_model.dart';
import 'package:samastha/modules/student/models/student_register_model.dart';
import 'package:samastha/modules/student/screens/academic_calendar.dart';
import 'package:samastha/modules/student/screens/application_completed_screen.dart';
import 'package:samastha/modules/student/screens/application_started_screen.dart';
import 'package:samastha/modules/student/screens/leave_of_absence/reschedule_screen.dart';
import 'package:samastha/modules/student/screens/missed_class/one_to_one_schedule_screen.dart';
import 'package:samastha/modules/student/screens/student_module_login.dart';
import 'package:samastha/modules/student/screens/tests_assignments/assignment_details_screen.dart';
import 'package:samastha/modules/student/screens/tests_assignments/assignments_screen.dart';
import 'package:samastha/modules/student/screens/chat/chart_with_usthad.dart';
import 'package:samastha/modules/student/screens/course_plan_screen.dart';
import 'package:samastha/modules/student/screens/fee_payment_summary.dart';
import 'package:samastha/modules/student/screens/high_class_join_registration_form.dart';
import 'package:samastha/modules/student/screens/join_higher_class_welcome_screen.dart';
import 'package:samastha/modules/student/screens/leader_board.dart';
import 'package:samastha/modules/student/screens/leave_of_absence/leave_received_screen.dart';
import 'package:samastha/modules/student/screens/leave_of_absence/leave_requests_list_screen.dart';
import 'package:samastha/modules/student/screens/leave_of_absence/request_leave.dart';
import 'package:samastha/modules/student/screens/live_class_room_welcome_screen.dart';
import 'package:samastha/modules/student/screens/mcq/marksheet_screen.dart';
import 'package:samastha/modules/student/screens/mcq/mcq_welcome_screen.dart';
import 'package:samastha/modules/student/screens/mcq/quiz_screen.dart';
import 'package:samastha/modules/student/screens/missed_class/missed_classes_screen.dart';
import 'package:samastha/modules/student/screens/new_join_registration_form.dart';
import 'package:samastha/modules/student/screens/missed_class/one_to_one_class.dart';
import 'package:samastha/modules/student/screens/performance_analysys_dashboard.dart';
import 'package:samastha/modules/student/screens/performance_score.dart';
import 'package:samastha/modules/student/screens/student_beyond_age_screen.dart';
import 'package:samastha/modules/student/screens/student_dashboard_screen.dart';
import 'package:samastha/modules/student/screens/student_regular_class_welcome_screen.dart';
import 'package:samastha/modules/student/screens/summary_dashboard_screen.dart';
import 'package:samastha/modules/student/screens/tests_assignments/assignmnet_marksheet_screen.dart';
import 'package:samastha/modules/student/screens/tests_assignments/daily_quiz_screen.dart';
import 'package:samastha/modules/student/screens/tests_assignments/exam_marksheet.dart';
import 'package:samastha/modules/student/screens/tests_assignments/exam_questions_screen.dart';
import 'package:samastha/modules/student/screens/tests_assignments/exam_solution_screen.dart';
import 'package:samastha/modules/student/screens/tests_assignments/exam_welcome_screen.dart';
import 'package:samastha/modules/student/screens/tests_assignments/exams_list_screen.dart';
import 'package:samastha/modules/student/screens/tests_assignments/quiz_mark_sheet_screen.dart';
import 'package:samastha/modules/student/screens/tests_assignments/quiz_question_screen.dart';
import 'package:samastha/modules/student/screens/tests_assignments/quiz_solutions_screen.dart';
import 'package:samastha/modules/student/screens/tests_assignments/quizes_welcome_screen.dart';
import 'package:samastha/modules/student/screens/tests_assignments/quizzes_list_screen.dart';
import 'package:samastha/modules/student/screens/tests_assignments/solution_screen.dart';
import 'package:samastha/modules/student/screens/tests_assignments/tests_dashboard.dart';
import 'package:samastha/modules/student/screens/usthad_detail_screen.dart';
import 'package:samastha/modules/student/screens/usthads_list_screen.dart';
import 'package:samastha/modules/student/screens/viva/completed_viva_screen.dart';
import 'package:samastha/modules/student/screens/viva/start_viva_call_screen.dart';
import 'package:samastha/modules/student/screens/viva/viva_appoinmet_booking_screen.dart';

import 'package:samastha/widgets/app_bars_custom.dart';

class Routes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // logInfo(settings.name);
    Uri uri = Uri.parse(settings.name ?? "");
    switch (uri.path) {
      // case SplashScreen.path:
      //   return pageRoute(settings, const SplashScreen());

      case RegisterScreen.path:
        return pageRoute(settings, const RegisterScreen());
      // case OTPScreen.path:
      //   return pageRoute(
      //       settings,
      //       OTPScreen(
      //         verificationId: settings.arguments as String,

      //       ));
      case ProfileEditScreen.path:
        return pageRoute(
            settings,
            ProfileEditScreen(
              isAfterLogin: settings.arguments as bool? ?? false,
            ));

      case StudentprofileViewScrenn.path:
        return pageRoute(settings, const StudentprofileViewScrenn());

      case DashboardScreen.path:
        return pageRoute(settings, const DashboardScreen());
      case KidsDashboardScreen.path:
        return pageRoute(settings, const KidsDashboardScreen());
      case ForgotPasswordScreen.path:
        return pageRoute(settings, const ForgotPasswordScreen());
      case ResetPasswordScreen.path:
        return pageRoute(settings,
            ResetPasswordScreen(username: settings.arguments as String?));
      case HomeScreen.path:
        return pageRoute(settings, const HomeScreen());
      case KidsHomeScreen.path:
        // Map<String, dynamic> data = settings.arguments as Map<String, dynamic>;

        return pageRoute(
            settings,
            const KidsHomeScreen(
                // isParent: data['isParent'] as bool,
                // studnetId: data['studnetId'] as int?,
                ));

      case KidsHomeParentScreen.path:
        Map<String, dynamic> data = settings.arguments as Map<String, dynamic>;

        return pageRoute(
            settings,
            KidsHomeParentScreen(
              isParent: data['isParent'] as bool,
              studnetId: data['studnetId'] as int?,
            ));
      // return pageRoute(settings, KidsHomeScreen());
      case KidsClassRoomScreen.path:
        return pageRoute(settings, const KidsClassRoomScreen());
      case KidsExamScreen.path:
        return pageRoute(settings, const KidsExamScreen());
      // case KidsLeaderBoardScreen.path:
      //   return pageRoute(settings, const KidsLeaderBoardScreen());
      case KidsTestAndAssignmentsScreen.path:
        return pageRoute(settings, const KidsTestAndAssignmentsScreen());
      case ParentModuleLogin.path:
        return pageRoute(settings, const ParentModuleLogin());
      case ParentModuleSetPassword.path:
        return pageRoute(
            settings,
            ParentModuleSetPassword(
                isResetPassword: settings.arguments as bool));
      case ParentHomeScreen.path:
        return pageRoute(settings, const ParentHomeScreen());
      case MyKidsListScreen.path:
        return pageRoute(settings, const MyKidsListScreen());
      case NewJoinRegistrationForm.path:
        return pageRoute(settings, const NewJoinRegistrationForm());
      case StudentBeyondAgeScreen.path:
        return pageRoute(
          settings,
          const StudentBeyondAgeScreen(),
        );
      case HighClassJoinRegistrationForm.path:
        return pageRoute(
            settings,
            HighClassJoinRegistrationForm(
              enableTC: settings.arguments as bool,
            ));
      case ApplicationCompletedScreen.path:
        return pageRoute(
            settings,
            ApplicationCompletedScreen(
              model: settings.arguments as StudentRegisterModel,
            ));
      case JoinHigherClassWelcomeScreen.path:
        return pageRoute(settings, const JoinHigherClassWelcomeScreen());
      case ApplicationStartedScreen.path:
        StudentRegisterModel? model =
            settings.arguments as StudentRegisterModel?;
        return pageRoute(settings, ApplicationStartedScreen(model: model));
      case MyApplicationsScreen.path:
        return pageRoute(settings, const MyApplicationsScreen());
      case MCQWelcomeScreen.path:
        return pageRoute(
            settings,
            MCQWelcomeScreen(
              studentId: settings.arguments as int,
            ));
      case MCQQuizScreen.path:
        var data = settings.arguments as Map<String, int>;
        return pageRoute(
            settings,
            MCQQuizScreen(
              examId: data['examId'] as int,
              studentId: data['studentId'] as int,
            ));
      case ExamQuestionScreen.path:
        var data = settings.arguments as Map<String, dynamic>;
        return pageRoute(
            settings,
            ExamQuestionScreen(
              examId: data['examId'] as int,
              examName: data['examName'] as String,
              studentId: data['studentId'] as int,
            ));
      case MCQMarkSheetScreen.path:
        return pageRoute(
            settings,
            MCQMarkSheetScreen(
              result: settings.arguments as ExamResultModel,
            ));
      case AppointmentBookingScreen.path:
        return pageRoute(
            settings,
            AppointmentBookingScreen(
              studentId: settings.arguments as int,
            ));
      case StartVivaCallScreen.path:
        return pageRoute(settings, const StartVivaCallScreen());
      case ParentProfileEditScreen.path:
        return pageRoute(settings, const ParentProfileEditScreen());
      case CompletedVivaScreen.path:
        return pageRoute(settings, const CompletedVivaScreen());
      case MyProfileScreen.path:
        return pageRoute(settings, const MyProfileScreen());
      case StudentRegularClassWelcomeScreen.path:
        return pageRoute(settings, const StudentRegularClassWelcomeScreen());
      case StudentDashboardScreen.path:
        return pageRoute(settings, const StudentDashboardScreen());
      case LiveClassWelcomeScreen.path:
        return pageRoute(settings, const LiveClassWelcomeScreen());
      case StudentSummaryDashboardScreen.path:
        return pageRoute(
            settings,
            StudentSummaryDashboardScreen(
              isShowBack: settings.arguments as bool?,
            ));
      case UsthadsListScreen.path:
        return pageRoute(settings, const UsthadsListScreen());
      case UsthadDetailScreen.path:
        return pageRoute(
          settings,
          UsthadDetailScreen(
            tutorId: settings.arguments as int,
          ),
        );
      case ChatWithUsthad.path:
        return pageRoute(settings, const ChatWithUsthad());
      case PerformanceAnalysisDashboard.path:
        return pageRoute(settings, const PerformanceAnalysisDashboard());
      case PerformanceScore.path:
        return pageRoute(settings, PerformanceScore());
      case FeePaymentSummary.path:
        return pageRoute(
            settings,
            FeePaymentSummary(
              title: settings.arguments as String,
            ));
      case CoursePlanScreen.path:
        return pageRoute(settings, const CoursePlanScreen());
      case AcademicCalendar.path:
        return pageRoute(settings, const AcademicCalendar());
      case LeaderBoardScreen.path:
        var data = settings.arguments as Map<String, dynamic>?;
        return pageRoute(
            settings,
            LeaderBoardScreen(
              isKid: data?["isKid"] as bool?,
            ));
      case MissedClassesScreen.path:
        return pageRoute(settings,
            MissedClassesScreen(studentId: settings.arguments as int));
      case OneToOneScheduleScreen.path:
        var data = settings.arguments as Map<String, dynamic>;
        return pageRoute(
            settings,
            OneToOneScheduleScreen(
              missedClassId: data["missedClassId"] as int,
              subjectId: data["studentId"] as int,
            ));
      case OneToOneClassWelcomeScreen.path:
        var data = settings.arguments as Map;
        return pageRoute(
            settings,
            OneToOneClassWelcomeScreen(
              missedClassId: data["missedClassId"] as int,
              subjectId: data["subjectId"] as int,
            ));
      case LeaveRequestsListScreen.path:
        return pageRoute(settings, const LeaveRequestsListScreen());
      case RequestLeaveForm.path:
        return pageRoute(settings, const RequestLeaveForm());
      case LeaveReceivedScreen.path:
        return pageRoute(settings, const LeaveReceivedScreen());
      case TestsAndAssignmentsDashboard.path:
        return pageRoute(settings, const TestsAndAssignmentsDashboard());
      case AssignmentsScreen.path:
        return pageRoute(settings, const AssignmentsScreen());

      case ExamsListScreen.path:
        return pageRoute(settings, const ExamsListScreen());
      case QuizzesListScreen.path:
        return pageRoute(
            settings, QuizzesListScreen(studentId: settings.arguments as int));

      case AssignmentDetailsScreen.path:
        return pageRoute(settings, const AssignmentDetailsScreen());
      case AssignmentMarkSheetScreen.path:
        return pageRoute(
            settings,
            AssignmentMarkSheetScreen(
              assignmentModel: settings.arguments as AssignmentModel,
            ));
      case ExamWelcomeScreen.path:
        var data = settings.arguments as Map<String, dynamic>;
        return pageRoute(
            settings,
            ExamWelcomeScreen(
              examId: data['examId'] as int,
              examName: data['examName'] as String,
            ));
      case ExamSolutionScreen.path:
        return pageRoute(
            settings,
            ExamSolutionScreen(
              questionId: settings.arguments as int,
            ));
      case ExamMarkSheetScreen.path:
        return pageRoute(
            settings,
            ExamMarkSheetScreen(
              markModel: settings.arguments as MarkSheetModel?,
            ));
      case QuizWelcomeScreen.path:
        var data = settings.arguments as Map<String, dynamic>;
        return pageRoute(
            settings,
            QuizWelcomeScreen(
              quizzName: data['quizzName'] as String,
              quizzId: data['quizzId'] as int,
              studentId: data['studentId'] as int,
            ));
      case QuizQuestionScreen.path:
        var data = settings.arguments as Map<String, dynamic>;
        return pageRoute(
            settings,
            QuizQuestionScreen(
                quizId: data['quizzId'] as int,
                studentId: data['studentId'] as int,
                quizName: data['quizzName'] as String));
      case QuizMarkSheetScreen.path:
        return pageRoute(settings, const QuizMarkSheetScreen());
      case QuizSolutionsScreen.path:
        return pageRoute(settings,
            QuizSolutionsScreen(solutions: settings.arguments as String));
      case DailyQuizScreen.path:
        return pageRoute(settings, const DailyQuizScreen());
      case SolutionScreen.path:
        return pageRoute(
            settings,
            SolutionScreen(
              questionId: settings.arguments as int,
            ));
      case NotificationListScreen.path:
        return pageRoute(settings, const NotificationListScreen());
      case AboutScreen.path:
        return pageRoute(settings, const AboutScreen());
      case CartScreen.path:
        return pageRoute(settings, const CartScreen());
      case RewardsScreen.path:
        return pageRoute(settings, const RewardsScreen());
      case FaqScreen.path:
        return pageRoute(settings, const FaqScreen());
      case CertificatesListScreen.path:
        return pageRoute(settings, const CertificatesListScreen());
      case SavedVideoScreen.path:
        return pageRoute(settings, const SavedVideoScreen());
      case CertificateDetailScreen.path:
        var data = settings.arguments as Map<String, dynamic>;
        return pageRoute(
            settings,
            CertificateDetailScreen(
              certificateUrl: data['certificateUrl'] as String,
            ));
      case MyCoursesScreen.path:
        return pageRoute(settings, const MyCoursesScreen());
      case CourseDetailScreen.path:
        Map<String, dynamic> data = settings.arguments as Map<String, dynamic>;
        return pageRoute(
            settings,
            CourseDetailScreen(
              courseId: data['id'] as int,
              courseName: data['name'] as String,
              isPurchased: data['isPurchased'] ?? false,
            ));
      case VideoPlayerScreen.path:
        Map<String, dynamic> data = settings.arguments as Map<String, dynamic>;
        return pageRoute(
            settings,
            VideoPlayerScreen(
              currentIndex: data['currentIndex'],
              lessonList: data['lessons'],
            ));
      case ChapterDetailsScreen.path:
        Map<String, dynamic> data = settings.arguments as Map<String, dynamic>;
        return pageRoute(
            settings,
            ChapterDetailsScreen(
              currentIndex: data['currentIndex'],
              lessonList: data['data'],
            ));

      case RescheduleScreen.path:
        Map<String, dynamic> data = settings.arguments as Map<String, dynamic>;
        return pageRoute(
            settings,
            RescheduleScreen(
              studentId: data["studentId"] as int,
              leaveId: data["leaveId"] as int,
              leaveStartDate: data["leaveDate"] as DateTime?,
            ));
      case CoursesSearchScreen.path:
        return pageRoute(settings, const CoursesSearchScreen());
      case OnlineMadrasaRegularClassScreen.path:
        Map<String, dynamic> data = settings.arguments as Map<String, dynamic>;
        return pageRoute(
            settings,
            OnlineMadrasaRegularClassScreen(
              isParent: data['isParent'] as bool,
              studnetId: data['studnetId'] as int?,
            ));
      case ClassRoomScreen.path:
        return pageRoute(settings, const ClassRoomScreen());
      case TimeTableScreen.path:
        return pageRoute(settings, const TimeTableScreen());
      case CourseMaterialsScreen.path:
        return pageRoute(
            settings,
            CourseMaterialsScreen(
              batchLessonId: settings.arguments as int,
            ));
      case StudentModuleSetPassword.path:
        return pageRoute(
            settings,
            StudentModuleSetPassword(
              isResetPassword: settings.arguments as bool,
            ));
      case StudentModuleLogin.path:
        return pageRoute(settings, const StudentModuleLogin());
      case ClassRoomLessonScreen.path:
        return pageRoute(
            settings,
            ClassRoomLessonScreen(
              subjectId: settings.arguments as SubjectModel,
            ));
      default:
      // // return null;
      // return pageRouteTwo(
      //     settings,
      //     const Scaffold(
      //       appBar: SimpleAppBar(
      //           title: '',
      //           leadingWidget: Icon(
      //             Icons.arrow_back,
      //             color: Colors.transparent,
      //           )),
      //       body: Center(
      //         child: Text('page not found!'),
      //       ),
      //     ));

      //     return pageRoute(
      //   settings,
      //   const Scaffold(
      //     appBar: SimpleAppBar(
      //       title: '',
      //       leadingWidget: IconButton(
      //         onPressed: null,
      //         icon: Icon(
      //           Icons.abc,
      //           color: Colors.transparent,
      //         ),
      //       ),
      //     ),
      //     body: Center(
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Text('page not found!'),
      //           // Gap(10),
      //           IconButton(
      //               onPressed: null,
      //               icon: Icon(
      //                 Icons.refresh,
      //                 color: Colors.black,
      //               ))
      //         ],
      //       ),
      //     ),
      //   ),
      // );
    }
  }

  static CupertinoPageRoute<dynamic> pageRoute(
      RouteSettings settings, Widget screen) {
    return CupertinoPageRoute(
      //change this to material route to avoid the slide to back feature
      settings: settings,
      builder: (context) => screen,
    );
  }

  static CupertinoPageRoute<dynamic> pageRouteTwo(
      RouteSettings settings, Widget screen) {
    return CupertinoPageRoute(
      //change this to material route to avoid the slide to back feature
      settings: settings,
      builder: (context) => ClosNavigation(),
    );
  }
}

class ClosNavigation extends StatelessWidget {
  const ClosNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    Navigator.pop(context);
    return const Scaffold(
      backgroundColor: Colors.amber,
    );
  }
}
