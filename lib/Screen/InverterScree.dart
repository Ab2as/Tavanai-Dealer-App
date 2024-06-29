import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tavanai_registration_app/Widget/GridItem.dart';

class InverterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Inverter Screen',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto'),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 30,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.75, // Adjust as needed
            ),
            children: [
              GridItem(
                imageUrl:
                    'https://media.istockphoto.com/id/1202474729/vector/car-battery-icon.jpg?s=612x612&w=0&k=20&c=SjsQuB9s-c8ZnnLt1_JHwXkNnzQsoeIF3w12Nc5qjH8=',
                title: 'TIT-180',
                subtitle: '12v/180AH Capacity\n18 Months Warranty',
                onPressed: () {
                  print('Item 1 clicked');
                },
              ),
              GridItem(
                imageUrl:
                    'https://media.istockphoto.com/id/1202474729/vector/car-battery-icon.jpg?s=612x612&w=0&k=20&c=SjsQuB9s-c8ZnnLt1_JHwXkNnzQsoeIF3w12Nc5qjH8=',
                title: 'TIT-200',
                subtitle: '12v/200AH Capacity\n24 Months Warranty',
                onPressed: () {
                  print('Item 2 clicked');
                },
              ),
              GridItem(
                imageUrl:
                    'https://media.istockphoto.com/id/1202474729/vector/car-battery-icon.jpg?s=612x612&w=0&k=20&c=SjsQuB9s-c8ZnnLt1_JHwXkNnzQsoeIF3w12Nc5qjH8=',
                title: 'TIT-220',
                subtitle: '12v/220AH Capacity\n24 Months Warranty',
                onPressed: () {
                  print('Item 3 clicked');
                },
              ),
              GridItem(
                imageUrl:
                    'https://media.istockphoto.com/id/1202474729/vector/car-battery-icon.jpg?s=612x612&w=0&k=20&c=SjsQuB9s-c8ZnnLt1_JHwXkNnzQsoeIF3w12Nc5qjH8=',
                title: 'TIT-250',
                subtitle: '12v/250AH Capacity\n136 Months Warranty',
                onPressed: () {
                  print('Item 4 clicked');
                },
              ),
              GridItem(
                imageUrl:
                    'https://media.istockphoto.com/id/1202474729/vector/car-battery-icon.jpg?s=612x612&w=0&k=20&c=SjsQuB9s-c8ZnnLt1_JHwXkNnzQsoeIF3w12Nc5qjH8=',
                title: 'TIT-200 JUMBO',
                subtitle: '12v/200AH Capacity\n24 Months Warranty',
                onPressed: () {
                  print('Item 4 clicked');
                },
              ),
              GridItem(
                imageUrl:
                    'https://media.istockphoto.com/id/1202474729/vector/car-battery-icon.jpg?s=612x612&w=0&k=20&c=SjsQuB9s-c8ZnnLt1_JHwXkNnzQsoeIF3w12Nc5qjH8=',
                title: 'TIT-220 JUMBO',
                subtitle: '12v/220AH Capacity\n24 Months Warranty',
                onPressed: () {
                  print('Item 4 clicked');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
