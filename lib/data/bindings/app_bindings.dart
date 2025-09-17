import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../controllers/auth_controller.dart';
import '../controllers/parent_report_controller.dart';
import '../controllers/finder_report_controller.dart';
import '../controllers/match_controller.dart';
import '../controllers/notification_controller.dart';
import '../controllers/dashboard_controller.dart';
import '../controllers/user_controller.dart';
import '../services/auth_service.dart';
import '../services/parent_report_service.dart';
import '../services/finder_report_service.dart';
import '../services/match_service.dart';
import '../services/notification_service.dart';
import '../services/dashboard_service.dart';
import '../services/user_service.dart';
import '../services/profile_service.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Initialize GetStorage
    Get.putAsync(() async {
      await GetStorage.init();
      return GetStorage();
    });
    
    // Initialize Services
    Get.put<AuthService>(AuthService(), permanent: true);
    Get.lazyPut<ParentReportService>(() => ParentReportService(), fenix: true);
    Get.lazyPut<FinderReportService>(() => FinderReportService(), fenix: true);
    Get.lazyPut<MatchService>(() => MatchService(), fenix: true);
    Get.lazyPut<NotificationService>(() => NotificationService(), fenix: true);
    Get.lazyPut<DashboardService>(() => DashboardService(), fenix: true);
    Get.lazyPut<UserService>(() => UserService(), fenix: true);
    Get.lazyPut<ProfileService>(() => ProfileService(), fenix: true);
    
    // Initialize Controllers
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
    Get.lazyPut<ParentReportController>(() => ParentReportController(), fenix: true);
    Get.lazyPut<FinderReportController>(() => FinderReportController(), fenix: true);
    Get.lazyPut<MatchController>(() => MatchController(), fenix: true);
    Get.lazyPut<NotificationController>(() => NotificationController(), fenix: true);
    Get.lazyPut<DashboardController>(() => DashboardController(), fenix: true);
    Get.lazyPut<UserController>(() => UserController(), fenix: true);
  }
}