import 'package:flutter/material.dart';
import 'package:spacetools/widgets/game2.dart';

class Game extends StatelessWidget {
  const Game({Key? key, required this.address}) : super(key: key);
  final String address;

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      address: address,
      headline: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(style: const TextStyle(fontSize: 30), children: [
          const TextSpan(text: 'The new '),
          WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: ShaderMask(
                  shaderCallback: (rect) {
                    return const LinearGradient(colors: [
                      Colors.white,
                      Color(0xFF35D3FF),
                      Color(0xFF336CFF),
                      Color(0xFFF533FF)
                    ]).createShader(rect);
                  },
                  child: const Text(
                    'Phygital Realm',
                    style: TextStyle(fontSize: 30),
                  ))),
          const TextSpan(text: 'awaits you')
        ]),
      ),
      image: 'assets/img.png',
      widget: SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Game2(address: address),
                  ));
            },
            child: const Text(
              'ENTER NEW SPACE',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
