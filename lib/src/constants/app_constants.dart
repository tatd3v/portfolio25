class AppConstants {
  // App information
  static const String appName = 'Tatd3v Portfolio';
  static const String appTagline = 'Flutter Developer & Web Engineer';

  // Navigation items
  static const List<Map<String, dynamic>> navItems = [
    {'title': 'Home', 'route': '/#home'},
    // {'title': 'About', 'route': '/#about'},
    // {'title': 'Skills', 'route': '/#skills'},
    // {'title': 'Projects', 'route': '/#projects'},
    // {'title': 'Experience', 'route': '/#experience'},
    // {'title': 'Contact', 'route': '/#contact'},
  ];

  // Social media links
  static const Map<String, String> socialLinks = {
    'GitHub': 'https://github.com/tatd3v',
    'LinkedIn': 'https://linkedin.com/in/tatdev',
    'Email': 'mailto:tatdev91@gmail.com',
    'Cellphone':
        'https://wa.me/573016492993?text=Hello%20Tatiana,%20I%20saw%20your%20portfolio%20and%20would%20like%20to%20connect!',
  };

  // Animation durations
  static const Duration fastAnimation = Duration(milliseconds: 300);
  static const Duration mediumAnimation = Duration(milliseconds: 600);
  static const Duration slowAnimation = Duration(milliseconds: 900);

  // Responsive breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;
}
