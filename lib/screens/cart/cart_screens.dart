import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/common-use/reusable_components.dart';
import 'package:shopping/screens/cart/cubit/cart_cubit.dart';

class CartScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: BlocProvider(
        create: (context) => CartCubit()..getCartProducts(),
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            CartCubit cubit = CartCubit.get(context);
            return
              state is GetCartProductsLoadingState?
              Center(child: CircularProgressIndicator(),):
                 cubit.cartProducts.isNotEmpty?
              Column(
                children: [
                  Expanded(
                   child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return CartItem(
                            cubit.cartProducts[index].image.toString(),
                            cubit.cartProducts[index].name.toString(),
                            cubit.cartProducts[index].price.toString(),
                            cubit.cartProducts[index].oldPrice.toString(),
                            cubit.cartProducts[index].discount.toString(),
                            cubit.cartProducts[index].id.toString(),
                        );
                      },
                      itemCount: cubit.cartProducts.length
                  ),
                  ),
                  Container(
                    color: Color(0xfff1f4fd),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("  Total",style: textStyle(fontSize: 20),),
                            Spacer(),
                            Text("EGP ${cubit.total} ",style: textStyle(fontWeight: FontWeight.bold,fontSize: 30),)
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ):
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("No Items in Cart ",style: textStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                    Icon(Icons.remove_shopping_cart,size: 60),
                  ],
                ),
              );
          },
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  late String image;
  late String name;
  late String price;
  late String oldPrice;
  late String discount;
  late String id;

  CartItem(this.image, this.name, this.price, this.oldPrice, this.discount, this.id);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(
            "$image",
            width: 200,
            height: 150,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("$name",
                textAlign: TextAlign.right,
                style: textStyle(fontSize: 20),
              ),
              SizedBox(height: 10,),
              Divider(),
              Row(
                children: [
                  Text("  EGP $price", style: textStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: (){
                        CartCubit.get(context).removeItemFromCart(id);
                      },
                      icon: Icon(Icons.delete,color: Colors.red,)),
                ],
              ),
              if(discount != "0")
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
                      style: textStyle(
                          color: Colors.green, fontSize: 20),
                    ),
                  ],
                ),
              SizedBox(height: 10,),
              Divider(),
            ],
          ),
        ],
      ),
    );
  }
}
