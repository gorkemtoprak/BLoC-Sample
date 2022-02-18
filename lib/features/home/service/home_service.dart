import 'package:fake_store/features/home/model/product_model.dart';
import 'package:fake_store/product/query/product_queries.dart';
import 'package:vexana/vexana.dart';

enum _HomeServicePath { products, categories }

abstract class IHomeService {
  final INetworkManager networkManager;

  IHomeService(this.networkManager);

  Future<List<ProductModel>> fetchAllProduct({int count = 5});
  Future<List<String>?> fetchAllCategories();
}

class HomeService extends IHomeService {
  HomeService(INetworkManager networkManager) : super(networkManager);

  @override
  Future<List<ProductModel>> fetchAllProduct({int count = 10}) async {
    final response =
        await networkManager.send<ProductModel, List<ProductModel>>(
      _HomeServicePath.products.name,
      parseModel: ProductModel(),
      method: RequestType.GET,
      queryParameters: Map.fromEntries(
        [ProductQueries.limit.toMapEntry('$count')],
      ),
    );
    return response.data!;
  }

  @override
  Future<List<String>?> fetchAllCategories() async {
    final response = await networkManager.sendPrimitive(
        '${_HomeServicePath.products.name}/${_HomeServicePath.categories.name}');

    return response is List ? response.map((e) => '$e').toList() : null;
  }
}
