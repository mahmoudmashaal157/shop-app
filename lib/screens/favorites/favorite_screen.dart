import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/common-use/reusable_components.dart';
import 'package:shopping/screens/favorites/cubit/favorite_cubit.dart';

class FavoriteScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      FavoriteCubit()
        ..getFavoriteProducts(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Favorites"),
        ),
        body: BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (context, state) {
            FavoriteCubit cubit = FavoriteCubit.get(context);
            return
              state is GetFavortieProductsLoadingState?
                  Center(child: CircularProgressIndicator(),):
                  cubit.products.isNotEmpty?
              GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1 / 1.8,
                children: List.generate(
                    cubit.products.length, (index) {
                  return ProductItem(
                    cubit.products[index].name.toString(),
                    cubit.products[index].image.toString(),
                    cubit.products[index].price.toString(),
                    cubit.products[index].oldPrice.toString(),
                    cubit.products[index].discount.toString(),
                    cubit.products[index].inFavourite.toString(),
                    cubit.products[index].id.toString(),
                  );
                })
            ):
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("No Favorites yet",style: textStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                        Icon(Icons.hourglass_empty_rounded,size: 60),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  late String name;
  late String image;
  late String price;
  late String oldPrice;
  late String discount;
  late String inFavourites;
  late String id;


  ProductItem(this.name, this.image, this.price, this.oldPrice, this.discount,
      this.inFavourites, this.id);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            "$image",
            width: double.infinity,
            height: 200,
          ),
          Text(
            "$name",
            maxLines: 2,
            style: textStyle(fontSize: 16, overflow: TextOverflow.ellipsis),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "EGP $price",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Row(
            children: [
              if(oldPrice != price)
                Row(
                  children: [
                    Text(
                      "$oldPrice",
                      style: TextStyle(
                          fontSize: 15, decoration: TextDecoration.lineThrough),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "$discount% OFF",
                      style: textStyle(color: Colors.green),
                    ),
                  ],
                ),
              Spacer(),
              IconButton(
                onPressed: () {
                  FavoriteCubit.get(context).changeFavoriteColor(id);
                },
                icon: Icon(
                  Icons.favorite,
                  color: FavoriteCubit.get(context).favorite[id]==true?
                  Colors.red:
                  Colors.grey
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
