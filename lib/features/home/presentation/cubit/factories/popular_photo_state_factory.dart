import 'package:webant_gallery/core/constants/enums.dart';
import 'package:webant_gallery/features/home/presentation/cubit/factories/home_state_factory.dart';
import 'package:webant_gallery/features/home/presentation/cubit/home_cubit.dart';

class PopularPhotosStateFactory implements HomeStateFactory {
  @override
  PhotoType get type => PhotoType.popularPhoto;

  @override
  HomeState createInitialState() {
    return HomeState.initial(type: type);
  }
}
