import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/utils/network_utils.dart';

void main() {
  group('Tests of method  parse() in Uri class', () {
    // Test method work with domains in different schemas
    test('Should return unchanged String value that is domain name of network via HTTPS', () async {
      expect(
        Uri.parse('https://testnet-rpc.kira.network/').toString(),
        'https://testnet-rpc.kira.network/',
      );
    });

    test('Should return unchanged String value that is domain name of network via HTTP', () async {
      expect(
        Uri.parse('http://testnet-rpc.kira.network/').toString(),
        'http://testnet-rpc.kira.network/',
      );
    });

    // Test method work with ip addresses in different schemas
    test('Should return unchanged String value that is IP address of network via HTTPS', () async {
      expect(
        Uri.parse('https://192.168.0.1/').toString(),
        'https://192.168.0.1/',
      );
    });
    test('Should return unchanged String value that is IP address of network via HTTP', () async {
      expect(
        Uri.parse('http://192.168.0.1/').toString(),
        'http://192.168.0.1/',
      );
    });

    // Method working with URL with port
    test('Should return unchanged String value that is IP address of network with PORT via HTTPS', () async {
      expect(
        Uri.parse('https://192.168.0.1:8001/').toString(),
        'https://192.168.0.1:8001/',
      );
    });

    test('Should return unchanged String value that is IP address of network with PORT via HTTP', () async {
      expect(
        Uri.parse('http://192.168.0.1:8001/').toString(),
        'http://192.168.0.1:8001/',
      );
    });
  });

  group('Tests of method parseUrl() in NetworkUtils class', () {
    // Test method work with with domains in different schemas
    test('Should return domain name with HTTPS prefix and no trailing slash', () async {
      expect(
        NetworkUtils.parseUrl('https://testnet-rpc.kira.network/').toString(),
        'https://testnet-rpc.kira.network',
      );
    });

    test('Should return domain name with HTTP prefix and no trailing slash', () async {
      expect(
        NetworkUtils.parseUrl('http://testnet-rpc.kira.network/').toString(),
        'http://testnet-rpc.kira.network',
      );
    });

    test('Should assign default HTTP prefix to URL if no schema is specified', () async {
      expect(
        NetworkUtils.parseUrl('testnet-rpc.kira.network').toString(),
        'http://testnet-rpc.kira.network',
      );
    });

    // Test method work with ip addresses in different schemas
    test('Should return ip address with HTTPS prefix, assign port 11000 by default and no trailing slash', () async {
      expect(
        NetworkUtils.parseUrl('https://192.168.0.1').toString(),
        'https://192.168.0.1:11000',
      );
    });

    test('Should return ip address with HTTP prefix, assign port 11000 by default and no trailing slash', () async {
      expect(
        NetworkUtils.parseUrl('http://192.168.0.1').toString(),
        'http://192.168.0.1:11000',
      );
    });

    test('Should assign default HTTP prefix to URL if no schema is specified', () async {
      expect(
        NetworkUtils.parseUrl('192.168.0.1').toString(),
        'http://192.168.0.1:11000',
      );
    });

    // Method working with URL with custom ports
    test('Should return ip address with HTTPS prefix with specified custom port and no trailing slash', () async {
      expect(
        NetworkUtils.parseUrl('https://192.168.0.1:8080/').toString(),
        'https://192.168.0.1:8080',
      );
    });

    test('Should return ip address with HTTP prefix with specified custom port and no trailing slash', () async {
      expect(
        NetworkUtils.parseUrl('http://192.168.0.1:8080/').toString(),
        'http://192.168.0.1:8080',
      );
    });

    test(
        'Should return ip address with assigned HTTPS prefix by default with specified custom port and no trailing slash',
        () async {
      expect(
        NetworkUtils.parseUrl('192.168.0.1:8080').toString(),
        'http://192.168.0.1:8080',
      );
    });

    // Method working with URL with query parameters
    test('Should return ip address with HTTPS prefix with specified custom port and with specified query parameters',
        () async {
      expect(
        NetworkUtils.parseUrl('https://192.168.0.1:8080?test1=result1&test2=result2').toString(),
        'https://192.168.0.1:8080?test1=result1&test2=result2',
      );
    });

    test('Should return domain name with HTTPS prefix with specified custom port and with specified query parameters',
        () async {
      expect(
        NetworkUtils.parseUrl('https://testnet-rpc.kira.network?test1=result1&test2=result2').toString(),
        'https://testnet-rpc.kira.network?test1=result1&test2=result2',
      );
    });

    test(
        'Should assign default HTTP prefix to URL and return ip address with query parameters if no schema is specified',
        () async {
      expect(
        NetworkUtils.parseUrl('192.168.0.1:8080?test1=result1&test2=result2').toString(),
        'http://192.168.0.1:8080?test1=result1&test2=result2',
      );
    });
  });
}
