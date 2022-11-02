class Intraday {
  double? open;
  double? high;
  double? low;
  double? last;
  double? close;
  double? volume;
  String? date;
  String? symbol;
  String? exchange;

  Intraday(
      {this.open,
      this.high,
      this.low,
      this.last,
      this.close,
      this.volume,
      this.date,
      this.symbol,
      this.exchange});

  Intraday.fromJson(Map<String, dynamic> json) {
    open = json['open'];
    high = json['high'];
    low = json['low'];
    last = json['last'];
    close = json['close'];
    volume = json['volume'];
    date = json['date'];
    symbol = json['symbol'];
    exchange = json['exchange'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['open'] = open;
    data['high'] = high;
    data['low'] = low;
    data['last'] = last;
    data['close'] = close;
    data['volume'] = volume;
    data['date'] = date;
    data['symbol'] = symbol;
    data['exchange'] = exchange;
    return data;
  }
}
