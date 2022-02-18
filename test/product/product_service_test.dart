import 'package:fake_store/features/home/service/home_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vexana/vexana.dart';

void main() {
  late IHomeService homeService;
  setUp(() {
    homeService = HomeService(
      NetworkManager(
        options: BaseOptions(baseUrl: 'https://fakestoreapi.com/'),
      ),
    );
  });
  test('Fetch Datas', () async {
    final response = await homeService.fetchAllProduct();

    expect(response, isNotEmpty);
  });

  test('Fetch Categories', () async {
    final response = await homeService.fetchAllCategories();

    expect(response, isNotEmpty);
  });
}
