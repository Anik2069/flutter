import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/product_provider.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/nav.dart';
import 'package:shop_app/widgets/product_grid.dart';
import 'package:shop_app/widgets/product_item.dart';

enum FilterOptions {
  Favourites,
  All,
}

class ProductOverViewScreen extends StatefulWidget {
  _ProductOverViewScreenCreateState createState() =>
      _ProductOverViewScreenCreateState();
}

class _ProductOverViewScreenCreateState extends State<ProductOverViewScreen> {
  var _showOnlyFav = false;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Shop"),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favourites) {
                  // productsContainer.showFavoritesOnly();
                  _showOnlyFav = true;
                } else {
                  // productsContainer.showAll();
                  _showOnlyFav = false;
                }
              });
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favourites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: Nav(),
      body: new ProductsGrid(_showOnlyFav),
    );
  }
}
