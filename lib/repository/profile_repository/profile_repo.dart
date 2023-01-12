import 'package:stockolio/model/profile/stock_profile.dart';
import 'package:stockolio/model/sampleData.dart';

class ProfileRepository {
  Future<StockProfile> getSymbolInfo(String symbolCode) async {
    return Future.delayed(Duration(microseconds: 500),
        () => SampleData.getStockProfile(symbolCode));
  }
}
