import 'dart:math';

import 'package:intl/intl.dart';
import 'package:stockolio/model/exchange/exchange.dart';
import 'package:stockolio/model/market/stock_chart.dart';
import 'package:stockolio/model/market/stock_info.dart';
import 'package:stockolio/model/market/stock_quote.dart';
import 'package:stockolio/model/profile/stock_profile.dart';

import 'company/company_info.dart';
import 'market/stock_overview.dart';

class SampleData {
  static List<StockOverviewModel> getAll() {
    final List<StockOverviewModel> data = [];

    final exchanges = getExchanges();

    for (var comp in listCompany) {
      int rdExchangeIndex = new Random().nextInt(exchanges.length);

      var exchange = exchanges[rdExchangeIndex];

      double priceNum = (11000 + new Random().nextInt(99000)).toDouble();
      double changePercentNum =
          new Random().nextInt(99) + new Random().nextDouble();
      double changeAmount = (-1000 + new Random().nextInt(1500)).toDouble();
      data.add(
        StockOverviewModel(
            code: comp.code!,
            name: comp.name!,
            exchangeCode: exchange.code,
            price: priceNum,
            changeAmount: changeAmount,
            changePercent: changePercentNum),
      );
    }

    return data;
  }

  static List<StockOverviewModel> getWatchList() {
    final List<StockOverviewModel> data = [];

    var sampleData = getAll();

    for (var i = 0; i < 5; i++) {
      data.add(sampleData[i]);
    }

    return data;
  }

  static List<StockOverviewModel> getExchangeSymbols(String exchangeCode) {
    final sampleData = getAll();
    final List<StockOverviewModel> data = sampleData
        .where((element) => element.exchangeCode.contains(exchangeCode))
        .toList();

    return data;
  }

  static List<StockOverviewModel> getExchangeSymbolByCodes(
      List<String> symbolCodes) {
    final sampleData = getAll();
    final List<StockOverviewModel> data = sampleData
        .where((element) => symbolCodes.contains(element.code))
        .toList();

    return data;
  }

  static List<ExchangeModel> getExchanges() {
    return [
      ExchangeModel(code: 'HNX', name: 'HNX', curency: 'VND'),
      ExchangeModel(code: 'HOSE', name: 'HOSE', curency: 'VND'),
      ExchangeModel(code: 'UPCOM', name: 'UPCOM', curency: 'VND'),
      ExchangeModel(code: 'VN30', name: 'VN30', curency: 'VND')
    ];
  }

  static StockProfile getStockProfile(String symbolCode) {
    return new StockProfile(
        stockInfo: new StockInfo(
            ceo: 'Pham Nhat Vuong',
            beta: '',
            changes: 1500,
            changesPercentage: '0.4%',
            companyName: 'Vincom Retail',
            description:
                'Công ty Vincom Retail được thành lập ban đầu vào ngày 11/4/2012 dưới hình thức công ty trách nhiệm hữu hạn. Trước đó, Tập đoàn Vingroup bắt đầu phát triển các TTTM thương hiệu “Vincom” từ năm 2004. Các TTTM này góp phần quan trọng trong quy hoạch phát triển tổng thể các dự án phức hợp và khu căn hộ do Tập đoàn Vingroup phát triển. Từ năm 2013, Vincom Retail được định hướng là đơn vị phát triển và vận hành hệ thống TTTM mang thương hiệu Vincom của Tập đoàn, đồng thời cũng được chuyển thành công ty cổ phần kể từ ngày 14/5/2013.',
            exchange: 'HSX',
            industry: 'Real Estate',
            mktCap: '2,328,818,410',
            price: 27.5,
            sector: 'VN30',
            volAvg: '2,774,972'),
        stockQuote: new StockQuote(
            avgVolume: 2774972,
            change: 1500,
            changesPercentage: 1.5,
            dayHigh: 28000,
            dayLow: 23000,
            eps: 1.05,
            pe: 26.12,
            marketCap: 2328818410,
            name: 'Vincom Retail',
            open: 23400,
            previousClose: 23400,
            price: 27500,
            sharesOutstanding: 2328818410,
            symbol: 'BTCUSDT',
            volume: 2000000000,
            yearHigh: 40000,
            yearLow: 20000),
        stockCharts: SampleData.listSampleStockChart());
  }

  static List<StockChart> listSampleStockChart() {
    List<StockChart> stockCharts = [];

    var rd = new Random();

    var toDay = DateTime.now();
    var startDate = toDay.add(new Duration(days: -30));

    for (var i = 0; i < 30; i++) {
      var chartDate = startDate.add(new Duration(days: i));

      String formatDate = DateFormat('dd-MM-yyyy').format(chartDate);

      stockCharts.add(new StockChart(
          date: chartDate, close: rd.nextDouble(), label: formatDate));
    }

    return stockCharts;
  }
}

final f = new NumberFormat("#,###", "en_US");
final rateFormat = new NumberFormat("#,###.##", "en_US");

List<CompanyInfo> listCompany = [
  CompanyInfo(code: 'TCB', name: 'Techcombank'),
  CompanyInfo(code: 'VHM', name: 'Vinhomes'),
  CompanyInfo(code: 'HPG', name: 'Hoa Phat'),
  CompanyInfo(code: 'NVL', name: 'Novaland'),
  CompanyInfo(code: 'VPB', name: 'VP Bank'),
  CompanyInfo(code: 'VNM', name: 'Vinamilk'),
  CompanyInfo(code: 'HSG', name: 'Hoa Sen'),
  CompanyInfo(code: 'CTG', name: 'Ngan hang cong thuong viet nam'),
  CompanyInfo(code: 'MSN', name: 'Masan'),
  CompanyInfo(code: 'PNJ', name: 'PNJ'),
  CompanyInfo(code: 'VCB', name: 'Vietcombank'),
  CompanyInfo(code: 'VIC', name: 'Vingroup'),
  CompanyInfo(code: 'SSI', name: 'SSI Stock Company'),
  CompanyInfo(code: 'SCB', name: 'SC Bank'),
  CompanyInfo(code: 'ASM', name: 'Sao mai company'),
  CompanyInfo(code: 'MWG', name: 'The gioi di dong'),
  CompanyInfo(code: 'PLX', name: 'Tap doan xang dau viet nam'),
  CompanyInfo(code: 'SAB', name: 'Sabeco'),
  CompanyInfo(code: 'VRE', name: 'Vincom Retail'),
  CompanyInfo(code: 'VRE', name: 'Vincom Retail'),
  CompanyInfo(code: 'VRE', name: 'Vincom Retail'),
  CompanyInfo(code: 'VRE', name: 'Vincom Retail'),
  CompanyInfo(code: 'VRE', name: 'Vincom Retail'),
  CompanyInfo(code: 'VRE', name: 'Vincom Retail'),
  CompanyInfo(code: 'VRE', name: 'Vincom Retail'),
  CompanyInfo(code: 'VRE', name: 'Vincom Retail'),
  CompanyInfo(code: 'VRE', name: 'Vincom Retail'),
  CompanyInfo(code: 'VRE', name: 'Vincom Retail'),
  CompanyInfo(code: 'VRE', name: 'Vincom Retail'),
  CompanyInfo(code: 'VRE', name: 'Vincom Retail'),
  CompanyInfo(code: 'VRE', name: 'Vincom Retail'),
];
