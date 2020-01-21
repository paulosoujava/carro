class ApiResponse<T>{
  bool ok;
  String errorMessage;
  T result;

  ApiResponse.ok(this.result){
    ok = true;
  }
  ApiResponse.error(this.errorMessage){
    ok = false;
  }


}