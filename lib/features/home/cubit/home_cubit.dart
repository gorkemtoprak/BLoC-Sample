import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fake_store/features/home/model/product_model.dart';
import 'package:fake_store/features/home/service/home_service.dart';
import 'package:fake_store/product/constants/app_constants.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeService) : super(const HomeState()) {
    initalComplete();
  }

  final IHomeService homeService;

  Future<void> initalComplete() async {
    await Future.microtask(() {
      emit(const HomeState(isInitial: true));
    });
    await Future.wait([fetchAllItems(), fetchAllCategories()]);
    emit(state.copyWith(selectItems: state.items));
  }

  void selectedCategories(String data) {
    emit(
      state.copyWith(
        selectItems:
            state.items?.where((element) => element.category == data).toList(),
      ),
    );
  }

  Future<void> fetchAllItems() async {
    changeLoading();
    final response = await homeService.fetchAllProduct();

    emit(state.copyWith(items: response));
    changeLoading();
  }

  Future<void> fetchNewItems() async {
    if (state.isLoading ?? false) {
      return;
    }
    changeLoading();
    int _pageNumber = (state.pageNumber ?? kOne.toInt());
    final response =
        await homeService.fetchAllProduct(count: ++_pageNumber * 5);
    changeLoading();
    emit(state.copyWith(items: response, pageNumber: _pageNumber));
  }

  Future<void> fetchAllCategories() async {
    final response = await homeService.fetchAllCategories();
    emit(state.copyWith(categories: response));
  }

  void updateList(int index, ProductModel? model) {
    if (model != null) {
      emit(state.copyWith(isUpdated: false));
      state.items?[index].price = (model.price ?? kZero) + 100;
      emit(state.copyWith(isUpdated: true));
    }
  }

  void changeLoading() {
    emit(state.copyWith(isLoading: !(state.isLoading ?? false)));
  }
}
