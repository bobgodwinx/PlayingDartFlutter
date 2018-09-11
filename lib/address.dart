class Address {
  Address({this.city, this.street, this.number});

  String city;
  String street;
  int number;

  factory Address.initialAddress() =>
      Address(city: 'Berlin', number: 39, street: 'Paul-Linke Ufer');

  Address.fromJson(Map<String, dynamic> json)
      : city = json['city'],
        number = json['number'],
        street = json['street'];

  Map toJson() => {
        'city': this.city,
        'number': this.number,
        'street': this.street,
      };

  @override
  String toString() {
    return 'street: $street, number: $number, city: $city';
  }

  @override
  int get hashCode => city.hashCode ^ street.hashCode ^ number.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Address &&
          runtimeType == other.runtimeType &&
          city == other.city &&
          number == other.number &&
          street == other.street;
}
