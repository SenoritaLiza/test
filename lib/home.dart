import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Основной контент
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 16.0), 
                child: _buildSearchBar(),
              ),

              SizedBox(height: 20), 

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Акции',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 20),
              _buildPromotionsSection(),
              SizedBox(height: 10),
              _buildPopularSection(),
              SizedBox(height: 0),
              _buildCategoriesSection(),
              SizedBox(height: 60), 
            ],
          ),
        ),
        // Корзина
        Align(
          alignment: Alignment.bottomCenter,
          child: _buildCartSummary(),
        ),
      ],
    );
  }

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
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromotionsSection() {
    return Container(
      height: 184,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildPromotionCard(
            'picture/PromoWatermelon.png', 
            'с 18 февраля по 16 марта',
            'Больше — выгодней',
          ),
          _buildPromotionCard(
            'picture/PromoPapaya.png',
            'с 18 февраля по 16 марта',
            'Больше — выгодней',
          ),
        ],
      ),
    );
  }

  // Карточка акции с параметрами для изображения и текста
  Widget _buildPromotionCard(String imagePath, String date, String title) {
  return Container(
    width: 327, // Ширина каждой карточки акции
    margin: EdgeInsets.only(left: 24),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 6,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          imagePath,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 100, 
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date,
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
              SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

  Widget _buildPopularSection() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Популярное',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Смотреть все',
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 320,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: _buildPopularItem(
                    'picture/Strawberry.png', 
                    'Клубника',
                    '1234 руб/кг',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 24),
                child: _buildMoreButton(), 
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Элемент раздела "Популярное"
  Widget _buildPopularItem(String imagePath, String name, String price) {
    return Container(
      width: 187,
      height: 320,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(0), 
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(0), 
            ),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 112,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Text(
                  name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  price,
                  style: TextStyle(fontSize: 14, color: Colors.orange),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Кнопка "Показать еще"
  Widget _buildMoreButton() {
    return Container(
      width: 187,
      height: 270,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(0),
        border: Border.all(color: Colors.orange),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('icon/ArrowRight.svg'),
            Text(
              'Показать еще',
              style: TextStyle(color: Colors.orange),
            ),
          ],
        ),
      ),
    );
  }

  // Раздел "Категории товаров"
  Widget _buildCategoriesSection() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Категории товаров',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          Column(
            children: [
              _buildCategoryItem('picture/VegetablesGreens.png'),
              _buildCategoryItem('picture/FruitsBerries.png'),
              _buildCategoryItem('picture/DriedFruits.png'),
              _buildCategoryItem('picture/NutsSeeds.png'),
              _buildCategoryItem('picture/Sweets.png'),
              _buildCategoryItem('picture/Drinks.png'),
              _buildCategoryItem('picture/NutpustesUrbechi.png'),
              _buildCategoryItem('picture/HoneyCreamhoney.png'),
              _buildCategoryItem('picture/Jam.png'),
              _buildCategoryItem('picture/Freezing.png'),
              _buildCategoryItem('picture/Cereals.png'),
            ],
          ),
        ],
      ),
    );
  }

  // Элемент категории товара
  Widget _buildCategoryItem(String imagePath) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Stack(
        children: [
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 72,
          ),
        ],
      ),
    );
  }
  
  // Отображения корзины
  Widget _buildCartSummary() {
    return Container(
      height: 48, 
      color: Color(0xFFA3D043), 
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(width: 16), 
              SvgPicture.asset(
                'icon/Basket.svg', 
                width: 32,
                height: 32,
                color: Colors.white,
              ),
              SizedBox(width: 10),
              Text(
                'В корзине: ',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '0 руб.',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8),
              SvgPicture.asset('picture/Basket.svg')
            ],
          ),
        ],
      ),
    );
  }
}