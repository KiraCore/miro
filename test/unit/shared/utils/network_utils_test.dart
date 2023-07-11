import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/utils/network_utils.dart';

void main() {
  group('Tests of Uri.parse()', () {
    // domain name
    test('Should return [domain name] [with HTTPS]', () {
      String actualDomainUrl = Uri.parse('https://testnet-rpc.kira.network/').toString();

      expect(actualDomainUrl, 'https://testnet-rpc.kira.network/');
    });

    test('Should return [domain name] [with HTTP]', () {
      String actualDomainUrl = Uri.parse('http://testnet-rpc.kira.network/').toString();

      expect(actualDomainUrl, 'http://testnet-rpc.kira.network/');
    });

    // IP addresses without port
    test('Should return [IP address] [with HTTPS] and [without port]', () {
      String actualDomainUrl = Uri.parse('https://192.168.0.1/').toString();

      expect(actualDomainUrl, 'https://192.168.0.1/');
    });

    test('Should return [IP address] [with HTTP] and [without port]', () {
      String actualDomainUrl = Uri.parse('http://192.168.0.1/').toString();

      expect(actualDomainUrl, 'http://192.168.0.1/');
    });

    // IP addresses with port
    test('Should return [IP address] [with HTTPS] and [custom port]', () {
      String actualDomainUrl = Uri.parse('https://192.168.0.1:8001/').toString();

      expect(actualDomainUrl, 'https://192.168.0.1:8001/');
    });

    test('Should return [IP address] [with HTTP] and [custom port]', () {
      String actualDomainUrl = Uri.parse('http://192.168.0.1:8001/').toString();

      expect(actualDomainUrl, 'http://192.168.0.1:8001/');
    });
  });

  group('Tests of NetworkUtils.parseUrlToInterxUri()', () {
    group('Domains', () {
      // scheme: https, http, no scheme
      test('Should return [domain name] [with HTTPS] and [without trailing slash]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('https://testnet-rpc.kira.network/').toString();

        expect(actualDomainUrl, 'https://testnet-rpc.kira.network');
      });

      test('Should return [domain name] [with HTTP] and [without trailing slash]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('http://testnet-rpc.kira.network/').toString();

        expect(actualDomainUrl, 'http://testnet-rpc.kira.network');
      });

      test('Should return [domain name] [with added HTTPS]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('testnet-rpc.kira.network').toString();

        expect(actualDomainUrl, 'https://testnet-rpc.kira.network');
      });

      // query parameters
      test('Should return [domain name] [with HTTPS] and [query parameters]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('https://testnet-rpc.kira.network?test1=result1&test2=result2').toString();

        expect(actualDomainUrl, 'https://testnet-rpc.kira.network?test1=result1&test2=result2');
      });

      test('Should return [domain name] [with HTTP] and [query parameters]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('http://testnet-rpc.kira.network?test1=result1&test2=result2').toString();

        expect(actualDomainUrl, 'http://testnet-rpc.kira.network?test1=result1&test2=result2');
      });

      test('Should return [domain name] [with added HTTPS] and [query parameters]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('testnet-rpc.kira.network?test1=result1&test2=result2').toString();

        expect(actualDomainUrl, 'https://testnet-rpc.kira.network?test1=result1&test2=result2');
      });
    });

    group('External IP addresses', () {
      // scheme: https, http, no scheme
      test('Should return [IP address] [with HTTPS], [added port 11000] and [without trailing slash]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('https://192.168.0.1/').toString();

        expect(actualDomainUrl, 'https://192.168.0.1:11000');
      });

      test('Should return [IP address] [with HTTP], [added port 11000] and [without trailing slash]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('http://192.168.0.1/').toString();

        expect(actualDomainUrl, 'http://192.168.0.1:11000');
      });

      test('Should return [IP address] [with added HTTPS] and [added port 11000]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('192.168.0.1').toString();

        expect(actualDomainUrl, 'https://192.168.0.1:11000');
      });

      // custom port
      test('Should return [IP address] [with HTTPS], [custom port] and [without trailing slash]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('https://192.168.0.1:8001/').toString();

        expect(actualDomainUrl, 'https://192.168.0.1:8001');
      });

      test('Should return [IP address] [with HTTP], [custom port] and [without trailing slash]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('http://192.168.0.1:8001/').toString();

        expect(actualDomainUrl, 'http://192.168.0.1:8001');
      });

      test('Should return [IP address] [with added HTTPS] and [custom port]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('192.168.0.1:8001').toString();

        expect(actualDomainUrl, 'https://192.168.0.1:8001');
      });

      // query parameters
      test('Should return [IP address] [with HTTPS], [custom port] and [query parameters]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('https://192.168.0.1:8001?test1=result1&test2=result2').toString();

        expect(actualDomainUrl, 'https://192.168.0.1:8001?test1=result1&test2=result2');
      });

      test('Should return [IP address] [with HTTP], [custom port] and [query parameters]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('http://192.168.0.1:8001?test1=result1&test2=result2').toString();

        expect(actualDomainUrl, 'http://192.168.0.1:8001?test1=result1&test2=result2');
      });

      test('Should return [IP address] [with added HTTPS], [custom port] and [query parameters]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('192.168.0.1:8001?test1=result1&test2=result2').toString();

        expect(actualDomainUrl, 'https://192.168.0.1:8001?test1=result1&test2=result2');
      });
    });

    group('Localhost', () {
      // scheme: https, http, no scheme
      test('Should return [localhost url] [with replaced HTTPS to HTTP] and [without trailing slash]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('https://localhost/').toString();

        expect(actualDomainUrl, 'http://localhost');
      });

      test('Should return [localhost url] [with HTTP] and [without trailing slash]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('http://localhost/').toString();

        expect(actualDomainUrl, 'http://localhost');
      });

      test('Should return [localhost url] [with added HTTP]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('localhost').toString();

        expect(actualDomainUrl, 'http://localhost');
      });

      // custom port
      test('Should return [localhost url] [with replaced HTTPS to HTTP], [custom port] and [without trailing slash]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('https://localhost:8001/').toString();

        expect(actualDomainUrl, 'http://localhost:8001');
      });

      test('Should return [localhost url] [with HTTP], [custom port] and [without trailing slash]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('http://localhost:8001/').toString();

        expect(actualDomainUrl, 'http://localhost:8001');
      });

      test('Should return [localhost url] [with added HTTP] and [custom port]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('localhost:8001').toString();

        expect(actualDomainUrl, 'http://localhost:8001');
      });

      // query parameters
      test('Should return [localhost url] [with replaced HTTPS to HTTP], [custom port] and [query parameters]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('https://localhost:8001?test1=result1&test2=result2').toString();

        expect(actualDomainUrl, 'http://localhost:8001?test1=result1&test2=result2');
      });

      test('Should return [localhost url] [with HTTP], [custom port] and [query parameters]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('http://localhost:8001?test1=result1&test2=result2').toString();

        expect(actualDomainUrl, 'http://localhost:8001?test1=result1&test2=result2');
      });

      test('Should return [localhost url] [with added HTTP], [custom port] and [query parameters]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('localhost:8001?test1=result1&test2=result2').toString();

        expect(actualDomainUrl, 'http://localhost:8001?test1=result1&test2=result2');
      });
    });

    group('Local IP address (127.0.0.1)', () {
      // scheme: https, http, no scheme
      test('Should return [IP address] [with replaced HTTPS to HTTP] and [without trailing slash]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('https://127.0.0.1/').toString();

        expect(actualDomainUrl, 'http://127.0.0.1');
      });

      test('Should return [IP address] [with HTTP] and [without trailing slash]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('http://127.0.0.1/').toString();

        expect(actualDomainUrl, 'http://127.0.0.1');
      });

      test('Should return [IP address] [with added HTTP]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('127.0.0.1').toString();

        expect(actualDomainUrl, 'http://127.0.0.1');
      });

      // custom port
      test('Should return [IP address] [with replaced HTTPS to HTTP], [custom port] and [without trailing slash]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('https://127.0.0.1:8001/').toString();

        expect(actualDomainUrl, 'http://127.0.0.1:8001');
      });

      test('Should return [IP address] [with HTTP], [custom port] and [without trailing slash]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('http://127.0.0.1:8001/').toString();

        expect(actualDomainUrl, 'http://127.0.0.1:8001');
      });

      test('Should return [IP address] [with added HTTP] and [custom port]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('127.0.0.1:8001').toString();

        expect(actualDomainUrl, 'http://127.0.0.1:8001');
      });

      // query parameters
      test('Should return [IP address] [with replaced HTTPS to HTTP], [custom port] and [query parameters]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('https://127.0.0.1:8001?test1=result1&test2=result2').toString();

        expect(actualDomainUrl, 'http://127.0.0.1:8001?test1=result1&test2=result2');
      });

      test('Should return [IP address] [with HTTP], [custom port] and [query parameters]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('http://127.0.0.1:8001?test1=result1&test2=result2').toString();

        expect(actualDomainUrl, 'http://127.0.0.1:8001?test1=result1&test2=result2');
      });

      test('Should return [IP address] [with added HTTP], [custom port] and [query parameters]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('127.0.0.1:8001?test1=result1&test2=result2').toString();

        expect(actualDomainUrl, 'http://127.0.0.1:8001?test1=result1&test2=result2');
      });
    });

    group('Local IP address (0.0.0.0)', () {
      // scheme: https, http, no scheme
      test('Should return [IP address] [with replaced HTTPS to HTTP] and [without trailing slash]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('https://0.0.0.0/').toString();

        expect(actualDomainUrl, 'http://0.0.0.0');
      });

      test('Should return [IP address] [with HTTP] and [without trailing slash]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('http://0.0.0.0/').toString();

        expect(actualDomainUrl, 'http://0.0.0.0');
      });

      test('Should return [IP address] [with added HTTP]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('0.0.0.0').toString();

        expect(actualDomainUrl, 'http://0.0.0.0');
      });

      // custom port
      test('Should return [IP address] [with replaced HTTPS to HTTP], [custom port] and [without trailing slash]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('https://0.0.0.0:8001/').toString();

        expect(actualDomainUrl, 'http://0.0.0.0:8001');
      });

      test('Should return [IP address] [with HTTP], [custom port] and [without trailing slash]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('http://0.0.0.0:8001/').toString();

        expect(actualDomainUrl, 'http://0.0.0.0:8001');
      });

      test('Should return [IP address] [with added HTTP] and [custom port]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('0.0.0.0:8001').toString();

        expect(actualDomainUrl, 'http://0.0.0.0:8001');
      });

      // query parameters
      test('Should return [IP address] [with replaced HTTPS to HTTP], [custom port] and [query parameters]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('https://0.0.0.0:8001?test1=result1&test2=result2').toString();

        expect(actualDomainUrl, 'http://0.0.0.0:8001?test1=result1&test2=result2');
      });

      test('Should return [IP address] [with HTTP], [custom port] and [query parameters]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('http://0.0.0.0:8001?test1=result1&test2=result2').toString();

        expect(actualDomainUrl, 'http://0.0.0.0:8001?test1=result1&test2=result2');
      });

      test('Should return [IP address] [with added HTTP], [custom port] and [query parameters]', () {
        String actualDomainUrl = NetworkUtils.parseUrlToInterxUri('0.0.0.0:8001?test1=result1&test2=result2').toString();

        expect(actualDomainUrl, 'http://0.0.0.0:8001?test1=result1&test2=result2');
      });
    });
  });

  group('Tests of method NetworkUtils.parseNoSchemeToHTTPS()', () {
    group('Domains', () {
      // scheme: https, http, no scheme
      test('Should return [domain name] [with HTTPS] and [without trailing slash]', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('https://testnet-rpc.kira.network/').toString();

        expect(actualDomainUrl, 'https://testnet-rpc.kira.network');
      });

      test('Should return [domain name] [with HTTP] and [without trailing slash]', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('http://testnet-rpc.kira.network/').toString();

        expect(actualDomainUrl, 'http://testnet-rpc.kira.network');
      });

      test('Should return [domain name] [with added HTTPS]', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('testnet-rpc.kira.network').toString();

        expect(actualDomainUrl, 'https://testnet-rpc.kira.network');
      });
    });

    group('External IP addresses', () {
      // scheme: https, http, no scheme
      test('Should return [IP address] [with HTTPS] and [without trailing slash]', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('https://192.168.0.1/').toString();

        expect(actualDomainUrl, 'https://192.168.0.1');
      });

      test('Should return [IP address] [with HTTP] and [without trailing slash]', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('http://192.168.0.1/').toString();

        expect(actualDomainUrl, 'http://192.168.0.1');
      });

      test('Should return [IP address] [with added HTTPS]', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('192.168.0.1').toString();

        expect(actualDomainUrl, 'https://192.168.0.1');
      });

      // custom port
      test('Should return [IP address] [with HTTPS], [custom port] and [without trailing slash]', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('https://192.168.0.1:8001/').toString();

        expect(actualDomainUrl, 'https://192.168.0.1:8001');
      });

      test('Should return [IP address] [with HTTP], [custom port] and [without trailing slash]', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('http://192.168.0.1:8001/').toString();

        expect(actualDomainUrl, 'http://192.168.0.1:8001');
      });

      test('Should return [IP address] [with added HTTPS], [custom port]', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('192.168.0.1:8001').toString();

        expect(actualDomainUrl, 'https://192.168.0.1:8001');
      });
    });

    group('Localhost', () {
      // scheme: https, http, no scheme
      test('Should return [localhost url] [with replaced HTTPS to HTTP] and [without trailing slash]', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('https://localhost/').toString();

        expect(actualDomainUrl, 'http://localhost');
      });

      test('Should return [localhost url] [with HTTP] and [without trailing slash]', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('http://localhost/').toString();

        expect(actualDomainUrl, 'http://localhost');
      });

      test('Should return [localhost url] [with added HTTP]', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('localhost').toString();

        expect(actualDomainUrl, 'http://localhost');
      });

      // custom port
      test('Should return [localhost url] [with replaced HTTPS to HTTP], [custom port] and [without trailing slash]', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('https://localhost:8001/').toString();

        expect(actualDomainUrl, 'http://localhost:8001');
      });

      test('Should return [localhost url] [with HTTP], [custom port] and [without trailing slash]', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('http://localhost:8001/').toString();

        expect(actualDomainUrl, 'http://localhost:8001');
      });

      test('Should return [localhost url] [with added HTTP] and [custom port]', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('localhost:8001').toString();

        expect(actualDomainUrl, 'http://localhost:8001');
      });
    });

    group('Local IP address (127.0.0.1)', () {
      // scheme: https, http, no scheme
      test('Should return [IP address] [with added HTTPS to HTTP] and [without trailing slash]', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('https://127.0.0.1/').toString();

        expect(actualDomainUrl, 'http://127.0.0.1');
      });

      test('Should return [IP address] [with HTTP] and [without trailing slash]', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('http://127.0.0.1/').toString();

        expect(actualDomainUrl, 'http://127.0.0.1');
      });

      test('Should return [IP address] [with added HTTP]', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('127.0.0.1').toString();

        expect(actualDomainUrl, 'http://127.0.0.1');
      });

      // custom port
      test('Should return [IP address] [with replaced HTTPS to HTTP], [custom port] and [without trailing slash]', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('https://127.0.0.1:8001/').toString();

        expect(actualDomainUrl, 'http://127.0.0.1:8001');
      });

      test('Should return [IP address] [with HTTP], [custom port] and [without trailing slash]', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('http://127.0.0.1:8001/').toString();

        expect(actualDomainUrl, 'http://127.0.0.1:8001');
      });

      test('Should return [IP address] [with added HTTP] and [custom port]', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('127.0.0.1:8001').toString();

        expect(actualDomainUrl, 'http://127.0.0.1:8001');
      });
    });

    group('Local IP address (0.0.0.0)', () {
      // scheme: https, http, no scheme
      test('Should return [IP address] [with replaced HTTPS to HTTP] and [without trailing slash]', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('https://0.0.0.0/').toString();

        expect(actualDomainUrl, 'http://0.0.0.0');
      });

      test('Should return [IP address] [with HTTP] and [without trailing slash]', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('http://0.0.0.0/').toString();

        expect(actualDomainUrl, 'http://0.0.0.0');
      });

      test('Should return [IP address] [with added HTTP]', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('0.0.0.0').toString();

        expect(actualDomainUrl, 'http://0.0.0.0');
      });

      // custom port
      test('Should return [IP address] [with replaced HTTPS to HTTP], [custom port] and [without trailing slash]', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('https://0.0.0.0:8001/').toString();

        expect(actualDomainUrl, 'http://0.0.0.0:8001');
      });

      test('Should return [IP address] [with HTTP], [custom port] and [without trailing slash]', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('http://0.0.0.0:8001/').toString();

        expect(actualDomainUrl, 'http://0.0.0.0:8001');
      });

      test('Should return [IP address] [with added HTTP] and [custom port]', () {
        String actualDomainUrl = NetworkUtils.parseNoSchemeToHTTPS('0.0.0.0:8001').toString();

        expect(actualDomainUrl, 'http://0.0.0.0:8001');
      });
    });
  });

  group('Tests of NetworkUtils.isLocalhost()', () {
    test('Should return [true] for [localhost]', () {
      // Arrange
      Uri actualUri = Uri.parse('http://localhost/');

      // Act
      bool actualIsLocalhostBool = NetworkUtils.isLocalhost(actualUri);

      // Assert
      expect(actualIsLocalhostBool, true);
    });

    test('Should return [true] for [local IP address] (0.0.0.0)', () {
      // Arrange
      Uri actualUri = Uri.parse('http://0.0.0.0/');

      // Act
      bool actualIsLocalhostBool = NetworkUtils.isLocalhost(actualUri);

      // Assert
      expect(actualIsLocalhostBool, true);
    });

    test('Should return [true] for [local IP address] (127.0.0.1)', () {
      // Arrange
      Uri actualUri = Uri.parse('http://127.0.0.1/');

      // Act
      bool actualIsLocalhostBool = NetworkUtils.isLocalhost(actualUri);

      // Assert
      expect(actualIsLocalhostBool, true);
    });

    test('Should return [false] for [domain]', () {
      // Arrange
      Uri actualUri = Uri.parse('https://facebook.com/');

      // Act
      bool actualIsLocalhostBool = NetworkUtils.isLocalhost(actualUri);

      // Assert
      expect(actualIsLocalhostBool, false);
    });

    test('Should return [false] for [external IP address]', () {
      // Arrange
      Uri actualUri = Uri.parse('http://173.212.254.147/');

      // Act
      bool actualIsLocalhostBool = NetworkUtils.isLocalhost(actualUri);

      // Assert
      expect(actualIsLocalhostBool, false);
    });
  });

  group('Tests of NetworkUtils.compareUrisByUrn()', () {
    test('Should return [true] if URIs [equal]', () {
      // Arrange
      Uri actualUri1 = Uri.parse('http://173.212.254.147:11000');
      Uri actualUri2 = Uri.parse('http://173.212.254.147:11000');

      // Act
      bool actualUrnsEqualBool = NetworkUtils.compareUrisByUrn(actualUri1, actualUri2);

      // Assert
      expect(actualUrnsEqualBool, true);
    });

    test('Should return [true] if HOST and PARAMS [equal], SCHEME [not equal]', () {
      // Arrange
      Uri actualUri1 = Uri.parse('http://173.212.254.147:11000/path');
      Uri actualUri2 = Uri.parse('https://173.212.254.147:11000/path');

      // Act
      bool actualUrnsEqualBool = NetworkUtils.compareUrisByUrn(actualUri1, actualUri2);

      // Assert
      expect(actualUrnsEqualBool, true);
    });

    test('Should return [false] if SCHEME and HOST [equal], PARAMS [not equal]', () {
      // Arrange
      Uri actualUri1 = Uri.parse('http://173.212.254.147:11000/path');
      Uri actualUri2 = Uri.parse('http://173.212.254.147:11000/test');

      // Act
      bool actualUrnsEqualBool = NetworkUtils.compareUrisByUrn(actualUri1, actualUri2);

      // Assert
      expect(actualUrnsEqualBool, false);
    });

    test('Should return [false] if SCHEME, HOST and PARAMS [not equal]', () {
      // Arrange
      Uri actualUri1 = Uri.parse('http://173.212.254.147:11000/path');
      Uri actualUri2 = Uri.parse('https://65.108.86.252:11000/test');

      // Act
      bool actualUrnsEqualBool = NetworkUtils.compareUrisByUrn(actualUri1, actualUri2);

      // Assert
      expect(actualUrnsEqualBool, false);
    });

    test('Should return [true] if SCHEME, HOST and PARAMS [equal], PORTS [not equal]', () {
      // Arrange
      Uri actualUri1 = Uri.parse('http://173.212.254.147:11000/path');
      Uri actualUri2 = Uri.parse('http://173.212.254.147:40/path');

      // Act
      bool actualUrnsEqualBool = NetworkUtils.compareUrisByUrn(actualUri1, actualUri2);

      // Assert
      expect(actualUrnsEqualBool, false);
    });
  });

  group('Tests of NetworkUtils.removeScheme()', () {
    test('Should remove [http] SCHEME', () {
      // Act
      String actualUriWithRemovedScheme = NetworkUtils.removeScheme('http://173.212.254.147:11000/path');

      // Assert
      expect(actualUriWithRemovedScheme, '173.212.254.147:11000/path');
    });

    test('Should remove [https] SCHEME', () {
      // Act
      String actualUriWithRemovedScheme = NetworkUtils.removeScheme('https://173.212.254.147:11000/path');

      // Assert
      expect(actualUriWithRemovedScheme, '173.212.254.147:11000/path');
    });

    test('Should remove [ftp] SCHEME', () {
      // Act
      String actualUriWithRemovedScheme = NetworkUtils.removeScheme('ftp://173.212.254.147:11000/path');

      // Assert
      expect(actualUriWithRemovedScheme, '173.212.254.147:11000/path');
    });

    test('Should return same string on [empty] SCHEME', () {
      // Act
      String actualUriWithRemovedScheme = NetworkUtils.removeScheme('173.212.254.147:11000/path');

      // Assert
      expect(actualUriWithRemovedScheme, '173.212.254.147:11000/path');
    });
  });
}
