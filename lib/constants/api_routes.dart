class ApiRoutes {
  static final String login = "/msc/api/LoginDash/DoLogin";

  static final String companyLst = "/msc/api/Company/GetCompany";
  static final String companyAdd = "/msc/api/Company/InsertCompany";
  static final String companyDel = "/msc/api/Company/DeleteCompany";
  static final String companyEdt = "/msc/api/Company/UpdateCompany";
  static final String companyDomainLst = "/msc/api/Company/GetCompanyDomain";

  static final String minifiedCompanyLst =
      "/msc/api/Company/GetMinifiedCompany";

  static final String employeeLst = "/msc/api/Employee/GetEmployee";
  static final String employeeAdd = "/msc/api/Employee/InsertEmployee";
  static final String employeeDel = "/msc/api/Employee/DeleteEmployee";
  static final String employeeEdt = "/msc/api/Employee/UpdateEmployee";
  static final String employeeUpl = "/msc/api/Employee/UploadFile";

  static final String reportConsolidate =
      "/msc/api/Report/GetReportConsolidate";

  static final String reportSessionAndTimer = "/msc/api/Reports/GetSessionAndTimer";
  static final String reportCourses = "/msc/api/Reports/GetCourses";
  static final String reportEmployess = "/msc/api/Reports/GetActiveEmployees";
}
