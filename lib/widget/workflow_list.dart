import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/viewmodel/workflow_viewmodel.dart';

class WorkflowList extends StatelessWidget {
  const WorkflowList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> steps = const [
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

    final displaySteps = List.generate(50, (i) => steps).expand((x) => x).toList();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryTextColor = isDark ? Colors.white : Colors.black;

    return ChangeNotifierProvider(
      create: (_) => WorkflowViewModel()..initialize(),
      child: Consumer<WorkflowViewModel>(
        builder: (context, viewModel, _) {
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
                controller: viewModel.scrollController,
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
        },
      ),
    );
  }
}
