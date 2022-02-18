import 'package:fake_store/product/constants/app_constants.dart';
import 'package:vexana/vexana.dart';

class ProductNetworkManager extends NetworkManager {
  ProductNetworkManager()
      : super(
          options: BaseOptions(baseUrl: ApplicationConstant.instance.baseUrl),
        );
}
