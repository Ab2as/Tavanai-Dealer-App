import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tavanai_registration_app/Widget/GridItem.dart';

class AutomotiveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Automotive Screen',
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
                title: 'TIB-105',
                subtitle: '12v/105AH Capacity\n12+6 Months Warranty',
                onPressed: () {
                  print('Item 1 clicked');
                },
              ),
              GridItem(
                imageUrl:
                    'https://media.istockphoto.com/id/1202474729/vector/car-battery-icon.jpg?s=612x612&w=0&k=20&c=SjsQuB9s-c8ZnnLt1_JHwXkNnzQsoeIF3w12Nc5qjH8=',
                title: 'TIB-110',
                subtitle: '12v/110AH Capacity\n18 Months Warranty',
                onPressed: () {
                  print('Item 2 clicked');
                },
              ),
              GridItem(
                imageUrl:
                    'https://media.istockphoto.com/id/1202474729/vector/car-battery-icon.jpg?s=612x612&w=0&k=20&c=SjsQuB9s-c8ZnnLt1_JHwXkNnzQsoeIF3w12Nc5qjH8=',
                title: 'TIB-400',
                subtitle: '12v/35AH Capacity\n12 Months Warranty',
                onPressed: () {
                  print('Item 3 clicked');
                },
              ),
              GridItem(
                imageUrl:
                    'https://media.istockphoto.com/id/1202474729/vector/car-battery-icon.jpg?s=612x612&w=0&k=20&c=SjsQuB9s-c8ZnnLt1_JHwXkNnzQsoeIF3w12Nc5qjH8=',
                title: 'TIB-450',
                subtitle: '12v/38AH Capacity\n18 Months Warranty',
                onPressed: () {
                  print('Item 4 clicked');
                },
              ),
              GridItem(
                imageUrl:
                    'https://media.istockphoto.com/id/1202474729/vector/car-battery-icon.jpg?s=612x612&w=0&k=20&c=SjsQuB9s-c8ZnnLt1_JHwXkNnzQsoeIF3w12Nc5qjH8=',
                title: 'TIB-600',
                subtitle: '12v/65AH Capacity\n12 Months Warranty',
                onPressed: () {
                  print('Item 4 clicked');
                },
              ),
              GridItem(
                imageUrl:
                    'https://media.istockphoto.com/id/1202474729/vector/car-battery-icon.jpg?s=612x612&w=0&k=20&c=SjsQuB9s-c8ZnnLt1_JHwXkNnzQsoeIF3w12Nc5qjH8=',
                title: 'TIB-700',
                subtitle: '12v/75AH Capacity\n18 Months Warranty',
                onPressed: () {
                  print('Item 4 clicked');
                },
              ),
              GridItem(
                imageUrl:
                    'https://media.istockphoto.com/id/1202474729/vector/car-battery-icon.jpg?s=612x612&w=0&k=20&c=SjsQuB9s-c8ZnnLt1_JHwXkNnzQsoeIF3w12Nc5qjH8=',
                title: 'TIB-750',
                subtitle: '12v/80AH Capacity\n12 Months Warranty',
                onPressed: () {
                  print('Item 4 clicked');
                },
              ),
              GridItem(
                imageUrl:
                    'https://media.istockphoto.com/id/1202474729/vector/car-battery-icon.jpg?s=612x612&w=0&k=20&c=SjsQuB9s-c8ZnnLt1_JHwXkNnzQsoeIF3w12Nc5qjH8=',
                title: 'TIB-850',
                subtitle: '12v/99AH Capacity\n18 Months Warranty',
                onPressed: () {
                  print('Item 4 clicked');
                },
              ),
              GridItem(
                imageUrl:
                    'https://media.istockphoto.com/id/1202474729/vector/car-battery-icon.jpg?s=612x612&w=0&k=20&c=SjsQuB9s-c8ZnnLt1_JHwXkNnzQsoeIF3w12Nc5qjH8=',
                title: 'TIB-1350',
                subtitle: '12v/150AH Capacity\n12 Months Warranty',
                onPressed: () {
                  print('Item 4 clicked');
                },
              ),
              GridItem(
                imageUrl:
                    'https://media.istockphoto.com/id/1202474729/vector/car-battery-icon.jpg?s=612x612&w=0&k=20&c=SjsQuB9s-c8ZnnLt1_JHwXkNnzQsoeIF3w12Nc5qjH8=',
                title: 'TIB-1500',
                subtitle: '12v/150AH Capacity\n18 Months Warranty',
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
