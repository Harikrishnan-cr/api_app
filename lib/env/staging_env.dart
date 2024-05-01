import 'package:samastha/env/env.dart';

class StagingEnv extends Env {
  StagingEnv() : super(domainUrl: 'http://192.168.29.206:8000');
  @override
  String toString() {
    return 'Staging';
  }
}
