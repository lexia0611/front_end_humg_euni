import 'package:fe/model/message.model.dart';
import 'package:fe/modules/classroom/chat/component/message.file.dart';
import 'package:fe/modules/classroom/chat/component/message.image.dart';
import 'package:fe/modules/classroom/chat/component/message.mess.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfoMessage extends StatelessWidget {
  final MessageModel message;
  final bool isAnother;
  const InfoMessage(this.message, {super.key, this.isAnother = false});

  @override
  Widget build(BuildContext context) {
    if (message.type == null) return const SizedBox.shrink();
    switch (message.type!) {
      case "text":
        return isAnother
            ? DecorationAnotherNormal(time: message.createTime ?? "", name: message.createUserName ?? "", child: MessageMess(message, isAnother))
            : DecorationOwnNormal(
                time: message.createTime ?? "",
                child: MessageMess(message, isAnother),
              );
      case "image":
        return isAnother
            ? DecorationMedia(child: MessageImage(message: message, isAnother: isAnother))
            : DecorationMedia(
                child: MessageImage(message: message, isAnother: isAnother),
              );
      case "file":
        return isAnother
            ? DecorationMedia(child: MessageFile(message: message, isAnother: isAnother))
            : DecorationMedia(
                child: MessageFile(message: message, isAnother: isAnother),
              );
      default:
        return const SizedBox.shrink();
    }
  }
}

class DecorationAnotherNormal extends StatelessWidget {
  final Widget child;
  final String time;
  final String name;

  const DecorationAnotherNormal({super.key, required this.child, required this.time, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(width: 15),
            Text(
              name,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: CustomPaint(
                painter: PainterAnotherMessageTail(),
                child: const SizedBox(
                  width: 8,
                  height: 10,
                ),
              ),
            ),
            Container(
              constraints: const BoxConstraints(minWidth: 50, maxWidth: 200),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Expanded(child: child),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    formatDate(time),
                    style: const TextStyle(color: Colors.black, fontSize: 11),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DecorationOwnNormal extends StatelessWidget {
  final Widget child;
  final String time;
  const DecorationOwnNormal({super.key, required this.child, required this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: const BoxConstraints(minWidth: 50, maxWidth: 200),
          decoration: BoxDecoration(color: const Color.fromARGB(255, 255, 241, 246), borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Expanded(child: child),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                formatDate(time),
                style: const TextStyle(color: Colors.black, fontSize: 13),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: CustomPaint(
            painter: PainterOwnMessageTail(),
            child: const SizedBox(
              width: 8,
              height: 10,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}

class DecorationMedia extends StatelessWidget {
  final Widget child;

  const DecorationMedia({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: ClipRRect(borderRadius: BorderRadius.circular(8), child: child),
      ),
    );
  }
}

class PainterOwnMessageTail extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    // Path number 1

    paint.color = const Color(0xfff5bfd1);
    path = Path();
    path.moveTo(-size.width * 0.08, size.height * 0.37);
    path.cubicTo(-size.width * 0.08, size.height * 0.37, size.width * 0.6, size.height / 2, size.width, 0);
    path.cubicTo(size.width, 0, size.width * 0.63, size.height * 1.18, 0, size.height * 0.98);
    path.cubicTo(0, size.height * 0.98, -size.width * 0.08, size.height * 0.37, -size.width * 0.08, size.height * 0.37);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class PainterAnotherMessageTail extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    // Path number 1

    paint.color = const Color(0xffffffff);
    path = Path();
    path.moveTo(size.width * 1.02, size.height * 0.37);
    path.cubicTo(size.width * 1.02, size.height * 0.37, size.width * 0.4, size.height / 2, 0, 0);
    path.cubicTo(0, 0, size.width * 0.38, size.height * 1.18, size.width, size.height * 0.98);
    path.cubicTo(size.width, size.height * 0.98, size.width * 1.02, size.height * 0.37, size.width * 0.92, size.height * 0.37);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

String formatDate(String inputDate) {
  final currentTime = DateTime.now();
  DateTime date;

  try {
    date = DateTime.parse(inputDate).toLocal();
  } catch (e) {
    print("Loi: $e");
    return "";
  }

  final dateFormat = DateFormat('HH:mm');

  if (date.year == currentTime.year && date.month == currentTime.month && date.day == currentTime.day) {
    return dateFormat.format(date);
  } else {
    return DateFormat('HH:mm dd-MM-yyyy').format(date);
  }
}
