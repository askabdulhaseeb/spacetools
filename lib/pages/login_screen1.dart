import 'package:flutter/material.dart';
import 'login_screen2.dart';

class LoginScreen1 extends StatelessWidget {
  const LoginScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: controller,
          children: [
            LoginWidget(
                image: 'assets/img2.png',
                title: 'Welcome to the Club',
                text:
                    'Reshaping the interconnectedness of blockchain economics, the social and the self',
                buttonText: 'GET STARTED',
                onPressed: () {
                  controller.jumpToPage(1);
                },
                index0: true),
            LoginWidget(
                image: 'assets/img3.png',
                title: 'Information is Power',
                text:
                    'Innovate your wealth by unlocking the power of spacetoolss',
                buttonText: 'NEXT',
                buttonText2: 'BACK',
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen2(),
                      ));
                },
                onPressed2: () {
                  controller.jumpToPage(0);
                },
                index0: false)
          ],
        )
      ],
    ));
  }
}

class LoginWidget extends StatelessWidget {
  const LoginWidget({
    Key? key,
    required this.image,
    required this.title,
    required this.text,
    required this.buttonText,
    required this.index0,
    this.buttonText2,
    required this.onPressed,
    this.onPressed2,
  }) : super(key: key);
  final String image;
  final String title;
  final String text;
  final String buttonText;
  final bool index0;
  final String? buttonText2;
  final VoidCallback onPressed;
  final VoidCallback? onPressed2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset('assets/Background.png'),
          RotatedBox(
            quarterTurns: 45,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.black,
                  Colors.black,
                  Colors.black,
                  const Color(0xFF010187).withOpacity(.5),
                  const Color(0xFFC41BFF),
                ],
              )),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 7,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Image.asset(
                    image,
                    height: 350,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 32, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        width: 35,
                        height: 3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: index0
                                ? Colors.white
                                : Colors.grey.withOpacity(.3)),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        width: 35,
                        height: 3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: !index0
                                ? Colors.white
                                : Colors.grey.withOpacity(.3)),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        !index0
                            ? Expanded(
                                child: SizedBox(
                                  height: 60,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black87,
                                      ),
                                      onPressed: onPressed2,
                                      child: Text(
                                        buttonText2!,
                                        style: const TextStyle(fontSize: 16),
                                      )),
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 60,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue),
                                onPressed: onPressed,
                                child: Text(
                                  buttonText,
                                  style: const TextStyle(fontSize: 16),
                                )),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
