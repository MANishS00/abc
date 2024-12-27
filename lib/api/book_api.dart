import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; // Use SharedPreferences instead of LocalStorage
import '../models/book_model.dart';
import '../service/api_adress.dart';

class BookState with ChangeNotifier {
  List<Book> _books = [];

  // Method to get SharedPreferences instance
  Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  // Fetch books from the API with the stored token
  Future<bool> getBooks() async {
    SharedPreferences prefs = await _getPrefs();
    String? token = prefs.getString('token');

    if (token == null) {
      print("Token not found!");
      return false;
    }

    String url = '$baseUrl:8000/api/v1/books/';
    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Content-Type": "application/json",
        'Authorization': "token $token"
      });

      print("Response: ${response.body}");

      if (response.statusCode == 200) {
        var data = json.decode(response.body) as List;

        List<Book> temp = data.map((json) => Book.fromJson(json)).toList();

        _books = temp;
        notifyListeners();
        return true;
      } else {
        print("Failed to load books. Status code: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Error fetching books: $e");
      return false;
    }
  }

  // Search for books using a query
  static Future<String> searchBook(String query) async {
    String url = '$baseUrl:8000/api/v1/books-filter/?search=$query';
    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Content-Type": "application/json",
      });

      if (response.statusCode == 200) {
        return response.body;
      } else {
        print("Failed to search books. Status code: ${response.statusCode}");
        return '';
      }
    } catch (e) {
      print("Error searching books: $e");
      return '';
    }
  }

  // Handle the favorite button click and add to favorites
  Future<void> favoriteButton(int id) async {
    SharedPreferences prefs = await _getPrefs(); // Get SharedPreferences instance
    String? token = prefs.getString('token'); // Retrieve token

    if (token == null) {
      print("Token not found!");
      return;
    }

    String url = '$baseUrl:8000/api/v1/favorites/';
    try {
      http.Response response = await http.post(Uri.parse(url),
          body: json.encode({'id': id}),
          headers: {
            "Content-Type": "application/json",
            'Authorization': "token $token"
          });

      var data = json.decode(response.body);
      print(data);

      // Reload books after favoriting
      await getBooks();
    } catch (e) {
      print("Error in favoriteButton: $e");
    }
  }

  // Getter for all books
  List<Book> get books {
    return [..._books];
  }

  // Getter for favorite books
  List<Book> get favorite {
    return _books.where((element) => element.favorite == true).toList();
  }

  // Get a single book by ID
  Book singleBook(int id) {
    return _books.firstWhere((element) => element.id == id);
  }
}
