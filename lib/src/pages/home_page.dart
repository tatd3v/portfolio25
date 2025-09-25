import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio_web/src/constants/app_constants.dart';
import 'package:portfolio_web/src/theme/app_theme.dart';
import 'package:portfolio_web/src/widgets/responsive_layout.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AutoScrollController _scrollController;
  final scrollDuration = const Duration(milliseconds: 800);
  final double scrollOffset = 100.0;

  @override
  void initState() {
    super.initState();
    _scrollController = AutoScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Method to handle scrolling to sections
  Future<void> _scrollToIndex(int index) async {
    await _scrollController.scrollToIndex(
      index,
      duration: scrollDuration,
      preferPosition: AutoScrollPosition.begin,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          AppConstants.appName,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          ),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          if (ResponsiveLayout.isDesktop(context))
            ...List.generate(
              AppConstants.navItems.length,
              (index) => TextButton(
                onPressed: () => _scrollToIndex(index),
                child: Text(
                  AppConstants.navItems[index]['title'],
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          const SizedBox(width: 16),
        ],
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: 6, // Number of sections
        itemBuilder: (context, index) {
          return AutoScrollTag(
            key: ValueKey(index),
            controller: _scrollController,
            index: index,
            child: _buildSection(index, context),
          );
        },
      ),
    );
  }

  Widget _buildSection(int index, BuildContext context) {
    switch (index) {
      case 0:
        return _buildHeroSection(context);
      case 1:
        return _buildAboutSection(context);
      case 2:
        return _buildSkillsSection(context);
      case 3:
        return _buildProjectsSection(context);
      case 4:
        return _buildExperienceSection(context);
      case 5:
        return _buildContactSection(context);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, I\'m',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Tatiana Davila',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              AppConstants.appTagline,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppTheme.lightTextColor,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final whatsappUrl = Uri.parse(
                      AppConstants.socialLinks['Cellphone']!,
                    );
                    if (await canLaunchUrl(whatsappUrl)) {
                      await launchUrl(whatsappUrl);
                    } else {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Could not launch WhatsApp'),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text('Contact Me'),
                ),
                const SizedBox(width: 16),
                OutlinedButton(
                  onPressed: () {
                    try {
                      final fileName = 'Tatiana_Davila_CV.pdf';
                      
                      // Direct download approach
                      final anchor = html.AnchorElement(
                        href: fileName
                      )
                        ..setAttribute('download', fileName)
                        ..style.display = 'none';
                      
                      // Add to DOM, trigger click, and remove
                      html.document.body?.children.add(anchor);
                      anchor.click();
                      html.document.body?.children.remove(anchor);
                      
                      // Fallback: If direct download doesn't work, open in new tab
                      Future.delayed(const Duration(seconds: 1), () {
                        if (anchor.href != null && anchor.href!.isNotEmpty) {
                          html.window.open(fileName, '_blank');
                        }
                      });
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error: ${e.toString()}'),
                            duration: const Duration(seconds: 5),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text('Download CV'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('About Me', style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 24),
          const Text(
            'I\'m a passionate Flutter developer with experience in building beautiful and performant cross-platform applications. '
            'I love turning ideas into reality through code and creating amazing user experiences.\n\n'
            'When I\'m not coding, you can find me exploring new technologies, contributing to open-source projects, or enjoying outdoor activities.',
            style: TextStyle(fontSize: 16, height: 1.8),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection(BuildContext context) {
    // This would be replaced with your actual skills data
    final skills = [
      {'name': 'Flutter', 'level': 90},
      {'name': 'Dart', 'level': 85},
      {'name': 'Firebase', 'level': 80},
      {'name': 'UI/UX Design', 'level': 75},
      {'name': 'Git', 'level': 85},
      {'name': 'REST APIs', 'level': 80},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      color: Colors.grey[50],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('My Skills', style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 40),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: skills.map((skill) {
              return _buildSkillCard(
                context,
                skill['name'] as String,
                skill['level'] as int,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCard(BuildContext context, String name, int level) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: level / 100,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 8),
          Text(
            '$level%',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppTheme.lightTextColor),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsSection(BuildContext context) {
    // This would be replaced with your actual projects data
    final projects = [
      {
        'title': 'E-Commerce App',
        'description':
            'A full-featured e-commerce application built with Flutter and Firebase.',
        'technologies': ['Flutter', 'Firebase', 'Provider'],
      },
      {
        'title': 'Weather App',
        'description':
            'Real-time weather forecasting application with beautiful UI.',
        'technologies': ['Flutter', 'REST API', 'BLoC'],
      },
      {
        'title': 'Task Management',
        'description':
            'Productivity app for managing daily tasks and projects.',
        'technologies': ['Flutter', 'SQLite', 'GetX'],
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('My Projects', style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 40),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: projects.map((project) {
              return _buildProjectCard(context, project);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, Map<String, dynamic> project) {
    return Container(
      width: 350,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Container(
              height: 180,
              color: Colors.grey[200],
              child: const Center(
                child: Icon(Icons.image, size: 50, color: Colors.grey),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project['title'],
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Text(
                  project['description'],
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: (project['technologies'] as List<dynamic>).map((
                    tech,
                  ) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        tech,
                        style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        // View project details
                      },
                      child: const Text('View Project'),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        // View code
                      },
                      icon: const Icon(Icons.code),
                      tooltip: 'View Code',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceSection(BuildContext context) {
    // This would be replaced with your actual experience data
    final experiences = [
      {
        'title': 'Senior Flutter Developer',
        'company': 'Tech Solutions Inc.',
        'period': '2022 - Present',
        'description':
            'Leading the development of cross-platform mobile applications using Flutter. Collaborating with the design team to create beautiful and intuitive user interfaces.',
      },
      {
        'title': 'Flutter Developer',
        'company': 'Digital Innovations',
        'period': '2020 - 2022',
        'description':
            'Developed and maintained multiple Flutter applications. Worked closely with the backend team to integrate RESTful APIs.',
      },
      {
        'title': 'Junior Mobile Developer',
        'company': 'StartUp Hub',
        'period': '2018 - 2020',
        'description':
            'Assisted in the development of mobile applications. Gained experience in mobile UI/UX design principles and best practices.',
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      color: Colors.grey[50],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Work Experience',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 40),
          ...experiences
              .map((exp) => _buildExperienceItem(context, exp))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildExperienceItem(
    BuildContext context,
    Map<String, dynamic> experience,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.work_outline,
                  color: AppTheme.primaryColor,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      experience['title'],
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      experience['company'],
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppTheme.lightTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  experience['period'],
                  style: TextStyle(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            experience['description'],
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Get In Touch', style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 24),
          Text(
            'I\'m always open to discussing product design work or partnerships.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildContactInfoItem(
                      context,
                      Icons.email_outlined,
                      'Email',
                      'your.email@example.com',
                    ),
                    const SizedBox(height: 20),
                    _buildContactInfoItem(
                      context,
                      Icons.phone_outlined,
                      'Phone',
                      '+1 (123) 456-7890',
                    ),
                    const SizedBox(height: 20),
                    _buildContactInfoItem(
                      context,
                      Icons.location_on_outlined,
                      'Location',
                      'San Francisco, CA',
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'Follow Me',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _buildSocialIcon(
                          Icons.g_mobiledata,
                          'https://github.com',
                        ),
                        const SizedBox(width: 16),
                        _buildSocialIcon(Icons.link, 'https://linkedin.com'),
                        const SizedBox(width: 16),
                        _buildSocialIcon(
                          Icons.chat_bubble_outline,
                          'https://twitter.com',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (ResponsiveLayout.isDesktop(context))
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Your Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Your Email',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Your Message',
                            border: OutlineInputBorder(),
                            alignLabelWithHint: true,
                          ),
                          maxLines: 5,
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Handle form submission
                            },
                            child: const Text('Send Message'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfoItem(
    BuildContext context,
    IconData icon,
    String title,
    String value,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppTheme.primaryColor, size: 24),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppTheme.lightTextColor),
            ),
            const SizedBox(height: 4),
            Text(value, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return InkWell(
      onTap: () {
        // Launch URL
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppTheme.primaryColor),
      ),
    );
  }
}
