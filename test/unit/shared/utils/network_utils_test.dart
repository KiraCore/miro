import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/utils/network_utils.dart';

void main() {
  group('Tests of method parse() in Uri class', () {
    // domain name
    test('Should return String that is domain name with HTTPS prefix', () {
      String actualDomainUrl = Uri.parse('https://testnet-rpc.kira.network/').toString();

      expect(actualDomainUrl, 'https://testnet-rpc.kira.network/');
    });

    test('Should return String that is domain name with HTTP prefix', () {
      String actualDomainUrl = Uri.parse('http://testnet-rpc.kira.network/').toString();

      expect(actualDomainUrl, 'http://testnet-rpc.kira.network/');
    });

    // IP addresses without port
    test('Should return String that is IP address with HTTPS prefix', () {
      String actualDomainUrl = Uri.parse('https://192.168.0.1/').toString();

      expect(actualDomainUrl, 'https://192.168.0.1/');
    });

    test('Should return String that is IP address with HTTP prefix', () {
      String actualDomainUrl = Uri.parse('http://192.168.0.1/').toString();

      expect(actualDomainUrl, 'http://192.168.0.1/');
    });

    // IP addresses with port
    test('Should return String that is IP address with HTTPS prefix and custom port', () {
      String actualDomainUrl = Uri.parse('https://192.168.0.1:8001/').toString();

      expect(actualDomainUrl, 'https://192.168.0.1:8001/');
    });

    test('Should return String that is IP address with HTTP prefix and custom port', () {
      String actualDomainUrl = Uri.parse('http://192.168.0.1:8001/').toString();

      expect(actualDomainUrl, 'http://192.168.0.1:8001/');
    });
  });

  group('Tests of method NetworkUtils.parseUrlToInterxUri()', () {
    group('Domain names', () {
      // scheme: https, http, no scheme
      test('Should return domain name with HTTPS prefix and without trailing slash', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('https://testnet-rpc.kira.network/').toString();

        expect(actualDomainUrl, 'https://testnet-rpc.kira.network');
      });

      test('Should return domain name with HTTP prefix and without trailing slash', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('http://testnet-rpc.kira.network/').toString();

        expect(actualDomainUrl, 'http://testnet-rpc.kira.network');
      });

      test('Should return domain name with assigned HTTPS prefix', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('testnet-rpc.kira.network').toString();

        expect(actualDomainUrl, 'https://testnet-rpc.kira.network');
      });

      // query parameters
      test('Should return domain name with HTTPS prefix and custom query parameters', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('https://testnet-rpc.kira.network?test1=result1&test2=result2').toString();

        expect(actualDomainUrl, 'https://testnet-rpc.kira.network?test1=result1&test2=result2');
      });

      test('Should return domain name with HTTP prefix and custom query parameters', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('http://testnet-rpc.kira.network?test1=result1&test2=result2').toString();

        expect(actualDomainUrl, 'http://testnet-rpc.kira.network?test1=result1&test2=result2');
      });
      
      test('Should return domain name with assigned HTTPS prefix and custom query parameters', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('testnet-rpc.kira.network?test1=result1&test2=result2').toString();

        expect(actualDomainUrl, 'https://testnet-rpc.kira.network?test1=result1&test2=result2');
      });
    });

    group('IP addresses', () {
      // scheme: https, http, no scheme
      test('Should return IP address with HTTPS prefix, assigned port 11000 and without trailing slash', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('https://192.168.0.1/').toString();

        expect(actualDomainUrl, 'https://192.168.0.1:11000');
      });

      test('Should return IP address with HTTP prefix, assigned port 11000 and without trailing slash', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('http://192.168.0.1/').toString();

        expect(actualDomainUrl, 'http://192.168.0.1:11000');
      });

      test('Should return IP address with assigned HTTPS prefix and port 11000', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('192.168.0.1').toString();

        expect(actualDomainUrl, 'https://192.168.0.1:11000');
      });

      // custom port
      test('Should return IP address with HTTPS prefix, custom port and without trailing slash', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('https://192.168.0.1:8001/').toString();

        expect(actualDomainUrl, 'https://192.168.0.1:8001');
      });

      test('Should return IP address with HTTP prefix, custom port and without trailing slash', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('http://192.168.0.1:8001/').toString();

        expect(actualDomainUrl, 'http://192.168.0.1:8001');
      });

      test('Should return IP address with assigned HTTPS prefix and custom port', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('192.168.0.1:8001').toString();

        expect(actualDomainUrl, 'https://192.168.0.1:8001');
      });

      // query parameters
      test('Should return IP address with HTTPS prefix, custom port and query parameters', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('https://192.168.0.1:8001?test1=result1&test2=result2').toString();

        expect(actualDomainUrl, 'https://192.168.0.1:8001?test1=result1&test2=result2');
      });

      test('Should return IP address with HTTP prefix, custom port and query parameters', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('http://192.168.0.1:8001?test1=result1&test2=result2').toString();

        expect(actualDomainUrl, 'http://192.168.0.1:8001?test1=result1&test2=result2');
      });

      test('Should return IP address with assigned HTTPS prefix, custom port and query parameters', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('192.168.0.1:8001?test1=result1&test2=result2').toString();

        expect(actualDomainUrl, 'https://192.168.0.1:8001?test1=result1&test2=result2');
      });
    });

    group('localhost', () {
      // scheme: https, http, no scheme
      test('Should return localhost url with replaced prefix from HTTPS to HTTP and without trailing slash', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('https://localhost/').toString();

        expect(actualDomainUrl, 'http://localhost');
      });

      test('Should return localhost url with HTTP prefix and without trailing slash', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('http://localhost/').toString();

        expect(actualDomainUrl, 'http://localhost');
      });

      test('Should return localhost url with assigned HTTP prefix', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('localhost').toString();

        expect(actualDomainUrl, 'http://localhost');
      });

      // custom port
      test('Should return localhost url with replaced prefix from HTTPS to HTTP, custom port and without trailing slash', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('https://localhost:8001/').toString();

        expect(actualDomainUrl, 'http://localhost:8001');
      });

      test('Should return localhost url with HTTP prefix, custom port and without trailing slash', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('http://localhost:8001/').toString();

        expect(actualDomainUrl, 'http://localhost:8001');
      });

      test('Should return localhost url with assigned HTTP prefix and custom port', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('localhost:8001').toString();

        expect(actualDomainUrl, 'http://localhost:8001');
      });

      // query parameters
      test('Should return localhost url with replaced prefix from HTTPS to HTTP, custom port and query parameters', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('https://localhost:8001?test1=result1&test2=result2').toString();

        expect(actualDomainUrl, 'http://localhost:8001?test1=result1&test2=result2');
      });

      test('Should return localhost url with HTTP prefix, custom port and query parameters', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('http://localhost:8001?test1=result1&test2=result2').toString();

        expect(actualDomainUrl, 'http://localhost:8001?test1=result1&test2=result2');
      });

      test('Should return localhost url with assigned HTTP prefix, custom port and query parameters', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('localhost:8001?test1=result1&test2=result2').toString();

        expect(actualDomainUrl, 'http://localhost:8001?test1=result1&test2=result2');
      });
    });

    group('localhost IP address (127.0.0.1)', () {
      // scheme: https, http, no scheme
      test('Should return IP address with replaced prefix from HTTPS to HTTP and without trailing slash', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('https://127.0.0.1/').toString();

        expect(actualDomainUrl, 'http://127.0.0.1');
      });

      test('Should return IP address with HTTP prefix and without trailing slash', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('http://127.0.0.1/').toString();

        expect(actualDomainUrl, 'http://127.0.0.1');
      });

      test('Should return IP address with assigned HTTP prefix', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('127.0.0.1').toString();

        expect(actualDomainUrl, 'http://127.0.0.1');
      });

      // custom port
      test('Should return IP address with replaced prefix from HTTPS to HTTP, custom port and without trailing slash', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('https://127.0.0.1:8001/').toString();

        expect(actualDomainUrl, 'http://127.0.0.1:8001');
      });

      test('Should return IP address with HTTP prefix, custom port and without trailing slash', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('http://127.0.0.1:8001/').toString();

        expect(actualDomainUrl, 'http://127.0.0.1:8001');
      });

      test('Should return IP address with assigned HTTP prefix and custom port', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('127.0.0.1:8001').toString();

        expect(actualDomainUrl, 'http://127.0.0.1:8001');
      });

      // query parameters
      test('Should return IP address with replaced prefix from HTTPS to HTTP, custom port and query parameters', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('https://127.0.0.1:8001?test1=result1&test2=result2').toString();

        expect(actualDomainUrl, 'http://127.0.0.1:8001?test1=result1&test2=result2');
      });

      test('Should return IP address with HTTP prefix, custom port and query parameters', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('http://127.0.0.1:8001?test1=result1&test2=result2').toString();

        expect(actualDomainUrl, 'http://127.0.0.1:8001?test1=result1&test2=result2');
      });

      test('Should return IP address with assigned HTTP prefix, custom port and query parameters', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('127.0.0.1:8001?test1=result1&test2=result2').toString();

        expect(actualDomainUrl, 'http://127.0.0.1:8001?test1=result1&test2=result2');
      });
    });

    group('localhost IP address (0.0.0.0)', () {
      // scheme: https, http, no scheme
      test('Should return IP address with replaced prefix from HTTPS to HTTP and without trailing slash', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('https://0.0.0.0/').toString();

        expect(actualDomainUrl, 'http://0.0.0.0');
      });

      test('Should return IP address with HTTP prefix and without trailing slash', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('http://0.0.0.0/').toString();

        expect(actualDomainUrl, 'http://0.0.0.0');
      });

      test('Should return IP address with assigned HTTP prefix', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('0.0.0.0').toString();

        expect(actualDomainUrl, 'http://0.0.0.0');
      });

      // custom port
      test('Should return IP address with replaced prefix from HTTPS to HTTP, custom port and without trailing slash', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('https://0.0.0.0:8001/').toString();

        expect(actualDomainUrl, 'http://0.0.0.0:8001');
      });

      test('Should return IP address with HTTP prefix, custom port and without trailing slash', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('http://0.0.0.0:8001/').toString();

        expect(actualDomainUrl, 'http://0.0.0.0:8001');
      });

      test('Should return IP address with assigned HTTP prefix and custom port', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('0.0.0.0:8001').toString();

        expect(actualDomainUrl, 'http://0.0.0.0:8001');
      });

      // query parameters
      test('Should return IP address with replaced prefix from HTTPS to HTTP, custom port and query parameters', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('https://0.0.0.0:8001?test1=result1&test2=result2').toString();

        expect(actualDomainUrl, 'http://0.0.0.0:8001?test1=result1&test2=result2');
      });

      test('Should return IP address with HTTP prefix, custom port and query parameters', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('http://0.0.0.0:8001?test1=result1&test2=result2').toString();

        expect(actualDomainUrl, 'http://0.0.0.0:8001?test1=result1&test2=result2');
      });

      test('Should return IP address with assigned HTTP prefix, custom port and query parameters', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('0.0.0.0:8001?test1=result1&test2=result2').toString();

        expect(actualDomainUrl, 'http://0.0.0.0:8001?test1=result1&test2=result2');
      });
    });
  });

  group('Tests of method NetworkUtils.parseNoSchemeToHTTPS()', () {
    group('Domain names', () {
      // scheme: https, http, no scheme
      test('Should return domain name with HTTPS prefix and without trailing slash', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('https://testnet-rpc.kira.network/').toString();

        expect(actualDomainUrl, 'https://testnet-rpc.kira.network');
      });

      test('Should return domain name with HTTP prefix and without trailing slash', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('http://testnet-rpc.kira.network/').toString();

        expect(actualDomainUrl, 'http://testnet-rpc.kira.network');
      });

      test('Should return domain name with assigned HTTPS prefix', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('testnet-rpc.kira.network').toString();

        expect(actualDomainUrl, 'https://testnet-rpc.kira.network');
      });
    });

    group('IP addresses', () {
      // scheme: https, http, no scheme
      test('Should return IP address with HTTPS prefix and without trailing slash', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('https://192.168.0.1/').toString();

        expect(actualDomainUrl, 'https://192.168.0.1');
      });

      test('Should return IP address with HTTP prefix and without trailing slash', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('http://192.168.0.1/').toString();

        expect(actualDomainUrl, 'http://192.168.0.1');
      });

      test('Should return IP address with assigned HTTPS prefix', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('192.168.0.1').toString();

        expect(actualDomainUrl, 'https://192.168.0.1');
      });

      // custom port
      test('Should return IP address with HTTPS prefix, custom port and without trailing slash', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('https://192.168.0.1:8001/').toString();

        expect(actualDomainUrl, 'https://192.168.0.1:8001');
      });

      test('Should return IP address with HTTP prefix, custom port and without trailing slash', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('http://192.168.0.1:8001/').toString();

        expect(actualDomainUrl, 'http://192.168.0.1:8001');
      });

      test('Should return IP address with assigned HTTPS prefix, custom port', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('192.168.0.1:8001').toString();

        expect(actualDomainUrl, 'https://192.168.0.1:8001');
      });
    });

    group('localhost', () {
      // scheme: https, http, no scheme
      test('Should return localhost url with replaced prefix from HTTPS to HTTP and without trailing slash', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('https://localhost/').toString();

        expect(actualDomainUrl, 'http://localhost');
      });

      test('Should return localhost url with HTTP prefix and without trailing slash', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('http://localhost/').toString();

        expect(actualDomainUrl, 'http://localhost');
      });

      test('Should return localhost url with assigned HTTP prefix', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('localhost').toString();

        expect(actualDomainUrl, 'http://localhost');
      });

      // custom port
      test('Should return localhost url with replaced prefix from HTTPS to HTTP, custom port and without trailing slash', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('https://localhost:8001/').toString();

        expect(actualDomainUrl, 'http://localhost:8001');
      });

      test('Should return localhost url with HTTP prefix, custom port and without trailing slash', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('http://localhost:8001/').toString();

        expect(actualDomainUrl, 'http://localhost:8001');
      });

      test('Should return localhost url with assigned HTTP prefix and custom port', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('localhost:8001').toString();

        expect(actualDomainUrl, 'http://localhost:8001');
      });
    });

    group('localhost IP address (127.0.0.1)', () {
      // scheme: https, http, no scheme
      test('Should return IP address with replaced prefix from HTTPS to HTTP and without trailing slash', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('https://127.0.0.1/').toString();

        expect(actualDomainUrl, 'http://127.0.0.1');
      });

      test('Should return IP address with HTTP prefix and without trailing slash', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('http://127.0.0.1/').toString();

        expect(actualDomainUrl, 'http://127.0.0.1');
      });

      test('Should return IP address with assigned HTTP prefix', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('127.0.0.1').toString();

        expect(actualDomainUrl, 'http://127.0.0.1');
      });

      // custom port
      test('Should return IP address with replaced prefix from HTTPS to HTTP, custom port and without trailing slash', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('https://127.0.0.1:8001/').toString();

        expect(actualDomainUrl, 'http://127.0.0.1:8001');
      });

      test('Should return IP address with HTTP prefix, custom port and without trailing slash', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('http://127.0.0.1:8001/').toString();

        expect(actualDomainUrl, 'http://127.0.0.1:8001');
      });

      test('Should return IP address with assigned HTTP prefix and custom port', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('127.0.0.1:8001').toString();

        expect(actualDomainUrl, 'http://127.0.0.1:8001');
      });
    });

    group('localhost IP address (0.0.0.0)', () {
      // scheme: https, http, no scheme
      test('Should return IP address with replaced prefix from HTTPS to HTTP and without trailing slash', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('https://0.0.0.0/').toString();

        expect(actualDomainUrl, 'http://0.0.0.0');
      });

      test('Should return IP address with HTTP prefix and without trailing slash', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('http://0.0.0.0/').toString();

        expect(actualDomainUrl, 'http://0.0.0.0');
      });

      test('Should return IP address with assigned HTTP prefix', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('0.0.0.0').toString();

        expect(actualDomainUrl, 'http://0.0.0.0');
      });

      // custom port
      test('Should return IP address with replaced prefix from HTTPS to HTTP, custom port and without trailing slash', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('https://0.0.0.0:8001/').toString();

        expect(actualDomainUrl, 'http://0.0.0.0:8001');
      });

      test('Should return IP address with HTTP prefix, custom port and without trailing slash', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('http://0.0.0.0:8001/').toString();

        expect(actualDomainUrl, 'http://0.0.0.0:8001');
      });

      test('Should return IP address with assigned HTTP prefix and custom port', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('0.0.0.0:8001').toString();

        expect(actualDomainUrl, 'http://0.0.0.0:8001');
      });
    });
  });
}
