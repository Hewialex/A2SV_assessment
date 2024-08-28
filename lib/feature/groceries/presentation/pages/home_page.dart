import 'package:flutter/material.dart';
import 'description_page.dart'; // Import the description page

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // List of grocery items (all with the same title, rating, and price)
    final List<Map<String, dynamic>> groceries = List.generate(6, (index) {
      return {
        'title': 'Chicken Burger',
        'imageUrl': 'https://via.placeholder.com/150', // Placeholder image
        'rating': 4.9,
        'price': '€5.99',
        'discountPrice': '€7.99', // Adding a higher discount price
        'description': 'Delicious chicken burger with a special sauce.', // Add a description
      };
    });

    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/images/Cheese_Burger.png', // Replace with your image path
              width: 24, // Adjust width as needed
              height: 24, // Adjust height as needed
            ),
            const SizedBox(width: 8),
            const Text(
              'Burger',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        elevation: 0, // Remove shadow if needed
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: const TextStyle(
                  color: Color.fromRGBO(186, 189, 193, 1), // Placeholder text color
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Color.fromRGBO(186, 189, 193, 1), // Search icon color
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(233, 234, 235, 1), // Border color
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(233, 234, 235, 1), // Border color when focused
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(233, 234, 235, 1), // Border color when enabled
                    width: 1.0,
                  ),
                ),
              ),
              onChanged: (value) {
                // Handle search logic here
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 160.5 / 187, // Aspect ratio for each card
                ),
                itemCount: groceries.length,
                itemBuilder: (context, index) {
                  final grocery = groceries[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DescriptionPage(
                            grocery: grocery,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 6,
                      shadowColor: const Color.fromRGBO(13, 10, 44, 0.06),
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12.0),
                                ),
                                child: Image.network(
                                  grocery['imageUrl'],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 100,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      grocery['title'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12, // Adjusted font size
                                        color: Colors.black, // Title text color
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        // Discount price
                                        Text(
                                          grocery['discountPrice'],
                                          style: TextStyle(
                                            fontSize: 12, // Adjusted font size
                                            color: Color.fromRGBO(186, 189, 193, 1), // Discount price color
                                            decoration: TextDecoration.lineThrough, // Line through for discount
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        // Main price
                                        Text(
                                          grocery['price'],
                                          style: const TextStyle(
                                            fontSize: 12, // Adjusted font size
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(255, 99, 71, 1), // Main price color
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 16,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          '${grocery['rating']}',
                                          style: const TextStyle(
                                            fontSize: 12, // Adjusted font size
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white, // Circle background color
                                border: Border.all(
                                  color: Colors.white, // Tomato color border
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.favorite_border, // Use heart outline
                                  color: Color.fromRGBO(255, 99, 71, 1), // Tomato color icon
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
