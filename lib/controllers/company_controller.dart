import 'package:br_com_mindselfcompany_backoffice_web/dto/company_dto.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/api_result_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/company_model.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/pagination_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/repositories/company_repository.dart';

class CompanyController extends GetxController {
  @protected
  final CompanyRepository companyRepository;

  List<CompanyModel> _companies = <CompanyModel>[].obs;
  List<CompanyModel> get companies => _companies;

  CompanyController(this.companyRepository);

  var _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  var _companyName = "".obs;
  String get companyName => _companyName.value;
  set companyName(value) => _companyName.value = value;

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
      _listCompany();
    }
  }

  Future<void> goPreviousPage() async {
    if (_actualPage.value > 0) {
      _actualPage.value--;
      _listCompany();
    }
  }

  Future<void> goFirstPage() async {
    if (_actualPage.value != 0) {
      _actualPage.value = 0;
      _listCompany();
    }
  }

  Future<void> goLastPage() async {
    if (_actualPage.value + 1 != _countPage.value) {
      _actualPage.value = _countPage.value - 1;
      _listCompany();
    }
  }

  Future<ApiResultModel<bool>> insertCompany() async {
    _isLoading.value = true;

    ApiResultModel<bool> result =
        await companyRepository.insertCompany(CompanyDto(
      idCompany: 0,
      name: _companyName.value.trim().toUpperCase(),
    ));

    _isLoading.value = false;

    if (result.message.isEmpty) {
      return ApiResultModel<bool>(message: result.message, data: true);
    } else
      return ApiResultModel<bool>(message: result.message, data: false);
  }

  Future<void> getCompany(int idCompany) async {
    _isLoading.value = true;

    ApiResultModel<PaginationModel> result =
        await companyRepository.getCompany(CompanyDto(idCompany: idCompany));

    if (result.message.isEmpty) {
      CompanyModel companyModel =
          CompanyModel.fromJson(result.data.pagedList.first);

      _companyName.value = companyModel.name;
      _isLoading.value = false;

      return ApiResultModel<bool>(message: result.message, data: true);
    } else {
      _isLoading.value = false;
      return ApiResultModel<bool>(message: result.message, data: false);
    }
  }

  Future _listCompany() async {
    _isLoading.value = true;

    ApiResultModel<PaginationModel> result = await companyRepository
        .listCompany(CompanyDto(name: _filter), _actualPage.value);

    _isLoading.value = false;
    _companies.clear();

    if (result.message.isEmpty) {
      _countPage.value = result.data.totalPages;
      result.data.pagedList.forEach((element) {
        _companies.add(CompanyModel.fromJson(element));
      });
    } else
      throw Exception(result.message);
  }

  Future<ApiResultModel<bool>> updateCompany(int idCompany) async {
    _isLoading.value = true;

    ApiResultModel<bool> result =
        await companyRepository.updateCompany((CompanyDto(
      idCompany: idCompany,
      name: _companyName.value.trim().toUpperCase(),
    )));

    _isLoading.value = false;

    if (result.message.isEmpty) {
      return ApiResultModel<bool>(message: result.message, data: true);
    } else
      return ApiResultModel<bool>(message: result.message, data: false);
  }

  Future<ApiResultModel<bool>> deleteCompany(int idCompany) async {
    _isLoading.value = true;

    ApiResultModel<bool> result =
        await companyRepository.deleteCompany(CompanyDto(idCompany: idCompany));

    _isLoading.value = false;

    if (result.message.isEmpty) {
      await _listCompany();
      return ApiResultModel<bool>(message: result.message, data: true);
    } else
      return ApiResultModel<bool>(message: result.message, data: false);
  }
}
