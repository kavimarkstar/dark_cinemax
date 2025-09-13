import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoPlayerPage extends StatefulWidget {
  final String videoUrl;
  final String movieTitle;

  const VideoPlayerPage({
    Key? key,
    required this.videoUrl,
    required this.movieTitle,
  }) : super(key: key);

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late final WebViewController _controller;

  final List<String> adHosts = [
    "doubleclick.net",
    "googleadservices.com",
    "googlesyndication.com",
    "adservice.google.com",
    "ads.youtube.com",
    "facebook.net",
    "adform.net",
    "taboola.com",
    "outbrain.com",
    "popads.net",
    "propellerads.com",
  ];

  late final String allowedDomain;

  @override
  void initState() {
    super.initState();

    // Force fullscreen landscape
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    // Extract base domain
    final uri = Uri.parse(widget.videoUrl);
    allowedDomain = uri.host;

    // Setup WebView
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            final url = request.url;

            // Block ads by host
            for (var host in adHosts) {
              if (url.contains(host)) {
                debugPrint("Blocked ad request: $url");
                return NavigationDecision.prevent;
              }
            }

            // Block redirects outside original domain
            final reqUri = Uri.parse(url);
            if (reqUri.host != allowedDomain) {
              debugPrint("Blocked external redirect: $url");
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
          onPageFinished: (String url) {
            // Inject JS to remove inline ads
            _controller.runJavaScript("""
              var css = `
                iframe, .ads, .adsbygoogle, .ad-banner, .ad-container,
                .sponsored, .promo, .advertisement, [id*="ad"], [class*="ad"] {
                  display: none !important;
                  visibility: hidden !important;
                }
              `;
              var style = document.createElement('style');
              style.innerHTML = css;
              document.head.appendChild(style);

              // Disable popups
              window.open = function() { return null; };
            """);
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.videoUrl));
  }

  @override
  void dispose() {
    // Restore portrait + normal UI
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: WebViewWidget(controller: _controller),
    );
  }
}
