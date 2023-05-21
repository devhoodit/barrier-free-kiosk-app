import 'package:barrier_free_kiosk/lib/config.dart';
import 'package:barrier_free_kiosk/lib/menu.dart';
import 'package:barrier_free_kiosk/main.dart';
import 'package:barrier_free_kiosk/pages/default/detail/bottombar.dart';
import 'package:barrier_free_kiosk/pages/default/topbar.dart';
import 'package:barrier_free_kiosk/provider/detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Detail extends StatelessWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          TopProcessBar(curProcess: 1, processes: ["메뉴선택", "상세선택"]),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 20.0),
              decoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.secondary),
              child: Column(children: [
                Expanded(child: DetailOrder()),
              ]),
            ),
          ),
          ShowPrice(),
          BottomBar()
        ],
      ),
    );
  }
}

class DetailOrder extends StatelessWidget {
  const DetailOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final menuInfo = ModalRoute.of(context)!.settings.arguments as MenuInfo;
    final details = menuInfo.detailCategories;
    context.read<DetailProvider>().initializeRadio(menuInfo);
    return ListView.separated(
      itemCount: details.length,
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          margin: const EdgeInsets.only(bottom: 30),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  width: 4, color: Theme.of(context).colorScheme.primary),
            ),
          ),
        );
      },
      itemBuilder: (BuildContext context, int index) {
        final detail = details[index];
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Text(
                  detail.name,
                  style: const TextStyle(
                      fontSize: 50, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: SingleChoiceChips(
                  detailIndex: index,
                  detailCategory: detail,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SingleChoiceChips extends StatefulWidget {
  final int detailIndex;
  final DetailCategory detailCategory;
  const SingleChoiceChips(
      {Key? key, required this.detailIndex, required this.detailCategory})
      : super(key: key);

  @override
  State<SingleChoiceChips> createState() => _SingleChoiceChipsState();
}

class _SingleChoiceChipsState extends State<SingleChoiceChips> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final details = widget.detailCategory.details;
    return Wrap(
      spacing: 15,
      children: List<Widget>.generate(details.length, (index) {
        return ChipTheme(
          data: const ChipThemeData(checkmarkColor: Colors.white),
          child: ChoiceChip(
            disabledColor: Colors.white,
            selectedColor: Theme.of(context).colorScheme.primary,
            labelStyle: index == selectedIndex
                ? const TextStyle(color: Colors.white)
                : TextStyle(color: Theme.of(context).colorScheme.primary),
            label: Text(
              details[index].name,
              style: Theme.of(context).textTheme.detailLarge,
            ),
            selected: index == selectedIndex,
            onSelected: (selected) {
              setState(() {
                selectedIndex = index;
                context
                    .read<DetailProvider>()
                    .changeRadio(widget.detailIndex, selectedIndex);
              });
            },
          ),
        );
      }).toList(),
    );
  }
}

//

class ShowPrice extends StatelessWidget {
  const ShowPrice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailProvider>(builder: (context, value, child) {
      return Container(
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${value.getDefaultPrice()} + ${value.getDetailPrice()} = ",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white60),
            ),
            Text(
              "${value.getTotalPrcie()} 원",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white),
            )
          ],
        ),
      );
    });
  }
}
// class SingleChoiceSegments extends StatefulWidget {
//   final int detailIndex;
//   final DetailCategory detailCategory;
//   const SingleChoiceSegments(
//       {Key? key, required this.detailIndex, required this.detailCategory})
//       : super(key: key);

//   @override
//   State<SingleChoiceSegments> createState() => _SingleChoiceSegmentsState();
// }

// class _SingleChoiceSegmentsState extends State<SingleChoiceSegments> {
//   int selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     final details = widget.detailCategory.details;
//     final List<ButtonSegment<int>> buttonSegments = [];
//     for (int i = 0; i < details.length; i++) {
//       buttonSegments.add(
//         ButtonSegment(
//           value: i,
//           label: Padding(
//             padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
//             child: Text(
//               "${details[i].name}\n+${details[i].price}",
//               style: const TextStyle(fontSize: 30),
//             ),
//           ),
//         ),
//       );
//     }
//     return SegmentedButton<int>(
//       style: ButtonStyle(),
//       segments: buttonSegments,
//       selected: <int>{selectedIndex},
//       showSelectedIcon: false,
//       onSelectionChanged: (Set<int> newSelection) {
//         setState(() {
//           selectedIndex = newSelection.first;
//           context
//               .read<DetailProvider>()
//               .changeRadio(widget.detailIndex, selectedIndex);
//         });
//       },
//     );
//   }
// }
