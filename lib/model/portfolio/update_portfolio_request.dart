import 'dart:ffi';

class UpdatePortfolioRequest {
  final Int64 portfolioId;
  final String name;
  final String watchlist;

  UpdatePortfolioRequest({
    required this.portfolioId,
    required this.name,
    required this.watchlist,
  });

  Map<String, String> toJson() => {
        'portfolioId': portfolioId.toString(),
        'watchlist': watchlist,
        'name': name,
      };
}
