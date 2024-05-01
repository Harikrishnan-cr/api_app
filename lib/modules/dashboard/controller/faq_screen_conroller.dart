import 'package:flutter/material.dart';
import 'package:samastha/helper/dio_client.dart';
import 'package:samastha/helper/service_locator.dart' as di;

class FaqScreenController extends ChangeNotifier {
  final DioClient dioClient = di.sl<DioClient>();

  List<int> isExpandedList = [];

  void onIsExpanded(int expandedID) {
    if (isExpandedList.contains(expandedID)) {
      isExpandedList.remove(expandedID);

      notifyListeners();
      return;
    }
    isExpandedList.add(expandedID);

    notifyListeners();
  }
}

final dummyFaq = [
  FaqModelClass(discription: 'the descripion one', id: 1, tittle: 'title one'),
  FaqModelClass(discription: 'the descripion two', id: 2, tittle: 'title two'),
  FaqModelClass(
      discription: 'the descripion three', id: 3, tittle: 'title three'),
  FaqModelClass(
      discription: 'the descripion four', id: 4, tittle: 'title four'),
  FaqModelClass(
      discription: 'the descripion five', id: 5, tittle: 'title five'),
];

class FaqModelClass {
  int id;
  String tittle;
  String discription;

  FaqModelClass(
      {required this.discription, required this.id, required this.tittle});
}
