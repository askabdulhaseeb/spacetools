import 'dart:developer';

import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import '../Model/chart_data.dart';
import '../Model/trending.dart';
import '../Services/service.dart';
import '../constants.dart';

class Chart extends StatefulWidget {
  const Chart({Key? key, required this.data, required this.index})
      : super(key: key);
  final List<TrendingData>? data;
  final int index;

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> with AutomaticKeepAliveClientMixin {
  late Future<ChartData> future;
  late Future ethFuture;
  @override
  void initState() {
    future = chartData(widget.data?[widget.index].shortName ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<ChartData>(
        future: future,
        builder: (context, sShot) {
          if (sShot.hasData) {
            return Sparkline(
              data: List.generate(sShot.data!.stats.length,
                  (chartIndex) => sShot.data!.stats[chartIndex].open!),
              useCubicSmoothing: true,
              lineColor: checkColor(
                      widget.data![widget.index].color ?? ColorValues.gray)
                  .first,
              lineWidth: 1.5,
              fillGradient: LinearGradient(colors: [
                checkColor(widget.data![widget.index].color ?? ColorValues.gray)
                    .first
                    .withOpacity(.3),
                Colors.transparent
              ], begin: const Alignment(0, .7), end: const Alignment(0, 3)),
              fillMode: FillMode.below,
            );
          } else {
            return const SizedBox();
          }
        });
  }

  @override
  bool get wantKeepAlive => true;
}
