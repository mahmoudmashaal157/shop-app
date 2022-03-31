import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/common-use/reusable_components.dart';
import 'package:shopping/common-use/reusable_functions.dart';
import 'package:shopping/screens/descriptioin_of_product/discription_of_product_screen.dart';
import 'package:shopping/screens/home/cubit/home_cubit.dart';
import 'package:shopping/screens/login/login_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: BlocProvider(
        create: (context) =>
        HomeCubit()
          ..getProducts(),
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            HomeCubit cubit = HomeCubit.get(context);
            return
              cubit.products.isEmpty?
                  Center(child: CircularProgressIndicator()):
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
                      cubit.products[index].images!,
                    cubit.products[index].description.toString()
                  );
                })
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
  late String description;
  late String id;
  late List<dynamic>images;


  ProductItem(this.name, this.image, this.price, this.oldPrice, this.discount, this.inFavourites, this.id, this.images, this.description);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
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
                if(oldPrice!=price)
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
                    HomeCubit.get(context).changeFavoriteColor(id);
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: HomeCubit.get(context).favorite[id]==true?
                        Colors.red:
                        Colors.grey
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: (){
        navigateTo(context,
            DescriptionOfProduct(name, price, oldPrice, discount, id, images, description)
        );
      },
    );
  }
}
