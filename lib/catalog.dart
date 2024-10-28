import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CatalogScreen extends StatefulWidget {
  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  int _selectedCategoryIndex = 0; 
  List<Product> filteredProducts = products; 

  // Карта для хранения количества товаров в корзине
  Map<Product, double> cart = {};

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: _buildSearchBar(),
            ),
            SizedBox(height: 20), 
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Text(
                'Каталог',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                itemCount: 7,
                itemBuilder: (context, index) {
                  final bool isLast = index == 6;
                  return Padding(
                    padding: EdgeInsets.only(right: isLast ? 0 : 8.0),
                    child: _buildCategoryButton(
                      _getCategoryLabel(index),
                      _getCategoryIcon(index),
                      index,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: filteredProducts.length, // Используем отфильтрованные продукты
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 156 / 240,
              ),
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return index % 2 == 0
                    ? Padding(
                        padding: const EdgeInsets.only(left: 24.0),
                        child: _buildProductCard(product),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(right: 24.0),
                        child: _buildProductCard(product),
                      );
              },
            ),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  // Панель поиска
  Widget _buildSearchBar() {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16), 
      child: Row(
        children: [
          SvgPicture.asset('icon/Lupa.svg'),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Поиск по товарам',
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero, 
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Метод для обработки нажатий на категории
  void _onCategorySelected(int index) {
    setState(() {
      _selectedCategoryIndex = index;
      if (index == 0) {
        // Все товары
        filteredProducts = products;
      } else if (index == 2) {
        // Фрукты и ягоды
        filteredProducts = products.where((product) {
          return product.name == 'Клубника' || 
                 product.name == 'Ананас' || 
                 product.name == 'Яблоки' || 
                 product.name == 'Бананы с длинным названием' || 
                 product.name == 'Папайя';
        }).toList();
      } else {

        filteredProducts = []; // Устанавливаем пустой список для остальных категорий
      }
    });
  }

  // Кнопка категории
  Widget _buildCategoryButton(String label, IconData icon, int index) {
  bool isActive = _selectedCategoryIndex == index;

  return GestureDetector(
    onTap: () {
      _onCategorySelected(index); // Обработка выбора категории
    },
    child: Container(
      decoration: BoxDecoration(
        color: isActive ? Colors.orange : Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.orange),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color: isActive ? Colors.white : Colors.orange,
          ),
          SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.orange,
            ),
          ),
        ],
      ),
    ),
  );
}

  // Список для хранения избранных товаров
  Set<Product> favorites = {};

  Widget _buildProductCard(Product product) {
    bool isInCart = cart.containsKey(product);
    bool isFavorite = favorites.contains(product);

    return Container(
      width: 156,
      height: 220,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.zero, 
      ),
      padding: EdgeInsets.zero, 
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Изображение продукта
              ClipRRect(
                borderRadius: BorderRadius.zero, 
                child: Image.asset(
                  product.imagePath,
                  width: double.infinity,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 4),
              // Название продукта
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0), 
                child: Text(
                  product.name,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 4),
              // Цена и старая цена
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0), 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.price,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (product.oldPrice != null)
                      Text(
                        product.oldPrice!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                  ],
                ),
              ),
              Spacer(),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 30),
                  child: isInCart
                      ? _buildQuantityController(product)
                      : _buildAddToCartButton(product),
                ),
              ),
            ],
          ),
          // Кнопка добавления в избранное
          Positioned(
            top: 15,
            left: 15,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (isFavorite) {
                    favorites.remove(product);
                  } else {
                    favorites.add(product);
                  }
                });
              },
              child: SvgPicture.asset(
                isFavorite ? 'icon/HeartFill.svg' : 'icon/Heart.svg',
                width: 20,
                height: 20,
                color: isFavorite ? Colors.orange : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Кнопка добавления в корзину
  Widget _buildAddToCartButton(Product product) {
    bool isInCart = cart.containsKey(product); // Проверяем, находится ли продукт в корзине

    return SizedBox(
      width: 170, 
      height: 50, 
      child: Container(
        decoration: BoxDecoration(
          color: isInCart ? Colors.white : Colors.orange, 
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.orange),
        ),
        child: TextButton(
          onPressed: () {
            setState(() {
              cart[product] = 0.4; 
            });
          },
          child: SvgPicture.asset(
            'icon/Basket.svg',
            width: 24,
            height: 24,
            color: isInCart ? Colors.orange : Colors.white, 
          ),
        ),
      ),
    );
  }

  // Контроллер количества
  Widget _buildQuantityController(Product product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(30), 
        border: Border.all(color: Colors.orange, width: 1), 
      ),
      padding: EdgeInsets.symmetric(horizontal: 5), 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, 
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                double currentQty = cart[product]!;
                if (currentQty > 0.4) {
                  cart[product] = currentQty - 0.1;
                } else {
                  cart.remove(product);
                }
              });
            },
            icon: Icon(Icons.remove),
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              '${cart[product]!.toStringAsFixed(1)} кг',
              style: TextStyle(fontSize: 16),
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                cart[product] = cart[product]! + 0.1;
              });
            },
            icon: Icon(Icons.add),
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  String _getCategoryLabel(int index) {
    return [
      'Все товары',
      'Овощи и зелень',
      'Фрукты и ягоды',
      'Сладости',
      'Напитки', 
      'Сухофрукты',
      'Орехи и семечки',
    ][index];
  }

  IconData _getCategoryIcon(int index) {
    return [
    Icons.all_inclusive,        
    Icons.grass,   
    Icons.apple,   
    Icons.cake,            
    Icons.local_drink,  
    Icons.category,     
    Icons.local_florist, 
  ][index];
}
}

// Модель продукта
class Product {
  final String name;
  final String price;
  final String imagePath;
  final String? oldPrice;

  Product({
    required this.name,
    required this.price,
    required this.imagePath,
    this.oldPrice,
  });
}

// Список продуктов
final List<Product> products = [
  Product(
      name: 'Арбуз',
      price: '1234 руб/кг',
      imagePath: 'picture/Watermelon.png',
      oldPrice: '2356 руб/кг'
  ),
  Product(
    name: 'Клубника',
    price: '1234 руб/кг',
    imagePath: 'picture/Strawberry.png',
  ),
  Product(
    name: 'Ананас',
    price: '1234 руб/кг',
    imagePath: 'picture/Pinapple.png',
    oldPrice: '2356 руб/кг'
  ),
  Product(
    name: 'Яблоки',
    price: '1234 руб/кг',
    imagePath: 'picture/Apples.png',
    oldPrice: '2356 руб/кг'
  ),
  Product(
    name: 'Бананы с длинным названием',
    price: '1234 руб/кг',
    imagePath: 'picture/Bananas.png',
    oldPrice: '2356 руб/кг'
  ),
  Product(
    name: 'Папайя',
    price: '1234 руб/кг',
    imagePath: 'picture/Papaya.png',
    oldPrice: '2356 руб/кг'
  ),
];