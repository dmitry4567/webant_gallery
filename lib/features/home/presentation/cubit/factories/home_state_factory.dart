import 'package:webant_gallery/core/constants/enums.dart';
import 'package:webant_gallery/features/home/presentation/cubit/home_cubit.dart';

abstract class HomeStateFactory {
  PhotoType get type;
  HomeState createInitialState();
}