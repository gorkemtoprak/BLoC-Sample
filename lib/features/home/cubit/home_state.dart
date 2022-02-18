part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.items,
    this.selectItems,
    this.isLoading,
    this.categories,
    this.isInitial = false,
    this.pageNumber,
    this.isUpdated = false,
  });

  final List<ProductModel>? items;
  final List<ProductModel>? selectItems;
  final bool? isLoading;
  final List<String>? categories;
  final bool isInitial;
  final int? pageNumber;
  final bool isUpdated;

  @override
  List<Object?> get props {
    return [
      items,
      selectItems,
      isLoading,
      categories,
      isInitial,
      pageNumber,
      isUpdated,
    ];
  }

  HomeState copyWith({
    List<ProductModel>? items,
    List<ProductModel>? selectItems,
    bool? isLoading,
    List<String>? categories,
    bool? isInitial,
    int? pageNumber,
    bool? isUpdated,
  }) {
    return HomeState(
      items: items ?? this.items,
      selectItems: selectItems ?? this.selectItems,
      isLoading: isLoading ?? this.isLoading,
      categories: categories ?? this.categories,
      isInitial: isInitial ?? this.isInitial,
      pageNumber: pageNumber ?? this.pageNumber,
      isUpdated: isUpdated ?? this.isUpdated,
    );
  }
}
