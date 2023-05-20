import 'package:barrier_free_kiosk/lib/config.dart';

class MenuInfo {
  final int categoryId;
  final int menuId;
  final List<DetailCategory> detailCategories;
  MenuInfo(
      {required this.categoryId,
      required this.menuId,
      required this.detailCategories});
}
