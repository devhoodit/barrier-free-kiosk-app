import 'package:barrier_free_kiosk/lib/menu.dart';
import 'package:barrier_free_kiosk/provider/detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailOrder extends StatelessWidget {
  const DetailOrder({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var focusBoxDecoration = BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      border: Border.all(color: Colors.black, width: 8),
    );
    var outFocusBoxDecoration = BoxDecoration();

    final args = ModalRoute.of(context)!.settings.arguments as MenuInfo;
    final details = args.detailCategories;
    context.read<DetailProvider>().initializeRadio(details);
    return Consumer<DetailProvider>(
      builder: (context, value, child) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.all(100),
            child: ListView.separated(
              itemCount: details.length,
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  height: 4,
                  color: const Color.fromARGB(255, 228, 228, 228),
                );
              },
              itemBuilder: (BuildContext context, int index) {
                final detailCategory = details[index];
                List<Widget> detailContainer = [];
                int radioIndex = 0;
                for (final detail in detailCategory.details) {
                  final ri = radioIndex;
                  detailContainer.add(Container(
                    width: 200,
                    height: 200,
                    decoration: value.radio[index] == radioIndex
                        ? focusBoxDecoration
                        : outFocusBoxDecoration,
                    child: TextButton(
                      onPressed: () {
                        context.read<DetailProvider>().changeRadio(index, ri);
                      },
                      child: Center(
                        child: Text(
                          "${detail.name}\n+${detail.price}원",
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ));
                  radioIndex++;
                }
                return Row(
                  children: detailContainer,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
