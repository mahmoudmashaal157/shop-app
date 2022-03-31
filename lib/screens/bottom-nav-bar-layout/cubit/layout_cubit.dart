import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());

  int curIndex=0;

  static LayoutCubit get(BuildContext context)=>BlocProvider.of(context);

  void changeIndex(int index){
    curIndex=index;
    emit(ChangeNavBarIndex());
  }
}
