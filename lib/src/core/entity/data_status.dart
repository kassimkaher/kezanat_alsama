// enum DataStatus { ideal, loading, success, error }
// class DataStatus {
//   final String? id;
//   DataStatus({this.id});
//   factory DataStatus.ideal() => DataStatus();
//   factory DataStatus.loading({String? id}) => DataStatus(id: id);
//   factory DataStatus.success() => DataStatus();
//   factory DataStatus.error() => DataStatus();

//   static get init => DataStatus.ideal();
// }

abstract class DataStatus<T> {
  final T? data;

  const DataStatus({
    this.data,
  });
}

class StateLoading<T> extends DataStatus<T> {
  const StateLoading({dynamic data}) : super(data: data);
}

class DataIdeal<T> extends DataStatus<T> {
  const DataIdeal() : super(data: null);
}

class SateSucess<T> extends DataStatus<T> {
  const SateSucess() : super(data: null);
}

class DataSucessOperation<T> extends DataStatus<T> {
  const DataSucessOperation() : super(data: null);
}

class StateError<T> extends DataStatus<T> {
  const StateError() : super(data: null);
}
