import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/utils/network_utils.dart';

void main() {
  group('Tests of method parse() in Uri class', () {
    // domain name
    test('Should return String that is domain name of network via HTTPS', () {
      expect(
        Uri.parse('https://testnet-rpc.kira.network/').toString(),
        'https://testnet-rpc.kira.network/',
      );
    });

    test('Should return String that is domain name of network via HTTP', () {
      expect(
        Uri.parse('http://testnet-rpc.kira.network/').toString(),
        'http://testnet-rpc.kira.network/',
      );
    });

    // IP addresses without port
    test('Should return String that is IP address of network via HTTPS', () {
      expect(
        Uri.parse('https://192.168.0.1/').toString(),
        'https://192.168.0.1/',
      );
    });
    test('Should return String that is IP address of network via HTTP', () {
      expect(
        Uri.parse('http://192.168.0.1/').toString(),
        'http://192.168.0.1/',
      );
    });

    // IP addresses with port
    test('Should return String that is IP address of network with PORT via HTTPS', () {
      expect(
        Uri.parse('https://192.168.0.1:8001/').toString(),
        'https://192.168.0.1:8001/',
      );
    });

    test('Should return String that is IP address of network with PORT via HTTP', () {
      expect(
        Uri.parse('http://192.168.0.1:8001/').toString(),
        'http://192.168.0.1:8001/',
      );
    });
  });

  group('Tests of method NetworkUtils.parseUrl() for domain names', () {
    // schemas: https, http, no schema
    test('Should return domain name with HTTPS prefix and without trailing slash', () {
      expect(
        NetworkUtils.parseUrl('https://testnet-rpc.kira.network/').toString(),
        'https://testnet-rpc.kira.network',
      );
    });

    test('Should return domain name with HTTP prefix and without trailing slash', () {
      expect(
        NetworkUtils.parseUrl('http://testnet-rpc.kira.network/').toString(),
        'http://testnet-rpc.kira.network',
      );
    });

    test('Should return domain name with HTTP prefix', () {
      expect(
        NetworkUtils.parseUrl('testnet-rpc.kira.network').toString(),
        'http://testnet-rpc.kira.network',
      );
    });

    // query parameters
    test('Should return domain name with HTTPS prefix, custom port and custom query parameters', () {
      expect(
        NetworkUtils.parseUrl('https://testnet-rpc.kira.network?test1=result1&test2=result2').toString(),
        'https://testnet-rpc.kira.network?test1=result1&test2=result2',
      );
    });

    test('Should return domain name with HTTP prefix, custom port and custom query parameters', () {
      expect(
        NetworkUtils.parseUrl('http://testnet-rpc.kira.network?test1=result1&test2=result2').toString(),
        'http://testnet-rpc.kira.network?test1=result1&test2=result2',
      );
    });

    test('Should return domain name with HTTP prefix, custom port and custom query parameters', () {
      expect(
        NetworkUtils.parseUrl('testnet-rpc.kira.network?test1=result1&test2=result2').toString(),
        'http://testnet-rpc.kira.network?test1=result1&test2=result2',
      );
    });
  });

  group('Tests of method NetworkUtils.parseUrl() for IP addresses', () {
    // schemas: https, http, no schema
    test('Should return IP address with HTTPS prefix, assigned port 11000 and without trailing slash', () {
      expect(
        NetworkUtils.parseUrl('https://192.168.0.1/').toString(),
        'https://192.168.0.1:11000',
      );
    });

    test('Should return IP address with HTTP prefix, assigned port 11000 and without trailing slash', () {
      expect(
        NetworkUtils.parseUrl('http://192.168.0.1/').toString(),
        'http://192.168.0.1:11000',
      );
    });

    test('Should return IP address with assigned HTTP prefix, assigned port 11000 and without trailing slash', () {
      expect(
        NetworkUtils.parseUrl('192.168.0.1').toString(),
        'http://192.168.0.1:11000',
      );
    });

    // custom port
    test('Should return IP address with HTTPS prefix, custom port and without trailing slash', () {
      expect(
        NetworkUtils.parseUrl('https://192.168.0.1:8001/').toString(),
        'https://192.168.0.1:8001',
      );
    });

    test('Should return IP address with HTTP prefix, custom port and without trailing slash', () {
      expect(
        NetworkUtils.parseUrl('http://192.168.0.1:8001/').toString(),
        'http://192.168.0.1:8001',
      );
    });

    test('Should return IP address with assigned HTTP prefix, custom port and without trailing slash', () {
      expect(
        NetworkUtils.parseUrl('192.168.0.1:8001').toString(),
        'http://192.168.0.1:8001',
      );
    });

    // query parameters
    test('Should return IP address with HTTPS prefix, custom port and query parameters', () {
      expect(
        NetworkUtils.parseUrl('https://192.168.0.1:8001?test1=result1&test2=result2').toString(),
        'https://192.168.0.1:8001?test1=result1&test2=result2',
      );
    });

    test('Should return IP address with HTTP prefix, custom port and query parameters', () {
      expect(
        NetworkUtils.parseUrl('http://192.168.0.1:8001?test1=result1&test2=result2').toString(),
        'http://192.168.0.1:8001?test1=result1&test2=result2',
      );
    });

    test('Should return IP address with assigned HTTP prefix with custom query parameters', () {
      expect(
        NetworkUtils.parseUrl('192.168.0.1:8001?test1=result1&test2=result2').toString(),
        'http://192.168.0.1:8001?test1=result1&test2=result2',
      );
    });
  });

  group('Tests of method NetworkUtils.parseUrl() for localhost url', () {
    // schemas: https, http, no schema
    test('Should return localhost url with replaced prefix from HTTPS to HTTP and without trailing slash', () {
      expect(
        NetworkUtils.parseUrl('https://localhost/').toString(),
        'http://localhost',
      );
    });

    test('Should return localhost url with HTTP prefix and without trailing slash', () {
      expect(
        NetworkUtils.parseUrl('http://localhost').toString(),
        'http://localhost',
      );
    });

    test('Should return localhost url with assigned HTTP prefix and without trailing slash', () {
      expect(
        NetworkUtils.parseUrl('localhost').toString(),
        'http://localhost',
      );
    });

    // custom port
    test('Should return localhost url with prefix replaced from HTTPS to HTTP, custom port and without trailing slash',
        () {
      expect(
        NetworkUtils.parseUrl('https://localhost:8001/').toString(),
        'http://localhost:8001',
      );
    });

    test('Should return localhost url with HTTP prefix, custom port and without trailing slash', () {
      expect(
        NetworkUtils.parseUrl('http://localhost:8001/').toString(),
        'http://localhost:8001',
      );
    });

    test('Should return localhost url with assigned HTTP prefix, custom port and without trailing slash', () {
      expect(
        NetworkUtils.parseUrl('localhost:8001/').toString(),
        'http://localhost:8001',
      );
    });

    // query parameters
    test('Should return localhost url with prefix replaced from HTTPS to HTTP, custom port and custom query parameters',
        () {
      expect(
        NetworkUtils.parseUrl('https://localhost:8001?test1=result1&test2=result2').toString(),
        'http://localhost:8001?test1=result1&test2=result2',
      );
    });

    test('Should return localhost url with HTTP prefix, custom port and custom query parameters', () {
      expect(
        NetworkUtils.parseUrl('http://localhost:8001?test1=result1&test2=result2').toString(),
        'http://localhost:8001?test1=result1&test2=result2',
      );
    });

    test('Should return localhost url with assigned HTTP prefix, custom port and custom query parameters', () {
      expect(
        NetworkUtils.parseUrl('localhost:8001?test1=result1&test2=result2').toString(),
        'http://localhost:8001?test1=result1&test2=result2',
      );
    });
  });

  group('Tests of method NetworkUtils.parseUrl() for localhost IP address (127.0.0.1)', () {
    // schemas: https, http, no schema
    test('Should return IP address with replaced prefix from HTTPS to HTTP and without trailing slash', () {
      expect(
        NetworkUtils.parseUrl('https://127.0.0.1/').toString(),
        'http://127.0.0.1',
      );
    });

    test('Should return IP address with HTTP prefix and without trailing slash', () {
      expect(
        NetworkUtils.parseUrl('http://127.0.0.1/').toString(),
        'http://127.0.0.1',
      );
    });

    test('Should return IP address with assigned HTTP prefix and without trailing slash', () {
      expect(
        NetworkUtils.parseUrl('127.0.0.1').toString(),
        'http://127.0.0.1',
      );
    });

    // custom port
    test('Should return IP address with prefix replaced from HTTPS to HTTP, custom port and without trailing slash',
        () {
      expect(
        NetworkUtils.parseUrl('https://127.0.0.1:8001/').toString(),
        'http://127.0.0.1:8001',
      );
    });

    test('Should return IP address with HTTP prefix, custom port and without trailing slash', () {
      expect(
        NetworkUtils.parseUrl('http://127.0.0.1:8001/').toString(),
        'http://127.0.0.1:8001',
      );
    });

    test('Should return IP address with assigned HTTP prefix, custom port and without trailing slash', () {
      expect(
        NetworkUtils.parseUrl('127.0.0.1:8001/').toString(),
        'http://127.0.0.1:8001',
      );
    });

    // query parameters
    test('Should return IP address with prefix replaced from HTTPS to HTTP, custom port and custom query parameters',
        () {
      expect(
        NetworkUtils.parseUrl('https://127.0.0.1:8001?test1=result1&test2=result2').toString(),
        'http://127.0.0.1:8001?test1=result1&test2=result2',
      );
    });

    test('Should return IP address with HTTP prefix, custom port and custom query parameters', () {
      expect(
        NetworkUtils.parseUrl('http://127.0.0.1:8001?test1=result1&test2=result2').toString(),
        'http://127.0.0.1:8001?test1=result1&test2=result2',
      );
    });

    test('Should return IP address with assigned HTTP prefix, custom port and custom query parameters', () {
      expect(
        NetworkUtils.parseUrl('127.0.0.1:8001?test1=result1&test2=result2').toString(),
        'http://127.0.0.1:8001?test1=result1&test2=result2',
      );
    });
  });

  group('Tests of method NetworkUtils.parseUrl() for localhost IP address (0.0.0.0)', () {
    // schemas: https, http, no schema
    test('Should return IP address with replaced prefix from HTTPS to HTTP and without trailing slash', () {
      expect(
        NetworkUtils.parseUrl('https://0.0.0.0').toString(),
        'http://0.0.0.0',
      );
    });

    test('Should return IP address with HTTP prefix and without trailing slash', () {
      expect(
        NetworkUtils.parseUrl('http://0.0.0.0').toString(),
        'http://0.0.0.0',
      );
    });

    test('Should return IP address with assigned HTTP prefix and without trailing slash', () {
      expect(
        NetworkUtils.parseUrl('0.0.0.0').toString(),
        'http://0.0.0.0',
      );
    });

    // custom port
    test('Should return IP address with prefix replaced from HTTPS to HTTP, custom port and without trailing slash',
        () {
      expect(
        NetworkUtils.parseUrl('https://0.0.0.0:8001/').toString(),
        'http://0.0.0.0:8001',
      );
    });

    test('Should return IP address with HTTP prefix, custom port and without trailing slash', () {
      expect(
        NetworkUtils.parseUrl('http://0.0.0.0:8001/').toString(),
        'http://0.0.0.0:8001',
      );
    });

    test('Should return IP address with assigned HTTP prefix, custom port and without trailing slash', () {
      expect(
        NetworkUtils.parseUrl('0.0.0.0:8001/').toString(),
        'http://0.0.0.0:8001',
      );
    });

    // query parameters
    test('Should return IP address with prefix replaced from HTTPS to HTTP, custom port and custom query parameters',
        () {
      expect(
        NetworkUtils.parseUrl('https://0.0.0.0:8001?test1=result1&test2=result2').toString(),
        'http://0.0.0.0:8001?test1=result1&test2=result2',
      );
    });

    test('Should return IP address with HTTP prefix, custom port and custom query parameters', () {
      expect(
        NetworkUtils.parseUrl('http://0.0.0.0:8001?test1=result1&test2=result2').toString(),
        'http://0.0.0.0:8001?test1=result1&test2=result2',
      );
    });

    test('Should return IP address with assigned HTTP prefix, custom port and custom query parameters', () {
      expect(
        NetworkUtils.parseUrl('0.0.0.0:8001?test1=result1&test2=result2').toString(),
        'http://0.0.0.0:8001?test1=result1&test2=result2',
      );
    });
  });
}
