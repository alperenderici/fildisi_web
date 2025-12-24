import '../models/product.dart';

class AtelierCatalog {
  static const heroBonbonImage = 'assets/images/bonbon/bonbon_satsuma2.jpeg';

  static const bonbons = <Product>[
    Product(
      id: 'satsuma-cocoa',
      name: 'Satsuma',
      flavorLine: 'Citrus lift, deep cocoa, clean finish.',
      imageAsset: 'assets/images/bonbon/bonbon_satsuma.jpeg',
      notes: ['Dark cacao shell', 'Satsuma reduction', 'Soft ganache'],
    ),
    Product(
      id: 'passion',
      name: 'Çarkıfelek',
      flavorLine: 'Tropical acidity, satin ganache.',
      imageAsset: 'assets/images/bonbon/bonbon_carkifelek.jpeg',
      notes: ['Fruit reduction', 'Balanced sweetness', 'Bright aroma'],
    ),
    Product(
      id: 'raspberry',
      name: 'Ahududu',
      flavorLine: 'Ruby fruit, cocoa depth.',
      imageAsset: 'assets/images/bonbon/bonbon_ahududu.jpeg',
      notes: ['Raspberry core', 'Dark chocolate', 'Clean acidity'],
    ),
    Product(
      id: 'espresso',
      name: 'Espresso',
      flavorLine: 'Roasted notes, quiet intensity.',
      imageAsset: 'assets/images/bonbon/bonbon_espresso.jpeg',
      notes: ['Coffee ganache', 'Cacao nib hint', 'Long finish'],
    ),
    Product(
      id: 'lemon',
      name: 'Limon',
      flavorLine: 'Crisp citrus, restrained sweetness.',
      imageAsset: 'assets/images/bonbon/bonbon_limon.jpeg',
      notes: ['Lemon zest', 'Silky ganache', 'Bright lift'],
    ),
    Product(
      id: 'milk',
      name: 'Sütlü',
      flavorLine: 'Creamy cacao, velvet texture.',
      imageAsset: 'assets/images/bonbon/bonbon_sutlu.jpeg',
      notes: ['Milk chocolate', 'Soft caramel note', 'Round finish'],
    ),
    Product(
      id: 'truffle',
      name: 'Trüf',
      flavorLine: 'Cocoa dust, slow melt.',
      imageAsset: 'assets/images/bonbon/truf.jpeg',
      notes: ['Ganache center', 'Cocoa coating', 'Deep aroma'],
    ),
  ];

  static const macarons = <Product>[
    Product(
      id: 'macaron-signature',
      name: 'Signature Macarons',
      flavorLine: 'Thin shells. Clean fillings. Precision.',
      imageAsset: 'assets/images/makaron/makaron.jpeg',
      notes: ['Almond shell', 'Balanced sweetness', 'Seasonal rotation'],
    ),
    Product(
      id: 'macaron-cacao',
      name: 'Cacao',
      flavorLine: 'Soft cocoa, polished finish.',
      imageAsset: 'assets/images/makaron/makaron.jpeg',
      notes: ['Cocoa filling', 'Silky texture', 'Quiet intensity'],
    ),
    Product(
      id: 'macaron-citrus',
      name: 'Citrus',
      flavorLine: 'Aromatic zest, bright lift.',
      imageAsset: 'assets/images/makaron/makaron.jpeg',
      notes: ['Zest-forward', 'Clean acidity', 'Light finish'],
    ),
  ];

  static const giftBoxes = <Product>[
    Product(
      id: 'box-bonbon',
      name: 'Bonbon Box',
      flavorLine: 'Curated for gifting—understated detail.',
      imageAsset: 'assets/images/bonbon/bonbon_box.jpeg',
      notes: ['Assorted selection', 'Limited production', 'Reserve in advance'],
    ),
    Product(
      id: 'box-seasonal',
      name: 'Seasonal Selection',
      flavorLine: 'A restrained intensity, seasonal notes.',
      imageAsset: 'assets/images/bonbon/bonbon4.jpeg',
      notes: ['Seasonal rotation', 'Fresh reductions', 'Small batch'],
    ),
  ];
}
