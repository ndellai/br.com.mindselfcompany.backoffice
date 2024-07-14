import 'package:br_com_mindselfcompany_backoffice_web/constants/form_key.dart';
import 'package:br_com_mindselfcompany_backoffice_web/dto/application_dto.dart';
import 'package:br_com_mindselfcompany_backoffice_web/dto/authentication_dto.dart';
import 'package:br_com_mindselfcompany_backoffice_web/dto/company_dto.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/api_result_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/company_application_authentication_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/company_model.dart';
import 'package:br_com_mindselfcompany_backoffice_web/repositories/authentication_repository.dart';
import 'package:br_com_mindselfcompany_backoffice_web/repositories/company_application_authentication_repository.dart';
import 'package:br_com_mindselfcompany_backoffice_web/repositories/company_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colours.dart';
import '../dto/company_application_authentication_dto.dart';
import '../model/application_model.dart';
import '../model/authentication_model.dart';
import '../model/pagination_model.dart';
import '../repositories/application_repository.dart';

class CompanyApplicationAuthenticationController extends GetxController {
  @protected
  final CompanyRepository companyRepository;
  final ApplicationRepository applicationRepository;
  final AuthenticationRepository authenticationRepository;
  final CompanyApplicationAuthenticationRepository
      companyApplicationAuthenticationRepository;

  CompanyApplicationAuthenticationController(
      this.companyRepository,
      this.applicationRepository,
      this.authenticationRepository,
      this.companyApplicationAuthenticationRepository);

  List<CompanyModel>? _companies = <CompanyModel>[];
  List<CompanyModel>? get companies => _companies;

  List<ApplicationModel> _applications = <ApplicationModel>[];
  List<ApplicationModel> get applications => _applications;

  List<AuthenticationModel> _authentications = <AuthenticationModel>[];
  List<AuthenticationModel> get authentications => _authentications;

  List<CompanyApplicationAuthenticationModel>
      _companyApplicationAuthentication =
      <CompanyApplicationAuthenticationModel>[];
  List<CompanyApplicationAuthenticationModel>
      get companyApplicationAuthentication => _companyApplicationAuthentication;

  RxList<Panel> _panel = <Panel>[].obs;
  RxList<Panel> get panel => _panel;

  RxInt _idCompany = 1000.obs;
  RxInt get idCompany => _idCompany;
  set idCompany(value) => _idCompany.value = value;

  RxBool _isValidCompany = true.obs;
  RxBool get isValidCompany => _isValidCompany;
  set isValidCompany(value) => _isValidCompany.value = value;

  RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;

  @override
  void onInit() {
    _listMinifiedCompany();
    super.onInit();
  }

  @override
  void onClose() {
    super.onInit();
  }

  Future<void> changePanelValue(AuthenticationCustom _) async {
    _.value = !(_.value ?? false);
    _panel.refresh();
  }

  Future _listMinifiedCompany() async {
    _isLoading.value = true;

    ApiResultModel<List<CompanyModel>> result =
        await companyRepository.listMinifiedCompany(CompanyDto());

    if (result.message!.isEmpty) _companies = result.data;

    _isLoading.value = false;
  }

  Future _getApplications() async {
    ApiResultModel<PaginationModel> result =
        await applicationRepository.listApplication(ApplicationDto(), 0);

    _applications.clear();

    if (result.message!.isEmpty) {
      result.data!.pagedList!.forEach((element) {
        _applications.add(ApplicationModel.fromJson(element));
      });
    } else
      throw Exception(result.message);
  }

  Future _getAuthentications() async {
    ApiResultModel<PaginationModel> result = await authenticationRepository
        .listAuthentication(AuthenticationDto(), 0);

    _authentications.clear();

    if (result.message!.isEmpty) {
      result.data!.pagedList!.forEach((element) {
        _authentications.add(AuthenticationModel.fromJson(element));
      });
    } else
      throw Exception(result.message);
  }

  Future _getCompanyApplicationAuthentication() async {
    ApiResultModel<PaginationModel> result =
        await companyApplicationAuthenticationRepository
            .listCompanyApplicationAuthentication(
                CompanyApplicationAuthenticationDto(
                    idCompany: _idCompany.value),
                0);

    _companyApplicationAuthentication.clear();

    if (result.message!.isEmpty) {
      result.data!.pagedList!.forEach((element) {
        _companyApplicationAuthentication
            .add(CompanyApplicationAuthenticationModel.fromJson(element));
      });
    } else
      throw Exception(result.message);
  }

  Future<void> getApplicationsAndAuthentications() async {
    _isLoading.value = true;

    await Future.wait([
      _getApplications(),
      _getAuthentications(),
      _getCompanyApplicationAuthentication()
    ]);

    await _makePanel();

    _isLoading.value = false;
  }

  Future<void> redirectHome() async {
    await Get.offAllNamed("/home", arguments: {"acao": "C", "idScreen": 0});
  }

  Future _updateEmployee() async {
    _isLoading.value = true;

    List<CompanyApplicationAuthenticationDto> lst =
        <CompanyApplicationAuthenticationDto>[];

    for (var i = 0; i < _panel.length; i++) {
      for (var z = 0; z < _panel.elementAt(i).authentications.length; z++) {
        CompanyApplicationAuthenticationDto co =
            CompanyApplicationAuthenticationDto();

        co.idCompany = _idCompany.value;
        co.idApplication = _panel.elementAt(i).applications.idApplication;

        if (_panel.elementAt(i).authentications.elementAt(z).value ?? false) {
          co.idAuthentication =
              _panel.elementAt(i).authentications.elementAt(z).idAuthentication;
        } else {
          co.idAuthentication = 0;
        }

        lst.add(co);
      }
    }

    var result = await companyApplicationAuthenticationRepository
        .updateCompanyApplicationAuthentication(lst);

    _isLoading.value = false;

    return result;
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
      ApiResultModel result = await _updateEmployee();

      if (result.message!.isEmpty) {
        Get.snackbar(
          "SUCESSO",
          "Configuração alterada!",
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

  Future<void> _makePanel() async {
    _panel.clear();

    for (var i = 0; i < _applications.length; i++) {
      var _apl = ApplicationModel(
          idApplication: _applications.elementAt(i).idApplication,
          name: _applications.elementAt(i).name);

      var _auth = <AuthenticationCustom>[];

      _authentications.forEach((e) {
        _auth.add(AuthenticationCustom(
            idAuthentication: e.idAuthentication, name: e.name));
      });

      _panel.add(Panel(applications: _apl, authentications: _auth));
    }

    for (var i = 0; i < _panel.length; i++) {
      var apl = _panel.elementAt(i).applications.idApplication;

      for (var z = 0; z < _panel.elementAt(i).authentications.length; z++) {
        var value =
            _companyApplicationAuthentication.firstWhereOrNull((element) {
          return element.idCompany == _idCompany.value &&
              element.idApplication == apl &&
              element.idAuthentication ==
                  _panel
                      .elementAt(i)
                      .authentications
                      .elementAt(z)
                      .idAuthentication;
        });

        if (value != null) {
          _panel.elementAt(i).authentications.elementAt(z).value = true;
        }
      }
    }
  }
}

class Panel {
  ApplicationModel applications;
  List<AuthenticationCustom> authentications;
  Panel({
    required this.applications,
    required this.authentications,
  });
}

class AuthenticationCustom extends AuthenticationModel {
  int? idAuthentication;
  String? name;
  bool? value;
  AuthenticationCustom({
    required this.idAuthentication,
    required this.name,
    this.value = false,
  }) : super(idAuthentication: idAuthentication, name: name);
}
