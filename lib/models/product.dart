class ProductData{

  ProductData()
  {
    images = new List();
    quality = 0;
    unit = 1;
  }

  List<String> images;
  String title, description;
  double quality, price;
  bool fix, bid;
  int quantity, unit, cat;

}

class ProductUnit{
  static int UNIT = 1;
  static int GRAM = 2;
  static int OUNCE = 3;
  static int KG = 4;
  static int TON = 5;
  static int LB = 6;
  static int LITER = 7;
  static int METER = 8;

  static getUnit(int i)
 {
    switch (i) {
       case 1:
        return "Unit";
        break;
       case 2:
        return "Gram";
        break;
       case 3:
        return "Ounce";
        break;
       case 4:
        return "Kg";
        break;
       case 5:
        return "Ton";
        break;
       case 6:
        return "Lb";
        break;
       case 7:
        return "Liter";
        break;
       case 8:
        return "Meter";
        break;
    }
  }
}

class ProductCat{
  static int BOTTLE = 1;
  static int PAPER = 2;
  static int OIL = 3;
  static int WOOD = 4;
  static int FOOD = 5;
  static int OTHER = 6;

  static getCat(int i)
 {
    switch (i) {
       case 1:
        return "Bottles";
        break;
       case 2:
        return "Paper";
        break;
       case 3:
        return "Oil";
        break;
       case 4:
        return "Wood";
        break;
       case 5:
        return "Food";
        break;
       case 6:
        return "Other";
        break;
    }
  }
}