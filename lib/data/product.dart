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
  set quantity(quantity) {

    this._quantity = quantity;

    this._totalPrice = this._quantity * this._unitPrice;
  }

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

  /* AUX field: Hold whether product is tagged or not (affects item color) */
  bool _isTagged;
  bool get isTagged => this._isTagged;
  set isTagged(bool) => this._isTagged = bool;

  Product(this._imageLocation, this._name, this._quantity, this._observations, this._unitPrice) {

    this._totalPrice = this._unitPrice * this._quantity;

    this.isTagged = false;
  }

  /* Returns List of default product */
  static List<Product> init() {

    const productNames = ["Water", "Steak", "Milk", "Mango", "Orange", "Banana", "Cookie", "Beer"];

    return List.generate(
          productNames.length,
              (index) =>
              Product(
                'lib/assets/${productNames[index]}.jpg',
                productNames[index],
                index * 2 + 1,
                "Must buy $index",
                (productNames.length * 2 - (index + 8)).toDouble(),
              )
      );
  }

  @override
  String toString() {
    return "Product: ${this.name}  |  #${this.quantity}  |  ${this.totalPrice}€";
  }

  /* Overide the == operator */
  @override
  bool operator ==(other) => other is Product && other.name == this.name;

  /* Override hashcode generator */
  @override
  int get hashCode => this.name.hashCode;
}