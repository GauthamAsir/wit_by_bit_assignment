import 'dart:convert';

import 'package:amerika_foods/src/data/models/category_model.dart';
import 'package:amerika_foods/src/data/models/product_model.dart';

const dummyData = '''[
  {
    "name": "Recommended",
    "items": [
      {
        "id": "rec1",
        "title": "Chicken Crunch Burger",
        "description": "Crispy chicken patty with fresh veggies and mayo.",
        "price": 209,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Crunch"
      },
      {
        "id": "rec2",
        "title": "Mighty Chicken Patty Burger",
        "description": "Loaded chicken burger with extra cheese and lettuce.",
        "price": 259,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Mighty"
      },
      {
        "id": "rec3",
        "title": "Donut Header Chicken",
        "description": "Unique donut-shaped chicken burger with spicy sauce.",
        "price": 199,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Donut"
      },
      {
        "id": "rec4",
        "title": "Crunchy Veg Surprise",
        "description": "Veg patty with onion rings and secret sauce.",
        "price": 189,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Veg+Crunch"
      },
      {
        "id": "rec5",
        "title": "Fiery Chicken Blaster",
        "description": "Hot chicken burger with jalapenos.",
        "price": 239,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Blaster"
      },
      {
        "id": "rec6",
        "title": "Deluxe Chicken Classic",
        "description": "Classic chicken burger with double patty.",
        "price": 269,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Deluxe"
      },
      {
        "id": "rec7",
        "title": "BBQ Onion Melt",
        "description": "Grilled chicken, BBQ sauce, crispy onions.",
        "price": 229,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=BBQ"
      },
      {
        "id": "rec8",
        "title": "Chicken Salsa Delight",
        "description": "Chicken with salsa and creamy cheese.",
        "price": 249,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Salsa"
      },
      {
        "id": "rec9",
        "title": "Spicy Ranch Burger",
        "description": "Spicy mayo and ranch dressing with crunchy patty.",
        "price": 219,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Ranch"
      },
      {
        "id": "rec10",
        "title": "Bistro Chicken Delight",
        "description": "Signature bistro style grilled burger.",
        "price": 259,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Bistro"
      }
    ]
  },
  {
    "name": "Combos",
    "items": [
      {
        "id": "combo1",
        "title": "Burger Combo Meal",
        "description": "Burger, fries and drink combo for one.",
        "price": 349,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Combo1"
      },
      {
        "id": "combo2",
        "title": "Family Chicken Combo",
        "description": "Family pack combo for 3-4 people.",
        "price": 599,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Combo2"
      },
      {
        "id": "combo3",
        "title": "Cheesy Duo Combo",
        "description": "Two cheesy burgers, two drinks and fries.",
        "price": 449,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Combo3"
      },
      {
        "id": "combo4",
        "title": "Spicy Meal Box",
        "description": "Spicy burger, peri fries, drink and brownie.",
        "price": 399,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Combo4"
      },
      {
        "id": "combo5",
        "title": "Veggie Delight Combo",
        "description": "Veg burger, fries, drink, and dessert.",
        "price": 329,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Combo5"
      },
      {
        "id": "combo6",
        "title": "Kids Mini Combo",
        "description": "Small burger, juice box and a toy.",
        "price": 289,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Combo6"
      },
      {
        "id": "combo7",
        "title": "Midnight Combo Pack",
        "description": "Combo of burger, nuggets, fries and cola.",
        "price": 379,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Combo7"
      },
      {
        "id": "combo8",
        "title": "Party Feast Combo",
        "description": "Burgers, sides, desserts for a group of 5.",
        "price": 799,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Combo8"
      },
      {
        "id": "combo9",
        "title": "Value Lunch Combo",
        "description": "Single burger, drink and a wrap.",
        "price": 309,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Combo9"
      },
      {
        "id": "combo10",
        "title": "Wrap & Burger Combo",
        "description": "Burger, wrap, fries and chilled drink.",
        "price": 429,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Combo10"
      }
    ]
  },
  {
    "name": "Regular Burgers",
    "items": [
      {
        "id": "reg1",
        "title": "Classic Beef Burger",
        "description": "Timeless beef patty with cheese and lettuce.",
        "price": 189,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Beef"
      },
      {
        "id": "reg2",
        "title": "Veggie Delight Burger",
        "description": "A healthy pick with mixed vegetable patty.",
        "price": 179,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Veggie"
      },
      {
        "id": "reg3",
        "title": "Aloo Tikki Burger",
        "description": "Indian aloo patty with spicy mayo.",
        "price": 159,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Aloo"
      },
      {
        "id": "reg4",
        "title": "Egg Mayo Burger",
        "description": "Soft egg patty with creamy mayo.",
        "price": 169,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Egg"
      },
      {
        "id": "reg5",
        "title": "Paneer Supreme Burger",
        "description": "Paneer tikka patty with mint chutney.",
        "price": 199,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Paneer"
      },
      {
        "id": "reg6",
        "title": "Grilled Chicken Burger",
        "description": "Tender grilled chicken with garlic sauce.",
        "price": 209,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Grilled"
      },
      {
        "id": "reg7",
        "title": "Chilli Cheese Melt",
        "description": "Melted cheese and green chilli topping.",
        "price": 189,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Chilli"
      },
      {
        "id": "reg8",
        "title": "Corn & Spinach Burger",
        "description": "Corn-spinach mix in a crispy patty.",
        "price": 179,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Corn"
      },
      {
        "id": "reg9",
        "title": "Tandoori Veg Burger",
        "description": "Tandoori flavor-infused veggie patty.",
        "price": 189,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Tandoori"
      },
      {
        "id": "reg10",
        "title": "Cheese Classic Veg",
        "description": "Simple veg burger with extra cheese.",
        "price": 169,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Cheese"
      }
    ]
  },
  {
    "name": "Special Burgers",
    "items": [
      {
        "id": "spec1",
        "title": "Spicy Chicken Volcano",
        "description": "Fiery hot chicken burger for spice lovers.",
        "price": 249,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Volcano"
      },
      {
        "id": "spec2",
        "title": "Cheesy Burst Supreme",
        "description": "Extra cheese, double patty, and creamy sauce.",
        "price": 289,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Cheesy"
      },
      {
        "id": "spec3",
        "title": "Mac & Cheese Burger",
        "description": "Loaded with macaroni and molten cheese.",
        "price": 259,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Mac"
      },
      {
        "id": "spec4",
        "title": "Black Bun Burger",
        "description": "Activated charcoal bun with grilled meat.",
        "price": 269,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Black"
      },
      {
        "id": "spec5",
        "title": "Mexican Fiesta Burger",
        "description": "Beans, salsa, and jalapenos mix.",
        "price": 239,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Mexican"
      },
      {
        "id": "spec6",
        "title": "Truffle Mushroom Melt",
        "description": "Gourmet mushrooms in truffle sauce.",
        "price": 299,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Truffle"
      },
      {
        "id": "spec7",
        "title": "Double Decker Burger",
        "description": "Double meat and double cheese stack.",
        "price": 279,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Decker"
      },
      {
        "id": "spec8",
        "title": "Gourmet Lamb Burger",
        "description": "Premium lamb patty with caramelized onions.",
        "price": 319,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Lamb"
      },
      {
        "id": "spec9",
        "title": "Smoked BBQ Chicken",
        "description": "Smokey BBQ chicken with lettuce.",
        "price": 259,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Smoked"
      },
      {
        "id": "spec10",
        "title": "Falafel Crunch Special",
        "description": "Falafel patty, pickled onions and tahini.",
        "price": 229,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Falafel"
      }
    ]
  },
  {
    "name": "Mutton Burgers",
    "items": [
      {
        "id": "mutt1",
        "title": "Grilled Mutton Delight",
        "description": "Juicy mutton grilled to perfection.",
        "price": 299,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Mutton1"
      },
      {
        "id": "mutt2",
        "title": "Spicy Mutton Masala Burger",
        "description": "Indian-style masala mutton burger.",
        "price": 319,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Mutton2"
      },
      {
        "id": "mutt3",
        "title": "Double Mutton Stack",
        "description": "Two thick mutton patties with cheese.",
        "price": 349,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Mutton3"
      },
      {
        "id": "mutt4",
        "title": "Mint Mutton Zing",
        "description": "Mutton patty with mint mayo.",
        "price": 299,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Mutton4"
      },
      {
        "id": "mutt5",
        "title": "Classic Lamb Burger",
        "description": "Mild spiced lamb burger with fresh lettuce.",
        "price": 279,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Mutton5"
      },
      {
        "id": "mutt6",
        "title": "Crispy Mutton Delight",
        "description": "Crispy fried mutton with onion rings.",
        "price": 309,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Mutton6"
      },
      {
        "id": "mutt7",
        "title": "Herb Infused Lamb",
        "description": "Herbed lamb burger with garlic aioli.",
        "price": 289,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Mutton7"
      },
      {
        "id": "mutt8",
        "title": "Fiery Mutton Inferno",
        "description": "Extra spicy mutton burger.",
        "price": 319,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Mutton8"
      },
      {
        "id": "mutt9",
        "title": "Tandoori Lamb Treat",
        "description": "Tandoori grilled lamb patty with chutney.",
        "price": 299,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Mutton9"
      },
      {
        "id": "mutt10",
        "title": "Smoked Mutton BBQ",
        "description": "BBQ mutton burger with coleslaw.",
        "price": 339,
        "imageUrl": "https://via.placeholder.com/100x100.png?text=Mutton10"
      }
    ]
  }
]
''';

final List<CategoryModel> categoriesList =
    ((jsonDecode(dummyData)) as List)
        .map((item) => CategoryModel.fromMap(item))
        .toList();

final List<ProductModel> searchableProductList = categoriesList
    .expand((category) => category.items)
    .toList();
