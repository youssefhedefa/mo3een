import 'dart:developer' as dev;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:mo3een/core/components/widgets/custom_loading.dart';
import 'package:mo3een/core/helpers/get_current_position_helper.dart';
import 'package:mo3een/core/helpers/image_helper.dart';
import 'package:mo3een/features/qibla/presentation/ui/widgets/permission_error_widget.dart';

class QiblahDirectionWidget extends StatefulWidget {
  const QiblahDirectionWidget({super.key});

  @override
  State<QiblahDirectionWidget> createState() => _QiblahDirectionWidgetState();
}

class _QiblahDirectionWidgetState extends State<QiblahDirectionWidget>
    with SingleTickerProviderStateMixin {
  bool hasPermission = false;
  late LocationHelper locationHelper;

  Animation<double>? animation;
  AnimationController? _animationController;
  double begin = 0.0;

  Future<void> getPermission() async {
    hasPermission = await locationHelper.checkLocationPermission();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    locationHelper = LocationHelper();
    getPermission();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animation = Tween(begin: 0.0, end: 0.0).animate(_animationController!);
    super.initState();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!hasPermission) {
      return const PermissionErrorWidget();
    }
    return StreamBuilder(
      stream: FlutterQiblah.qiblahStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CustomLoadingIndicator());
        }
        if (snapshot.hasError || !snapshot.hasData) {
          dev.log('Error from qibla direction: ${snapshot.error}');
          return const PermissionErrorWidget();
        }
        final qiblahDirection = snapshot.data;
        animation = Tween(
          begin: begin,
          end: (qiblahDirection!.qiblah * (pi / 180) * -1),
        ).animate(_animationController!);
        begin = (qiblahDirection.qiblah * (pi / 180) * -1);
        _animationController!.forward(from: 0);

        return Center(
          child: AnimatedBuilder(
            animation: animation!,
            builder: (context, child) => Transform.rotate(
              angle: animation!.value,
              child: Image.asset(AppImageHelper.qiblaImage),
            ),
          ),
        );
      },
    );
  }
}
