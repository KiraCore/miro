import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/shared/models/network_visualiser/node_localization.dart';
import 'package:miro/shared/models/network_visualiser/node_model.dart';
import 'package:miro/views/widgets/generic/visualiser_map/visualiser_map.dart';

class NetworkVisualiserPage extends StatelessWidget {
  const NetworkVisualiserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: VisualiserMap(
          nodeModels: <NodeModel>[
            NodeModel(
              ip: '18.135.115.225',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.751,
                  lng: -97.822,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '163.172.83.39',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'FR',
                  countryName: 'France',
                  lat: 48.8582,
                  lng: 2.3387000000000002,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '163.172.59.133',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'FR',
                  countryName: 'France',
                  lat: 48.8582,
                  lng: 2.3387000000000002,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '194.163.139.50',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '45.140.185.136',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'null',
                  countryName: 'null',
                  lat: 0,
                  lng: 0,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '130.185.119.129',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 32.7787,
                  lng: -96.8217,
                  city: 'null',
                  postal: 'null',
                  state: 'Texas'),
            ),
            NodeModel(
              ip: '194.163.161.234',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '45.85.146.3',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'null',
                  countryName: 'null',
                  lat: 0,
                  lng: 0,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '38.242.215.75',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.751,
                  lng: -97.822,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '62.171.141.103',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'GB',
                  countryName: 'United Kingdom',
                  lat: 51.4964,
                  lng: -0.1224,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '5.189.177.161',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 49.4075,
                  lng: 11.1649,
                  city: 'Nuremberg',
                  postal: '90475',
                  state: 'Bavaria'),
            ),
            NodeModel(
              ip: '142.132.201.36',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'CA',
                  countryName: 'Canada',
                  lat: 49.898,
                  lng: -97.1401,
                  city: 'Winnipeg',
                  postal: 'R3B',
                  state: 'Manitoba'),
            ),
            NodeModel(
              ip: '62.171.174.169',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'GB',
                  countryName: 'United Kingdom',
                  lat: 51.4964,
                  lng: -0.1224,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '5.9.120.155',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '185.237.252.201',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 34.0494,
                  lng: -118.2641,
                  city: 'Los Angeles',
                  postal: '90014',
                  state: 'California'),
            ),
            NodeModel(
              ip: '176.57.189.249',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 50.1137,
                  lng: 8.7119,
                  city: 'Frankfurt am Main',
                  postal: '60314',
                  state: 'Hesse'),
            ),
            NodeModel(
              ip: '173.249.21.151',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 49.4075,
                  lng: 11.1649,
                  city: 'Nuremberg',
                  postal: '90475',
                  state: 'Bavaria'),
            ),
            NodeModel(
              ip: '5.182.17.100',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'null',
                  countryName: 'null',
                  lat: 0,
                  lng: 0,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '173.212.234.46',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 49.4075,
                  lng: 11.1649,
                  city: 'Nuremberg',
                  postal: '90475',
                  state: 'Bavaria'),
            ),
            NodeModel(
              ip: '144.76.70.190',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '173.212.232.104',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 49.4075,
                  lng: 11.1649,
                  city: 'Nuremberg',
                  postal: '90475',
                  state: 'Bavaria'),
            ),
            NodeModel(
              ip: '167.86.78.246',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.751,
                  lng: -97.822,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '148.251.181.132',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '161.97.121.49',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 39.9914,
                  lng: -105.2392,
                  city: 'Boulder',
                  postal: '80303',
                  state: 'Colorado'),
            ),
            NodeModel(
              ip: '144.91.110.235',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.7811,
                  lng: -122.1866,
                  city: 'Oakland',
                  postal: '94613',
                  state: 'California'),
            ),
            NodeModel(
              ip: '163.172.62.131',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'FR',
                  countryName: 'France',
                  lat: 48.8582,
                  lng: 2.3387000000000002,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '85.190.254.164',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '194.163.159.203',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '62.171.152.12',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'GB',
                  countryName: 'United Kingdom',
                  lat: 51.4964,
                  lng: -0.1224,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '194.34.232.24',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.751,
                  lng: -97.822,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '65.108.225.106',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 42.6496,
                  lng: -71.1565,
                  city: 'Andover',
                  postal: '01810',
                  state: 'Massachusetts'),
            ),
            NodeModel(
              ip: '207.180.213.114',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 49.4075,
                  lng: 11.1649,
                  city: 'Nuremberg',
                  postal: '90475',
                  state: 'Bavaria'),
            ),
            NodeModel(
              ip: '65.108.91.148',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 42.6496,
                  lng: -71.1565,
                  city: 'Andover',
                  postal: '01810',
                  state: 'Massachusetts'),
            ),
            NodeModel(
              ip: '94.16.111.103',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '65.21.33.28',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.751,
                  lng: -97.822,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '91.142.79.25',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'RU',
                  countryName: 'Russia',
                  lat: 55.7386,
                  lng: 37.6068,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '185.144.99.59',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'RU',
                  countryName: 'Russia',
                  lat: 42.9753,
                  lng: 47.5022,
                  city: 'Makhachkala',
                  postal: '367013',
                  state: 'Dagestan'),
            ),
            NodeModel(
              ip: '5.189.183.214',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 49.4075,
                  lng: 11.1649,
                  city: 'Nuremberg',
                  postal: '90475',
                  state: 'Bavaria'),
            ),
            NodeModel(
              ip: '83.171.249.20',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '178.205.143.239',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'RU',
                  countryName: 'Russia',
                  lat: 55.7679,
                  lng: 49.1631,
                  city: 'Kazan’',
                  postal: '422525',
                  state: 'Tatarstan Republic'),
            ),
            NodeModel(
              ip: '146.120.161.147',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'NL',
                  countryName: 'Netherlands',
                  lat: 52.3824,
                  lng: 4.8995,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '45.89.88.184',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'null',
                  countryName: 'null',
                  lat: 0,
                  lng: 0,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '144.91.116.30',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.7811,
                  lng: -122.1866,
                  city: 'Oakland',
                  postal: '94613',
                  state: 'California'),
            ),
            NodeModel(
              ip: '5.161.120.11',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'AE',
                  countryName: 'United Arab Emirates',
                  lat: 24,
                  lng: 54,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '176.105.214.71',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'UA',
                  countryName: 'Ukraine',
                  lat: 49.7576,
                  lng: 27.2034,
                  city: 'Starokostiantyniv',
                  postal: '31100',
                  state: 'Khmelnytska Oblast'),
            ),
            NodeModel(
              ip: '194.156.79.23',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'IQ',
                  countryName: 'Iraq',
                  lat: 33,
                  lng: 44,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '51.195.254.71',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'FR',
                  countryName: 'France',
                  lat: 48.8582,
                  lng: 2.3387000000000002,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '109.238.12.46',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'FR',
                  countryName: 'France',
                  lat: 48.8582,
                  lng: 2.3387000000000002,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '185.246.84.53',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'FR',
                  countryName: 'France',
                  lat: 48.8582,
                  lng: 2.3387000000000002,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '62.122.168.232',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'CZ',
                  countryName: 'Czechia',
                  lat: 50.0848,
                  lng: 14.411200000000001,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '135.125.202.134',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.751,
                  lng: -97.822,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '161.97.175.86',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 39.9914,
                  lng: -105.2392,
                  city: 'Boulder',
                  postal: '80303',
                  state: 'Colorado'),
            ),
            NodeModel(
              ip: '185.137.122.74',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '185.217.125.98',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.751,
                  lng: -97.822,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '161.97.132.107',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 39.9914,
                  lng: -105.2392,
                  city: 'Boulder',
                  postal: '80303',
                  state: 'Colorado'),
            ),
            NodeModel(
              ip: '194.163.143.204',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '75.119.153.120',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.751,
                  lng: -97.822,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '202.61.195.79',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'AU',
                  countryName: 'Australia',
                  lat: -33.494,
                  lng: 143.2104,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '75.119.146.31',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.751,
                  lng: -97.822,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '85.10.201.123',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 49.4478,
                  lng: 11.0683,
                  city: 'Nuremberg',
                  postal: '90455',
                  state: 'Bavaria'),
            ),
            NodeModel(
              ip: '161.97.164.68',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 39.9914,
                  lng: -105.2392,
                  city: 'Boulder',
                  postal: '80303',
                  state: 'Colorado'),
            ),
            NodeModel(
              ip: '94.250.202.83',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '89.58.6.93',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '144.76.14.215',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '109.205.181.158',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '75.119.143.187',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.751,
                  lng: -97.822,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '194.163.174.194',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '194.163.139.207',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '194.163.160.71',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '178.18.254.183',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '161.97.138.27',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 39.9914,
                  lng: -105.2392,
                  city: 'Boulder',
                  postal: '80303',
                  state: 'Colorado'),
            ),
            NodeModel(
              ip: '38.242.201.71',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.751,
                  lng: -97.822,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '185.232.68.242',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'AT',
                  countryName: 'Austria',
                  lat: 48.2,
                  lng: 16.3667,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '176.9.48.61',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '168.119.67.71',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.751,
                  lng: -97.822,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '185.239.208.254',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.751,
                  lng: -97.822,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '178.18.247.21',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '38.242.209.219',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.751,
                  lng: -97.822,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '49.12.121.152',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '161.97.84.58',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 39.9914,
                  lng: -105.2392,
                  city: 'Boulder',
                  postal: '80303',
                  state: 'Colorado'),
            ),
            NodeModel(
              ip: '144.76.100.138',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '46.4.120.105',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '161.97.77.219',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 39.9914,
                  lng: -105.2392,
                  city: 'Boulder',
                  postal: '80303',
                  state: 'Colorado'),
            ),
            NodeModel(
              ip: '173.212.227.165',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 49.4075,
                  lng: 11.1649,
                  city: 'Nuremberg',
                  postal: '90475',
                  state: 'Bavaria'),
            ),
            NodeModel(
              ip: '178.18.247.79',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '167.86.78.98',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.751,
                  lng: -97.822,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '5.189.131.118',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 49.4075,
                  lng: 11.1649,
                  city: 'Nuremberg',
                  postal: '90475',
                  state: 'Bavaria'),
            ),
            NodeModel(
              ip: '75.119.135.110',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.751,
                  lng: -97.822,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '148.251.121.25',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '79.143.183.91',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 48.1089,
                  lng: 11.6074,
                  city: 'Munich',
                  postal: '81549',
                  state: 'Bavaria'),
            ),
            NodeModel(
              ip: '161.97.80.198',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 39.9914,
                  lng: -105.2392,
                  city: 'Boulder',
                  postal: '80303',
                  state: 'Colorado'),
            ),
            NodeModel(
              ip: '161.97.180.14',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 39.9914,
                  lng: -105.2392,
                  city: 'Boulder',
                  postal: '80303',
                  state: 'Colorado'),
            ),
            NodeModel(
              ip: '194.163.131.181',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '173.212.230.144',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 49.4075,
                  lng: 11.1649,
                  city: 'Nuremberg',
                  postal: '90475',
                  state: 'Bavaria'),
            ),
            NodeModel(
              ip: '45.88.189.92',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'null',
                  countryName: 'null',
                  lat: 0,
                  lng: 0,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '75.119.156.204',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.751,
                  lng: -97.822,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '62.171.161.7',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'GB',
                  countryName: 'United Kingdom',
                  lat: 51.4964,
                  lng: -0.1224,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '94.130.128.236',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '164.68.118.40',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 42.2374,
                  lng: -87.8482,
                  city: 'Lake Forest',
                  postal: '60045',
                  state: 'Illinois'),
            ),
            NodeModel(
              ip: '5.9.23.231',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '164.68.113.153',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 42.2374,
                  lng: -87.8482,
                  city: 'Lake Forest',
                  postal: '60045',
                  state: 'Illinois'),
            ),
            NodeModel(
              ip: '161.97.77.52',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 39.9914,
                  lng: -105.2392,
                  city: 'Boulder',
                  postal: '80303',
                  state: 'Colorado'),
            ),
            NodeModel(
              ip: '5.189.184.249',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 49.4075,
                  lng: 11.1649,
                  city: 'Nuremberg',
                  postal: '90475',
                  state: 'Bavaria'),
            ),
            NodeModel(
              ip: '185.213.27.57',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'NL',
                  countryName: 'Netherlands',
                  lat: 52.3824,
                  lng: 4.8995,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '173.249.1.76',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 49.4075,
                  lng: 11.1649,
                  city: 'Nuremberg',
                  postal: '90475',
                  state: 'Bavaria'),
            ),
            NodeModel(
              ip: '173.212.197.125',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 49.4075,
                  lng: 11.1649,
                  city: 'Nuremberg',
                  postal: '90475',
                  state: 'Bavaria'),
            ),
            NodeModel(
              ip: '75.119.138.182',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.751,
                  lng: -97.822,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '167.86.109.227',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 49.4075,
                  lng: 11.1649,
                  city: 'Nuremberg',
                  postal: '90475',
                  state: 'Bavaria'),
            ),
            NodeModel(
              ip: '38.242.196.220',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.751,
                  lng: -97.822,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '173.212.254.147',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 49.4075,
                  lng: 11.1649,
                  city: 'Nuremberg',
                  postal: '90475',
                  state: 'Bavaria'),
            ),
            NodeModel(
              ip: '185.211.5.96',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.751,
                  lng: -97.822,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '38.242.246.71',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.751,
                  lng: -97.822,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '75.119.144.28',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.751,
                  lng: -97.822,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '202.61.227.181',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'AU',
                  countryName: 'Australia',
                  lat: -33.494,
                  lng: 143.2104,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '202.61.226.161',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'AU',
                  countryName: 'Australia',
                  lat: -33.494,
                  lng: 143.2104,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '161.97.185.219',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 39.9914,
                  lng: -105.2392,
                  city: 'Boulder',
                  postal: '80303',
                  state: 'Colorado'),
            ),
            NodeModel(
              ip: '167.86.98.93',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 49.4075,
                  lng: 11.1649,
                  city: 'Nuremberg',
                  postal: '90475',
                  state: 'Bavaria'),
            ),
            NodeModel(
              ip: '178.18.245.143',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '167.86.105.134',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 49.4075,
                  lng: 11.1649,
                  city: 'Nuremberg',
                  postal: '90475',
                  state: 'Bavaria'),
            ),
            NodeModel(
              ip: '188.40.207.181',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '194.163.182.222',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '38.242.200.159',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.751,
                  lng: -97.822,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '167.86.91.80',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 49.4075,
                  lng: 11.1649,
                  city: 'Nuremberg',
                  postal: '90475',
                  state: 'Bavaria'),
            ),
            NodeModel(
              ip: '78.46.94.29',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '173.249.1.183',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 49.4075,
                  lng: 11.1649,
                  city: 'Nuremberg',
                  postal: '90475',
                  state: 'Bavaria'),
            ),
            NodeModel(
              ip: '65.108.98.125',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 42.6496,
                  lng: -71.1565,
                  city: 'Andover',
                  postal: '01810',
                  state: 'Massachusetts'),
            ),
            NodeModel(
              ip: '65.108.66.204',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 42.6496,
                  lng: -71.1565,
                  city: 'Andover',
                  postal: '01810',
                  state: 'Massachusetts'),
            ),
            NodeModel(
              ip: '65.108.96.159',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 42.6496,
                  lng: -71.1565,
                  city: 'Andover',
                  postal: '01810',
                  state: 'Massachusetts'),
            ),
            NodeModel(
              ip: '65.21.198.194',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.751,
                  lng: -97.822,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '65.108.105.29',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 42.6496,
                  lng: -71.1565,
                  city: 'Andover',
                  postal: '01810',
                  state: 'Massachusetts'),
            ),
            NodeModel(
              ip: '65.21.253.230',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.751,
                  lng: -97.822,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '164.68.97.65',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 42.2374,
                  lng: -87.8482,
                  city: 'Lake Forest',
                  postal: '60045',
                  state: 'Illinois'),
            ),
            NodeModel(
              ip: '178.170.42.24',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'FR',
                  countryName: 'France',
                  lat: 48.8582,
                  lng: 2.3387000000000002,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '192.145.47.85',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '65.21.198.195',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.751,
                  lng: -97.822,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '185.207.250.70',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 34.0494,
                  lng: -118.2641,
                  city: 'Los Angeles',
                  postal: '90014',
                  state: 'California'),
            ),
            NodeModel(
              ip: '65.21.253.144',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.751,
                  lng: -97.822,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '65.21.135.33',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.751,
                  lng: -97.822,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '65.108.88.36',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 42.6496,
                  lng: -71.1565,
                  city: 'Andover',
                  postal: '01810',
                  state: 'Massachusetts'),
            ),
            NodeModel(
              ip: '65.108.12.214',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 42.6496,
                  lng: -71.1565,
                  city: 'Andover',
                  postal: '01810',
                  state: 'Massachusetts'),
            ),
            NodeModel(
              ip: '38.242.203.221',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.751,
                  lng: -97.822,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '94.250.203.36',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '65.21.106.36',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.751,
                  lng: -97.822,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '65.21.135.34',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.751,
                  lng: -97.822,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '185.214.134.193',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.751,
                  lng: -97.822,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '135.181.141.189',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'CA',
                  countryName: 'Canada',
                  lat: 43.6319,
                  lng: -79.3716,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '194.163.139.206',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '202.61.229.75',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'AU',
                  countryName: 'Australia',
                  lat: -33.494,
                  lng: 143.2104,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '65.21.133.149',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.751,
                  lng: -97.822,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '161.97.146.1',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 39.9914,
                  lng: -105.2392,
                  city: 'Boulder',
                  postal: '80303',
                  state: 'Colorado'),
            ),
            NodeModel(
              ip: '65.108.125.188',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 42.6496,
                  lng: -71.1565,
                  city: 'Andover',
                  postal: '01810',
                  state: 'Massachusetts'),
            ),
            NodeModel(
              ip: '80.76.235.196',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'RU',
                  countryName: 'Russia',
                  lat: 55.7522,
                  lng: 37.6156,
                  city: 'Moscow',
                  postal: '102292',
                  state: 'Moscow'),
            ),
            NodeModel(
              ip: '173.212.217.36',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 49.4075,
                  lng: 11.1649,
                  city: 'Nuremberg',
                  postal: '90475',
                  state: 'Bavaria'),
            ),
            NodeModel(
              ip: '188.120.232.232',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'RU',
                  countryName: 'Russia',
                  lat: 55.7386,
                  lng: 37.6068,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '185.144.99.47',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'RU',
                  countryName: 'Russia',
                  lat: 42.9753,
                  lng: 47.5022,
                  city: 'Makhachkala',
                  postal: '367013',
                  state: 'Dagestan'),
            ),
            NodeModel(
              ip: '217.197.124.9',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'RU',
                  countryName: 'Russia',
                  lat: 55.7522,
                  lng: 37.6156,
                  city: 'Moscow',
                  postal: '127434',
                  state: 'Moscow'),
            ),
            NodeModel(
              ip: '173.249.46.52',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 49.4075,
                  lng: 11.1649,
                  city: 'Nuremberg',
                  postal: '90475',
                  state: 'Bavaria'),
            ),
            NodeModel(
              ip: '185.144.99.31',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'RU',
                  countryName: 'Russia',
                  lat: 42.9753,
                  lng: 47.5022,
                  city: 'Makhachkala',
                  postal: '367013',
                  state: 'Dagestan'),
            ),
            NodeModel(
              ip: '185.226.113.55',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'UA',
                  countryName: 'Ukraine',
                  lat: 46.4775,
                  lng: 30.7326,
                  city: 'Odesa',
                  postal: '65059',
                  state: 'Odessa'),
            ),
            NodeModel(
              ip: '138.201.127.219',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 48.0458,
                  lng: 9.9669,
                  city: 'Oberstetten',
                  postal: '88416',
                  state: 'Baden-Württemberg Region'),
            ),
            NodeModel(
              ip: '194.163.132.244',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '194.242.56.246',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'null',
                  countryName: 'null',
                  lat: 0,
                  lng: 0,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '167.86.96.211',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 49.4075,
                  lng: 11.1649,
                  city: 'Nuremberg',
                  postal: '90475',
                  state: 'Bavaria'),
            ),
            NodeModel(
              ip: '144.76.219.187',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '91.238.228.56',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'RU',
                  countryName: 'Russia',
                  lat: 59.8944,
                  lng: 30.2642,
                  city: 'St Petersburg',
                  postal: '190985',
                  state: 'St.-Petersburg'),
            ),
            NodeModel(
              ip: '5.9.83.147',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '65.21.135.32',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.751,
                  lng: -97.822,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '167.86.97.190',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 49.4075,
                  lng: 11.1649,
                  city: 'Nuremberg',
                  postal: '90475',
                  state: 'Bavaria'),
            ),
            NodeModel(
              ip: '94.41.17.129',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'RU',
                  countryName: 'Russia',
                  lat: 54.7852,
                  lng: 56.0456,
                  city: 'Ufa',
                  postal: '450000',
                  state: 'Bashkortostan Republic'),
            ),
            NodeModel(
              ip: '194.163.141.23',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 51.2993,
                  lng: 9.491,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '65.108.11.167',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 42.6496,
                  lng: -71.1565,
                  city: 'Andover',
                  postal: '01810',
                  state: 'Massachusetts'),
            ),
            NodeModel(
              ip: '91.238.230.15',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'RU',
                  countryName: 'Russia',
                  lat: 59.8944,
                  lng: 30.2642,
                  city: 'St Petersburg',
                  postal: '190985',
                  state: 'St.-Petersburg'),
            ),
            NodeModel(
              ip: '161.97.145.130',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 39.9914,
                  lng: -105.2392,
                  city: 'Boulder',
                  postal: '80303',
                  state: 'Colorado'),
            ),
            NodeModel(
              ip: '128.0.139.225',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'RU',
                  countryName: 'Russia',
                  lat: 55.7522,
                  lng: 37.6156,
                  city: 'Moscow',
                  postal: '102292',
                  state: 'Moscow'),
            ),
            NodeModel(
              ip: '65.108.100.223',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 42.6496,
                  lng: -71.1565,
                  city: 'Andover',
                  postal: '01810',
                  state: 'Massachusetts'),
            ),
            NodeModel(
              ip: '51.120.80.82',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'GB',
                  countryName: 'United Kingdom',
                  lat: 51.4964,
                  lng: -0.1224,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '3.11.224.235',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'GB',
                  countryName: 'United Kingdom',
                  lat: 51.5161,
                  lng: -0.0949,
                  city: 'London',
                  postal: 'EC2V',
                  state: 'England'),
            ),
            NodeModel(
              ip: '167.86.98.24',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'DE',
                  countryName: 'Germany',
                  lat: 49.4075,
                  lng: 11.1649,
                  city: 'Nuremberg',
                  postal: '90475',
                  state: 'Bavaria'),
            ),
            NodeModel(
              ip: '158.69.30.150',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'CA',
                  countryName: 'Canada',
                  lat: 45.5,
                  lng: -73.5833,
                  city: 'Montreal',
                  postal: 'H3G',
                  state: 'Quebec'),
            ),
            NodeModel(
              ip: '95.217.60.125',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'FI',
                  countryName: 'Finland',
                  lat: 60.1708,
                  lng: 24.9375,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '167.114.86.237',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'CA',
                  countryName: 'Canada',
                  lat: 45.504,
                  lng: -73.5747,
                  city: 'Montreal',
                  postal: 'H3A',
                  state: 'Quebec'),
            ),
            NodeModel(
              ip: '65.108.98.124',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 42.6496,
                  lng: -71.1565,
                  city: 'Andover',
                  postal: '01810',
                  state: 'Massachusetts'),
            ),
            NodeModel(
              ip: '188.127.253.221',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'RU',
                  countryName: 'Russia',
                  lat: 55.7386,
                  lng: 37.6068,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '144.126.130.207',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 39.3507,
                  lng: -76.6321,
                  city: 'Baltimore',
                  postal: '21210',
                  state: 'Maryland'),
            ),
            NodeModel(
              ip: '161.97.156.175',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 39.9914,
                  lng: -105.2392,
                  city: 'Boulder',
                  postal: '80303',
                  state: 'Colorado'),
            ),
            NodeModel(
              ip: '80.254.102.127',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'RU',
                  countryName: 'Russia',
                  lat: 47.2364,
                  lng: 39.7139,
                  city: 'Rostov-on-Don',
                  postal: '344065',
                  state: 'Rostov'),
            ),
            NodeModel(
              ip: '154.53.51.220',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.751,
                  lng: -97.822,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '209.126.2.170',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 38.7033,
                  lng: -90.4618,
                  city: 'St Louis',
                  postal: '63146',
                  state: 'Missouri'),
            ),
            NodeModel(
              ip: '176.65.61.156',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'RU',
                  countryName: 'Russia',
                  lat: 56.5,
                  lng: 84.9667,
                  city: 'Tomsk',
                  postal: '634026',
                  state: 'Tomsk Oblast'),
            ),
            NodeModel(
              ip: '91.105.131.140',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'RU',
                  countryName: 'Russia',
                  lat: 55.7386,
                  lng: 37.6068,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '185.208.206.119',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.751,
                  lng: -97.822,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '15.235.40.226',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 37.751,
                  lng: -97.822,
                  city: 'null',
                  postal: 'null',
                  state: 'null'),
            ),
            NodeModel(
              ip: '144.126.143.220',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'US',
                  countryName: 'United States',
                  lat: 39.3507,
                  lng: -76.6321,
                  city: 'Baltimore',
                  postal: '21210',
                  state: 'Maryland'),
            ),
            NodeModel(
              ip: '158.69.30.145',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'CA',
                  countryName: 'Canada',
                  lat: 45.5,
                  lng: -73.5833,
                  city: 'Montreal',
                  postal: 'H3G',
                  state: 'Quebec'),
            ),
            NodeModel(
              ip: '207.148.91.79',
              nodeLocalization: const NodeLocalization(
                  countryCode: 'JP',
                  countryName: 'Japan',
                  lat: 35.609,
                  lng: 139.7302,
                  city: 'Shinagawa',
                  postal: '141-0033',
                  state: 'Tokyo'),
            ),
          ],
        ),
      ),
    );

    // return Scaffold(
    //   body: Consumer<NetworkProvider>(
    //     builder: (_, NetworkProvider networkProvider, Widget ? child) {
    //       if (!networkProvider.isConnected) {
    //         return Text('No connection: ${networkProvider.state}');
    //       }
    //       return FutureBuilder<List<NodeModel>>(
    //         future: globalLocator<P2PListService>().getPubNodes(),
    //         builder: (BuildContext context, AsyncSnapshot<List<NodeModel>> snapshot) {
    //           if (snapshot.connectionState == ConnectionState.waiting) {
    //             return const CenterLoadSpinner();
    //           }
    //
    //           );
    //         },
    //       );
    //     },
    //   )
    //   ,
    // );
  }
}

class VisualiserLoaded extends StatefulWidget {
  final List<NodeModel> nodeModels;

  const VisualiserLoaded({
    required this.nodeModels,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VisualiserLoaded();
}

class _VisualiserLoaded extends State<VisualiserLoaded> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const TabBar(
          tabs: <Tab>[
            Tab(text: 'list'),
            Tab(text: 'map'),
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            VisualiserList(nodeModels: widget.nodeModels),
            // VisualiserMap(nodeModels: widget.nodeModels),
          ],
        ),
      ),
    );
  }
}

class VisualiserList extends StatelessWidget {
  final List<NodeModel> nodeModels;

  const VisualiserList({
    required this.nodeModels,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: ListView.builder(
        itemCount: nodeModels.length,
        itemBuilder: (BuildContext context, int index) {
          NodeModel nodeModel = nodeModels[index];
          return ListTile(
            title: SelectableText(nodeModel.ip),
            subtitle: Text(
              nodeModel.nodeLocalization.toString(),
            ),
          );
        },
      ),
    );
  }
}

// class VisualiserMap extends StatefulWidget {
//   final List<NodeModel> nodeModels;
//
//   const VisualiserMap({
//     required this.nodeModels,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => _VisualiserMap();
// }
//
// class _VisualiserMap extends State<VisualiserMap> {
//   late VectorMapController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VectorMapController();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     VectorMap map = VectorMap(controller: _controller);
//     return map;
//   }
// }
