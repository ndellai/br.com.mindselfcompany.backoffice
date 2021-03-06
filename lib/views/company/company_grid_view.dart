import 'package:flutter/material.dart';
import 'package:br_com_mindselfcompany_backoffice_web/controllers/company_controller.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/company_model.dart';

class CompanyGridView extends StatelessWidget {
  final List<CompanyModel> companies;
  final BoxConstraints constraints;
  final Function onDeleteCompany;
  final Function onRedirect;
  final CompanyController companyController;

  const CompanyGridView(
      {Key key,
      this.companies,
      this.constraints,
      this.onDeleteCompany,
      this.onRedirect,
      this.companyController})
      : super(key: key);

  List<Widget> getRows() {
    List<Widget> _widget = [];

    companies.forEach((company) {
      _widget.add(Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 5, left: 20, right: 5),
        width: constraints.maxWidth,
        child: Row(mainAxisSize: MainAxisSize.max, children: [
          Container(
            alignment: Alignment.center,
            height: 30,
            width: constraints.maxWidth * 0.15,
            color: Colors.grey.shade300,
            child: Text(
              company.idCompany.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: constraints.maxHeight * 0.03),
            ),
          ),
          SizedBox(
            width: 4,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              height: 30,
              color: Colors.grey.shade300,
              child: Text(
                company.name.toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: constraints.maxHeight * 0.03),
              ),
            ),
          ),
          SizedBox(
            width: 4,
          ),
          Container(
              color: Colors.grey.shade300,
              width: 30,
              height: 30,
              child: InkWell(
                child: Container(
                  child: Icon(Icons.edit),
                ),
                onTap: () async => await onRedirect(company.idCompany),
              )),
          SizedBox(
            width: 4,
          ),
          Container(
              color: Colors.grey.shade300,
              width: 30,
              height: 30,
              child: InkWell(
                onTap: () async => await onDeleteCompany(
                    company.idCompany, company.name, companyController),
                child: Container(
                  child: Icon(Icons.delete),
                ),
              )),
        ]),
      ));
    });

    return _widget;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: getRows(),
    );
  }
}
