import 'package:recap/httpServices/OrderServices/OrderFetcherApi.dart';
import 'package:recap/providers/OrdersProvider/OrderRepository.dart';
import '../../shared_preferences.dart';

class OrderFetcher {
  Future<void> fetchOrders() async {
    String idToken = await ShopSharedPreferences().idToken;
    String userId = await ShopSharedPreferences().userId;
    OrderRepository orderRepository = OrderRepository();
    OrderFetcherApi orderFetcherApi = OrderFetcherApi();
    orderRepository.orders = await orderFetcherApi.fetchOrders(idToken, userId);
  }
}
