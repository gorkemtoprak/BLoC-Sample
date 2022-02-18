import 'package:fake_store/features/home/cubit/home_cubit.dart';
import 'package:fake_store/features/home/service/home_service.dart';
import 'package:fake_store/product/constants/app_constants.dart';
import 'package:fake_store/product/network/product_network_manager.dart';
import 'package:fake_store/product/network/project_network_image.dart';
import 'package:fake_store/product/widget/dropdown_widget.dart';
import 'package:fake_store/product/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  void _listenScroll(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent) {
        context.read<HomeCubit>().fetchNewItems();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(HomeService(ProductNetworkManager())),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: _loadingCenter(),
          title: const Text(
            'BLoC Store',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            _dropdownProject(),
          ],
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 20,
            bottom: 20,
          ),
          child: _bodyListView(),
        ),
      ),
    );
  }

  Widget _bodyListView() {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.isInitial) {
          _listenScroll(context);
        }
      },
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.selectItems?.length ?? kZero.toInt(),
          itemBuilder: (BuildContext context, int index) {
            final _item = state.selectItems![index];
            return Column(
              children: [
                ListTile(
                  title: SizedBox(
                    height: context.dynamicHeight(0.32),
                    child: ProjectNetworkImage.network(src: _item.image),
                  ),
                  subtitle: Text(
                    _item.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // state.selectItems.isNotNullOrEmpty &&
                //         index == state.selectItems!.length - 1
                //     ? const LoadingCenter()
                //     : const SizedBox.shrink(),
                _dummyPlus(context, index, state),
              ],
            );
          },
        );
      },
    );
  }

  TextButton _dummyPlus(BuildContext context, int index, HomeState state) {
    return TextButton(
      onPressed: () {
        context.read<HomeCubit>().updateList(index, state.selectItems?[index]);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${state.selectItems?[index].price ?? kZero}'),
          const Icon(Icons.add),
        ],
      ),
    );
  }

  Widget _loadingCenter() {
    return BlocSelector<HomeCubit, HomeState, bool>(
      selector: (state) {
        return state.isLoading ?? false;
      },
      builder: (context, state) {
        return AnimatedOpacity(
          opacity: state ? kOne : kZero,
          duration: context.durationLow,
          child: const LoadingCenter(),
        );
      },
    );
  }

  Widget _dropdownProject() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: ProductDropDown(
              items: state.categories ?? [],
              onSelected: (String data) {
                context.read<HomeCubit>().selectedCategories(data);
              },
            ),
          ),
        );
      },
    );
  }
}
