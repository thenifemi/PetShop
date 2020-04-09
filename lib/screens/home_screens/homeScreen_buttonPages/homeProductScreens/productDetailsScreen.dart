import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mollet/model/data/MOCK_productsData.dart';
import 'package:mollet/model/data/products_data.dart';
import 'package:mollet/model/modules/products_presenter.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/widgets/starRatings.dart';

class ProductDetails extends StatefulWidget {
  ProductDetails(this._products);
  Products _products;

  @override
  _ProductDetailsState createState() => _ProductDetailsState(_products);
}

class _ProductDetailsState extends State<ProductDetails>
    implements ProductsListViewContract {
  Products _products;
  ProductsListPresenter _presenter;

  bool _isLoading;

  _ProductDetailsState(this._products) {
    _presenter = ProductsListPresenter(this);
  }

  @override
  void initState() {
    _isLoading = true;

    _presenter.loadProducts();
    print("HERE HERE");

    super.initState();
  }

  Widget _buildBody() {
    return Container(
      color: MColors.primaryWhite,
      height: double.infinity,
      child: Column(
        children: <Widget>[
          _buildProductImage(),
          _buildProductDetails(_products),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    return Builder(
      builder: (context) {
        final Products product = _products;

        return Container(
          height: (MediaQuery.of(context).size.height) / 2.8,
          color: MColors.primaryWhite,
          padding: const EdgeInsets.all(20.0),
          child: _products == null
              ? CircularProgressIndicator()
              : Hero(
                  child: product.productImage,
                  tag: product.productID.toString(),
                ),
        );
      },
    );
  }

  ////
  int qty = 1;

  Widget _buildProductDetails(_products) {
    final Products product = _products;
    double price = product.price;

    void addQty() {
      setState(() {
        qty++;
        price++;
      });
    }

    void subQty() {
      setState(() {
        if (qty != 1) {
          qty--;
          price--;
        } else if (qty < 1) {
          setState(() {
            qty = 1;
          });
        }
      });
    }

    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          decoration: new BoxDecoration(
            color: MColors.primaryWhiteSmoke,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(30.0),
              topRight: const Radius.circular(30.0),
            ),
          ),
          padding: const EdgeInsets.only(
            top: 20.0,
            right: 20.0,
            left: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  product.name,
                  style: GoogleFonts.montserrat(
                    color: MColors.textDark,
                    fontWeight: FontWeight.w400,
                    fontSize: 22.0,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 17.0),
                child: Text(
                  "\$$price",
                  style: GoogleFonts.montserrat(
                    color: MColors.textDark,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: IconTheme(
                          data: IconThemeData(
                            color: Colors.amberAccent,
                            size: 18,
                          ),
                          child: StarDisplay(value: 4),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "742 reviews",
                        style: GoogleFonts.montserrat(
                          color: MColors.textGrey,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    Text(
                      "#8887272",
                      style: GoogleFonts.montserrat(
                        color: MColors.textGrey,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Quantity",
                        style: GoogleFonts.montserrat(
                          color: MColors.textGrey,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: subQty,
                      icon: Icon(
                        Icons.remove,
                        color: MColors.primaryPurple,
                        size: 20.0,
                      ),
                    ),
                    Container(
                      color: MColors.primaryWhite,
                      padding: const EdgeInsets.only(
                        right: 5,
                        left: 5.0,
                      ),
                      child: Text(
                        '$qty',
                        style: GoogleFonts.montserrat(
                          color: MColors.textDark,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: addQty,
                      icon: Icon(
                        Icons.add,
                        color: MColors.primaryPurple,
                        size: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: ExpansionTile(
                  title: Text(
                    "Details",
                    style: GoogleFonts.montserrat(
                      color: MColors.textDark,
                      fontSize: 18.0,
                    ),
                  ),
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(
                        left: 30.0,
                        bottom: 10.0,
                        right: 30.0,
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Food type",
                              style: GoogleFonts.montserrat(
                                color: MColors.textDark,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              product.foodType,
                              style: GoogleFonts.montserrat(
                                color: MColors.textGrey,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        left: 30.0,
                        bottom: 10.0,
                        right: 30.0,
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Life stage",
                              style: GoogleFonts.montserrat(
                                color: MColors.textDark,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              product.lifeStage,
                              style: GoogleFonts.montserrat(
                                color: MColors.textGrey,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        left: 30.0,
                        bottom: 10.0,
                        right: 30.0,
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Weight",
                              style: GoogleFonts.montserrat(
                                color: MColors.textDark,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              product.weight,
                              style: GoogleFonts.montserrat(
                                color: MColors.textGrey,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        left: 30.0,
                        bottom: 10.0,
                        right: 30.0,
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Flavor",
                              style: GoogleFonts.montserrat(
                                color: MColors.textDark,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              product.flavor,
                              style: GoogleFonts.montserrat(
                                color: MColors.textGrey,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: ExpansionTile(
                  title: Text(
                    "Description",
                    style: GoogleFonts.montserrat(
                      color: MColors.textDark,
                      fontSize: 18.0,
                    ),
                  ),
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(
                        left: 30.0,
                        bottom: 10.0,
                        right: 30.0,
                      ),
                      child: Text(
                        product.desc,
                        style: GoogleFonts.montserrat(
                          color: MColors.textGrey,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    ExpansionTile(
                      title: Text(
                        "More description",
                        style: GoogleFonts.montserrat(
                          color: MColors.textDark,
                          fontSize: 18.0,
                        ),
                      ),
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(
                            left: 30.0,
                            bottom: 10.0,
                            right: 30.0,
                          ),
                          child: Text(
                            product.moreDesc,
                            style: GoogleFonts.montserrat(
                              color: MColors.textGrey,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                child: ExpansionTile(
                  title: Text(
                    "Directions",
                    style: GoogleFonts.montserrat(
                      color: MColors.textDark,
                      fontSize: 18.0,
                    ),
                  ),
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(
                        left: 30.0,
                        bottom: 10.0,
                        right: 30.0,
                      ),
                      child: Text(
                        product.directions,
                        style: GoogleFonts.montserrat(
                          color: MColors.textGrey,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: ExpansionTile(
                  title: Text(
                    "Ingredients",
                    style: GoogleFonts.montserrat(
                      color: MColors.textDark,
                      fontSize: 18.0,
                    ),
                  ),
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(
                        left: 30.0,
                        bottom: 10.0,
                        right: 30.0,
                      ),
                      child: Text(
                        product.ingredients,
                        style: GoogleFonts.montserrat(
                          color: MColors.textGrey,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        brightness: Brightness.light,
        backgroundColor: MColors.primaryWhite,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: MColors.textDark,
          ),
          onPressed: () {
            Navigator.of(context).pop(_products);
          },
        ),
        // title: Text(
        //   "Product name",
        //   style: GoogleFonts.montserrat(
        //       fontSize: 20.0,
        //       color: MColors.primaryPurple,
        //       fontWeight: FontWeight.bold),
        // ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.favorite_border,
              color: MColors.textDark,
            ),
            onPressed: () {
              // Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: Container(
        height: 60.0,
        child: RawMaterialButton(
          onPressed: () {},
          fillColor: MColors.primaryPurple,
          child: Text(
            "Add to cart",
            style: GoogleFonts.montserrat(
              color: MColors.primaryWhite,
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void onLoadCategoriesComplete(List<Products> items) {}

  @override
  void onLoadCategoriesError() {
    // TODO: implement onLoadCategoriesError
  }

  @override
  void onLoadPetsComplete(List<Products> items) {
    // TODO: implement onLoadPetsComplete
  }

  @override
  void onLoadPetsError() {
    // TODO: implement onLoadPetsError
  }

  @override
  void onLoadProductsComplete(List<Products> items) {
    // _products = items;
    // _isLoading = false;
  }

  @override
  void onLoadProductsError() {
    // TODO: implement onLoadProductsError
  }

  @override
  void onLoadServicesComplete(List<Products> items) {
    // TODO: implement onLoadServicesComplete
  }

  @override
  void onLoadServicesError() {
    // TODO: implement onLoadServicesError
  }
}

class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

// The entire multilevel list displayed by this app.
final List<Entry> data = <Entry>[
  Entry(
    'Chapter A',
    <Entry>[
      Entry(
        'Section A0',
        <Entry>[
          Entry('Item A0.1'),
          Entry('Item A0.2'),
          Entry('Item A0.3'),
        ],
      ),
      Entry('Section A1'),
      Entry('Section A2'),
    ],
  ),
  Entry(
    'Chapter B',
    <Entry>[
      Entry('Section B0'),
      Entry('Section B1'),
    ],
  ),
  Entry(
    'Chapter C',
    <Entry>[
      Entry('Section C0'),
      Entry('Section C1'),
      Entry(
        'Section C2',
        <Entry>[
          Entry('Item C2.0'),
          Entry('Item C2.1'),
          Entry('Item C2.2'),
          Entry('Item C2.3'),
        ],
      ),
    ],
  ),
];

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
