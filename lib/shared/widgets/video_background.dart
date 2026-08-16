import 'package:flutter/material.dart';
import 'dart:js_interop';
import 'package:web/web.dart' as web;

/// A full-screen looping video background for Flutter Web.
///
/// Flutter web HTML platform views always render ABOVE the Flutter canvas,
/// so we cannot use [HtmlElementView] for a background. Instead, this widget
/// directly injects a `<video>` element into `document.body` with
/// `position: fixed; z-index: -1` so it sits behind the Flutter canvas.
class VideoBackground extends StatefulWidget {
  const VideoBackground({super.key});

  @override
  State<VideoBackground> createState() => _VideoBackgroundState();
}

class _VideoBackgroundState extends State<VideoBackground> {
  @override
  void initState() {
    super.initState();
    _injectVideo();
  }

  void _injectVideo() {
    // Ensure document.body and html root have transparent backgrounds
    web.document.body?.style.backgroundColor = 'transparent';
    (web.document.documentElement as web.HTMLElement?)?.style.backgroundColor =
        'transparent';

    final existingVideo =
        web.document.getElementById('portfolio-bg-video') as web.HTMLVideoElement?;
    if (existingVideo != null) {
      existingVideo.play().toDart.catchError((_) => null);
      return;
    }

    final video = web.document.createElement('video') as web.HTMLVideoElement;
    video.id = 'portfolio-bg-video';
    video.autoplay = true;
    video.loop = true;
    video.muted = true;
    video.setAttribute('muted', '');
    video.setAttribute('playsinline', '');
    video.setAttribute('webkit-playsinline', '');

    // Add source options for flutter web asset serving paths
    final source1 = web.document.createElement('source') as web.HTMLSourceElement;
    source1.src = 'assets/assets/background/background_video.mp4';
    source1.type = 'video/mp4';

    final source2 = web.document.createElement('source') as web.HTMLSourceElement;
    source2.src = 'assets/background/background_video.mp4';
    source2.type = 'video/mp4';

    video.appendChild(source1);
    video.appendChild(source2);

    // Fallback src attribute
    video.src = 'assets/assets/background/background_video.mp4';

    // Position it fixed behind the Flutter canvas
    video.style
      ..position = 'fixed'
      ..top = '0'
      ..left = '0'
      ..width = '100%'
      ..height = '100%'
      ..objectFit = 'cover'
      ..zIndex = '-1'
      ..pointerEvents = 'none';

    web.document.body?.appendChild(video);
    video.play().toDart.catchError((_) => null);
  }

  @override
  void dispose() {
    // Retain video element across navigation for seamless background video looping
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Renders nothing in Flutter — the video lives in the DOM behind the canvas.
    return const SizedBox.shrink();
  }
}

