import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tharadtech/features/Profile/Presentation/View/Screen/profile_screen.dart';
import 'package:tharadtech/features/home_screen/Presentation/View/Screen/home_screen.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(HomeScreenInitial());

  static HomeScreenCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<Widget> screens = [
    const HomeScreen(),
    const ProfileScreen(),
  ];

  void changeBottomNavigationItem(int value) {
    currentIndex = value;
    emit(SuccessChange());
  }
}
