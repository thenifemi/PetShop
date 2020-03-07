import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mollet/utils/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mollet/utils/strings.dart';
import 'package:flutter/services.dart';

class IntroScreen extends StatelessWidget {
  // const IntroScreen({Key key}) : super(key: key);

  final pageDecoration = PageDecoration(
      pageColor: MColors.primaryWhiteSmoke,
      titleTextStyle: PageDecoration().titleTextStyle.copyWith(
            color: MColors.textDark,
            fontFamily: Strings.customFont,
            fontSize: 35.0,
          ),
      bodyTextStyle:
          PageDecoration().bodyTextStyle.copyWith(color: MColors.textGrey),
      contentPadding: const EdgeInsets.all(20.0),
      imagePadding: const EdgeInsets.only(right: 30.0, left: 30.0));

  List<PageViewModel> getPages() {
    return [
      PageViewModel(
        image: SvgPicture.asset(
          "assets/images/phone_number.svg",
        ),
        title: Strings.onBoardTitle1,
        bodyWidget: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 40.0),
              child: Text(
                Strings.onBoardTitle_sub1,
                style: TextStyle(
                  color: MColors.textGrey,
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ],
        ),
        decoration: pageDecoration,
      ),
      PageViewModel(
        image: SvgPicture.asset(
          "assets/images/online_shopping.svg",
        ),
        title: Strings.onBoardTitle2,
        bodyWidget: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 40.0),
              child: Text(
                Strings.onBoardTitle_sub2,
                style: TextStyle(
                  color: MColors.textGrey,
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ],
        ),
        decoration: pageDecoration,
      ),
      PageViewModel(
        image: SvgPicture.asset(
          "assets/images/manage.svg",
        ),
        title: Strings.onBoardTitle3,
        bodyWidget: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 40.0),
              child: Text(
                Strings.onBoardTitle_sub3,
                style: TextStyle(
                  color: MColors.textGrey,
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ],
        ),
        decoration: pageDecoration,
      ),
    ];
  }

  Widget buildIntro(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 50.0),
            height: MediaQuery.of(context).size.height / 1.4,
            child: IntroductionScreen(
              pages: getPages(),
              onDone: () {},
              done: Text(""),
              globalBackgroundColor: MColors.primaryWhiteSmoke,
              dotsDecorator: DotsDecorator(
                activeColor: MColors.primaryPurple,
                activeSize: const Size(25.0, 10.0),
                spacing: const EdgeInsets.symmetric(horizontal: 3.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Container(
              color: MColors.primaryWhite,
              height: MediaQuery.of(context).size.height / 3.99,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 30.0, left: 30.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 60.0,
                      child: RawMaterialButton(
                        elevation: 0.0,
                        hoverElevation: 0.0,
                        focusElevation: 0.0,
                        highlightElevation: 0.0,
                        fillColor: MColors.primaryPurple,
                        onPressed: () {
                          Navigator.of(context).pushNamed("/Login");
                        },
                        child: Text(
                          Strings.signin_small,
                          style: TextStyle(
                              color: MColors.primaryWhite, fontSize: 16.0),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30.0, left: 30.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 60.0,
                      child: RawMaterialButton(
                        fillColor: MColors.primaryWhiteSmoke,
                        elevation: 0.0,
                        hoverElevation: 0.0,
                        focusElevation: 0.0,
                        highlightElevation: 0.0,
                        onPressed: () {
                          Navigator.of(context).pushNamed("/Login");
                        },
                        child: Text(
                          Strings.register,
                          style: TextStyle(
                              color: MColors.primaryPurple, fontSize: 16.0),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.primaryWhiteSmoke,
      body: buildIntro(context),
    );
  }
}
