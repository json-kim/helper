import 'package:flutter/material.dart';

// SizeConfig는 ui를 반응형으로 만드는데 도움을 준다.
// 스크린 위젯을 시작할 때, SizeConfig.init을 시작해야 한다.

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

// 스크린 사이즈에 따라 비례하는 세로길이를 리턴
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // 아이폰12ProMax의 뷰포트 세로길이 926
  // 이때의 가로, 세로길이는 개발자가 사용하는 폰의 기종을 기준으로 한다.
  // 개발할 때, 구상했던 비율만큼 다른 기종에서도 동일한 비율을 가질수 있도록
  return (inputHeight / 926) * screenHeight;
}

// 스크린 사이즈에 따라 비례하는 가로길이를 리턴
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 아이폰12ProMax의 뷰포트 가로길이 428
  return (inputWidth / 428) * screenWidth;
}

// 세로로 빈 공간을 추가하기
class VerticalSpacing extends StatelessWidget {
  const VerticalSpacing({
    Key? key,
    this.of = 20,
  }) : super(key: key);

  final double of;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenHeight(of),
    );
  }
}

// 가로로 빈 공간을 추가하기
class HorizontalSpacing extends StatelessWidget {
  const HorizontalSpacing({
    Key? key,
    this.of = 20,
  }) : super(key: key);

  final double of;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(of),
    );
  }
}
