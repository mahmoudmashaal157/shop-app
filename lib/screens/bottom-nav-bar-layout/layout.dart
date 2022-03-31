import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/screens/bottom-nav-bar-layout/cubit/layout_cubit.dart';
import 'package:shopping/screens/cart/cart_screens.dart';
import 'package:shopping/screens/favorites/favorite_screen.dart';
import 'package:shopping/screens/home/home_screen.dart';
import 'package:shopping/screens/profile/profile_screen.dart';

class Layout extends StatelessWidget {
  List<Widget>screens=[HomeScreen(),FavoriteScreen(),CartScreen(),ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: BlocBuilder<LayoutCubit, LayoutState>(
        builder: (context, state) {
          LayoutCubit cubit = LayoutCubit.get(context);
          return Scaffold(
            body: screens[cubit.curIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: const[
                BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "home"
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: "Favorites"
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart),
                    label: "cart"
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: "My Account"
                ),
              ],
              currentIndex: cubit.curIndex,
              onTap: (int currentIndex){
                cubit.changeIndex(currentIndex);
              },
            ),
          );
        },
      ),
    );
  }
}
