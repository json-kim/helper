import 'package:flutter/material.dart';

// 개발 에뮬레이터 뷰포트 사이즈 (iPhone 12 Pro Max 기준)
final double devEmulatorWidth = 428;
final double devEmulatorHeight = 926;
const double defaultPadding = 16.0;

/// SizeConfig는 ui를 반응형으로 만드는데 도움을 준다.
/// 현재 뷰포트의 MediaQueryData를 초기화하는 클래스
class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late Orientation orientation;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

// 아래의 함수, 위젯을 사용하기 위해서는 SizeConfig.init() 메소드를 우선 실행해야 한다.

/// 개발 에뮬레이터와 실제 작동 기기와의 크기 비율을 가지고 실제 기기에서 적당한 사이즈를 리턴
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // 아이폰12ProMax의 뷰포트 세로길이 926
  // 이때의 가로, 세로길이는 개발자가 사용하는 폰의 기종을 기준으로 한다.
  // 개발할 때, 구상했던 비율만큼 다른 기종에서도 동일한 비율을 가질수 있도록
  return inputHeight * (screenHeight / devEmulatorHeight);
}

/// 스크린 사이즈에 따라 비례하는 가로길이를 리턴
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 아이폰12ProMax의 뷰포트 가로길이 428
  return inputWidth * (screenWidth / devEmulatorWidth);
}

/// SizedBox를 실제 기기에 맞게 크기를 조정해주는 위젯 (세로)
class VerticalSpacing extends StatelessWidget {
  const VerticalSpacing({
    Key? key,
    this.of = defaultPadding,
  }) : super(key: key);

  final double of;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenHeight(of),
    );
  }
}

/// SizedBox를 실제 기기에 맞게 크기를 조정해주는 위젯 (가로)
class HorizontalSpacing extends StatelessWidget {
  const HorizontalSpacing({
    Key? key,
    this.of = defaultPadding,
  }) : super(key: key);

  final double of;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(of),
    );
  }
}
