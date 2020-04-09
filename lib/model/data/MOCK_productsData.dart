import 'package:flutter/cupertino.dart';

import 'products_data.dart';

class MockProductsRepo implements ProductsRepo {
  @override
  Future<List<Products>> fetchProducts() {
    return Future.value(products);
  }

  Future<List<Products>> fetchPets() {
    return Future.value(pets);
  }

  Future<List<Products>> fetchCategories() {
    return Future.value(categories);
  }

  @override
  Future<List<Products>> fetchServices() {
    return Future.value(services);
  }
}

var services = <Products>[
  Products(
    productImage: Image.asset(
      'assets/images/productImages/grooming.png',
      fit: BoxFit.fill,
    ),
    service: "Grooming",
  ),
  Products(
    productImage: Image.asset(
      'assets/images/productImages/training.jpg',
      fit: BoxFit.fill,
    ),
    service: "Training",
  ),
  Products(
    productImage: Image.asset(
      'assets/images/productImages/pethotel.jpg',
      fit: BoxFit.fill,
    ),
    service: "Pet Hotels",
  ),
  Products(
    productImage: Image.asset(
      'assets/images/productImages/doggycamp.jpg',
      fit: BoxFit.fill,
    ),
    service: "Doggie Day Camp",
  ),
  Products(
    productImage: Image.asset(
      'assets/images/productImages/vetdoc.jpg',
      fit: BoxFit.fill,
    ),
    service: "Veterinary",
  ),
  Products(
    productImage: Image.asset(
      'assets/images/productImages/charities.png',
      fit: BoxFit.fill,
    ),
    service: "Charities",
  ),
];

var categories = <Products>[
  Products(
    category: "Toys",
  ),
  Products(
    category: "food",
  ),
  Products(
    category: "Aquariums",
  ),
  Products(
    category: "supplies",
  ),
  Products(
    category: "Treats",
  ),
  Products(
    category: "Medicine",
  ),
];

var pets = <Products>[
  Products(
    productImage: Image.asset('assets/images/productImages/dogs.png'),
    pet: "Dogs",
  ),
  Products(
    productImage: Image.asset('assets/images/productImages/cat.png'),
    pet: "Cats",
  ),
  Products(
    productImage: Image.asset('assets/images/productImages/fish.png'),
    pet: "Fish",
  ),
  Products(
    productImage: Image.asset('assets/images/productImages/bird.png'),
    pet: "Birds",
  ),
  Products(
    productImage: Image.asset('assets/images/productImages/reptile.png'),
    pet: "Reptiles",
  ),
  Products(
    productImage: Image.asset('assets/images/productImages/hedgehog.png'),
    pet: "Small pets",
  ),
];

var products = <Products>[
  Products(
    productImage: Image.asset('assets/images/productImages/buffalo.jpg'),
    name:
        "Blue Buffalo Wilderness High Protein Grain Free, Natural Adult Dry Dog Food",
    price: 58.78,
    brand: "Blue Buffalo",
    desc:
        "Inspired by the diet of wolves, true omnivores whose endurance is legendary, BLUE Wilderness is a grain-free, protein-rich food that contains more of the delicious chicken your dog loves. Made with the finest natural ingredients and no grains.",
    moreDesc:
        "Key BenefitsDeboned chicken, chicken meal and turkey meal supply the protein your dog needs Sweet potatoes, peas and potatoes provide healthy complex carbohydrates Blueberries, cranberries and carrots support antioxidant-enrichment",
    foodType: "Dry",
    lifeStage: "Adult",
    flavor: "chicken",
    weight: "24.6kg",
    ingredients:
        " Deboned Chicken, Chicken Meal (source of Glucosamine), Peas, Pea Protein, Tapioca Starch, Menhaden Fish Meal (source of Omega 3 Fatty Acids), Dried Tomato Pomace, Chicken Fat (preserved with Mixed Tocopherols), Flaxseed (source of Omega 6 Fatty Acids), Pea Starch, Natural Flavor, Dried Egg Product, Dehydrated Alfalfa Meal, DL-Methionine, Potatoes, Dried Chicory Root, Pea Fiber, Alfalfa Nutrient Concentrate, Calcium Carbonate, Choline Chloride, Salt, Potassium Chloride, Sweet Potatoes, Carrots, preserved with Mixed Tocopherols, Zinc Amino Acid Chelate, Zinc Sulfate, Vegetable Juice for color, Ferrous Sulfate, Vitamin E Supplement, Iron Amino Acid Chelate, Blueberries, Cranberries, Barley Grass, Parsley, Turmeric, DriedKelp, Yucca Schidigera Extract, Niacin (Vitamin B3), Calcium Pantothenate (Vitamin B5), L-Carnitine, Copper Sulfate, L-Ascorbyl-2-Polyphosphate (source of Vitamin C), L-Lysine, Biotin (Vitamin B7), Vitamin A Supplement, Copper Amino Acid Chelate, Manganese Sulfate, Taurine, Manganese Amino Acid Chelate, Thiamine Mononitrate (Vitamin B1), Riboflavin Vitamin B2), Vitamin D3 Supplement,Vitamin B12 Supplement, Pyridoxine Hydrochloride (Vitamin B6), Calcium Iodate, Dried Yeast, Dried Enterococcus faecium fermentation product, Dried Lactobacillus acidophilus fermentation product, Dried Aspergillus niger fermentation extract, Dried Trichoderma longibrachiatum fermentation extract, Dried Bacillus subtilis fermentation extract, Folic Acid (Vitamin B9), Sodium Selenite, Oil of Rosemary.",
    directions:
        "Up to 15 lbs 1/2 to 1-1/4 cups*16 to 25 lbs 1-1/4 to 1-3/4 cups*26 to 40 lbs 1-3/4 to 2-1/4 cups*41 to 60 lbs 2-1/4 to 3-1/4 cups*61 to 80 lbs 3-1/4 to 4 cups*81 to 100 lbs 4 to 4-3/4 cups*Over 100 lbs 4-3/4 cups* + 1/2 cup for each additional 20 lbs",
    size: "null",
    productID: 0,
  ),
  Products(
    productImage: Image.asset('assets/images/productImages/cesar.jpg'),
    name: "Cesar Small Breed Dry Dog Food, All Flavors",
    price: 68.33,
    brand: "Cesar",
    desc:
        "Inspired by the diet of wolves, true omnivores whose endurance is legendary, BLUE Wilderness is a grain-free, protein-rich food that contains more of the delicious chicken your dog loves. Made with the finest natural ingredients and no grains.",
    moreDesc:
        "Key BenefitsDeboned chicken, chicken meal and turkey meal supply the protein your dog needs Sweet potatoes, peas and potatoes provide healthy complex carbohydrates Blueberries, cranberries and carrots support antioxidant-enrichment",
    foodType: "Dry",
    lifeStage: "Adult",
    flavor: "chicken",
    weight: "24.6kg",
    ingredients:
        " Deboned Chicken, Chicken Meal (source of Glucosamine), Peas, Pea Protein, Tapioca Starch, Menhaden Fish Meal (source of Omega 3 Fatty Acids), Dried Tomato Pomace, Chicken Fat (preserved with Mixed Tocopherols), Flaxseed (source of Omega 6 Fatty Acids), Pea Starch, Natural Flavor, Dried Egg Product, Dehydrated Alfalfa Meal, DL-Methionine, Potatoes, Dried Chicory Root, Pea Fiber, Alfalfa Nutrient Concentrate, Calcium Carbonate, Choline Chloride, Salt, Potassium Chloride, Sweet Potatoes, Carrots, preserved with Mixed Tocopherols, Zinc Amino Acid Chelate, Zinc Sulfate, Vegetable Juice for color, Ferrous Sulfate, Vitamin E Supplement, Iron Amino Acid Chelate, Blueberries, Cranberries, Barley Grass, Parsley, Turmeric, DriedKelp, Yucca Schidigera Extract, Niacin (Vitamin B3), Calcium Pantothenate (Vitamin B5), L-Carnitine, Copper Sulfate, L-Ascorbyl-2-Polyphosphate (source of Vitamin C), L-Lysine, Biotin (Vitamin B7), Vitamin A Supplement, Copper Amino Acid Chelate, Manganese Sulfate, Taurine, Manganese Amino Acid Chelate, Thiamine Mononitrate (Vitamin B1), Riboflavin Vitamin B2), Vitamin D3 Supplement,Vitamin B12 Supplement, Pyridoxine Hydrochloride (Vitamin B6), Calcium Iodate, Dried Yeast, Dried Enterococcus faecium fermentation product, Dried Lactobacillus acidophilus fermentation product, Dried Aspergillus niger fermentation extract, Dried Trichoderma longibrachiatum fermentation extract, Dried Bacillus subtilis fermentation extract, Folic Acid (Vitamin B9), Sodium Selenite, Oil of Rosemary.",
    directions:
        "Up to 15 lbs 1/2 to 1-1/4 cups*16 to 25 lbs 1-1/4 to 1-3/4 cups*26 to 40 lbs 1-3/4 to 2-1/4 cups*41 to 60 lbs 2-1/4 to 3-1/4 cups*61 to 80 lbs 3-1/4 to 4 cups*81 to 100 lbs 4 to 4-3/4 cups*Over 100 lbs 4-3/4 cups* + 1/2 cup for each additional 20 lbs",
    size: "null",
    productID: 1,
  ),
  Products(
    productImage: Image.asset('assets/images/productImages/meowmix.jpg'),
    name: "Meow Mix Original Choice Dry Cat Food",
    price: 33.8,
    brand: "Meow Mix",
    desc:
        "Inspired by the diet of wolves, true omnivores whose endurance is legendary, BLUE Wilderness is a grain-free, protein-rich food that contains more of the delicious chicken your dog loves. Made with the finest natural ingredients and no grains.",
    moreDesc:
        "Key BenefitsDeboned chicken, chicken meal and turkey meal supply the protein your dog needs Sweet potatoes, peas and potatoes provide healthy complex carbohydrates Blueberries, cranberries and carrots support antioxidant-enrichment",
    foodType: "Dry",
    lifeStage: "Adult",
    flavor: "chicken",
    weight: "24.6kg",
    ingredients:
        " Deboned Chicken, Chicken Meal (source of Glucosamine), Peas, Pea Protein, Tapioca Starch, Menhaden Fish Meal (source of Omega 3 Fatty Acids), Dried Tomato Pomace, Chicken Fat (preserved with Mixed Tocopherols), Flaxseed (source of Omega 6 Fatty Acids), Pea Starch, Natural Flavor, Dried Egg Product, Dehydrated Alfalfa Meal, DL-Methionine, Potatoes, Dried Chicory Root, Pea Fiber, Alfalfa Nutrient Concentrate, Calcium Carbonate, Choline Chloride, Salt, Potassium Chloride, Sweet Potatoes, Carrots, preserved with Mixed Tocopherols, Zinc Amino Acid Chelate, Zinc Sulfate, Vegetable Juice for color, Ferrous Sulfate, Vitamin E Supplement, Iron Amino Acid Chelate, Blueberries, Cranberries, Barley Grass, Parsley, Turmeric, DriedKelp, Yucca Schidigera Extract, Niacin (Vitamin B3), Calcium Pantothenate (Vitamin B5), L-Carnitine, Copper Sulfate, L-Ascorbyl-2-Polyphosphate (source of Vitamin C), L-Lysine, Biotin (Vitamin B7), Vitamin A Supplement, Copper Amino Acid Chelate, Manganese Sulfate, Taurine, Manganese Amino Acid Chelate, Thiamine Mononitrate (Vitamin B1), Riboflavin Vitamin B2), Vitamin D3 Supplement,Vitamin B12 Supplement, Pyridoxine Hydrochloride (Vitamin B6), Calcium Iodate, Dried Yeast, Dried Enterococcus faecium fermentation product, Dried Lactobacillus acidophilus fermentation product, Dried Aspergillus niger fermentation extract, Dried Trichoderma longibrachiatum fermentation extract, Dried Bacillus subtilis fermentation extract, Folic Acid (Vitamin B9), Sodium Selenite, Oil of Rosemary.",
    directions:
        "Up to 15 lbs 1/2 to 1-1/4 cups*16 to 25 lbs 1-1/4 to 1-3/4 cups*26 to 40 lbs 1-3/4 to 2-1/4 cups*41 to 60 lbs 2-1/4 to 3-1/4 cups*61 to 80 lbs 3-1/4 to 4 cups*81 to 100 lbs 4 to 4-3/4 cups*Over 100 lbs 4-3/4 cups* + 1/2 cup for each additional 20 lbs",
    size: "null",
    productID: 2,
  ),
  Products(
    productImage: Image.asset('assets/images/productImages/pedigree.jpg'),
    name: "Pedigree Adult Dry Dog Food - Grilled Steak & Vegetable Flavor",
    price: 128.89,
    brand: "Pedigree",
    desc:
        "Inspired by the diet of wolves, true omnivores whose endurance is legendary, BLUE Wilderness is a grain-free, protein-rich food that contains more of the delicious chicken your dog loves. Made with the finest natural ingredients and no grains.",
    moreDesc:
        "Key BenefitsDeboned chicken, chicken meal and turkey meal supply the protein your dog needs Sweet potatoes, peas and potatoes provide healthy complex carbohydrates Blueberries, cranberries and carrots support antioxidant-enrichment",
    foodType: "Dry",
    lifeStage: "Adult",
    flavor: "chicken",
    weight: "24.6kg",
    ingredients:
        " Deboned Chicken, Chicken Meal (source of Glucosamine), Peas, Pea Protein, Tapioca Starch, Menhaden Fish Meal (source of Omega 3 Fatty Acids), Dried Tomato Pomace, Chicken Fat (preserved with Mixed Tocopherols), Flaxseed (source of Omega 6 Fatty Acids), Pea Starch, Natural Flavor, Dried Egg Product, Dehydrated Alfalfa Meal, DL-Methionine, Potatoes, Dried Chicory Root, Pea Fiber, Alfalfa Nutrient Concentrate, Calcium Carbonate, Choline Chloride, Salt, Potassium Chloride, Sweet Potatoes, Carrots, preserved with Mixed Tocopherols, Zinc Amino Acid Chelate, Zinc Sulfate, Vegetable Juice for color, Ferrous Sulfate, Vitamin E Supplement, Iron Amino Acid Chelate, Blueberries, Cranberries, Barley Grass, Parsley, Turmeric, DriedKelp, Yucca Schidigera Extract, Niacin (Vitamin B3), Calcium Pantothenate (Vitamin B5), L-Carnitine, Copper Sulfate, L-Ascorbyl-2-Polyphosphate (source of Vitamin C), L-Lysine, Biotin (Vitamin B7), Vitamin A Supplement, Copper Amino Acid Chelate, Manganese Sulfate, Taurine, Manganese Amino Acid Chelate, Thiamine Mononitrate (Vitamin B1), Riboflavin Vitamin B2), Vitamin D3 Supplement,Vitamin B12 Supplement, Pyridoxine Hydrochloride (Vitamin B6), Calcium Iodate, Dried Yeast, Dried Enterococcus faecium fermentation product, Dried Lactobacillus acidophilus fermentation product, Dried Aspergillus niger fermentation extract, Dried Trichoderma longibrachiatum fermentation extract, Dried Bacillus subtilis fermentation extract, Folic Acid (Vitamin B9), Sodium Selenite, Oil of Rosemary.",
    directions:
        "Up to 15 lbs 1/2 to 1-1/4 cups*16 to 25 lbs 1-1/4 to 1-3/4 cups*26 to 40 lbs 1-3/4 to 2-1/4 cups*41 to 60 lbs 2-1/4 to 3-1/4 cups*61 to 80 lbs 3-1/4 to 4 cups*81 to 100 lbs 4 to 4-3/4 cups*Over 100 lbs 4-3/4 cups* + 1/2 cup for each additional 20 lbs",
    size: "null",
    productID: 3,
  ),
  Products(
    productImage: Image.asset('assets/images/productImages/proplan.jpg'),
    name:
        "Purina Pro Plan FOCUS Sensitive Skin & Stomach Adult Dry Dog Food & Wet Dog Food",
    price: 47.12,
    brand: "Purina Pro Plan",
    desc:
        "Inspired by the diet of wolves, true omnivores whose endurance is legendary, BLUE Wilderness is a grain-free, protein-rich food that contains more of the delicious chicken your dog loves. Made with the finest natural ingredients and no grains.",
    moreDesc:
        "Key BenefitsDeboned chicken, chicken meal and turkey meal supply the protein your dog needs Sweet potatoes, peas and potatoes provide healthy complex carbohydrates Blueberries, cranberries and carrots support antioxidant-enrichment",
    foodType: "Dry",
    lifeStage: "Adult",
    flavor: "chicken",
    weight: "24.6kg",
    ingredients:
        " Deboned Chicken, Chicken Meal (source of Glucosamine), Peas, Pea Protein, Tapioca Starch, Menhaden Fish Meal (source of Omega 3 Fatty Acids), Dried Tomato Pomace, Chicken Fat (preserved with Mixed Tocopherols), Flaxseed (source of Omega 6 Fatty Acids), Pea Starch, Natural Flavor, Dried Egg Product, Dehydrated Alfalfa Meal, DL-Methionine, Potatoes, Dried Chicory Root, Pea Fiber, Alfalfa Nutrient Concentrate, Calcium Carbonate, Choline Chloride, Salt, Potassium Chloride, Sweet Potatoes, Carrots, preserved with Mixed Tocopherols, Zinc Amino Acid Chelate, Zinc Sulfate, Vegetable Juice for color, Ferrous Sulfate, Vitamin E Supplement, Iron Amino Acid Chelate, Blueberries, Cranberries, Barley Grass, Parsley, Turmeric, DriedKelp, Yucca Schidigera Extract, Niacin (Vitamin B3), Calcium Pantothenate (Vitamin B5), L-Carnitine, Copper Sulfate, L-Ascorbyl-2-Polyphosphate (source of Vitamin C), L-Lysine, Biotin (Vitamin B7), Vitamin A Supplement, Copper Amino Acid Chelate, Manganese Sulfate, Taurine, Manganese Amino Acid Chelate, Thiamine Mononitrate (Vitamin B1), Riboflavin Vitamin B2), Vitamin D3 Supplement,Vitamin B12 Supplement, Pyridoxine Hydrochloride (Vitamin B6), Calcium Iodate, Dried Yeast, Dried Enterococcus faecium fermentation product, Dried Lactobacillus acidophilus fermentation product, Dried Aspergillus niger fermentation extract, Dried Trichoderma longibrachiatum fermentation extract, Dried Bacillus subtilis fermentation extract, Folic Acid (Vitamin B9), Sodium Selenite, Oil of Rosemary.",
    directions:
        "Up to 15 lbs 1/2 to 1-1/4 cups*16 to 25 lbs 1-1/4 to 1-3/4 cups*26 to 40 lbs 1-3/4 to 2-1/4 cups*41 to 60 lbs 2-1/4 to 3-1/4 cups*61 to 80 lbs 3-1/4 to 4 cups*81 to 100 lbs 4 to 4-3/4 cups*Over 100 lbs 4-3/4 cups* + 1/2 cup for each additional 20 lbs",
    size: "null",
    productID: 4,
  ),
  Products(
    productImage: Image.asset('assets/images/productImages/temptations.jpg'),
    name: "Temptations Classic Crunchy and Soft Cat Treats, 30 oz.",
    price: 14.67,
    brand: "Temptations",
    desc:
        "Inspired by the diet of wolves, true omnivores whose endurance is legendary, BLUE Wilderness is a grain-free, protein-rich food that contains more of the delicious chicken your dog loves. Made with the finest natural ingredients and no grains.",
    moreDesc:
        "Key BenefitsDeboned chicken, chicken meal and turkey meal supply the protein your dog needs Sweet potatoes, peas and potatoes provide healthy complex carbohydrates Blueberries, cranberries and carrots support antioxidant-enrichment",
    foodType: "Dry",
    lifeStage: "Adult",
    flavor: "chicken",
    weight: "24.6kg",
    ingredients:
        " Deboned Chicken, Chicken Meal (source of Glucosamine), Peas, Pea Protein, Tapioca Starch, Menhaden Fish Meal (source of Omega 3 Fatty Acids), Dried Tomato Pomace, Chicken Fat (preserved with Mixed Tocopherols), Flaxseed (source of Omega 6 Fatty Acids), Pea Starch, Natural Flavor, Dried Egg Product, Dehydrated Alfalfa Meal, DL-Methionine, Potatoes, Dried Chicory Root, Pea Fiber, Alfalfa Nutrient Concentrate, Calcium Carbonate, Choline Chloride, Salt, Potassium Chloride, Sweet Potatoes, Carrots, preserved with Mixed Tocopherols, Zinc Amino Acid Chelate, Zinc Sulfate, Vegetable Juice for color, Ferrous Sulfate, Vitamin E Supplement, Iron Amino Acid Chelate, Blueberries, Cranberries, Barley Grass, Parsley, Turmeric, DriedKelp, Yucca Schidigera Extract, Niacin (Vitamin B3), Calcium Pantothenate (Vitamin B5), L-Carnitine, Copper Sulfate, L-Ascorbyl-2-Polyphosphate (source of Vitamin C), L-Lysine, Biotin (Vitamin B7), Vitamin A Supplement, Copper Amino Acid Chelate, Manganese Sulfate, Taurine, Manganese Amino Acid Chelate, Thiamine Mononitrate (Vitamin B1), Riboflavin Vitamin B2), Vitamin D3 Supplement,Vitamin B12 Supplement, Pyridoxine Hydrochloride (Vitamin B6), Calcium Iodate, Dried Yeast, Dried Enterococcus faecium fermentation product, Dried Lactobacillus acidophilus fermentation product, Dried Aspergillus niger fermentation extract, Dried Trichoderma longibrachiatum fermentation extract, Dried Bacillus subtilis fermentation extract, Folic Acid (Vitamin B9), Sodium Selenite, Oil of Rosemary.",
    directions:
        "Up to 15 lbs 1/2 to 1-1/4 cups*16 to 25 lbs 1-1/4 to 1-3/4 cups*26 to 40 lbs 1-3/4 to 2-1/4 cups*41 to 60 lbs 2-1/4 to 3-1/4 cups*61 to 80 lbs 3-1/4 to 4 cups*81 to 100 lbs 4 to 4-3/4 cups*Over 100 lbs 4-3/4 cups* + 1/2 cup for each additional 20 lbs",
    size: "null",
    productID: 5,
  ),
  Products(
    productImage: Image.asset('assets/images/productImages/todycats.jpg'),
    name: "Purina Tidy Cats 24/7 Performance Clumping Cat Litter",
    price: 24.10,
    brand: "Purina",
    desc:
        "Inspired by the diet of wolves, true omnivores whose endurance is legendary, BLUE Wilderness is a grain-free, protein-rich food that contains more of the delicious chicken your dog loves. Made with the finest natural ingredients and no grains.",
    moreDesc:
        "Key BenefitsDeboned chicken, chicken meal and turkey meal supply the protein your dog needs Sweet potatoes, peas and potatoes provide healthy complex carbohydrates Blueberries, cranberries and carrots support antioxidant-enrichment",
    foodType: "Dry",
    lifeStage: "Adult",
    flavor: "chicken",
    weight: "24.6kg",
    ingredients:
        " Deboned Chicken, Chicken Meal (source of Glucosamine), Peas, Pea Protein, Tapioca Starch, Menhaden Fish Meal (source of Omega 3 Fatty Acids), Dried Tomato Pomace, Chicken Fat (preserved with Mixed Tocopherols), Flaxseed (source of Omega 6 Fatty Acids), Pea Starch, Natural Flavor, Dried Egg Product, Dehydrated Alfalfa Meal, DL-Methionine, Potatoes, Dried Chicory Root, Pea Fiber, Alfalfa Nutrient Concentrate, Calcium Carbonate, Choline Chloride, Salt, Potassium Chloride, Sweet Potatoes, Carrots, preserved with Mixed Tocopherols, Zinc Amino Acid Chelate, Zinc Sulfate, Vegetable Juice for color, Ferrous Sulfate, Vitamin E Supplement, Iron Amino Acid Chelate, Blueberries, Cranberries, Barley Grass, Parsley, Turmeric, DriedKelp, Yucca Schidigera Extract, Niacin (Vitamin B3), Calcium Pantothenate (Vitamin B5), L-Carnitine, Copper Sulfate, L-Ascorbyl-2-Polyphosphate (source of Vitamin C), L-Lysine, Biotin (Vitamin B7), Vitamin A Supplement, Copper Amino Acid Chelate, Manganese Sulfate, Taurine, Manganese Amino Acid Chelate, Thiamine Mononitrate (Vitamin B1), Riboflavin Vitamin B2), Vitamin D3 Supplement,Vitamin B12 Supplement, Pyridoxine Hydrochloride (Vitamin B6), Calcium Iodate, Dried Yeast, Dried Enterococcus faecium fermentation product, Dried Lactobacillus acidophilus fermentation product, Dried Aspergillus niger fermentation extract, Dried Trichoderma longibrachiatum fermentation extract, Dried Bacillus subtilis fermentation extract, Folic Acid (Vitamin B9), Sodium Selenite, Oil of Rosemary.",
    directions:
        "Up to 15 lbs 1/2 to 1-1/4 cups*16 to 25 lbs 1-1/4 to 1-3/4 cups*26 to 40 lbs 1-3/4 to 2-1/4 cups*41 to 60 lbs 2-1/4 to 3-1/4 cups*61 to 80 lbs 3-1/4 to 4 cups*81 to 100 lbs 4 to 4-3/4 cups*Over 100 lbs 4-3/4 cups* + 1/2 cup for each additional 20 lbs",
    size: "null",
    productID: 6,
  ),
  Products(
    productImage: Image.asset('assets/images/productImages/9lives.jpg'),
    name: "9Lives Dry Cat Food",
    price: 18.78,
    brand: "9 Lives",
    desc:
        "Inspired by the diet of wolves, true omnivores whose endurance is legendary, BLUE Wilderness is a grain-free, protein-rich food that contains more of the delicious chicken your dog loves. Made with the finest natural ingredients and no grains.",
    moreDesc:
        "Key BenefitsDeboned chicken, chicken meal and turkey meal supply the protein your dog needs Sweet potatoes, peas and potatoes provide healthy complex carbohydrates Blueberries, cranberries and carrots support antioxidant-enrichment",
    foodType: "Dry",
    lifeStage: "Adult",
    flavor: "chicken",
    weight: "24.6kg",
    ingredients:
        " Deboned Chicken, Chicken Meal (source of Glucosamine), Peas, Pea Protein, Tapioca Starch, Menhaden Fish Meal (source of Omega 3 Fatty Acids), Dried Tomato Pomace, Chicken Fat (preserved with Mixed Tocopherols), Flaxseed (source of Omega 6 Fatty Acids), Pea Starch, Natural Flavor, Dried Egg Product, Dehydrated Alfalfa Meal, DL-Methionine, Potatoes, Dried Chicory Root, Pea Fiber, Alfalfa Nutrient Concentrate, Calcium Carbonate, Choline Chloride, Salt, Potassium Chloride, Sweet Potatoes, Carrots, preserved with Mixed Tocopherols, Zinc Amino Acid Chelate, Zinc Sulfate, Vegetable Juice for color, Ferrous Sulfate, Vitamin E Supplement, Iron Amino Acid Chelate, Blueberries, Cranberries, Barley Grass, Parsley, Turmeric, DriedKelp, Yucca Schidigera Extract, Niacin (Vitamin B3), Calcium Pantothenate (Vitamin B5), L-Carnitine, Copper Sulfate, L-Ascorbyl-2-Polyphosphate (source of Vitamin C), L-Lysine, Biotin (Vitamin B7), Vitamin A Supplement, Copper Amino Acid Chelate, Manganese Sulfate, Taurine, Manganese Amino Acid Chelate, Thiamine Mononitrate (Vitamin B1), Riboflavin Vitamin B2), Vitamin D3 Supplement,Vitamin B12 Supplement, Pyridoxine Hydrochloride (Vitamin B6), Calcium Iodate, Dried Yeast, Dried Enterococcus faecium fermentation product, Dried Lactobacillus acidophilus fermentation product, Dried Aspergillus niger fermentation extract, Dried Trichoderma longibrachiatum fermentation extract, Dried Bacillus subtilis fermentation extract, Folic Acid (Vitamin B9), Sodium Selenite, Oil of Rosemary.",
    directions:
        "Up to 15 lbs 1/2 to 1-1/4 cups*16 to 25 lbs 1-1/4 to 1-3/4 cups*26 to 40 lbs 1-3/4 to 2-1/4 cups*41 to 60 lbs 2-1/4 to 3-1/4 cups*61 to 80 lbs 3-1/4 to 4 cups*81 to 100 lbs 4 to 4-3/4 cups*Over 100 lbs 4-3/4 cups* + 1/2 cup for each additional 20 lbs",
    size: "null",
    productID: 7,
  ),
];
