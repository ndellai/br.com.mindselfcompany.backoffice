import 'package:br_com_mindselfcompany_backoffice_web/dto/report_dto.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/api_result_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/services/model/report_courses_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/services/model/report_employess_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/services/model/report_session_timer_model.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:br_com_mindselfcompany_backoffice_web/repositories/report_repository.dart';

class ReportController extends GetxController {
  @protected
  final ReportRepository reportRepository;

  List<ReportSessionTimerModel>? reportSessionTimer =
      <ReportSessionTimerModel>[].obs;
  List<ReportCoursesModel>? reportCoursesData = <ReportCoursesModel>[].obs;
  List<ReportEmployeesModel>? reportEmployessData = <ReportEmployeesModel>[].obs;

  ReportController(this.reportRepository);

  var _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  var _groupReport = 1000.obs;
  int get groupReport => _groupReport.value;
  set groupReport(value) => _groupReport.value = value;

  var _isValidReport = true.obs;
  bool get isValidReport => _isValidReport.value;
  set isValidReport(value) => _isValidReport.value = value;

  var _isValidPeriod = true.obs;
  bool get isValidPeriod => _isValidPeriod.value;
  set isValidPeriod(value) => _isValidPeriod.value = value;

  var _messagePeriod = "".obs;
  String get messagePeriod => _messagePeriod.value;
  set messagePeriod(value) => _messagePeriod.value = value;

  Future<ApiResultModel<bool>> getSessionTimerReport(
      DateTime initialDate, DateTime finalDate) async {
    _isLoading.value = true;

    ApiResultModel<List<ReportSessionTimerModel>> result =
        await reportRepository.getReportSessionAndTimer(
            ReportDto(initialDate: initialDate, finalDate: finalDate));

    if (result.message!.isEmpty) {
      reportSessionTimer = result.data;
      _isLoading.value = false;
      return ApiResultModel<bool>(message: result.message, data: true);
    } else {
      _isLoading.value = false;
      return ApiResultModel<bool>(message: result.message, data: false);
    }
  }

  Future<ApiResultModel<bool>> getCoursesReport(
      DateTime initialDate, DateTime finalDate) async {
    _isLoading.value = true;

    ApiResultModel<List<ReportCoursesModel>> result =
        await reportRepository.getReportCourses(
            ReportDto(initialDate: initialDate, finalDate: finalDate));

    if (result.message!.isEmpty) {
      reportCoursesData = result.data;
      _isLoading.value = false;
      return ApiResultModel<bool>(message: result.message, data: true);
    } else {
      _isLoading.value = false;
      return ApiResultModel<bool>(message: result.message, data: false);
    }
  }

  Future<ApiResultModel<bool>> getEmployessReport(
      DateTime initialDate, DateTime finalDate) async {
    _isLoading.value = true;

    ApiResultModel<List<ReportEmployeesModel>> result =
        await reportRepository.getReportEmployees(
            ReportDto(initialDate: initialDate, finalDate: finalDate));

    if (result.message!.isEmpty) {
      reportEmployessData = result.data;
      _isLoading.value = false;
      return ApiResultModel<bool>(message: result.message, data: true);
    } else {
      _isLoading.value = false;
      return ApiResultModel<bool>(message: result.message, data: false);
    }
  }
}
