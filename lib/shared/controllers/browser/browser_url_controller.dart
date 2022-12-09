import 'package:flutter/foundation.dart';
import 'package:miro/shared/controllers/browser/browser_controller.dart';

/// Generic class responsible for controlling browser url.
/// It is used to:
/// - get current url from browser
/// 
/// - extract query parameters from url
///   e.g. For url: https://miro.kira.network/#/app/dashboard?rpc=http://testnet-rpc.kira.network&page=1&account=kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx
///   [extractQueryParameters] will return:
///   {
///      "rpc": "http://testnet-rpc.kira.network",
///      "page": "1",
///      "account": "kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx",
///    }
///    
/// - replace query parameters in url
///   e.g. For url: https://miro.kira.network/#/app/dashboard?rpc=http://192.168.8.100:11000
///   and query parameters map:
///   {
///     "rpc": "http://testnet-rpc.kira.network",
///     "page": "1",
///     "account": "kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx",
///   }
///   [replaceQueryParameters] will change url to:
///   https://miro.kira.network/#/app/dashboard?rpc=http://testnet-rpc.kira.network&page=1&account=kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx
class BrowserUrlController {
  const BrowserUrlController();
  
  Uri get uri {
    return Uri.base;
  }

  @protected
  set uri(Uri uri) {
    BrowserController.replaceUrl(uri);
  }

  /// Uri class doesn't recognize '#' as a valid url component, because of that

  /// - remove the '#' from the url before we can use this link to get current query parameters
  Map<String, dynamic> extractQueryParameters() {
    String uriWithoutHashText = uri.toString().replaceFirst('/#/', '/');
    Uri uriWithoutHash = Uri.parse(uriWithoutHashText);
    
    // [uriWithoutHash.queryParameters] is an unmodifiable map, so we need to copy it to a new modifiable map
    return Map<String, dynamic>.from(uriWithoutHash.queryParameters);
  }

  /// - temporarily replace the '#' with some other value, set query parameters, and then revert the '#' back to its original value
  void replaceQueryParameters(Map<String, dynamic> queryParameters) {
    String hashReplacement = 'bcb258b7-d714-42c6-b69e-b78cdb9a6cfe';

    Uri uriWithoutHash = Uri.parse(uri.toString().replaceFirst('/#/', '/$hashReplacement/'));
    uriWithoutHash = uriWithoutHash.replace(queryParameters: queryParameters);

    Uri uriWithNewQueryParameters = Uri.parse(uriWithoutHash.toString().replaceFirst('/$hashReplacement/', '/#/'));
    uri = uriWithNewQueryParameters;
  }
}
