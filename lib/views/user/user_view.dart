import 'package:br_com_mindselfcompany_backoffice_web/constants/colours.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        color: Colours.Purple,
        height: 30,
        child: Text(
            "Copyright © ${DateTime.now().year} - MINDSELF DESENVOLVIMENTO HUMANO LTDA",
            style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.01)),
      ),
      appBar: AppBar(
        backgroundColor: Colours.Purple,
        title: Container(
          child: Text(
            "Usuários",
            style: TextStyle(fontSize: 30),
          ),
          alignment: Alignment.center,
        ),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
              margin: EdgeInsets.only(left: 57),
              height: constraints.maxHeight,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.only(top: 5, left: 20, right: 5),
                          width: constraints.maxWidth - 70,
                          height: 40,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  height: 40,
                                  child: TextFormField(
                                    cursorColor: Colors.black,
                                    style: TextStyle(color: Colors.black),
                                    validator: (email) {
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding: EdgeInsets.only(left: 20),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      fillColor: Colors.grey.shade300,
                                      errorMaxLines: 2,
                                      filled: true,
                                      hintText:
                                          'Pesquise pelo email ou nome...',
                                      hintStyle: TextStyle(
                                        fontSize: constraints.maxHeight * 0.03,
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey.shade300),
                                ),
                              ),
                              FittedBox(
                                child: Icon(Icons.search),
                              )
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.only(top: 5, left: 20, right: 5),
                          width: constraints.maxWidth,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 40,
                                width: constraints.maxWidth * 0.15,
                                color: Colours.Blue,
                                child: Text(
                                  "ID",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: constraints.maxHeight * 0.03),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 40,
                                width: constraints.maxWidth * 0.3,
                                color: Colours.Blue,
                                child: Text(
                                  "E-MAIL",
                                  style: TextStyle(
                                      color: Colors.white,
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
                                  height: 40,
                                  color: Colours.Blue,
                                  child: Text(
                                    "NOME",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: constraints.maxHeight * 0.03),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Container(
                                  color: Colours.Blue,
                                  width: 30,
                                  height: 40,
                                  child: Container()),
                              SizedBox(
                                width: 4,
                              ),
                              Container(
                                  color: Colours.Blue,
                                  width: 30,
                                  height: 40,
                                  child: Text("")),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.only(top: 5, left: 20, right: 5),
                          width: constraints.maxWidth,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: constraints.maxWidth * 0.15,
                                color: Colors.grey.shade300,
                                child: Text(
                                  "1",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: constraints.maxHeight * 0.03),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: constraints.maxWidth * 0.30,
                                color: Colors.grey.shade300,
                                child: Text(
                                  "NELSON.DELLAI@GMAIL.COM",
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
                                    "NELSON DELLAI",
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
                                  child: Container(
                                    child: Icon(Icons.edit),
                                  )),
                              SizedBox(
                                width: 4,
                              ),
                              Container(
                                  color: Colors.grey.shade300,
                                  width: 30,
                                  height: 30,
                                  child: Container(
                                    child: Icon(Icons.delete),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.only(top: 5, left: 20, right: 5),
                          width: constraints.maxWidth,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: constraints.maxWidth * 0.15,
                                color: Colors.grey.shade300,
                                child: Text(
                                  "1",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: constraints.maxHeight * 0.03),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: constraints.maxWidth * 0.30,
                                color: Colors.grey.shade300,
                                child: Text(
                                  "NELSON.DELLAI@GMAIL.COM",
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
                                    "NELSON DELLAI",
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
                                  child: Container(
                                    child: Icon(Icons.edit),
                                  )),
                              SizedBox(
                                width: 4,
                              ),
                              Container(
                                  color: Colors.grey.shade300,
                                  width: 30,
                                  height: 30,
                                  child: Container(
                                    child: Icon(Icons.delete),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.only(top: 5, left: 20, right: 5),
                          width: constraints.maxWidth,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: constraints.maxWidth * 0.15,
                                color: Colors.grey.shade300,
                                child: Text(
                                  "1",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: constraints.maxHeight * 0.03),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: constraints.maxWidth * 0.30,
                                color: Colors.grey.shade300,
                                child: Text(
                                  "NELSON.DELLAI@GMAIL.COM",
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
                                    "NELSON DELLAI",
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
                                  child: Container(
                                    child: Icon(Icons.edit),
                                  )),
                              SizedBox(
                                width: 4,
                              ),
                              Container(
                                  color: Colors.grey.shade300,
                                  width: 30,
                                  height: 30,
                                  child: Container(
                                    child: Icon(Icons.delete),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.only(top: 5, left: 20, right: 5),
                          width: constraints.maxWidth,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: constraints.maxWidth * 0.15,
                                color: Colors.grey.shade300,
                                child: Text(
                                  "1",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: constraints.maxHeight * 0.03),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: constraints.maxWidth * 0.30,
                                color: Colors.grey.shade300,
                                child: Text(
                                  "NELSON.DELLAI@GMAIL.COM",
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
                                    "NELSON DELLAI",
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
                                  child: Container(
                                    child: Icon(Icons.edit),
                                  )),
                              SizedBox(
                                width: 4,
                              ),
                              Container(
                                  color: Colors.grey.shade300,
                                  width: 30,
                                  height: 30,
                                  child: Container(
                                    child: Icon(Icons.delete),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.only(top: 5, left: 20, right: 5),
                          width: constraints.maxWidth,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: constraints.maxWidth * 0.15,
                                color: Colors.grey.shade300,
                                child: Text(
                                  "1",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: constraints.maxHeight * 0.03),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: constraints.maxWidth * 0.30,
                                color: Colors.grey.shade300,
                                child: Text(
                                  "NELSON.DELLAI@GMAIL.COM",
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
                                    "NELSON DELLAI",
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
                                  child: Container(
                                    child: Icon(Icons.edit),
                                  )),
                              SizedBox(
                                width: 4,
                              ),
                              Container(
                                  color: Colors.grey.shade300,
                                  width: 30,
                                  height: 30,
                                  child: Container(
                                    child: Icon(Icons.delete),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.only(top: 5, left: 20, right: 5),
                          width: constraints.maxWidth,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: constraints.maxWidth * 0.15,
                                color: Colors.grey.shade300,
                                child: Text(
                                  "1",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: constraints.maxHeight * 0.03),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: constraints.maxWidth * 0.30,
                                color: Colors.grey.shade300,
                                child: Text(
                                  "NELSON.DELLAI@GMAIL.COM",
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
                                    "NELSON DELLAI",
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
                                  child: Container(
                                    child: Icon(Icons.edit),
                                  )),
                              SizedBox(
                                width: 4,
                              ),
                              Container(
                                  color: Colors.grey.shade300,
                                  width: 30,
                                  height: 30,
                                  child: Container(
                                    child: Icon(Icons.delete),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.only(top: 5, left: 20, right: 5),
                          width: constraints.maxWidth,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: constraints.maxWidth * 0.15,
                                color: Colors.grey.shade300,
                                child: Text(
                                  "1",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: constraints.maxHeight * 0.03),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: constraints.maxWidth * 0.30,
                                color: Colors.grey.shade300,
                                child: Text(
                                  "NELSON.DELLAI@GMAIL.COM",
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
                                    "NELSON DELLAI",
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
                                  child: Container(
                                    child: Icon(Icons.edit),
                                  )),
                              SizedBox(
                                width: 4,
                              ),
                              Container(
                                  color: Colors.grey.shade300,
                                  width: 30,
                                  height: 30,
                                  child: Container(
                                    child: Icon(Icons.delete),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.only(top: 5, left: 20, right: 5),
                          width: constraints.maxWidth,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: constraints.maxWidth * 0.15,
                                color: Colors.grey.shade300,
                                child: Text(
                                  "1",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: constraints.maxHeight * 0.03),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: constraints.maxWidth * 0.30,
                                color: Colors.grey.shade300,
                                child: Text(
                                  "NELSON.DELLAI@GMAIL.COM",
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
                                    "NELSON DELLAI",
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
                                  child: Container(
                                    child: Icon(Icons.edit),
                                  )),
                              SizedBox(
                                width: 4,
                              ),
                              Container(
                                  color: Colors.grey.shade300,
                                  width: 30,
                                  height: 30,
                                  child: Container(
                                    child: Icon(Icons.delete),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.only(top: 5, left: 20, right: 5),
                          width: constraints.maxWidth,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: constraints.maxWidth * 0.15,
                                color: Colors.grey.shade300,
                                child: Text(
                                  "1",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: constraints.maxHeight * 0.03),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: constraints.maxWidth * 0.30,
                                color: Colors.grey.shade300,
                                child: Text(
                                  "NELSON.DELLAI@GMAIL.COM",
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
                                    "NELSON DELLAI",
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
                                  child: Container(
                                    child: Icon(Icons.edit),
                                  )),
                              SizedBox(
                                width: 4,
                              ),
                              Container(
                                  color: Colors.grey.shade300,
                                  width: 30,
                                  height: 30,
                                  child: Container(
                                    child: Icon(Icons.delete),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.only(top: 5, left: 20, right: 5),
                          width: constraints.maxWidth,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: constraints.maxWidth * 0.15,
                                color: Colors.grey.shade300,
                                child: Text(
                                  "1",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: constraints.maxHeight * 0.03),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: constraints.maxWidth * 0.30,
                                color: Colors.grey.shade300,
                                child: Text(
                                  "NELSON.DELLAI@GMAIL.COM",
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
                                    "NELSON DELLAI",
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
                                  child: Container(
                                    child: Icon(Icons.edit),
                                  )),
                              SizedBox(
                                width: 4,
                              ),
                              Container(
                                  color: Colors.grey.shade300,
                                  width: 30,
                                  height: 30,
                                  child: Container(
                                    child: Icon(Icons.delete),
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                          width: constraints.maxWidth,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                alignment: Alignment.topCenter,
                                padding: EdgeInsets.only(left: 10, right: 10),
                                color: Colours.Blue,
                                height: 40,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Página 01 de 10",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                constraints.maxHeight * 0.02),
                                      ),
                                    ),
                                    IconButton(
                                        icon: Icon(
                                          Icons.first_page,
                                          color: Colors.white,
                                          size: constraints.maxHeight * 0.04,
                                        ),
                                        onPressed: null),
                                    IconButton(
                                        icon: Icon(
                                          Icons.skip_previous,
                                          color: Colors.white,
                                          size: constraints.maxHeight * 0.04,
                                        ),
                                        onPressed: null),
                                    IconButton(
                                        icon: Icon(
                                          Icons.skip_next,
                                          color: Colors.white,
                                          size: constraints.maxHeight * 0.04,
                                        ),
                                        onPressed: null),
                                    IconButton(
                                        icon: Icon(
                                          Icons.last_page,
                                          color: Colors.white,
                                          size: constraints.maxHeight * 0.04,
                                        ),
                                        onPressed: null)
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 5),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    minimumSize:
                                        MaterialStateProperty.resolveWith(
                                            (states) => Size(
                                                constraints.maxWidth * 0.2,
                                                constraints.maxHeight * 0.08)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colours.BlueAccented),
                                  ),
                                  onPressed: () async {
                                    await Get.offNamed("/user_add");
                                  },
                                  child: Text(
                                    "NOVO USUÁRIO",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: constraints.maxHeight * 0.03),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
