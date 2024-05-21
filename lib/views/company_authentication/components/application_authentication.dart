import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/colours.dart';
import '../../../controllers/company_application_authentication_controller.dart';

class ApplicationAuthentication
    extends GetView<CompanyApplicationAuthenticationController> {
  const ApplicationAuthentication(
      {super.key, required this.constraints, required this.indexAppl});

  final BoxConstraints constraints;
  final int indexAppl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.only(left: 20, right: 20),
          width: constraints.maxWidth,
          child: InputDecorator(
            decoration: new InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colours.Purple)),
              focusColor: Colors.black,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Colors.black),
              ),
              contentPadding: EdgeInsets.all(10),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              fillColor: Colors.grey.shade200,
              errorStyle: TextStyle(
                color: Colours.BlueAccented,
                fontWeight: FontWeight.bold,
                backgroundColor: Color(0x22000000),
              ),
              errorMaxLines: 2,
              filled: true,
              labelText:
                  controller.panel.elementAt(indexAppl).applications.name,
              labelStyle: TextStyle(
                  fontSize: constraints.maxHeight * 0.03,
                  color: Colours.Blue,
                  fontWeight: FontWeight.bold),
            ),
            child: Container(
              height: constraints.maxHeight * 0.07,
              child: Row(
                  children: List.generate(
                      controller.panel
                          .elementAt(indexAppl)
                          .authentications
                          .length, (indexAuth) {
                return Row(
                  children: [
                    SizedBox(
                      width: constraints.maxWidth * 0.01,
                    ),
                    Text(
                        controller.panel
                            .elementAt(indexAppl)
                            .authentications
                            .elementAt(indexAuth)
                            .name!,
                        style: TextStyle(
                          fontSize: constraints.maxHeight * 0.023,
                        )),
                    Checkbox(
                      value: controller.panel
                          .elementAt(indexAppl)
                          .authentications
                          .elementAt(indexAuth)
                          .value,
                      onChanged: (bool? value) async {
                        await controller.changePanelValue(controller.panel
                            .elementAt(indexAppl)
                            .authentications
                            .elementAt(indexAuth));
                      },
                    ),
                  ],
                );
              })),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
