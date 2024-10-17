import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:mo3een/core/components/widgets/custom_loading.dart';
import 'package:mo3een/core/helpers/image_helper.dart';
import 'package:permission_handler/permission_handler.dart';

class QiblahDirection extends StatefulWidget {
  const QiblahDirection({super.key});

  @override
  State<QiblahDirection> createState() => _QiblahDirectionState();
}

class _QiblahDirectionState extends State<QiblahDirection>
    with SingleTickerProviderStateMixin {
  bool hasPermission = false;

  Animation<double>? animation;
  AnimationController? _animationController;
  double begin = 0.0;

  Future getPermission() async {
    if (await Permission.location.serviceStatus.isEnabled) {
      var status = await Permission.location.status;
      if (status.isGranted) {
        hasPermission = true;
      } else {
        Permission.location.request().then((value) {
          setState(() {
            hasPermission = (value == PermissionStatus.granted);
          });
        });
      }
    }
  }

  @override
  void initState() {
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
    return FutureBuilder(
        future: getPermission(),
        builder: (context, snapshot) {
          if (!hasPermission) {
            return const Center(
              child: Text(
                'الرجاء تفعيل الصلاحيات',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          return StreamBuilder(
            stream: FlutterQiblah.qiblahStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  alignment: Alignment.center,
                  child: const CustomLoadingIndicator(),
                );
              }
              final qiblahDirection = snapshot.data;
              animation = Tween(
                      begin: begin,
                      end: (qiblahDirection!.qiblah * (pi / 180) * -1))
                  .animate(_animationController!);
              begin = (qiblahDirection.qiblah * (pi / 180) * -1);
              _animationController!.forward(from: 0);
              return Center(
                child: AnimatedBuilder(
                  animation: animation!,
                  builder: (context, child) => Transform.rotate(
                    angle: animation!.value,
                    child: Image.asset(
                      AppImageHelper.qiblaImage,
                    ),
                  ),
                ),
              );
            },
          );
        },
    );
  }
}
