import 'package:flutter/material.dart';
import 'package:br_com_mindselfcompany_backoffice_web/constants/colours.dart';

class BottomPage extends StatelessWidget {
  final double? margin;

  BottomPage({this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colours.Purple,
      height: 30,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 200,
            margin: EdgeInsets.only(left: margin!),
            child: Text("MeDiT",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.013)),
          ),
          Container(
            child: Text(
                "Copyright © ${DateTime.now().year} - MINDSELF DESENVOLVIMENTO HUMANO LTDA",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.01)),
          ),
          Container(
            width: 200,
            margin: EdgeInsets.only(right: 10),
            alignment: Alignment.centerRight,
            child: Text("MeDiT",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.013)),
          ),
        ],
      ),
    );
  }
}
