import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/logo_carousel_viewmodel.dart';

class LogoCarousel extends StatelessWidget {
  const LogoCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> logos = const [
      'assets/stack/flutter.png',
      'assets/stack/dart.png',
      'assets/stack/block.png',
      'assets/stack/firebase.png',
      'assets/stack/sqlite.webp',
      'assets/stack/supabase.webp',
    ];

    final displayLogos = List.generate(50, (i) => logos).expand((x) => x).toList();

    return ChangeNotifierProvider(
      create: (_) => LogoCarouselViewModel()..initialize(),
      child: Consumer<LogoCarouselViewModel>(
        builder: (context, viewModel, _) {
          return SizedBox(
            height: 96,
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.transparent,
                    Colors.white,
                    Colors.white,
                    Colors.transparent,
                  ],
                  stops: [0.0, 0.08, 0.92, 1.0],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: ListView.builder(
                controller: viewModel.scrollController,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: displayLogos.length,
                itemBuilder: (context, index) {
                  final logo = displayLogos[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 4.0, bottom: 12.0),
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0x1F000000),
                          width: 1,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x1A000000),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Image.asset(
                        logo,
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
