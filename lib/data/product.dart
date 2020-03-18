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

  bool _assetImage;
  bool get assetImage => this._assetImage;

  Product(this._name, this._quantity, this._unitPrice, {String imageLocation = "lib/assets/noImage.jpg", String observations = "", bool assetImage = false}) {

    if(imageLocation == "lib/assets/noImage.jpg") { this._assetImage = true;}

    this._imageLocation = imageLocation;
    this._observations = observations;
    this._assetImage = assetImage;

    this._totalPrice = this._unitPrice * this._quantity;

    this.isTagged = false;
  }

  /* Returns List of default product */
  static Map<String, Product> init() {

    const productNames = ["Banana", "Beer", "Cookie", "Mango", "Milk", "Orange", "Steak", "Water"];
    
    List<Product> products = List.generate(
          productNames.length,
              (index) =>
              Product(
                productNames[index],
                index * 2 + 1,
                (productNames.length * 2 - (index + 8)).toDouble(),
                imageLocation: 'lib/assets/${productNames[index]}.jpg',
                observations: "This is a default product. Feel free to delete it!",
                assetImage: true,
              )
      );

    /* Returns a Map in the format <product._name, product> */
    return Map.fromIterable(
        products,
        key: (item) => (item as Product).name,
        value: (item) => item
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