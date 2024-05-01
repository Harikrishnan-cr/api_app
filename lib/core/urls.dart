import 'package:samastha/env/env.dart';

class Urls {
  static String fetchAIContent = "ai-content";

  static var apiUrl = '${Env.instance.domainUrl}/api/v1/';

  static const String tokenRefresh = '/auth/token/refresh';

  static const String countries = '/country';

  static const String states = '/country/states';

  static const String checkPhone = '/user/check';

  static const String checkPasswordResetPhoneNumberUrl =
      '/user/check-phone-reset';

  static const String register = '/register';
  static const String updateFcmToken = '/update-fcm';

  static const String login = '/login';

  static const String changePassword = '/user-change-password';

  static const String bannersList = '/banners';

  static const String user = '/user';

  static const String setPassword = '/parent/set-password';

  static const String instructions = '/instructions';

  static String checkPin = '/parent/check-pin';

  static String kidsList = '/parent/students';

  static String classes = '/classes';

  static String timeSlots = '/timeslots';

  static String registerStudent = '/parent/addmission';

  static String parentAdmission = '/parent/admission';

  static String mcqInstructions = '/user/mcq/instructions';

  static String mcqQuestionPaper = '/user/mcq/questions';

  static String applications = '/parent/my-application';

  static String solution = '/user/mcq/solutions';

  static String submitMCQQuiz = '/user/mcq/submit';

  static String vivaDates = '/user/viva/days';

  static String fetchSlots = '/user/viva/time';

  static String scheduleSlot = '/student/viva-schedule';

  static String vivaCall = '/user/viva/call';

  static String submitViva = '/student/viva-submit';

  static String checkStudentPIN = '/student/check-pin';

  static String setStudentPin = '/student/set-pin';

  static String fetchStudentProfile = '/student';

  static String fetchSubjects = '/student/subjects';

  static String fetchSubjectsLessons = '/student/subjects/subject-lessons';

  static String coursesList = '/user/courses';

  static String myCoursesList = '/user/courses/my-courses';

  static String courseDetail = '/user/courses/course-details';

  static String courseChaptersUrl = '/user/courses/course-chapters';

  static String chapterDetailssUrl = '/user/courses/chapter-details';

  static String mentorsList = '/student/mentors-list';

  static String getSignedURL = 'get-img/';

  static String usthadDetails = '/student/mentor-details';

  static String fetchNotification = '/user/user-notifications';

  static String getLeaveTypes = '/leave-type';

  static String applyLeave = '/student/apply-leave';

  static String getLeaveRequest = '/student/leave-requests';

  static String getApprovedLeaveRequest = '/student/approved-leave';

  static String assignmentsUrl = '/student/assignments';

  static String assignmentDetailsUrl = '/student/assignment-details';

  static String submitAssignmentUrl = '/student/assignment-submit';

  static String uploadAssignmentUrl = '/student/assignment-worksheet-upload';

  static String getSubjectsUrl = '/student/get-subjects';

  static String getExamUrl = '/student/exams';

  static String getExamInstructionsUrl = '/student/exam/instructions';

  static String getExamQuestionsUrl = '/student/exam/questions';

  static String submitExamUrl = '/student/exam/submit';

  static String examSolutionUrl = '/student/exam/solutions';

  static String examMarks = '/student/exam/mark';

  static String fetchQuizzesUrl = '/student/quizzes';

  static String fetchQuizzInstructionsUrl = '/student/quiz/instructions';

  static String fetchQuizzQuestionsUrl = '/student/quiz/questions';

  static String fetchQuizzSolutionsUrl = '/student/quiz/solutions';

  static String submitQuizzUrl = '/student/quiz/submit';

  static String quizzMarkUrl = '/student/quiz/mark';

  static String rescheduleSubmitUrl = '/student/reschedule-submit';

  static String missedClassesUrl = '/student/missed-class';

  static String scheduleMissedClassesUrl = '/student/schedule-class';

  static String matchingSchedulesUrl = '/student/matching-schedules';

  static String rescheduledClassesUrl = '/student/rescheduled-classes';

  static String submitRescheduledClassUrl = '/student/reschedule-submit';

  static String academicCalenderUrl = '/student/academic-calendar';

  static String batchLessonsUrl = '/student/batch-lessons';

  static String saveCourseUrl = '/student/save-course';

  static String saveSubjectUrl = '/student/save-subject';

  static String saveDurationUrl = '/student/subjects/save-duration';

  static String questionSubmitUrl = '/student/subjects/question-submit';

  static String checkPaymentUrl = '/student/check-payment';

  static String usthadsUrl = '/student/usthad/';

  static String feePayment = '/user/fee-payment';

  static String updateProfilePicUrl = '/user/profile-pic-updation';

  static String batchLessonUrl = '/student/batch-lessons';

  static String deleteAccountUrl = '/user/delete-account';

  static String rewardsUrl = '/student/rewards';
  static String leaderBoard = '/student/leader-board';
  static String performnaceAnalysis = '/student/performance-analaysis';
  static String liveClassZoom = '/student/live-class';
  static String offlineDownload = '/student/download-video';
  static String getofflineDownloa = '/student/downloaded-video';
  static String getAllCertificates = '/user/cerificates';
}
