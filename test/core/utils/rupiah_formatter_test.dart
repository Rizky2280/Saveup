import 'package:flutter_test/flutter_test.dart';
import 'package:saveup/core/utils/utils.dart';

void main() {
  test('formats integers as Indonesian Rupiah', () {
    expect(formatRupiah(1000), 'Rp 1.000');
    expect(formatRupiah(10000), 'Rp 10.000');
    expect(formatRupiah(100000), 'Rp 100.000');
    expect(formatRupiah(1000000), 'Rp 1.000.000');
  });

  test('parses formatted Rupiah to raw integer', () {
    expect(parseRupiah('Rp 1.000.000'), 1000000);
    expect(parseRupiah(''), isNull);
    expect(parseRupiah('Rp 0'), 0);
  });
}
