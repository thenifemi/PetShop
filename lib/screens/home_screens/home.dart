import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mollet/model/data/products_data.dart';
import 'package:mollet/prodModel/Product_service.dart';
import 'package:mollet/prodModel/Products.dart';
import 'package:mollet/prodModel/brands_notifier.dart';
import 'package:mollet/prodModel/products_notifier.dart';
import 'package:mollet/screens/home_screens/homeScreen_pages/productDetailsScreen.dart';
import 'package:mollet/utils/colors.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    ProductsNotifier productsNotifier =
        Provider.of<ProductsNotifier>(context, listen: false);
    getProdProducts(productsNotifier);

    BrandsNotifier brandsNotifier =
        Provider.of<BrandsNotifier>(context, listen: false);
    getBrands(brandsNotifier);

    _tabController = TabController(
      length: _tabItems.length,
      vsync: this,
    );
    super.initState();
  }

  final _tabItems = [
    "All",
    "Dogs",
    "Cats",
    "Fish",
    "Birds",
    "Reptiles",
    "Small Pets",
  ];

  @override
  Widget build(BuildContext context) {
    ProductsNotifier productsNotifier = Provider.of<ProductsNotifier>(context);
    var prods = productsNotifier.productsList;

    BrandsNotifier brandsNotifier = Provider.of<BrandsNotifier>(context);

    //Tab Items
    final _tabBody = [
      buildAllBody(prods),
      buildDogBody(prods),
      buildCatBody(prods),
      buildDogBody(prods),
      buildCatBody(prods),
      buildDogBody(prods),
      buildCatBody(prods),
    ];

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: MColors.primaryWhiteSmoke,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(54),
          child: Container(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 20.0, left: 25.0),
                        child: SvgPicture.asset(
                          "assets/images/icons/Search.svg",
                          color: MColors.textGrey,
                        ),
                      ),
                      suffixIconConstraints: BoxConstraints(maxHeight: 20.0),
                      labelText: "Search product here...",
                      labelStyle: GoogleFonts.montserrat(
                        fontSize: 14.0,
                        color: MColors.textGrey,
                      ),
                      contentPadding:
                          new EdgeInsets.symmetric(horizontal: 25.0),
                      fillColor: MColors.primaryWhite,
                      hasFloatingPlaceholder: false,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0.0,
                        ),
                      ),
                    ),
                  ),
                ),
                TabBar(
                  unselectedLabelColor: MColors.textGrey,
                  unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 18.0,
                  ),
                  labelColor: MColors.textDark,
                  labelStyle: GoogleFonts.montserrat(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                  ),
                  indicatorColor: MColors.primaryWhiteSmoke,
                  isScrollable: true,
                  tabs: _tabItems.map((e) {
                    return Tab(
                      child: Text(
                        e,
                      ),
                    );
                  }).toList(),
                  controller: _tabController,
                ),
              ],
            ),
          ),
        ),
      ),
      body: prods.isEmpty
          ? Container(
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                ),
              ),
            )
          : TabBarView(
              children: _tabBody,
              controller: _tabController,
            ),
    );
  }

  Widget buildAllBody(prods) {
    Iterable<ProdProducts> all = prods.reversed;

    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.4;
    final double itemWidth = size.width / 2;
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
      ),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: (itemWidth / itemHeight),
        mainAxisSpacing: 15.0,
        crossAxisSpacing: 15.0,
        children: List<Widget>.generate(all.length, (i) {
          var cleanList = all.toList();

          var fil = cleanList[i];

          return RawMaterialButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductDetailsProv(fil, prods),
                ),
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
            ),
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 170,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Hero(
                        child: FadeInImage.assetNetwork(
                          image: fil.productImage,
                          fit: BoxFit.fill,
                          height: MediaQuery.of(context).size.height,
                          placeholder: "assets/images/placeholder.jpg",
                          placeholderScale:
                              MediaQuery.of(context).size.height / 2,
                        ),
                        tag: fil.productID,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        fil.name,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                          color: MColors.textDark,
                          // fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                      child: Text(
                        "\$${fil.price}",
                        style: GoogleFonts.montserrat(
                          color: MColors.primaryPurple,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: MColors.primaryWhite,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.03),
                      offset: Offset(0, 10),
                      blurRadius: 10,
                      spreadRadius: 0),
                ],
              ),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
            ),
          );
        }),
      ),
    );
  }

  Widget buildDogBody(prods) {
    Iterable<ProdProducts> dog = prods.where((e) => e.pet == "dog");

    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.4;
    final double itemWidth = size.width / 2;
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
      ),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: (itemWidth / itemHeight),
        mainAxisSpacing: 15.0,
        crossAxisSpacing: 15.0,
        children: List<Widget>.generate(dog.length, (i) {
          var cleanList = dog.toList();

          var fil = cleanList[i];

          return RawMaterialButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductDetailsProv(fil, prods),
                ),
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
            ),
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 170,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Hero(
                        child: FadeInImage.assetNetwork(
                          image: fil.productImage,
                          fit: BoxFit.fill,
                          height: MediaQuery.of(context).size.height,
                          placeholder: "assets/images/placeholder.jpg",
                          placeholderScale:
                              MediaQuery.of(context).size.height / 2,
                        ),
                        tag: fil.productID,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        fil.name,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                          color: MColors.textDark,
                          // fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                      child: Text(
                        "\$${fil.price}",
                        style: GoogleFonts.montserrat(
                          color: MColors.primaryPurple,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: MColors.primaryWhite,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.03),
                      offset: Offset(0, 10),
                      blurRadius: 10,
                      spreadRadius: 0),
                ],
              ),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
            ),
          );
        }),
      ),
    );
  }

  Widget buildCatBody(prods) {
    Iterable<ProdProducts> cat = prods.where((e) => e.pet == "cat");

    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.4;
    final double itemWidth = size.width / 2;
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
      ),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: (itemWidth / itemHeight),
        mainAxisSpacing: 15.0,
        crossAxisSpacing: 15.0,
        children: List<Widget>.generate(cat.length, (i) {
          var cleanList = cat.toList();

          var fil = cleanList[i];

          return RawMaterialButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductDetailsProv(fil, prods),
                ),
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
            ),
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 170,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Hero(
                        child: FadeInImage.assetNetwork(
                          image: fil.productImage,
                          fit: BoxFit.fill,
                          height: MediaQuery.of(context).size.height,
                          placeholder: "assets/images/placeholder.jpg",
                          placeholderScale:
                              MediaQuery.of(context).size.height / 2,
                        ),
                        tag: fil.productID,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        fil.name,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                          color: MColors.textDark,
                          // fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                      child: Text(
                        "\$${fil.price}",
                        style: GoogleFonts.montserrat(
                          color: MColors.primaryPurple,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: MColors.primaryWhite,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.03),
                      offset: Offset(0, 10),
                      blurRadius: 10,
                      spreadRadius: 0),
                ],
              ),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
            ),
          );
        }),
      ),
    );
  }

  @override
  void onLoadPetsComplete(List<Products> items) {
    // TODO: implement onLoadPetsComplete
  }

  @override
  void onLoadPetsError() {
    // TODO: implement onLoadPetsError
  }
}
