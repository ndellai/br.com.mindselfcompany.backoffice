import 'package:br_com_mindselfcompany_backoffice_web/dto/company_dto.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/api_result_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/company_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/pagination_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/repositories/company_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../cache/cache.dart';
import '../constants/colours.dart';
import '../constants/form_key.dart';
import '../views/widgets/modal_confirm.dart';

class CompanyController extends GetxController {
  @protected
  final CompanyRepository companyRepository;

  RxList<CompanyModel> _companies = <CompanyModel>[].obs;
  RxList<CompanyModel> get companies => _companies;

  CompanyController(this.companyRepository);

  RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;

  RxInt _actualPage = 1.obs;
  RxInt get actualPage => _actualPage;
  set actualPage(value) => _actualPage.value = value;

  var _countPage = 0.obs;
  int get countPage => _countPage.value;

  var _filter = "";
  set filter(String value) => _filter = value;

  final TextEditingController searchController = new TextEditingController();

  final TextEditingController razaoSocialController =
      new TextEditingController();

  @override
  void onInit() {
    if (Get.arguments == null) {
      goFirstPage();
    } else {
      if ((Get.arguments["acao"] == "C")) {
        if (_actualPage.value == 1)
          goFirstPage();
        else
          _listCompany();
      } else {
        if ((Get.arguments["acao"] == "A")) {
          Cache.set<int>("idCompany", Get.arguments["idCompany"]);
          getCompany(Get.arguments["idCompany"]);
        }
      }
    }

    super.onInit();
  }

  @override
  void onClose() {
    super.onInit();
  }

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
      _actualPage.value = _countPage.value - 1; //final int pageIndex;

      _listCompany();
    }
  }

  Future<ApiResultModel<bool>> _insertCompany() async {
    _isLoading.value = true;

    ApiResultModel<bool> result =
        await companyRepository.insertCompany(CompanyDto(
      idCompany: 0,
      name: razaoSocialController.text.trim().toUpperCase(),
    ));

    _isLoading.value = false;

    if (result.message!.isEmpty) {
      return ApiResultModel<bool>(message: result.message, data: true);
    } else
      return ApiResultModel<bool>(message: result.message, data: false);
  }

  Future<void> getCompany(int idCompany) async {
    _isLoading.value = true;

    ApiResultModel<PaginationModel> result =
        await companyRepository.getCompany(CompanyDto(idCompany: idCompany));

    if (result.message!.isEmpty) {
      CompanyModel companyModel =
          CompanyModel.fromJson(result.data!.pagedList!.first);

      razaoSocialController.text = companyModel.name!;
      _isLoading.value = false;
    } else {
      _isLoading.value = false;
    }
  }

  Future _listCompany() async {
    _isLoading.value = true;

    ApiResultModel<PaginationModel> result = await companyRepository
        .listCompany(CompanyDto(name: _filter), _actualPage.value);

    _companies.clear();

    if (result.message!.isEmpty) {
      _countPage.value = result.data!.totalPages!;
      result.data!.pagedList!.forEach((element) {
        _companies.add(CompanyModel.fromJson(element));
      });
    } else
      throw Exception(result.message);

    _isLoading.value = false;
  }

  Future<ApiResultModel<bool>> _updateCompany(int idCompany) async {
    _isLoading.value = true;

    ApiResultModel<bool> result =
        await companyRepository.updateCompany((CompanyDto(
      idCompany: idCompany,
      name: razaoSocialController.text.trim().toUpperCase(),
    )));

    _isLoading.value = false;

    if (result.message!.isEmpty) {
      return ApiResultModel<bool>(message: result.message, data: true);
    } else
      return ApiResultModel<bool>(message: result.message, data: false);
  }

  Future<ApiResultModel<bool>> _deleteCompany(int idCompany) async {
    _isLoading.value = true;

    ApiResultModel<bool> result =
        await companyRepository.deleteCompany(CompanyDto(idCompany: idCompany));

    _isLoading.value = false;

    if (result.message!.isEmpty) {
      await _listCompany();
      return ApiResultModel<bool>(message: result.message, data: true);
    } else
      return ApiResultModel<bool>(message: result.message, data: false);
  }

  Future<void> redirectCompanyEdt(int idCompany) async {
    await Get.offNamed("/company_edt",
        arguments: {"acao": "A", "idCompany": idCompany});
  }

  Future<void> redirectHome() async {
    await Get.offAllNamed("/home", arguments: {"acao": "C", "idScreen": 0});
  }

  Future<void> updateValues() async {
    bool saveData = true;

    if (!FormKey.key.currentState!.validate()) saveData = false;

    if (saveData) {
      var idCompany = await Cache.get<int>("idCompany");

      ApiResultModel result = await _updateCompany(idCompany!);

      if (result.message!.isEmpty) {
        Get.snackbar(
          "SUCESSO",
          "Empresa alterada!",
          snackbarStatus: (_) =>
              _ == SnackbarStatus.CLOSED ? redirectHome() : null,
          duration: Duration(seconds: 1),
          colorText: Colors.white,
          backgroundColor: Colours.Green,
          boxShadows: [
            BoxShadow(
              color: Colors.black45,
              offset: Offset(3, 3),
              blurRadius: 3,
            )
          ],
        );
      } else {
        Get.snackbar(
          "ERRO",
          result.message!,
          colorText: Colors.white,
          backgroundColor: Colors.black,
          boxShadows: [
            BoxShadow(
              color: Colors.black45,
              offset: Offset(3, 3),
              blurRadius: 3,
            )
          ],
        );
      }
    }
  }

  Future<void> deleteCompany(int idCompany, String name) async {
    var dialog = (await Get.dialog<bool>(ModalConfirm(
        title: "Atenção!",
        text: "Confirma a exclusão da empresa?\n $idCompany - $name")))!;

    if (dialog) {
      var result = await _deleteCompany(idCompany);

      if (result.message!.isEmpty) {
        Get.snackbar(
          "SUCESSO",
          "Empresa excluída!",
          colorText: Colors.white,
          backgroundColor: Colours.Green,
          boxShadows: [
            BoxShadow(
              color: Colors.black45,
              offset: Offset(3, 3),
              blurRadius: 3,
            )
          ],
        );
      } else {
        Get.snackbar(
          "ERRO",
          result.message!,
          colorText: Colors.white,
          backgroundColor: Colors.black,
          boxShadows: [
            BoxShadow(
              color: Colors.black45,
              offset: Offset(3, 3),
              blurRadius: 3,
            )
          ],
        );
      }
    }
  }

  Future<void> insertValues() async {
    bool saveData = true;

    if (!FormKey.key.currentState!.validate()) saveData = false;

    if (saveData) {
      ApiResultModel result = await _insertCompany();

      if (result.message!.isEmpty) {
        Get.snackbar(
          "SUCESSO",
          "Empresa cadastrada!",
          colorText: Colors.white,
          backgroundColor: Colours.Green,
          boxShadows: [
            BoxShadow(
              color: Colors.black45,
              offset: Offset(3, 3),
              blurRadius: 3,
            )
          ],
        );
        _clearData();
      } else {
        Get.snackbar(
          "ERRO",
          result.message!,
          colorText: Colors.white,
          backgroundColor: Colors.black,
          boxShadows: [
            BoxShadow(
              color: Colors.black45,
              offset: Offset(3, 3),
              blurRadius: 3,
            )
          ],
        );
      }
    }
  }

  void _clearData() {
    razaoSocialController.clear();
  }
}
