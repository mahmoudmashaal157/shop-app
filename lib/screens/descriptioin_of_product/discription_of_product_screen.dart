import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/common-use/reusable_components.dart';
import 'package:shopping/screens/descriptioin_of_product/cubit/product_description_cubit.dart';

class DescriptionOfProduct extends StatelessWidget {
  late String name;
  late String price;
  late String oldPrice;
  late String discount;
  late String id;
  late String description;
  late List<dynamic> images;

  DescriptionOfProduct(this.name, this.price, this.oldPrice, this.discount,
      this.id, this.images, this.description);

  double curIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Description"),
      ),
      body: BlocProvider(
        create: (context) => ProductDescriptionCubit(),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        child: Text(
                          "$name",
                          textAlign: TextAlign.right,
                          style: textStyle(fontSize: 22),
                        ),
                        alignment: Alignment.centerRight,
                      ),
                    ),
                    BlocBuilder<ProductDescriptionCubit,
                        ProductDescriptionState>(
                      builder: (context, state) {
                        ProductDescriptionCubit cubit =
                            ProductDescriptionCubit.get(context);
                        return Column(
                          children: [
                            CarouselSlider(
                              items: images.map((e) {
                                return Image.network(
                                  "$e",
                                );
                              }).toList(),
                              options: CarouselOptions(
                                  height: 400,
                                  initialPage: 0,
                                  onPageChanged: (int index, reason) {
                                    cubit.changeIndeicatorIndex(index);
                                  },
                                  enlargeCenterPage: true,
                                  viewportFraction: 0.9),
                            ),
                            DotsIndicator(
                              dotsCount: images.length,
                              position: ProductDescriptionCubit.get(context)
                                  .index
                                  .toDouble(),
                            ),
                          ],
                        );
                      },
                    ),
                    Text(
                      " EGP $price",
                      style: textStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (discount != "0")
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "$oldPrice",
                            style: TextStyle(
                                fontSize: 25,
                                decoration: TextDecoration.lineThrough,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "$discount% OFF",
                            style: textStyle(color: Colors.green, fontSize: 20),
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(thickness: 2),
                    Center(
                      child: Text(
                        "Description",
                        style: textStyle(
                            fontSize: 45, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Divider(thickness: 2),
                    Align(
                      child: Text(
                        "$description",
                        textAlign: TextAlign.right,
                        style: textStyle(fontSize: 20),
                      ),
                      alignment: Alignment.centerRight,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            BlocBuilder<ProductDescriptionCubit, ProductDescriptionState>(
              builder: (context, state) {
                return Container(
                  width: double.infinity,
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        ProductDescriptionCubit.get(context).addProductToCart(id);
                      },
                      child: state is AddProductToCartLoadingState?
                      Center(child: CircularProgressIndicator(color: Colors.white,)):
                      Text("Add to Cart")
                ),
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
