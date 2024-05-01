import 'package:samastha/env/env.dart';

class DevelopmentEnv extends Env {
  DevelopmentEnv()
      : super(domainUrl: 'https://test.samastha.lilacinfotech.com');
  @override
  String toString() {
    return 'Development';
  }
}
