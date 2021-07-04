class ApiResultModel<T> {
  String message = "";
  T data;

  ApiResultModel({this.message, this.data});
}
