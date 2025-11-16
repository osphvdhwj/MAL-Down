import 'package:flutter_test/flutter_test.dart';
import 'package:mal_down/main.dart';

void main() {
  testWidgets('App loads and displays title', (WidgetTester tester) async {
    await tester.pumpWidget(const MALDownApp());

    expect(find.text('MAL Down'), findsOneWidget);
    expect(find.text('MyAnimeList Image Downloader'), findsOneWidget);
  });
}
