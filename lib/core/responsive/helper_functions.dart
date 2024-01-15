import 'responsive.dart';

double responsiveIcon(double size,double distance){
  return screenSize == ScreenSize.small
                      ? size-distance
                      : (screenSize == ScreenSize.medium ? size : distance+size);
}