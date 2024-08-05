part of 'apicubit_cubit.dart';

@immutable
abstract class ApicubitState {}

class ApicubitInitial extends ApicubitState {}

class ApicubitLoading extends ApicubitState {}

class ApicubitSuccess_allProdcut extends ApicubitState {
  final List<Product> data;
  ApicubitSuccess_allProdcut(this.data);
}

class ApicubitError_allProdcut extends ApicubitState {
  String error;
  ApicubitError_allProdcut(this.error);
}

class ApicubitSuccess_singleProdcut extends ApicubitState {
  final Product data;
  ApicubitSuccess_singleProdcut(this.data);
}

class ApicubitError_singleProdcut extends ApicubitState {
  String error;
  ApicubitError_singleProdcut(this.error);
}

class ApicubitSuccess_allCategory extends ApicubitState {
  final List<Categoryes> data;
  ApicubitSuccess_allCategory(this.data);
}

class ApicubitError_allCategory extends ApicubitState {
  String error;
  ApicubitError_allCategory(this.error);
}

//singal category
class ApicubitSuccess_singleCategory extends ApicubitState {
  final dynamic data;
  ApicubitSuccess_singleCategory(this.data);
}

class ApicubitError_singleCategory extends ApicubitState {
  String error;
  ApicubitError_singleCategory(this.error);
}
