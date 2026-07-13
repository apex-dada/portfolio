import 'dart:async';
import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:portfolio/widget/bento_card.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _isDarkMode = true;
  late final ScrollController _mainScrollController;
  final GlobalKey _portfolioKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _mainScrollController = ScrollController();
  }

  @override
  void dispose() {
    _mainScrollController.dispose();
    super.dispose();
  }

  void _scrollToKey(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: const Color(0xFF1E1E1E),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFF333333), width: 1),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (mounted) _showSnackBar(context, "Could not launch $urlString");
    }
  }

  Future<void> _sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'kaziwoaej@gmail.com',
    );
    if (!await launchUrl(emailLaunchUri)) {
      if (mounted) _showSnackBar(context, "Could not launch email client");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;

    // Theme values matching the mockup
    final cardColor = _isDarkMode ? const Color(0xFF151515) : const Color(0xFFFFFFFF);
    final borderColor = _isDarkMode ? const Color(0xFF222222) : const Color(0xFFE8E8E8);
    final hoverBorderColor = _isDarkMode ? const Color(0xFF3F3F3F) : const Color(0xFFCCCCCC);
    final primaryTextColor = _isDarkMode ? Colors.white : Colors.black;
    final secondaryTextColor = _isDarkMode ? Colors.white54 : Colors.black54;

    // Common Text Styles
    final titleStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: secondaryTextColor,
      letterSpacing: 1.5,
    );

    // 1. Intro Card
    Widget buildIntroCard() => BentoCard(
          backgroundColor: cardColor,
          borderColor: borderColor,
          hoverBorderColor: hoverBorderColor,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hi, I'm Kazi Woaej Mariz —",
                style: TextStyle(
                  color: primaryTextColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Mobile application developer, building high-quality Android & iOS experiences based in Bangladesh",
                style: TextStyle(
                  color: secondaryTextColor,
                  fontSize: 15,
                  height: 1.4,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        );

    // 2. Phone Mockup 1
    Widget buildPhoneMock1() => BentoCard(
          key: _portfolioKey,
          backgroundColor: cardColor,
          borderColor: borderColor,
          hoverBorderColor: hoverBorderColor,
          padding: EdgeInsets.zero,
          onTap: () => _launchUrl('https://github.com/apex-dada'),
          backgroundImage: Image.asset(
            'assets/images/phone_mockup.png',
            fit: BoxFit.cover,
          ),
        );

    // 3. Phone Mockup 2
    Widget buildPhoneMock2() => BentoCard(
          backgroundColor: cardColor,
          borderColor: borderColor,
          hoverBorderColor: hoverBorderColor,
          padding: EdgeInsets.zero,
          onTap: () => _launchUrl('https://github.com/apex-dada'),
          backgroundImage: Image.asset(
            'assets/images/phone_mockup.png',
            fit: BoxFit.cover,
          ),
        );

    // 4. Socials Grid Card
    Widget buildSocialsCard() => SizedBox(
          key: _contactKey,
          child: Column(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Facebook
                    Expanded(
                      child: BentoCard(
                        backgroundColor: cardColor,
                        borderColor: borderColor,
                        hoverBorderColor: hoverBorderColor,
                        padding: EdgeInsets.zero,
                        onTap: () => _launchUrl('https://www.facebook.com/kazi.woaej.mariz/'),
                        child: Center(
                          child: Icon(
                            Icons.facebook_rounded,
                            color: primaryTextColor,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Instagram
                    Expanded(
                      child: BentoCard(
                        backgroundColor: cardColor,
                        borderColor: borderColor,
                        hoverBorderColor: hoverBorderColor,
                        padding: EdgeInsets.zero,
                        onTap: () => _launchUrl('https://www.instagram.com/kazi_woaej/'),
                        child: Center(
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: primaryTextColor,
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // LinkedIn
                    Expanded(
                      child: BentoCard(
                        backgroundColor: cardColor,
                        borderColor: borderColor,
                        hoverBorderColor: hoverBorderColor,
                        padding: EdgeInsets.zero,
                        onTap: () => _launchUrl('https://www.linkedin.com/in/kazi-woaej-mariz-3586501b9/'),
                        child: Center(
                          child: Text(
                            "in",
                            style: TextStyle(
                              color: primaryTextColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // GitHub
                    Expanded(
                      child: BentoCard(
                        backgroundColor: cardColor,
                        borderColor: borderColor,
                        hoverBorderColor: hoverBorderColor,
                        padding: EdgeInsets.zero,
                        onTap: () => _launchUrl('https://github.com/apex-dada'),
                        child: Center(
                          child: Icon(
                            Icons.code_rounded,
                            color: primaryTextColor,
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Email
                    Expanded(
                      child: BentoCard(
                        backgroundColor: cardColor,
                        borderColor: borderColor,
                        hoverBorderColor: hoverBorderColor,
                        padding: EdgeInsets.zero,
                        onTap: _sendEmail,
                        child: Center(
                          child: Icon(
                            Icons.mail_outline_rounded,
                            color: primaryTextColor,
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );

    // 5. Profile Pic Card
    Widget buildProfileCard() => BentoCard(
          backgroundColor: cardColor,
          borderColor: borderColor,
          hoverBorderColor: hoverBorderColor,
          padding: EdgeInsets.zero,
          backgroundImage: Image.asset(
            'assets/images/IMG_0741 (1).jpg',
            fit: BoxFit.cover,
          ),
        );

    // 6. About Card
    Widget buildAboutCard() => BentoCard(
          backgroundColor: cardColor,
          borderColor: borderColor,
          hoverBorderColor: hoverBorderColor,
          title: "ABOUT",
          titleStyle: titleStyle,
          onTap: () => _launchUrl('https://www.linkedin.com/in/kazi-woaej-mariz-3586501b9/'),
          trailing: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _isDarkMode ? const Color(0xFF1E1E1E) : const Color(0xFFF0F0F2),
              border: Border.all(color: borderColor),
            ),
            child: Icon(
              Icons.arrow_outward_rounded,
              color: primaryTextColor,
              size: 16,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "ABOUT",
                style: titleStyle,
              ),
              const SizedBox(height: 16),
              Text(
                "Passionate about mobile application development and enjoy solving problems.",
                style: TextStyle(
                  color: primaryTextColor,
                  fontSize: 20,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );

    // 7. Workflow Card
    Widget buildWorkflowCard() => BentoCard(
          backgroundColor: cardColor,
          borderColor: borderColor,
          hoverBorderColor: hoverBorderColor,
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  "My Workflow",
                  style: TextStyle(
                    color: primaryTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Expanded(
                child: WorkflowList(),
              ),
            ],
          ),
        );



    // 9. Newsletter Card
    Widget buildNewsletterCard() => BentoCard(
          backgroundColor: cardColor,
          borderColor: borderColor,
          hoverBorderColor: hoverBorderColor,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Have a project in mind?",
                style: TextStyle(
                  color: primaryTextColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 10),
              LayoutBuilder(
                builder: (context, constraints) {
                  final useColumn = constraints.maxWidth < 280;
                  if (useColumn) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: _isDarkMode ? const Color(0xFF1A1A1A) : const Color(0xFFF2F2F7),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: borderColor),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            style: TextStyle(color: primaryTextColor, fontSize: 14),
                            decoration: InputDecoration(
                              hintText: "Your email address",
                              hintStyle: TextStyle(color: secondaryTextColor, fontSize: 14),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () => _showSnackBar(context, "Project request sent successfully!"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryTextColor,
                            foregroundColor: _isDarkMode ? Colors.black : Colors.white,
                            elevation: 0,
                            minimumSize: const Size(double.infinity, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Sent",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ),
                      ],
                    );
                  }

                  return Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: _isDarkMode ? const Color(0xFF1A1A1A) : const Color(0xFFF2F2F7),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: borderColor),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            style: TextStyle(color: primaryTextColor, fontSize: 14),
                            decoration: InputDecoration(
                              hintText: "Your email address",
                              hintStyle: TextStyle(color: secondaryTextColor, fontSize: 14),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () => _showSnackBar(context, "Project request sent successfully!"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryTextColor,
                          foregroundColor: _isDarkMode ? Colors.black : Colors.white,
                          elevation: 0,
                          minimumSize: const Size(100, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Sent",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        );



    // 10. Stack Card
    Widget buildStackCard() => BentoCard(
          backgroundColor: cardColor,
          borderColor: borderColor,
          hoverBorderColor: hoverBorderColor,
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0, top: 24.0, right: 24.0),
                child: Text(
                  "Stack I use",
                  style: TextStyle(
                    color: primaryTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Expanded(
                child: Center(
                  child: LogoCarousel(),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );

    // 11. Toggle Switch Card
    Widget buildToggleCard() => BentoCard(
          backgroundColor: cardColor,
          borderColor: borderColor,
          hoverBorderColor: hoverBorderColor,
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                  color: primaryTextColor,
                  size: 24,
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isDarkMode = !_isDarkMode;
                    });
                  },
                  child: Container(
                    width: 50,
                    height: 28,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: _isDarkMode ? const Color(0xFF262626) : const Color(0xFFE5E5EA),
                      border: Border.all(color: borderColor),
                    ),
                    padding: const EdgeInsets.all(2),
                    child: AnimatedAlign(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOutCubic,
                      alignment: _isDarkMode ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryTextColor,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0x1A000000),
                              blurRadius: 4,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );



    // Responsive builds
    Widget buildBody() {
      if (isMobile) {
        // Mobile Layout (Single Column)
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
            children: [
              SizedBox(height: 220, child: buildIntroCard()),
              const SizedBox(height: 16),
              SizedBox(height: 240, child: buildPhoneMock1()),
              const SizedBox(height: 16),
              SizedBox(height: 240, child: buildPhoneMock2()),
              const SizedBox(height: 16),
              SizedBox(height: 160, child: buildSocialsCard()),
              const SizedBox(height: 16),
              SizedBox(height: 240, child: buildProfileCard()),
              const SizedBox(height: 16),
              SizedBox(height: 200, child: buildAboutCard()),
              const SizedBox(height: 16),
              SizedBox(height: 100, child: buildToggleCard()),
              const SizedBox(height: 16),
              SizedBox(height: 200, child: buildStackCard()),
              const SizedBox(height: 16),
              SizedBox(height: 180, child: buildNewsletterCard()),
              const SizedBox(height: 16),
              SizedBox(height: 240, child: buildWorkflowCard()),
            ],
          ),
        );
      }

      // Desktop Layout (Structured Row/Column Grid aligning perfectly to column percentages)
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        child: Column(
          children: [
            // Row 1
            SizedBox(
              height: 190,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(flex: 4, child: buildIntroCard()),
                  const SizedBox(width: 16),
                  Expanded(flex: 2, child: buildPhoneMock1()),
                  const SizedBox(width: 16),
                  Expanded(flex: 2, child: buildPhoneMock2()),
                  const SizedBox(width: 16),
                  Expanded(flex: 2, child: buildSocialsCard()),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Rows 2 & 3 (Combined grid for vertical alignment of workflow)
            SizedBox(
              height: 386,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Left side grid column (Profile, About, Toggle, Stack, Newsletter)
                  Expanded(
                    flex: 8,
                    child: Column(
                      children: [
                        // Row 2 Left
                        SizedBox(
                          height: 200,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(flex: 2, child: buildProfileCard()),
                              const SizedBox(width: 16),
                              Expanded(flex: 3, child: buildAboutCard()),
                              const SizedBox(width: 16),
                              SizedBox(width: 200, child: buildToggleCard()),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Row 3 Left (Green marked area)
                        SizedBox(
                          height: 170,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(flex: 5, child: buildStackCard()),
                              const SizedBox(width: 16),
                              Expanded(flex: 3, child: buildNewsletterCard()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Right side grid column (Red marked area)
                  Expanded(
                    flex: 2,
                    child: buildWorkflowCard(),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // App Bar Builder
    Widget buildAppBar(bool isMobile) {
      final appBarPadding = isMobile
          ? const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 4.0)
          : const EdgeInsets.only(left: 32.0, right: 32.0, top: 12.0, bottom: 4.0);

      return Padding(
        padding: appBarPadding,
        child: LiquidGlass.withOwnLayer(
          shape: const LiquidRoundedRectangle(
            borderRadius: 16,
            side: BorderSide(
              color: Color(0x1F000000),
              width: 1,
            ),
          ),
          settings: const LiquidGlassSettings(
            blur: 16.0,
            glassColor: Colors.transparent,
          ),
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo
                Text(
                  "Mariz.",
                  style: TextStyle(
                    color: primaryTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                ),
                // Nav Items
                Row(
                  children: [
                    HoverNavItem(
                      label: "Home",
                      isDarkMode: _isDarkMode,
                      onTap: () {
                        _mainScrollController.animateTo(
                          0.0,
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeInOutCubic,
                        );
                      },
                    ),
                    const SizedBox(width: 24),
                    HoverNavItem(
                      label: "Portfolio",
                      isDarkMode: _isDarkMode,
                      onTap: () => _scrollToKey(_portfolioKey),
                    ),
                    const SizedBox(width: 24),
                    HoverNavItem(
                      label: "Contact",
                      isDarkMode: _isDarkMode,
                      onTap: () => _scrollToKey(_contactKey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    final backgroundDecoration = _isDarkMode
        ? const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background/background_2.jpg'),
              fit: BoxFit.fill,
            ),
          )
        : const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background/background_3.jpg'),
              fit: BoxFit.fill,
            ),
          );

    return Scaffold(
      body: Container(
        decoration: backgroundDecoration,
        height: double.infinity,
        width: double.infinity,
        child: SafeArea(
          child: Column(
            children: [
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: buildAppBar(isMobile),
                ),
              ),
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: SingleChildScrollView(
                      controller: _mainScrollController,
                      child: buildBody(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class HoverNavItem extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool isDarkMode;

  const HoverNavItem({
    required this.label,
    required this.onTap,
    required this.isDarkMode,
    super.key,
  });

  @override
  State<HoverNavItem> createState() => _HoverNavItemState();
}

class _HoverNavItemState extends State<HoverNavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final baseColor = widget.isDarkMode ? Colors.white : Colors.black;
    final color = _isHovered ? baseColor : (widget.isDarkMode ? const Color(0x99FFFFFF) : const Color(0x99000000));

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 150),
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}

class WorkflowList extends StatefulWidget {
  const WorkflowList({super.key});

  @override
  State<WorkflowList> createState() => _WorkflowListState();
}

class _WorkflowListState extends State<WorkflowList> {
  late final ScrollController _scrollController;
  Timer? _timer;

  final List<String> _steps = [
    'Requirements',
    'Planning & Design',
    'Project Setup',
    'UI Development',
    'State Management',
    'Business Logic',
    'API Integration',
    'Local Database & Storage',
    'Testing',
    'Debugging & Optimization',
    'Build & Release',
    'Deployment',
    'Monitoring & Maintenance',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent / 2);
        _startAutoScroll();
      }
    });
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      if (_scrollController.hasClients) {
        final currentScroll = _scrollController.offset;
        final maxScroll = _scrollController.position.maxScrollExtent;
        
        double nextScroll = currentScroll + 0.5;
        if (nextScroll >= maxScroll - 60) {
          nextScroll = maxScroll / 2;
        }
        _scrollController.jumpTo(nextScroll);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displaySteps = List.generate(50, (i) => _steps).expand((x) => x).toList();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryTextColor = isDark ? Colors.white : Colors.black;

    return Stack(
      children: [
        // Static Timeline Line
        Positioned(
          left: 27,
          top: 0,
          bottom: 0,
          child: Container(
            width: 2,
            color: isDark ? const Color(0xFF262626) : const Color(0xFFE5E5EA),
          ),
        ),
        // Scrolling List
        ListView.builder(
          controller: _scrollController,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: displaySteps.length,
          itemBuilder: (context, index) {
            final step = displaySteps[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
              child: Row(
                children: [
                  // Timeline Dot
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDark ? const Color(0xFF3DDC84) : const Color(0xFF007AFF),
                      boxShadow: [
                        BoxShadow(
                          color: isDark ? const Color(0x663DDC84) : const Color(0x66007AFF),
                          blurRadius: 6,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Step Text
                  Expanded(
                    child: Text(
                      step,
                      style: TextStyle(
                        color: primaryTextColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class LogoCarousel extends StatefulWidget {
  const LogoCarousel({super.key});

  @override
  State<LogoCarousel> createState() => _LogoCarouselState();
}

class _LogoCarouselState extends State<LogoCarousel> {
  late final ScrollController _scrollController;
  Timer? _timer;

  final List<String> _logos = [
    'assets/stack/flutter.png',
    'assets/stack/dart.png',
    'assets/stack/block.png',
    'assets/stack/firebase.png',
    'assets/stack/sqlite.webp',
    'assets/stack/supabase.webp',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent / 2);
        _startAutoScroll();
      }
    });
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(milliseconds: 20), (timer) {
      if (_scrollController.hasClients) {
        final currentScroll = _scrollController.offset;
        final maxScroll = _scrollController.position.maxScrollExtent;
        
        double nextScroll = currentScroll + 0.6;
        if (nextScroll >= maxScroll - 100) {
          nextScroll = maxScroll / 2;
        }
        _scrollController.jumpTo(nextScroll);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayLogos = List.generate(50, (i) => _logos).expand((x) => x).toList();

    return SizedBox(
      height: 96,
      child: ListView.builder(
        controller: _scrollController,
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
    );
  }
}
