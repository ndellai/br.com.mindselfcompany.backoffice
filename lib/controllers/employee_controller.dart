import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:br_com_mindselfcompany_backoffice_web/constants/page_count.dart';
import 'package:br_com_mindselfcompany_backoffice_web/dto/company_dto.dart';
import 'package:br_com_mindselfcompany_backoffice_web/dto/employee_dto.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/api_result_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/company_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/employee_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/pagination_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/repositories/company_repository.dart';
import 'package:br_com_mindselfcompany_backoffice_web/repositories/employee_repository.dart';

class EmployeeController extends GetxController {
  @protected
  final EmployeeRepository employeeRepository;
  final CompanyRepository companyRepository;

  EmployeeController(this.employeeRepository, this.companyRepository);

  List<EmployeeModel> _employees = <EmployeeModel>[].obs;
  List<EmployeeModel> get employees => _employees;
  List<int> fileUpload = <int>[].obs;

  List<CompanyModel> _companies = <CompanyModel>[].obs;
  List<CompanyModel> get companies => _companies;

  var _employee = "".obs;
  String get employee => _employee.value;
  set employee(value) => _employee.value = value;

  var _idCompany = 1000.obs;
  int get idCompany => _idCompany.value;
  set idCompany(value) => _idCompany.value = value;

  var _companyName = "".obs;
  String get companyName => _companyName.value;

  var _name = "".obs;
  String get name => _name.value;
  set name(value) => _name.value = value;

  var _email = "".obs;
  String get email => _email.value;
  set email(value) => _email.value = value;

  var _registration = "".obs;
  String get registration => _registration.value;
  set registration(value) => _registration.value = value;

  var _area = "".obs;
  String get area => _area.value;
  set area(value) => _area.value = value;

  var _sector = "".obs;
  String get sector => _sector.value;
  set sector(value) => _sector.value = value;

  var _isValidCompany = true.obs;
  bool get isValidCompany => _isValidCompany.value;
  set isValidCompany(value) => _isValidCompany.value = value;

  var _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  var _actualPage = 1.obs;
  int get actualPage => _actualPage.value;
  set actualPage(int value) => _actualPage.value = value;

  var _countPage = 0.obs;
  int get countPage => _countPage.value;

  var _filter = "";
  set filter(String value) => _filter = value;

  Future<void> goNextPage() async {
    if (_actualPage.value < _countPage.value - 1) {
      _actualPage.value++;
      _listEmployee();
    }
  }

  Future<void> goPreviousPage() async {
    if (_actualPage.value > 0) {
      _actualPage.value--;
      _listEmployee();
    }
  }

  Future<void> goFirstPage() async {
    if (_actualPage.value != 0) {
      _actualPage.value = 0;
      _listEmployee();
    }
  }

  Future<void> goLastPage() async {
    if (_actualPage.value + 1 != _countPage.value) {
      _actualPage.value = _countPage.value - 1;
      _listEmployee();
    }
  }

  Future<ApiResultModel<bool>> insertEmployee() async {
    _isLoading.value = true;

    ApiResultModel<bool> result = await employeeRepository.insertEmployee(
        EmployeeDto(
            idEmployee: null,
            idCompany: _idCompany.value,
            email: _email.value.trim().toUpperCase(),
            name: _name.value.trim().toUpperCase(),
            area: _area.value.trim().toUpperCase(),
            sector: _sector.value.trim().toUpperCase(),
            registration: _registration.value));

    _isLoading.value = false;

    if (result.message.isEmpty) {
      return ApiResultModel<bool>(message: result.message, data: true);
    } else
      return ApiResultModel<bool>(message: result.message, data: false);
  }

  Future _listEmployee() async {
    _isLoading.value = true;

    ApiResultModel<PaginationModel> result = await employeeRepository
        .listEmployee(EmployeeDto(email: _filter), _actualPage.value);

    _isLoading.value = false;

    _employees.clear();

    if (result.message.isEmpty) {
      _countPage.value = result.data.totalPages;
      result.data.pagedList.forEach((element) {
        _employees.add(EmployeeModel.fromJson(element));
      });
    } else
      throw Exception(result.message);
  }

  Future<ApiResultModel<bool>> updateEmployee(
      int idEmployee, int idCompany) async {
    _isLoading.value = true;

    ApiResultModel<bool> result = await employeeRepository.updateEmployee(
        EmployeeDto(
            email: _email.value.trim().toUpperCase(),
            registration: _registration.value,
            idCompany: idCompany,
            name: _name.value.trim().toUpperCase(),
            area: _area.value.trim().toUpperCase(),
            sector: _sector.value.trim().toUpperCase(),
            idEmployee: idEmployee));

    _isLoading.value = false;

    if (result.message.isEmpty) {
      return ApiResultModel<bool>(message: result.message, data: true);
    } else
      return ApiResultModel<bool>(message: result.message, data: false);
  }

  Future<ApiResultModel<bool>> deleteEmployee(
      int idEmployee, int idCompany) async {
    _isLoading.value = true;

    ApiResultModel<bool> result = await employeeRepository.deleteEmployee(
        EmployeeDto(idEmployee: idEmployee, idCompany: idCompany));

    _isLoading.value = false;

    if (result.message.isEmpty) {
      await _listEmployee();
      return ApiResultModel<bool>(message: result.message, data: true);
    } else
      return ApiResultModel<bool>(message: result.message, data: false);
  }

  Future<void> getEmployee(int idCompany, int idEmployee) async {
    _isLoading.value = true;

    ApiResultModel<PaginationModel> result =
        await employeeRepository.getEmployee(
            EmployeeDto(idCompany: idCompany, idEmployee: idEmployee),
            PageCount.maxPage);

    if (result.message.isEmpty) {
      EmployeeModel employeeModel =
          EmployeeModel.fromJson(result.data.pagedList.first);

      _idCompany.value = employeeModel.company.idCompany;
      _email.value = employeeModel.email.trim().toUpperCase();
      _registration.value = employeeModel.registration;
      _companyName.value = employeeModel.company.name;
      _name.value = employeeModel.name.trim().toUpperCase();
      _sector.value = employeeModel.sector.trim().toUpperCase();
      _area.value = employeeModel.area.trim().toUpperCase();

      _isLoading.value = false;
      return ApiResultModel<bool>(message: result.message, data: true);
    } else {
      _isLoading.value = false;
      return ApiResultModel<bool>(message: result.message, data: false);
    }
  }

  Future listMinifiedCompany() async {
    _isLoading.value = true;

    ApiResultModel<List<CompanyModel>> result =
        await companyRepository.listMinifiedCompany(CompanyDto());

    if (result.message.isEmpty)
      _companies = result.data;
    else
      print(result.message);

    _isLoading.value = false;
  }

  Future<bool> uploadFile(bool hasHeader) async {
    _isLoading.value = true;

    ApiResultModel<bool> result = await employeeRepository.makeUpload(
        fileUpload, hasHeader, _idCompany.value);

    _isLoading.value = false;

    if (result.message.isEmpty)
      return Future.value(true);
    else
      return Future.value(false);
  }
}
