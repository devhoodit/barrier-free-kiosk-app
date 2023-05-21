import 'package:path/path.dart' as p;

class Config {
  List<Category> categories = [];
  List<DetailCategory> detailCategories = [];
  List<Item> items = [];

  Config(Map<String, dynamic> map) {
    parseConfig(map);
  }

  void parseConfig(Map<String, dynamic> map) {
    categories = [];
    detailCategories = [];
    items = [];

    parseDetailCategory(map["detail_categories"]);
    parseItem(map["items"]);
    parseCategory(map["category"]);
  }

  void parseDetailCategory(List<dynamic> detailCategories) {
    for (final detailCategoryMap in detailCategories) {
      print(detailCategoryMap);
      DetailCategory detailCategory = DetailCategory(detailCategoryMap["name"]);
      for (final detail in detailCategoryMap["details"]) {
        detailCategory.details
            .add(Detail(detail["name"], detail["price"].toDouble()));
      }
      this.detailCategories.add(detailCategory);
    }
  }

  void parseItem(List<dynamic> items) {
    for (final item in items) {
      Item itm = Item(
        name: item["name"],
        price: item["price"].toDouble(),
        imagePath: item["image"],
        gluedPath: item["image"],
        description: item["description"],
      );
      this.items.add(itm);
    }
  }

  void parseCategory(List<dynamic> categories) {
    for (final category in categories) {
      final categoryName = category["title"];
      List<Item> itms = [];
      for (final itemIndex in category["items"]) {
        itms.add(items[itemIndex]);
      }
      List<List<DetailCategory>> detailCategories = [];
      for (final detailIndexes in category["details"]) {
        List<DetailCategory> details = [];
        for (final detailIndex in detailIndexes) {
          details.add(this.detailCategories[detailIndex]);
        }
        detailCategories.add(details);
      }
      this.categories.add(Category(categoryName, itms, detailCategories));
    }
  }

  void gluePath(String basepath) {
    for (var item in items) {
      item.gluedPath = p.join(basepath, item.imagePath);
    }
  }
}

class Category {
  String name;
  List<Item> items;
  List<List<DetailCategory>> detailCategories;
  Category(this.name, this.items, this.detailCategories);
}

class DetailCategory {
  String name;
  List<Detail> details = [];
  DetailCategory(this.name);
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
