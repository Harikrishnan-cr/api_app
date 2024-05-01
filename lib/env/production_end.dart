import 'package:samastha/env/env.dart';

class ProductionEnv extends Env {
  ProductionEnv() : super(domainUrl: 'https://course.samasthaelearning.com/');
  @override
  String toString() {
    return 'Production';
  }
}
