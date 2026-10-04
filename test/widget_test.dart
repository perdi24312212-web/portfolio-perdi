import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_perdi/main.dart';

void main() {
  testWidgets('Halaman utama menampilkan nama dan NPM', (tester) async {
    await tester.pumpWidget(const PortfolioApp());
    expect(find.text('24312212'), findsWidgets);
  });
}
