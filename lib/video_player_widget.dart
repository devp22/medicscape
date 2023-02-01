import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  VideoPlayerWidget({required this.url});
  final String url;
  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState(url: url);
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  _VideoPlayerWidgetState({required this.url});
  String url;
  late VideoPlayerController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.network(url)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container(),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: VideoProgressIndicator(
            _controller,
            allowScrubbing: true,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                    fixedSize: MaterialStateProperty.all(Size(20, 20)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)))),
                onPressed: () {
                  _controller.seekTo(Duration(
                      seconds: _controller.value.position.inSeconds - 10));
                },
                child: const Icon(Icons.fast_rewind)),
            ElevatedButton(
              onPressed: () {
                _controller.play();
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.redAccent),
                  fixedSize:
                      MaterialStateProperty.all<Size>(const Size(20, 20)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)))),
              child: const Icon(Icons.play_arrow),
            ),
            ElevatedButton(
              onPressed: () {
                _controller.pause();
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  fixedSize:
                      MaterialStateProperty.all<Size>(const Size(20, 20)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)))),
              child: const Icon(Icons.pause),
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                    fixedSize: MaterialStateProperty.all(const Size(20, 20)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)))),
                onPressed: () {
                  _controller.seekTo(Duration(
                      seconds: _controller.value.position.inSeconds + 10));
                },
                child: Icon(Icons.fast_forward)),
          ],
        )
      ],
    );
  }
}
