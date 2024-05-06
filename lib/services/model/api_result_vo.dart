class ApiResultVO {
  final int? code;
  final String? message;
  final dynamic data;

  ApiResultVO({this.code, this.message, this.data});

  factory ApiResultVO.fromJson(Map<String, dynamic> json) => ApiResultVO(
        code: json["code"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : json["data"],
      );
}
