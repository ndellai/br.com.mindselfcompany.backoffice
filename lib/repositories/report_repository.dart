import 'package:br_com_mindselfcompany_backoffice_web/constants/api_routes.dart';
import 'package:br_com_mindselfcompany_backoffice_web/dto/report_dto.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/api_result_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/repositories/base_repository.dart';
import 'package:br_com_mindselfcompany_backoffice_web/services/http_service.dart';
import 'package:br_com_mindselfcompany_backoffice_web/services/model/report_courses_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/services/model/report_employess_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/services/model/report_session_timer_model.dart';

class ReportRepository extends BaseRepository {
  final HttpService httpService;
  ReportRepository(this.httpService) : super(httpService);

  Future<ApiResultModel<List<ReportSessionTimerModel>>>
      getReportSessionAndTimer(ReportDto reportDto) async {
    var response = await httpService.invokeApi(
        method: Method.GET,
        route: ApiRoutes.reportSessionAndTimer,
        data: reportDto,
        header: Header.No,
        parameters:
            "initialDate=${reportDto.initialDate.toIso8601String()}&finalDate=${reportDto.finalDate.toIso8601String()}");

    return ApiResultModel<List<ReportSessionTimerModel>>(
        message: response.message,
        data: ReportSessionTimerModel.fromJsonList(response.data));
  }

  Future<ApiResultModel<List<ReportCoursesModel>>> getReportCourses(
      ReportDto reportDto) async {
    var response = await httpService.invokeApi(
        method: Method.GET,
        route: ApiRoutes.reportCourses,
        data: reportDto,
        header: Header.No,
        parameters:
            "initialDate=${reportDto.initialDate.toIso8601String()}&finalDate=${reportDto.finalDate.toIso8601String()}");

    return ApiResultModel<List<ReportCoursesModel>>(
        message: response.message,
        data: ReportCoursesModel.fromJsonList(response.data));
  }

  Future<ApiResultModel<List<ReportEmployeesModel>>> getReportEmployees(
      ReportDto reportDto) async {
    var response = await httpService.invokeApi(
        method: Method.GET,
        route: ApiRoutes.reportEmployess,
        data: reportDto,
        header: Header.No,
        parameters:
            "initialDate=${reportDto.initialDate.toIso8601String()}&finalDate=${reportDto.finalDate.toIso8601String()}");

    return ApiResultModel<List<ReportEmployeesModel>>(
        message: response.message,
        data: ReportEmployeesModel.fromJsonList(response.data));
  }
}
