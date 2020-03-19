import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mini_projeto/UI/shopping_list_screen.dart';

import 'package:mini_projeto/blocs/form_bloc.dart';
import 'package:mini_projeto/data/product.dart';

class ProductFormScreen extends StatefulWidget {

  static const routeName = "/form";

  final FormBloc formBloc;

  ProductFormScreen({Key key, @required this.formBloc}) : super(key: key);

  @override
  _ProductFormScreenState createState() => _ProductFormScreenState(this.formBloc);
}

class _ProductFormScreenState extends State<ProductFormScreen> {

  /* Request handler */
  FormBloc formBloc;
  Product product;

  /* Keys to validate each form */
  final _emptyFormKey = GlobalKey<FormState>(), _editFormKey = GlobalKey<FormState>();

  /* Text Field controllers to retrieve text from them */
  TextEditingController nameFieldController, quantityFieldController, unitPriceFieldController, observationsFieldController;

  /* File containing product's image */
  File _selectedImage;

  _ProductFormScreenState(this.formBloc) {

    this.nameFieldController = TextEditingController();
    this.quantityFieldController = TextEditingController();
    this.unitPriceFieldController = TextEditingController();
    this.observationsFieldController = TextEditingController();
  }

  showAlertDialog(BuildContext context, String title, String message, Function onPressed) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () => onPressed(),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  /* Retrieves image from ImageSource.gallery and assigns it to _selectedImage */
  Future getImage() async {

    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      this._selectedImage = image;
    });
  }

  /* Returns empty form (for new products) */
  Form emptyForm() {

    final textStyle = TextStyle(
      color: Colors.white,
      height: 1.2,
      letterSpacing: 1.8,
    );

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),

      borderSide: BorderSide(
        color: Colors.white,
      ),
    );

    return Form(

      key: _emptyFormKey,

      child: ListView(

        children: <Widget>[

          Column(

            children: <Widget>[

              /* Image and image selection field */
              Row(

                /* If there is no image selected, center the content, else space everything evenly */
                mainAxisAlignment: (this._selectedImage == null) ? MainAxisAlignment.center : MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  (this._selectedImage != null)

                  /* Display an image if one has been selected */
                      ? Container(
                    width: 75.0,
                    height: 75.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, /* Makes image circular */
                      image: DecorationImage(
                          image: FileImage(_selectedImage),
                          fit: BoxFit.fill, /* Fill area with image (no clipping) */
                      ),
                    ),
                  )

                  /* Else return empty container */
                      : Container(),

                  /* Button to select image and some text */
                  Container(
                    width: 200.0,
                    height: 125.0,
                    child:
                    Column(

                      /* Space components along container's height */
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      /* Stretch components along container's width */
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[

                        IconButton(
                          icon: Icon(
                            Icons.add_circle,
                            color: Colors.amber,
                            size: 50.0,
                          ),
                          onPressed: () => this.getImage(),
                        ),

                        Text(
                          "Click the icon above to select an image.",
                          style: textStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              /* Product name field */
              Container(

                margin: EdgeInsets.only(
                  top: 50.0,
                ),

                width: 325.0,

                /* Name field */
                child: TextFormField(

                    style: textStyle,
                    cursorColor: Colors.amber,
                    maxLength: 25,
                    maxLines: 1,

                    decoration: InputDecoration(

                      labelText: "Product Name",
                      labelStyle: textStyle,
                      hintText: "Ex: Banana",
                      hintStyle: textStyle,
                      counterStyle: textStyle,

                      focusedBorder: border,
                      enabledBorder: border,
                      border: border,
                    ),

                    controller: nameFieldController,

                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter a value.";
                      }
                      return null;
                    }
                ),
              ),

              /* Product quantity and unit-price fields */
              Row(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  Container(

                    width: 150.0,

                    margin: EdgeInsets.only(top: 30.0),

                    /* Unit Price field */
                    child: TextFormField(

                      style: textStyle,
                      cursorColor: Colors.amber,
                      maxLength: 3,
                      maxLines: 1,

                      decoration: InputDecoration(

                        labelText: "Unit Price (€)",
                        labelStyle: textStyle,
                        hintText: "Ex: 6",
                        hintStyle: textStyle,
                        counterStyle: textStyle,

                        focusedBorder: border,
                        enabledBorder: border,
                        border: border,
                      ),

                      controller: unitPriceFieldController,

                      validator: (value) {
                        if (value.isEmpty || double.tryParse(value) == null) {
                          return "Please enter a numeric value.";
                        }
                        return null;
                      },
                    ),
                  ),

                  Container(

                    width: 150.0,
                    margin: EdgeInsets.only(top: 30.0),

                    /* Quantity field */
                    child: TextFormField(

                      style: textStyle,
                      cursorColor: Colors.amber,
                      maxLength: 3,
                      maxLines: 1,

                      decoration: InputDecoration(

                        labelText: "Quantity",
                        labelStyle: textStyle,
                        hintText: "Ex: 3",
                        hintStyle: textStyle,
                        counterStyle: textStyle,

                        focusedBorder: border,
                        enabledBorder: border,
                        border: border,
                      ),

                      controller: quantityFieldController,

                      validator: (value) {
                        if (value.isEmpty || int.tryParse(value) == null) {
                          return "Please enter a descrite numeric value.";
                        }
                        return null;
                      },
                    ),

                  ),
                ],
              ),

              /* Product observations field */
              Container(

                margin: EdgeInsets.only(top: 30.0),

                width: 325.0,

                /* Observations field */
                child: TextFormField(

                  style: textStyle,
                  cursorColor: Colors.amber,
                  maxLength: 25,
                  maxLines: 3,

                  keyboardType: TextInputType.multiline,

                  decoration: InputDecoration(
                    labelText: "Observations (Optional)",
                    labelStyle: textStyle,
                    hintText: "Ex: Must check validation date",
                    hintStyle: textStyle,
                    counterStyle: textStyle,

                    focusedBorder: border,
                    enabledBorder: border,
                    border: border,
                  ),

                  controller: observationsFieldController,
                ),
              ),
            ],
          ),
        ],
      )
    );
  }

  /* Returns form containing product's info */
  Form editForm() {
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
      height: 1.5,
      letterSpacing: 1.8,
    );

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),

      borderSide: BorderSide(
        color: Colors.white,
      ),
    );

    return Form(

      key: _editFormKey,

      child: ListView(

        children: <Widget>[

          /* Product Info */
          Card(
            elevation: 8.0,
            color: Color.fromRGBO(64, 75, 96, 0.9),
            margin: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 8.0,
            ),

            child: Column(

              children: <Widget>[

                /* Photo, name, quantity, unit price and total price */
                Row(

                  children: <Widget>[

                    Container(
                      margin: EdgeInsets.only(
                          left: 20.0, top: 20.0, bottom: 20.0),
                      padding: EdgeInsets.only(right: 20.0),
                      decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(
                              width: 1.0,
                              color: Colors.white24,
                            )
                        ),
                      ),

                      child: Container(
                        width: 75.0,
                        height: 75.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle, /* Makes image circular */
                          image: DecorationImage(
                            image: (this.product.assetImage)
                                ? AssetImage(
                                this.product.imageLocation)
                                : FileImage(File(this.product
                                .imageLocation)),
                            fit: BoxFit
                                .fill, /* Fill area with image (no clipping) */
                          ),
                        ),
                      ),
                    ),

                    Expanded(

                      child: Container(

                        margin: EdgeInsets.only(top: 10.0),

                        child: Column(

                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: <Widget>[

                            Text(
                              this.product.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                height: 1.2,
                                letterSpacing: 1.8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Text(
                              "Quantity: ${this.product.quantity}\n"
                                  "Price: ${this.product.totalPrice}€\n"
                                  "Unit-Price: ${this.product.unitPrice}\n",
                              style: textStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                /* Product's observations */
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: Text(
                  "Observations: ${this.product.observations}",
                  style: textStyle,
                )
                ),
              ],
            ),
          ),

          /* Form fields */
          Column(

            children: <Widget>[

              /* Image and image selection field */
              Row(

                /* If there is no image selected, center the content, else space everything evenly */
                mainAxisAlignment: (this._selectedImage == null)
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  (this._selectedImage != null)

                  /* Display an image if one has been selected */
                      ? Container(
                    width: 75.0,
                    height: 75.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, /* Makes image circular */
                      image: DecorationImage(
                        image: FileImage(_selectedImage),
                        fit: BoxFit
                            .fill, /* Fill area with image (no clipping) */
                      ),
                    ),
                  )

                  /* Else return empty container */
                      : Container(),

                  /* Button to select image and some text */
                  Container(
                    width: 200.0,
                    height: 125.0,
                    child:
                    Column(

                      /* Space components along container's height */
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      /* Stretch components along container's width */
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[

                        IconButton(
                          icon: Icon(
                            Icons.add_circle,
                            color: Colors.amber,
                            size: 50.0,
                          ),
                          onPressed: () => this.getImage(),
                        ),

                        Text(
                          "Click the icon above to select an image.",
                          style: textStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              /* Product quantity and unit-price fields */
              Row(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  Container(

                    width: 150.0,

                    margin: EdgeInsets.only(top: 30.0),

                    /* Unit Price field */
                    child: TextFormField(

                      style: textStyle,
                      cursorColor: Colors.amber,
                      maxLength: 3,
                      maxLines: 1,

                      decoration: InputDecoration(

                        labelText: "Unit Price (€)",
                        labelStyle: textStyle,
                        hintText: "Ex: 6",
                        hintStyle: textStyle,
                        counterStyle: textStyle,

                        focusedBorder: border,
                        enabledBorder: border,
                        border: border,
                      ),

                      controller: unitPriceFieldController,

                      validator: (value) {

                        /* If field is not empty, check for double value */
                        if (value.isNotEmpty &&
                            double.tryParse(value) == null) {
                          return "Please enter a numeric value.";
                        }
                        return null;
                      },
                    ),
                  ),

                  Container(

                    width: 150.0,
                    margin: EdgeInsets.only(top: 30.0),

                    /* Quantity field */
                    child: TextFormField(

                      style: textStyle,
                      cursorColor: Colors.amber,
                      maxLength: 3,
                      maxLines: 1,

                      decoration: InputDecoration(

                        labelText: "Quantity",
                        labelStyle: textStyle,
                        hintText: "Ex: 3",
                        hintStyle: textStyle,
                        counterStyle: textStyle,

                        focusedBorder: border,
                        enabledBorder: border,
                        border: border,
                      ),

                      controller: quantityFieldController,

                      validator: (value) {

                        /* If field is not empty, check for double value */
                        if (value.isNotEmpty && int.tryParse(value) == null) {
                          return "Please enter a descrite numeric value.";
                        }
                        return null;
                      },
                    ),

                  ),
                ],
              ),

              /* Product observations field */
              Container(

                margin: EdgeInsets.only(top: 30.0),

                width: 325.0,

                /* Observations field */
                child: TextFormField(

                  style: textStyle,
                  cursorColor: Colors.amber,
                  maxLength: 25,
                  maxLines: 3,

                  keyboardType: TextInputType.multiline,

                  decoration: InputDecoration(
                    labelText: "Observations (Optional)",
                    labelStyle: textStyle,
                    hintText: "Ex: Must check validation date",
                    hintStyle: textStyle,
                    counterStyle: textStyle,

                    focusedBorder: border,
                    enabledBorder: border,
                    border: border,
                  ),

                  controller: observationsFieldController,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    /* When called, check if there is a Product was passed as argument */
    this.product = ModalRoute.of(context).settings.arguments;

    return Scaffold(

      appBar: AppBar(
        title: Text(
          (this.product == null) ? "New product" : "Edit product",
        ),

        actions: <Widget>[

          IconButton(

              icon: const Icon(Icons.save),
              onPressed: () {

                /* If no product was passed to form, validate emptyForm */
                if (this.product == null) {
                  if (this._emptyFormKey.currentState.validate()) {
                    Product newProduct = (this._selectedImage == null)
                        ? Product(
                      this.nameFieldController.value.text,
                      int.parse(this.quantityFieldController.value.text),
                      double.parse(this.unitPriceFieldController.value.text),
                      observations: this.observationsFieldController.value.text,
                    )
                        : Product(
                      this.nameFieldController.value.text,
                      int.parse(this.quantityFieldController.value.text),
                      double.parse(this.unitPriceFieldController.value.text),
                      observations: this.observationsFieldController.value.text,
                      imageLocation: this._selectedImage.path,
                    );

                    this.formBloc.onSubmit(newProduct);

                    showAlertDialog(
                      context,
                        "Product created!",
                        "The product has been added to the list.",
                        () => Navigator.popUntil(context, ModalRoute.withName(ShoppingListScreen.routeName)),
                    );
                  }
                }
                else {

                  if(this._editFormKey.currentState.validate()) {

                    bool allEmpty = true;

                    if(this.quantityFieldController.value.text.isNotEmpty) {

                      setState(() {
                        this.product.quantity = int.parse(this.quantityFieldController.value.text);
                      });

                      allEmpty = false;
                    }

                    if(this.unitPriceFieldController.value.text.isNotEmpty) {

                      setState(() {
                        this.product.unitPrice = double.parse(this.unitPriceFieldController.value.text);
                      });

                      allEmpty = false;
                    }

                    if(this.observationsFieldController.value.text.isNotEmpty) {

                      setState(() {

                        this.product.observations = this.observationsFieldController.value.text;
                      });

                      allEmpty = false;
                    }

                    if(!allEmpty) {

                      this.formBloc.onSubmit(this.product);

                      showAlertDialog(
                        context,
                        "Product modified!",
                        "The information regarding the product has been modified.",
                            () => Navigator.popUntil(context, ModalRoute.withName(ShoppingListScreen.routeName)),
                      );
                    }
                    else {

                      showAlertDialog(
                        context,
                        "No information specified",
                        "Please fill any of the form's fields in order to modify the product.",
                            () => Navigator.pop(context),
                      );
                    }
                  }
                }
              }
          ),
        ],
      ),

      body: Container(

        color: Color.fromRGBO(58, 66, 86, 1.0),

        child: (this.product == null) ? emptyForm() : editForm(),
      ),
    );
  }

  @override
  void dispose() {

    nameFieldController.dispose();
    quantityFieldController.dispose();
    unitPriceFieldController.dispose();
    observationsFieldController.dispose();

    super.dispose();
  }
}