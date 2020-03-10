class Product {

  /* Values shown in list */
  String _imageLocation;
  String get imageLocation => this._imageLocation;
  set imageLocation(imageLocation) => this._imageLocation = imageLocation;

  String _name;
  String get name => this._name;
  set name(name) =>this. _name = name;

  int _quantity;
  int get quantity => this._quantity;
  set quantity(quantity) => this._quantity = quantity;

  double _totalPrice;
  double get totalPrice => this._totalPrice;

  /* Values only shown in details */
  String _observations;
  String get observations => this._observations;
  set observations(observations) => this._observations = observations;

  double _unitPrice;
  double get unitPrice => this._unitPrice;
  set unitPrice(unitPrice) {

    this._unitPrice = unitPrice;
    this._totalPrice = this._unitPrice * this._quantity;
  }

  /* List of default product names */
  static const _productNames = ["Fish", "Orange", "Sugar Bag", "Tuna Can", "Banana", "Egg"];
  static List<String> get productNames => _productNames;

  Product(this._imageLocation, this._name, this._quantity, this._observations, this._unitPrice);
}