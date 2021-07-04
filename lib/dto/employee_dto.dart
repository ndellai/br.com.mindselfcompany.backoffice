import 'package:br_com_mindselfcompany_backoffice_web/model/employee_model.dart';

class EmployeeDto extends EmployeeModel {
  EmployeeDto(
      {int idEmployee,
      String email,
      String registration,
      int idCompany,
      String name,
      String area,
      String sector})
      : super(
            idEmployee: idEmployee,
            email: email,
            registration: registration,
            idCompany: idCompany,
            name: name,
            area: area,
            sector: sector);
}
