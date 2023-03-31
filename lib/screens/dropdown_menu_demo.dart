import 'package:flutter/material.dart';

class DropdownMenuDemo extends StatefulWidget {
  const DropdownMenuDemo({super.key});

  static const routeName = '/dropdown_menu_demo';

  @override
  State<DropdownMenuDemo> createState() => _DropdownMenuDemoState();
}

class _DropdownMenuDemoState extends State<DropdownMenuDemo> {
  final TextEditingController _controller = TextEditingController();

  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dropdown Menu Demo'),
      ),
      body: Center(
        child: Focus(
          focusNode: focusNode,
          onFocusChange: (value) {
            if (!value) {
              if (categoryIcons.keys.contains(_controller.text)) {
                _controller.text = categoryIcons.keys.elementAt(
                    categoryIcons.keys.toList().indexOf(_controller.text));
              } else {
                _controller.text = 'ყველა ვაკანსია';
              }
            }
          },
          child: Expanded(
            child: DropdownMenu(
                enableSearch: false,
                enableFilter: false,
                menuHeight: 350,
                controller: _controller,
                dropdownMenuEntries:
                    List.generate(categoryIcons.length, (index) {
                  return DropdownMenuEntry(
                      value: categoryIcons.keys.elementAt(index),
                      label: categoryIcons.keys.elementAt(index));
                })),
          ),
        ),
      ),
    );
  }
}

const Map<String, IconData> categoryIcons = {
  'ყველა კატეგორია': Icons.all_inclusive,
  'ადმინისტრაცია/მენეჯმენტი': Icons.business,
  'ფინანსები/სტატისტიკა': Icons.attach_money_outlined,
  'გაყიდვები': Icons.shopping_cart_outlined,
  'PR/მარკეტინგი': Icons.insights,
  'ზოგადი ტექნიკური პერსონალი': Icons.group,
  'ლოგისტიკა/ტრანსპორტი/დისტრიბუცია': Icons.local_shipping_outlined,
  'მშენებლობა/რემონტი': Icons.home_outlined,
  'დასუფთავება': Icons.local_laundry_service_outlined,
  'დაცვა/უსაფრთხოება': Icons.security_outlined,
  'IT/პროგრამირება': Icons.code,
  'მედია/გამომცემლობა': Icons.library_books_outlined,
  'განათლება': Icons.school_outlined,
  'სამართალი': Icons.gavel_outlined,
  'მედიცინა/ფარმაცია': Icons.local_pharmacy_outlined,
  'სილამაზე/მოდა': Icons.face_outlined,
  'კვება': Icons.restaurant_outlined,
  'სხვა': Icons.more_horiz_outlined
};
