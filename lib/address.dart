class Address {
  Address({this.city, this.street, this.number});
  String city;
  String street;
  int number;

  factory Address.initialAddress() =>
      Address(city: 'Berlin', number: 39, street: 'Paul-Linke Ufer');

  @override
  String toString() {
    return 'street: $street, number: $number, city: $city';
  }
}
