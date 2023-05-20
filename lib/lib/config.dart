import 'package:path/path.dart' as p;

class Config {
  List<Category> categories = [];
  List<DetailCategory> detailCategories = [];
  List<Item> items = [];

  Config(Map<String, dynamic> map) {
    parseConfig(map);
  }

  void gluePath(String basepath) {
    for (var item in items) {
      item.gluedPath = p.join(basepath, item.imagePath);
    }
  }

  void parseConfig(Map<String, dynamic> map) {
    categories = [];
    detailCategories = [];
    items = [];
    for (Map<String, dynamic> item in map["items"]) {
      items.add(Item(
          name: item["name"],
          price: item["price"].toDouble(),
          imagePath: item["image"],
          gluedPath: item["image"],
          description: item["description"]));
    }
    for (List<dynamic> detail in map["details"]) {
      detailCategories.add(DetailCategory(detail));
    }
    for (Map<String, dynamic> category in map["category"]) {
      categories.add(Category(category, items, detailCategories));
    }
  }

  String getName(int categoryId, int menuId) {
    return categories[categoryId].items[menuId].name;
  }

  double getPrice(int categoryId, int menuId, List<int> details) {
    double defaultCost = categories[categoryId].items[menuId].price;
    for (var i = 0; i < details.length; i++) {
      final detail = categories[categoryId].details[menuId][i];
      defaultCost += detail.details[details[i]].price;
    }
    return defaultCost;
  }
}

class Category {
  String title = "";
  List<Item> items = [];
  List<List<DetailCategory>> details = [];
  Category(Map<String, dynamic> info, List<Item> items,
      List<DetailCategory> detailCategories) {
    title = info["title"];
    for (int index in info["items"]) {
      this.items.add(items[index]);
    }
    for (List<dynamic> detailContainer in info["details"]) {
      details.add([]);
      for (int index in detailContainer) {
        details[details.length - 1].add(detailCategories[index]);
      }
    }
  }
}

class DetailCategory {
  List<Detail> details = [];
  DetailCategory(List<dynamic> detailCategories) {
    for (Map<String, dynamic> detailCategoryMap in detailCategories) {
      details.add(Detail(
          detailCategoryMap["name"], detailCategoryMap["price"].toDouble()));
    }
  }
}

class Detail {
  String name;
  double price;
  Detail(this.name, this.price);
}

class Item {
  String name;
  double price;
  String imagePath;
  String gluedPath;
  String description;
  Item(
      {required this.name,
      required this.price,
      required this.imagePath,
      required this.gluedPath,
      required this.description});
}
