import 'package:flutter_test/flutter_test.dart';
import 'package:mal_down/main.dart';

void main() {
  group('Main App Tests', () {
    test('App can be instantiated', () {
      expect(() => const MALDownApp(), returnsNormally);
    });

    test('HomeScreen can be instantiated', () {
      expect(() => const HomeScreen(), returnsNormally);
    });
  });
}
