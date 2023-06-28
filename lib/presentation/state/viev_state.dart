enum ViewState {
  initial,
  loading,
  success,
  error;

  bool get isloading => this == loading;
}
