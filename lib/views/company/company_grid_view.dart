import 'package:br_com_mindselfcompany_backoffice_web/controllers/company_controller.dart';
import 'package:br_com_mindselfcompany_backoffice_web/model/company_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompanyGridView extends GetView<CompanyController> {
  final List<CompanyModel>? companies;
  final BoxConstraints? constraints;

  const CompanyGridView({
    Key? key,
    this.companies,
    this.constraints,
  }) : super(key: key);

  List<Widget> getRows() {
    List<Widget> _widget = [];

    companies!.forEach((company) {
      _widget.add(Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 5, left: 20, right: 5),
        width: constraints!.maxWidth,
        child: Row(mainAxisSize: MainAxisSize.max, children: [
          Container(
            alignment: Alignment.center,
            height: 30,
            width: constraints!.maxWidth * 0.15,
            color: Colors.grey.shade300,
            child: Text(
              company.idCompany.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: constraints!.maxHeight * 0.03),
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
                company.name!.toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: constraints!.maxHeight * 0.03),
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
                onTap: () async =>
                    await controller.redirectCompanyEdt(company.idCompany!),
              )),
          SizedBox(
            width: 4,
          ),
          Container(
              color: Colors.grey.shade300,
              width: 30,
              height: 30,
              child: InkWell(
                onTap: () async => await controller.deleteCompany(
                    company.idCompany!, company.name!),
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
