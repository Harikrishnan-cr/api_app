import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:samastha/core/urls.dart';
import 'package:samastha/helper/dio_client.dart';
import 'package:samastha/helper/service_locator.dart' as di;
import 'package:samastha/modules/parent/model/certificate_model.dart';

class CertificateController extends ChangeNotifier {
  final DioClient dioClient = di.sl<DioClient>();

  List<CertificateModelList>? certificateList = [];

  bool isLoading = false;

  void getAllCertificateList({bool onInt = false}) async {
    try {
      isLoading = true;

      onInt ? null : notifyListeners();
      final responce = await dioClient.get(Urls.getAllCertificates);

      certificateList?.clear();

      final value = certificateModelFromJson(jsonEncode(responce.data));
      certificateList?.addAll(value.certificateModelList ?? []);

      isLoading = false;

      notifyListeners();
    } catch (e) {
      certificateList?.clear();
      isLoading = false;

      notifyListeners();
    }
  }
}
