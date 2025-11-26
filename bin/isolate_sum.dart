import 'dart:async';
import 'dart:isolate';
import 'dart:math';

void main() async {
  final mainReceivePort = ReceivePort();

  // Spawn worker isolate
  await Isolate.spawn(_workerEntryPoint, mainReceivePort.sendPort);

  SendPort? workerSendPort;
  int sum = 0;

  mainReceivePort.listen((message) {
    if (message is SendPort) {
      // lần đầu, worker gửi sendPort của nó
      workerSendPort = message;
      print('Main: got worker sendPort');
    } else if (message is int) {
      sum += message;
      print('Main: received $message, sum = $sum');

      if (sum > 100 && workerSendPort != null) {
        print('Main: sum > 100, sending stop');
        workerSendPort!.send('stop');
      }
    } else if (message == 'done') {
      print('Main: worker exited, closing');
      mainReceivePort.close();
    }
  });
}

void _workerEntryPoint(SendPort mainSendPort) {
  final workerReceivePort = ReceivePort();
  mainSendPort.send(workerReceivePort.sendPort);

  final random = Random();
  Timer? timer;

  workerReceivePort.listen((message) {
    if (message == 'stop') {
      print('Worker: received stop, exiting...');
      timer?.cancel();
      mainSendPort.send('done');
      Isolate.exit();
    }
  });

  timer = Timer.periodic(const Duration(seconds: 1), (_) {
    final value = random.nextInt(10) + 1; // 1..10
    print('Worker: send $value');
    mainSendPort.send(value);
  });
}
