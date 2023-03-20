import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../Model/calendar.dart';
import '../constants.dart';

class Mint extends StatelessWidget {
  const Mint({
    Key? key,
    required this.future,
    required this.isEth,
    required this.ethFuture,
  }) : super(key: key);
  final Future<List<Calendar>> future;
  final Future<List<Calendar>> ethFuture;
  final bool isEth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: SizedBox(
        height: double.infinity,
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              'Mint Calendar',
              style: textTheme(context).bodyLarge,
            ),
            Container(
              height: 75,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(10)),
              child: Stack(
                children: [
                  Positioned.fill(
                    left: -400,
                    child: Container(
                      width: 200,
                      decoration: const BoxDecoration(
                          gradient: RadialGradient(
                              radius: 1,
                              colors: [Color(0xFF356EFF), Colors.transparent])),
                    ),
                  ),
                  Positioned.fill(
                    right: -400,
                    child: Container(
                      width: 200,
                      decoration: const BoxDecoration(
                          gradient: RadialGradient(
                              radius: 1,
                              colors: [Color(0xFFA14CFF), Colors.transparent])),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 30,
                        ),
                        Stack(
                          children: [
                            Image.asset(
                              'assets/cloud.png',
                              height: 42,
                            ),
                            Image.asset(
                              'assets/Glossy (1).png',
                              height: 42,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const VerticalDivider(
                          color: Color(0xFF434DF6),
                          indent: 20,
                          endIndent: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ShaderMask(
                            shaderCallback: (rect) {
                              return const LinearGradient(colors: [
                                Colors.white,
                                Colors.white,
                                Colors.white,
                                Color(0xFF35D3FF),
                                Color(0xFF336CFF),
                                Color(0xFFF533FF)
                              ]).createShader(rect);
                            },
                            child: const Text(
                              'Save time on research and never miss out on a project again!',
                            ),
                          ),
                        ),
                        const SizedBox(width: 10)
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Stack(
              children: [
                GestureDetector(
                  onTap: () async => await openWebsite(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Featured Mint',
                        style: textTheme(context).bodyLarge,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 105,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                        ),
                        child: Stack(
                          children: [
                            Image.asset('assets/Back.png'),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'The Space Club',
                                    style: TextStyle(
                                        fontSize: 17.5,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SvgPicture.asset(
                                      'assets/external-link (1).svg')
                                ],
                              ),
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 60, left: 10),
                                  child: Text(
                                    'Reshaping the interconnectedness of blockchain economics the social, and the self',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.white.withOpacity(.9)),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 65,
                  child: Image.asset(
                    'assets/1_5.png',
                    height: 104,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () => dialog(context),
              child: Container(
                height: 105,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                ),
                child: Column(
                  children: [
                    Container(
                      height: 55,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color(0xFFF533FF),
                            Color(0xFF336CFF),
                            Color(0xFF35D3FF)
                          ]),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8))),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Stack(
                          children: [
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: Image.asset(
                                  'assets/ai (1).png',
                                  opacity: const AlwaysStoppedAnimation(.3),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  const Text(
                                    'Live Mints!',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 18),
                                  ),
                                  const SizedBox(width: 5),
                                  const CircleAvatar(
                                      backgroundColor: Colors.red, radius: 4),
                                  const Spacer(),
                                  SvgPicture.asset(
                                      'assets/external-link (1).svg')
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'View breaking projects that are minting right now!',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white.withOpacity(.9),
                              fontSize: 13.5),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Upcoming Mints',
              style: textTheme(context).bodyLarge,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () => dialog(context),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/calendar.svg'),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          DateFormat('dd-MM-yy').format(DateTime.now()),
                          style: const TextStyle(fontWeight: FontWeight.normal),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        SvgPicture.asset('assets/arrow_down.svg')
                      ],
                    )),
                const SizedBox(width: 10),
                ElevatedButton(
                    onPressed: () => dialog(context),
                    child: SvgPicture.asset('assets/sliders.svg')),
                const Spacer(),
                GestureDetector(
                  onTap: () => dialog(context),
                  child: SvgPicture.asset('assets/search.svg'),
                ),
                const SizedBox(width: 5)
              ],
            ),
            const SizedBox(height: 10),
            FutureBuilder<List<Calendar>>(
                future: isEth ? ethFuture : future,
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  if (snapshot.hasData) {
                    return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return Column(
                          children: const [
                            Divider(
                              color: kGreyColor,
                              thickness: .3,
                            ),
                          ],
                        );
                      },
                      itemCount: data!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => dialog(context),
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: kGreyColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        data[index].image,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            color: Colors.black,
                                            child: const Text(
                                              'Error Loading Image',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        child: Text(
                                          data[index].name,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Values(
                                                path: 'assets/StackOfCoins.png',
                                                text: 'Mint: ',
                                                value: isEth
                                                    ? '${data[index].mint} ETH'
                                                    : data[index]
                                                        .mint
                                                        .substring(data[index]
                                                                .mint
                                                                .contains(
                                                                    'Public:')
                                                            ? 32
                                                            : 6),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Values(
                                                  path: 'assets/Discord2.png',
                                                  text: 'Discord: ',
                                                  value: isEth
                                                      ? data[index]
                                                                  .discordDesc !=
                                                              'Unknown'
                                                          ? data[index]
                                                              .discordDesc
                                                          : '--'
                                                      : data[index]
                                                              .discordDesc
                                                              .contains(' (')
                                                          ? data[index]
                                                              .discordDesc
                                                              .substring(
                                                                  0,
                                                                  data[index]
                                                                      .discordDesc
                                                                      .indexOf(
                                                                          ' ('))
                                                          : '--'),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                42,
                                          ),
                                          Column(
                                            children: [
                                              Values(
                                                path: 'assets/Maskgroup.png',
                                                text: 'Supply: ',
                                                value: data[index]
                                                        .supply
                                                        .contains('null')
                                                    ? '--'
                                                    : data[index]
                                                        .supply
                                                        .substring(
                                                            isEth ? 0 : 8),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Values(
                                                  path: 'assets/Twitter.png',
                                                  text: 'Twitter: ',
                                                  value: isEth
                                                      ? data[index].twitterDesc
                                                      : data[index]
                                                          .twitterDesc
                                                          .substring(
                                                              0,
                                                              data[index]
                                                                      .twitterDesc
                                                                      .contains(
                                                                          ' (')
                                                                  ? data[index]
                                                                      .twitterDesc
                                                                      .indexOf(
                                                                          ' (')
                                                                  : data[index]
                                                                      .twitterDesc
                                                                      .indexOf(
                                                                          'f'))),
                                              const SizedBox(height: 3),
                                            ],
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                13,
                                          ),
                                        ],
                                      ),
                                      isEth
                                          ? const SizedBox()
                                          : data[index].website != '-' &&
                                                  data[index].website != null
                                              ? Values(
                                                  path: 'assets/Internet.png',
                                                  text: 'Website: ',
                                                  value: data[index].website?.substring(
                                                          data[index]
                                                                  .website!
                                                                  .contains(
                                                                      'www.')
                                                              ? 12
                                                              : 8,
                                                          data[index]
                                                                  .website!
                                                                  .contains(
                                                                      'com/')
                                                              ? data[index]
                                                                      .website!
                                                                      .indexOf(
                                                                          'm/') +
                                                                  1
                                                              : null) ??
                                                      '--')
                                              : const SizedBox(),
                                    ],
                                  ),
                                ],
                              ),
                              Positioned(
                                  bottom: 5,
                                  child: SizedBox(
                                    height: 33,
                                    child: TextButton(
                                        onPressed: () => dialog(context),
                                        style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                side: const BorderSide(
                                                    width: 1,
                                                    color: Colors
                                                        .lightBlueAccent))),
                                        child: const Text(
                                          'View',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        )),
                                  )),
                              Positioned(
                                top: 0,
                                child: Text(
                                  data[index]
                                      .date
                                      .replaceAll(RegExp(r'[|]'), ''),
                                  style: textTheme(context)
                                      .labelMedium!
                                      .copyWith(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
          ],
        ),
      ),
    );
  }
}

class OutlineGradientButton extends StatelessWidget {
  const OutlineGradientButton({
    Key? key,
    required this.text,
    this.size = 14,
  }) : super(key: key);
  final String text;
  final double size;

  @override
  Widget build(BuildContext context) {
    return UnicornOutlineButton(
      strokeWidth: 1.2,
      radius: 7,
      gradient: const LinearGradient(
          colors: [Color(0xFFF533FF), Color(0xFF336CFF), Color(0xFF35D3FF)]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(fontSize: size),
        ),
      ),
      onPressed: () => dialog(context),
    );
  }
}

class Values extends StatelessWidget {
  const Values({
    Key? key,
    required this.text,
    required this.value,
    required this.path,
  }) : super(key: key);
  final String text;
  final String value;
  final String path;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          path,
          height: 20,
          color: Colors.lightBlueAccent,
        ),
        const SizedBox(width: 2),
        Text(
          text,
          style: const TextStyle(color: kGreyColor, fontSize: 12.5),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 12.5),
        )
      ],
    );
  }
}

class UnicornOutlineButton extends StatelessWidget {
  final _GradientPainter _painter;
  final Widget _child;
  final VoidCallback _callback;
  final double _radius;

  UnicornOutlineButton({
    super.key,
    required double strokeWidth,
    required double radius,
    required Gradient gradient,
    required Widget child,
    required VoidCallback onPressed,
  })  : _painter = _GradientPainter(
            strokeWidth: strokeWidth, radius: radius, gradient: gradient),
        _child = child,
        _callback = onPressed,
        _radius = radius;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _painter,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _callback,
        child: InkWell(
          borderRadius: BorderRadius.circular(_radius),
          onTap: _callback,
          child: Container(
            constraints: const BoxConstraints(minWidth: 58, minHeight: 32),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GradientPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double radius;
  final double strokeWidth;
  final Gradient gradient;

  _GradientPainter(
      {required this.strokeWidth,
      required this.radius,
      required this.gradient});

  @override
  void paint(Canvas canvas, Size size) {
    // create outer rectangle equals size
    Rect outerRect = Offset.zero & size;
    var outerRRect =
        RRect.fromRectAndRadius(outerRect, Radius.circular(radius));

    // create inner rectangle smaller by strokeWidth
    Rect innerRect = Rect.fromLTWH(strokeWidth, strokeWidth,
        size.width - strokeWidth * 2, size.height - strokeWidth * 2);
    var innerRRect = RRect.fromRectAndRadius(
        innerRect, Radius.circular(radius - strokeWidth));

    // apply gradient shader
    _paint.shader = gradient.createShader(outerRect);

    // create difference between outer and inner paths and draw it
    Path path1 = Path()..addRRect(outerRRect);
    Path path2 = Path()..addRRect(innerRRect);
    var path = Path.combine(PathOperation.difference, path1, path2);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}
