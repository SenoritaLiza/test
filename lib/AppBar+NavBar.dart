import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food/catalog.dart';
import 'home.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(90);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool _isDeliverySelected = true; // Состояние активной кнопки

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildDeliveryButton(context),
                _buildPickupButton(context),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'ул. Родионова, 13',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(width: 5),
                    SvgPicture.asset('icon/Edit.svg'),
                  ],
                ),
                _buildPriceButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Кнопка "Доставка"
  Widget _buildDeliveryButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isDeliverySelected = true; // Устанавливаем активную кнопку
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2, 
        height: 40,
        decoration: BoxDecoration(
          color: _isDeliverySelected ? Colors.lightGreen : Colors.grey[200],
        ),
        child: Center(
          child: Text(
            'Доставка',
            style: TextStyle(
              color: _isDeliverySelected ? Colors.white : Colors.black,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  // Кнопка "Забери сам"
  Widget _buildPickupButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isDeliverySelected = false; // Устанавливаем активную кнопку
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2, 
        height: 40,
        decoration: BoxDecoration(
          color: !_isDeliverySelected ? Colors.lightGreen : Colors.grey[200],
        ),
        child: Center(
          child: Text(
            'Забери сам',
            style: TextStyle(
              color: !_isDeliverySelected ? Colors.white : Colors.black,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  // Кнопка с отображением цены
  Widget _buildPriceButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          SvgPicture.asset('icon/Dollar.svg'),
          SizedBox(width: 5),
          Text(
            '38',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

// Панель навигации
class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState
    extends State<CustomBottomNavigationBar> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeContent(),
    CatalogScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: [
          _buildNavItem('icon/Home.svg', 'Главная', 0),
          _buildNavItem('icon/Catalog.svg', 'Каталог', 1),
          _buildNavItem('icon/User.svg', 'Профиль', 2),
          _buildNavItem('icon/Like.svg', 'Избранное', 3),
          _buildNavItem('icon/Shop.svg', 'Магазины', 4),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
      String assetPath, String label, int index) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        assetPath,
        width: 24,
        height: 24,
        color: _currentIndex == index ? Colors.green : Colors.grey,
      ),
      label: label,
    );
  }
}