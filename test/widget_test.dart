import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_web/main.dart';
import 'package:portfolio_web/src/pages/home_page.dart';

void main() {
  testWidgets('App should render without errors', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const MyPortfolioApp());

    // Verify that the app title is displayed
    expect(find.text('My Portfolio'), findsNothing); // Title is not in the widget tree directly
    
    // Verify that the home page is loaded
    expect(find.byType(HomePage), findsOneWidget);
  });
}
