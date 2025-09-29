class BoycottDatabase {
  static BoycottDatabase? _instance;
  static BoycottDatabase get instance => _instance ??= BoycottDatabase._();
  BoycottDatabase._();

  static const Map<String, ProductInfo> _productDatabase = {
    'always': ProductInfo(
      displayName: 'Always',
      companyName: 'Procter & Gamble',
      category: 'Personal Care',
      isBoycotted: true,
      boycottReason:
          'Support for Israeli operations and stance on Palestinian issues.',
      alternatives: ['Natracare', 'Organyc', 'Local brands'],
    ),
    'ariel': ProductInfo(
      displayName: 'Ariel',
      companyName: 'Procter & Gamble',
      category: 'Laundry',
      isBoycotted: true,
      boycottReason:
          'Support for Israeli operations and stance on Palestinian issues.',
      alternatives: [
        'Persil',
        'Local detergent brands',
        'Eco-friendly alternatives'
      ],
    ),
    'gilette': ProductInfo(
      displayName: 'Gillette',
      companyName: 'Procter & Gamble',
      category: 'Personal Care',
      isBoycotted: true,
      boycottReason:
          'Support for Israeli operations and stance on Palestinian issues.',
      alternatives: ['Schick', 'Local razor brands', 'Safety razors'],
    ),
    'tide': ProductInfo(
      displayName: 'Tide',
      companyName: 'Procter & Gamble',
      category: 'Laundry',
      isBoycotted: true,
      boycottReason:
          'Support for Israeli operations and stance on Palestinian issues.',
      alternatives: [
        'Persil',
        'Local detergent brands',
        'Eco-friendly alternatives'
      ],
    ),

    'lux': ProductInfo(
      displayName: 'Lux',
      companyName: 'Unilever',
      category: 'Personal Care',
      isBoycotted: true,
      boycottReason:
          'Corporate stance on various political issues and business practices.',
      alternatives: [
        'Local soap brands',
        'Natural soap alternatives',
        'Artisanal soaps'
      ],
    ),
    'omo': ProductInfo(
      displayName: 'Omo',
      companyName: 'Unilever',
      category: 'Laundry',
      isBoycotted: true,
      boycottReason:
          'Corporate stance on various political issues and business practices.',
      alternatives: [
        'Persil',
        'Local detergent brands',
        'Eco-friendly alternatives'
      ],
    ),
    'persil': ProductInfo(
      displayName: 'Persil',
      companyName: 'Unilever',
      category: 'Laundry',
      isBoycotted: true,
      boycottReason:
          'Corporate stance on various political issues and business practices.',
      alternatives: [
        'Local detergent brands',
        'Eco-friendly alternatives',
        'Homemade detergent'
      ],
    ),
    'rxona': ProductInfo(
      displayName: 'Rexona',
      companyName: 'Unilever',
      category: 'Personal Care',
      isBoycotted: true,
      boycottReason:
          'Corporate stance on various political issues and business practices.',
      alternatives: [
        'Local deodorant brands',
        'Natural deodorants',
        'Crystal deodorants'
      ],
    ),
    'vanish': ProductInfo(
      displayName: 'Vanish',
      companyName: 'Unilever',
      category: 'Laundry',
      isBoycotted: true,
      boycottReason:
          'Corporate stance on various political issues and business practices.',
      alternatives: [
        'Local stain removers',
        'Natural stain removal methods',
        'Homemade solutions'
      ],
    ),
    'vaseline': ProductInfo(
      displayName: 'Vaseline',
      companyName: 'Unilever',
      category: 'Personal Care',
      isBoycotted: true,
      boycottReason:
          'Corporate stance on various political issues and business practices.',
      alternatives: [
        'Natural petroleum jelly alternatives',
        'Coconut oil',
        'Shea butter'
      ],
    ),

    'nestle': ProductInfo(
      displayName: 'Nestlé',
      companyName: 'Nestlé S.A.',
      category: 'Food & Beverage',
      isBoycotted: true,
      boycottReason:
          'Water privatization issues, infant formula marketing practices, and various ethical concerns.',
      alternatives: [
        'Local food brands',
        'Fair trade alternatives',
        'Organic brands'
      ],
    ),
    'nescafe': ProductInfo(
      displayName: 'Nescafé',
      companyName: 'Nestlé S.A.',
      category: 'Beverages',
      isBoycotted: true,
      boycottReason:
          'Water privatization issues, infant formula marketing practices, and various ethical concerns.',
      alternatives: [
        'Local coffee brands',
        'Fair trade coffee',
        'Organic coffee'
      ],
    ),
    'kitkat': ProductInfo(
      displayName: 'KitKat',
      companyName: 'Nestlé S.A.',
      category: 'Confectionery',
      isBoycotted: true,
      boycottReason:
          'Water privatization issues, infant formula marketing practices, and various ethical concerns.',
      alternatives: [
        'Local chocolate brands',
        'Fair trade chocolate',
        'Organic chocolate'
      ],
    ),

    'ferrero': ProductInfo(
      displayName: 'Ferrero',
      companyName: 'Ferrero Group',
      category: 'Confectionery',
      isBoycotted: true,
      boycottReason:
          'Environmental concerns regarding palm oil usage and labor practices.',
      alternatives: [
        'Local chocolate brands',
        'Sustainable chocolate',
        'Organic alternatives'
      ],
    ),
    'nutella': ProductInfo(
      displayName: 'Nutella',
      companyName: 'Ferrero Group',
      category: 'Food',
      isBoycotted: true,
      boycottReason:
          'Environmental concerns regarding palm oil usage and labor practices.',
      alternatives: [
        'Local nut spreads',
        'Homemade alternatives',
        'Sustainable nut butters'
      ],
    ),
    'kinder': ProductInfo(
      displayName: 'Kinder',
      companyName: 'Ferrero Group',
      category: 'Confectionery',
      isBoycotted: true,
      boycottReason:
          'Environmental concerns regarding palm oil usage and labor practices.',
      alternatives: [
        'Local chocolate brands',
        'Fair trade children\'s chocolate',
        'Organic alternatives'
      ],
    ),

    'lays': ProductInfo(
      displayName: 'Lay\'s',
      companyName: 'PepsiCo',
      category: 'Snacks',
      isBoycotted: true,
      boycottReason:
          'Corporate policies and business practices in contested regions.',
      alternatives: [
        'Local chip brands',
        'Homemade chips',
        'Healthier snack alternatives'
      ],
    ),

    'gliss': ProductInfo(
      displayName: 'Gliss',
      companyName: 'L\'Oréal',
      category: 'Hair Care',
      isBoycotted: true,
      boycottReason:
          'Corporate stance on various issues and business practices.',
      alternatives: [
        'Local hair care brands',
        'Natural hair care',
        'Organic shampoos'
      ],
    ),

    'schweps': ProductInfo(
      displayName: 'Schweppes',
      companyName: 'The Coca-Cola Company',
      category: 'Beverages',
      isBoycotted: true,
      boycottReason:
          'Corporate policies and business practices in contested regions.',
      alternatives: [
        'Local soft drinks',
        'Natural sodas',
        'Homemade sparkling drinks'
      ],
    ),

    'mustela': ProductInfo(
      displayName: 'Mustela',
      companyName: 'Laboratoires Expanscience',
      category: 'Baby Care',
      isBoycotted: false,
      boycottReason: '',
      alternatives: [
        'Local baby care brands',
        'Natural baby products',
        'Organic alternatives'
      ],
    ),

    'uriage': ProductInfo(
      displayName: 'Uriage',
      companyName: 'Laboratoires Dermatologiques d\'Uriage',
      category: 'Skincare',
      isBoycotted: false,
      boycottReason: '',
      alternatives: [
        'Local skincare brands',
        'Natural skincare',
        'Organic dermatology'
      ],
    ),

    'maestro': ProductInfo(
      displayName: 'Maestro',
      companyName: 'Various',
      category: 'Various',
      isBoycotted: false,
      boycottReason: '',
      alternatives: ['Local alternatives', 'Research specific product'],
    ),

    'president': ProductInfo(
      displayName: 'Président',
      companyName: 'Lactalis Group',
      category: 'Dairy',
      isBoycotted: false,
      boycottReason: '',
      alternatives: [
        'Local dairy brands',
        'Organic dairy',
        'Plant-based alternatives'
      ],
    ),
  };

  ProductInfo? getProductInfo(String productName) {
    final key = productName.toLowerCase().trim();
    return _productDatabase[key];
  }

  List<ProductInfo> getBoycottedProducts() {
    return _productDatabase.values
        .where((product) => product.isBoycotted)
        .toList();
  }

  List<ProductInfo> getProductsByCompany(String companyName) {
    return _productDatabase.values
        .where((product) => product.companyName
            .toLowerCase()
            .contains(companyName.toLowerCase()))
        .toList();
  }

  bool isProductBoycotted(String productName) {
    final product = getProductInfo(productName);
    return product?.isBoycotted ?? false;
  }

  List<String> getAlternatives(String productName) {
    final product = getProductInfo(productName);
    return product?.alternatives ??
        ['Look for local alternatives', 'Check ethical brands'];
  }
}

class ProductInfo {
  final String displayName;
  final String companyName;
  final String category;
  final bool isBoycotted;
  final String boycottReason;
  final List<String> alternatives;

  const ProductInfo({
    required this.displayName,
    required this.companyName,
    required this.category,
    required this.isBoycotted,
    required this.boycottReason,
    required this.alternatives,
  });

  BoycottInfo toBoycottInfo() {
    return BoycottInfo(
      productName: displayName,
      companyName: companyName,
      description: isBoycotted
          ? boycottReason.isNotEmpty
              ? boycottReason
              : 'This product is currently being boycotted.'
          : 'This product is not currently being boycotted.',
      isBoycotted: isBoycotted,
      alternatives: alternatives,
    );
  }
}

class BoycottInfo {
  final String productName;
  final String companyName;
  final String description;
  final bool isBoycotted;
  final List<String> alternatives;

  BoycottInfo({
    required this.productName,
    required this.companyName,
    required this.description,
    required this.isBoycotted,
    required this.alternatives,
  });
}
