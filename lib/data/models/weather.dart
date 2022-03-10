class Weather {
  final String cityName;
  final double temperatureCelcius;

  Weather({
    required this.cityName,
    required this.temperatureCelcius,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Weather &&
        other.cityName == cityName &&
        other.temperatureCelcius == temperatureCelcius;
  }

  @override
  int get hashCode => cityName.hashCode ^ temperatureCelcius.hashCode;
}
