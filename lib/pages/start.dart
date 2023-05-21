import 'package:barrier_free_kiosk/provider/cart_provider.dart';
import 'package:barrier_free_kiosk/provider/config_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<CartProvider>().initialize();
    final isConfigCompleted = context.read<ConfigProvider>().isConfigComplete;
    navigate() => Navigator.pushNamed(context, '/settings');

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Builder(
        builder: (context) => GestureDetector(
          onTap: () {
            // there is button in child, but for better experience, any part touch will work like button
            isConfigCompleted
                ? Navigator.pushNamed(context, '/order')
                : ScaffoldMessenger.of(context)
                    .showSnackBar(createConfigSnackBar(navigate));
          },
          child: Container(
            constraints: const BoxConstraints.expand(),
            color: const Color.fromARGB(0, 0, 0, 0),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        isConfigCompleted
                            ? Navigator.pushNamed(context, '/order')
                            : ScaffoldMessenger.of(context)
                                .showSnackBar(createConfigSnackBar(navigate));
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                        ),
                        child: const Text(
                          "주문하기",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 100, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  right: 30,
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          isConfigCompleted
                              ? Navigator.pushNamed(context, '/blindhelp')
                              : null;
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(color: Colors.white70, width: 4),
                          ),
                          child: const Icon(
                            Icons.blind_rounded,
                            color: Colors.white70,
                            size: 50,
                          ),
                        ),
                      ),
                      const SizedBox(width: 30),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/settings');
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(color: Colors.white70, width: 4),
                          ),
                          child: const Icon(
                            Icons.settings,
                            color: Colors.white70,
                            size: 50,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

SnackBar createConfigSnackBar(void Function() onPressed) {
  return SnackBar(
    content: Row(
      children: [
        const SizedBox(width: 20),
        const Expanded(
          child: Text(
            "Config is not completed",
            style: TextStyle(
                fontSize: 35, color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color.fromARGB(255, 221, 49, 49)),
            child: const Text(
              "Go to setting",
              style: TextStyle(fontSize: 35, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 20),
      ],
    ),
    duration: const Duration(seconds: 5),
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    backgroundColor: const Color.fromARGB(255, 238, 73, 73),
  );
}
