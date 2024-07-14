import 'dart:convert';

import 'package:br_com_mindselfcompany_backoffice_web/constants/form_key.dart';
import 'package:br_com_mindselfcompany_backoffice_web/constants/page_count.dart';
import 'package:br_com_mindselfcompany_backoffice_web/dto/company_dto.dart';
import 'package:br_com_mindselfcompany_backoffice_web/dto/employee_dto.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/api_result_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/company_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/employee_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/pagination_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/repositories/company_repository.dart';
import 'package:br_com_mindselfcompany_backoffice_web/repositories/employee_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart' as html;

import '../cache/cache.dart';
import '../constants/colours.dart';
import '../views/widgets/modal_confirm.dart';
import '../views/widgets/modal_upload.dart';

class EmployeeController extends GetxController {
  @protected
  final EmployeeRepository employeeRepository;
  @protected
  final CompanyRepository companyRepository;

  EmployeeController(this.employeeRepository, this.companyRepository);

  List<EmployeeModel> _employees = <EmployeeModel>[];
  List<EmployeeModel> get employees => _employees;
  List<int> _fileUpload = <int>[].obs;

  List<CompanyModel>? _companies = <CompanyModel>[];
  List<CompanyModel>? get companies => _companies;

  RxInt _idCompany = 1000.obs;
  RxInt get idCompany => _idCompany;
  set idCompany(value) => _idCompany.value = value;

  RxString _companyName = "".obs;
  RxString get companyName => _companyName;

  RxBool _isValidCompany = true.obs;
  RxBool get isValidCompany => _isValidCompany;
  set isValidCompany(value) => _isValidCompany.value = value;

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

  final TextEditingController emailController = new TextEditingController();

  final TextEditingController nameController = new TextEditingController();

  final TextEditingController registrationController =
      new TextEditingController();

  final TextEditingController phoneController = new TextEditingController();

  final TextEditingController areaController = new TextEditingController();

  final TextEditingController sectorController = new TextEditingController();

  @override
  void onInit() {
    if (Get.arguments == null) {
      goFirstPage();
    } else {
      if ((Get.arguments["acao"] == "C")) {
        if (_actualPage.value == 1)
          goFirstPage();
        else
          _listEmployee();
      } else {
        if ((Get.arguments["acao"] == "A")) {
          Cache.set<int>("idCompany", Get.arguments["idCompany"]);
          Cache.set<int>("idEmployee", Get.arguments["idEmployee"]);
          getEmployee(
              Get.arguments["idCompany"], (Get.arguments["idEmployee"]));
        } else {
          _listMinifiedCompany();
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

  Future<ApiResultModel<bool>> _insertEmployee() async {
    _isLoading.value = true;

    ApiResultModel<bool> result = await employeeRepository.insertEmployee(
        EmployeeDto(
            idEmployee: 0,
            idCompany: _idCompany.value,
            email: emailController.text.trim().toUpperCase(),
            name: nameController.text.trim().toUpperCase(),
            area: areaController.text.trim().toUpperCase(),
            sector: sectorController.text.trim().toUpperCase(),
            registration: registrationController.text.trim(),
            phone: phoneController.text.trim()));

    _isLoading.value = false;

    if (result.message!.isEmpty) {
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

    if (result.message!.isEmpty) {
      _countPage.value = result.data!.totalPages!;
      result.data!.pagedList!.forEach((element) {
        _employees.add(EmployeeModel.fromJson(element));
      });
    } else
      throw Exception(result.message);
  }

  Future<ApiResultModel<bool>> _updateEmployee(
      int idEmployee, int idCompany) async {
    _isLoading.value = true;

    ApiResultModel<bool> result = await employeeRepository.updateEmployee(
        EmployeeDto(
            idCompany: idCompany,
            idEmployee: idEmployee,
            email: emailController.text.trim().toUpperCase(),
            name: nameController.text.trim().toUpperCase(),
            area: areaController.text.trim().toUpperCase(),
            sector: sectorController.text.trim().toUpperCase(),
            registration: registrationController.text.trim(),
            phone: phoneController.text.trim()));

    _isLoading.value = false;

    if (result.message!.isEmpty) {
      return ApiResultModel<bool>(message: result.message, data: true);
    } else
      return ApiResultModel<bool>(message: result.message, data: false);
  }

  Future<ApiResultModel<bool>> _deleteEmployee(
      int idEmployee, int idCompany) async {
    _isLoading.value = true;

    ApiResultModel<bool> result = await employeeRepository.deleteEmployee(
        EmployeeDto(idEmployee: idEmployee, idCompany: idCompany));

    _isLoading.value = false;

    if (result.message!.isEmpty) {
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

    if (result.message!.isEmpty) {
      EmployeeModel employeeModel =
          EmployeeModel.fromJson(result.data!.pagedList!.first);

      _idCompany.value = employeeModel.company!.idCompany!;
      emailController.text = employeeModel.email!.trim().toUpperCase();
      registrationController.text = employeeModel.registration!;
      _companyName.value = employeeModel.company!.name!;
      nameController.text = employeeModel.name!.trim().toUpperCase();
      sectorController.text = employeeModel.sector!.trim().toUpperCase();
      areaController.text = employeeModel.area!.trim().toUpperCase();
      phoneController.text = employeeModel.phone!.trim();
    }

    _isLoading.value = false;
  }

  Future _listMinifiedCompany() async {
    _isLoading.value = true;

    ApiResultModel<List<CompanyModel>> result =
        await companyRepository.listMinifiedCompany(CompanyDto());

    if (result.message!.isEmpty) _companies = result.data;

    _isLoading.value = false;
  }

  Future<bool> _uploadFile(bool hasHeader) async {
    _isLoading.value = true;

    ApiResultModel<bool> result = await employeeRepository.makeUpload(
        _fileUpload, hasHeader, _idCompany.value);

    _isLoading.value = false;

    if (result.message!.isEmpty)
      return Future.value(true);
    else
      return Future.value(false);
  }

  Future<void> deleteEmployee(int idCompany, String companyName, int idEmployee,
      String email, String registration) async {
    var dialog = (await Get.dialog<bool>(ModalConfirm(
        title: "Atenção!",
        text:
            "Confirma a exclusão do colaborador?\n $idEmployee ${email.isEmpty ? "" : "- " + email} ${registration.isEmpty ? "" : "- " + registration}\n Empresa: $companyName")))!;

    if (dialog) {
      var result = await _deleteEmployee(idEmployee, idCompany);

      if (result.message!.isEmpty) {
        Get.snackbar(
          "SUCESSO",
          "Colaborador excluído!",
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

  Future<void> redirectEmployeeEdt(int idEmployee, int idCompany) async {
    await Get.offNamed("/employee_edt", arguments: {
      "acao": "A",
      "idCompany": idCompany,
      "idEmployee": idEmployee
    });
  }

  Future<void> redirectHome() async {
    await Get.offAllNamed("/home", arguments: {"acao": "C", "idScreen": 1});
  }

  Future<void> updateValues() async {
    bool saveData = true;

    if (!FormKey.key.currentState!.validate()) saveData = false;

    if (_idCompany.value == 1000) {
      saveData = false;
      _isValidCompany.value = false;
    } else
      _isValidCompany.value = true;

    if (saveData) {
      var idEmployee = await Cache.get<int>("idEmployee");
      var idCompany = await Cache.get<int>("idCompany");

      ApiResultModel result = await _updateEmployee(idEmployee!, idCompany!);

      if (result.message!.isEmpty) {
        Get.snackbar(
          "SUCESSO",
          "Colaborador alterado!",
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

  Future<void> insertValues() async {
    bool saveData = true;

    if (!FormKey.key.currentState!.validate()) saveData = false;

    if (_idCompany.value == 1000) {
      saveData = false;
      _isValidCompany.value = false;
    } else
      _isValidCompany.value = true;

    if (saveData) {
      ApiResultModel result = await _insertEmployee();

      if (result.message!.isEmpty) {
        Get.snackbar(
          "SUCESSO",
          "Colaborador cadastrado!",
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
    emailController.clear();
    registrationController.clear();
    nameController.clear();
    areaController.clear();
    sectorController.clear();
    phoneController.clear();
  }

  Future initUpload() async {
    if (_idCompany == 1000) {
      _isValidCompany.value = false;
      return false;
    } else {
      _isValidCompany.value = true;

      var dialog = (await Get.dialog<String>(ModalUpload()))!;

      if (dialog.trim().isNotEmpty)
        _startWebFilePicker(
            dialog.toLowerCase().toLowerCase() == "true" ? true : false);
    }
  }

  Future _startWebFilePicker(bool hasHeader) async {
    html.InputElement uploadInput =
        html.FileUploadInputElement() as html.InputElement;
    uploadInput.multiple = false;
    uploadInput.draggable = true;
    uploadInput.accept = ".csv";
    uploadInput.onChange.listen((e) {
      var files = uploadInput.files!;
      var file = files[0];
      print(file.name);
      print(file.relativePath);
      var reader = new html.FileReader();

      reader.onLoadEnd.listen((e) {
        _handleResult(reader.result);
        print(_fileUpload.length);
        Future.delayed(
            Duration(milliseconds: 500), () => _makeRequest(hasHeader));
      });
      reader.readAsDataUrl(file);
    });
    uploadInput.click();
  }

  Future _makeRequest(bool hasHeader) async {
    if (await _uploadFile(hasHeader)) {
      Get.snackbar(
        "SUCESSO",
        "Arquivo carregado com sucesso!",
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
        "Não foi possível carregar o arquivo.",
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

  void _handleResult(Object? result) {
    _fileUpload = Base64Decoder().convert(result.toString().split(",").last);
  }
}
