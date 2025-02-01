enum DataStateStatus { loading, completed, error }

class DataStateStatusModel<T> {
  final DataStateStatus status;
  final T? data;
  final String? errorMessage;

  DataStateStatusModel({required this.status, this.data, this.errorMessage});

  factory DataStateStatusModel.loading() =>
      DataStateStatusModel(status: DataStateStatus.loading);

  factory DataStateStatusModel.completed(T data) =>
      DataStateStatusModel(status: DataStateStatus.completed, data: data);

  factory DataStateStatusModel.error(String message) => DataStateStatusModel(
      status: DataStateStatus.error, errorMessage: message);
}
