import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/blocs/pages/metamask/metamask_integration_provider.dart';
import 'package:provider/provider.dart';

class MetamaskIntegrationPage extends StatefulWidget {
  const MetamaskIntegrationPage({Key? key}) : super(key: key);

  @override
  State<MetamaskIntegrationPage> createState() => _MetamaskIntegrationPageState();
}

class _MetamaskIntegrationPageState extends State<MetamaskIntegrationPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MetaMaskProvider>(
      //Change the provider
      create: (BuildContext context) => MetaMaskProvider()..init(), //create an instant
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
          backgroundColor: const Color(0xFF181818),
          body: Stack(
            children: <Widget>[
              Center(
                child: Consumer<MetaMaskProvider>(
                  builder: (BuildContext context, MetaMaskProvider provider, Widget? child) {
                    late final String text; //check the state and display it

                    if (provider.isConnected) {
                      text = 'Connected'; //connected
                    } else if (provider.isEnabled) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text('Click the button...'),
                          const SizedBox(height: 8),
                          CupertinoButton(
                            onPressed: () async {
                              await context.read<MetaMaskProvider>().connect();
                            }, //call metamask on click
                            color: Colors.white,
                            padding: EdgeInsets.zero,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.network(
                                  'https://i0.wp.com/kindalame.com/wp-content/uploads/2021/05/metamask-fox-wordmark-horizontal.png?fit=1549%2C480&ssl=1',
                                  width: 300,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      text = 'Please use a Web3 supported browser.'; //please use web3 supported browser
                    }

                    return ShaderMask(
                      // a little bit of styling for text
                      shaderCallback: (Rect bounds) => const LinearGradient(
                        colors: <Color>[Colors.purple, Colors.blue, Colors.red],
                      ).createShader(bounds),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            text,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          const SizedBox(height: 8),
                          CupertinoButton(
                            onPressed: () async {
                              await context.read<MetaMaskProvider>().pay(
                                    to: '0xb83DF76e62980BDb0E324FC9Ce3e7bAF6309E7b5',
                                    amount: 1000000000000000000,
                                  );
                            }, //call metamask on click
                            color: Colors.white,
                            padding: EdgeInsets.zero,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text('Pay from ${context.read<MetaMaskProvider>().mainAddress}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Positioned.fill(
                child: IgnorePointer(
                  child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTicLAkhCzpJeu9OV-4GOO-BOon5aPGsj_wy9ETkR4g-BdAc8U2-TooYoiMcPcmcT48H7Y&usqp=CAU',
                    fit: BoxFit.cover,
                    opacity: const AlwaysStoppedAnimation<double>(0.025),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
