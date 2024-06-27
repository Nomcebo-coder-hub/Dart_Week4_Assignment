import 'dart:io';

abstract class Displayable {
  void display();
}

class LibraryItem {
  String title;
  String author;

  LibraryItem(this.title, this.author);

  void showInfo() {
    print('Title: $title, Author: $author');
  }
}

class Book extends LibraryItem implements Displayable {
  String isbn;

  Book(String title, String author, this.isbn) : super(title, author);

  @override
  void showInfo() {
    print('Book - Title: $title, Author: $author, ISBN: $isbn');
  }

  @override
  void display() {
    print('Displaying book info:');
    showInfo();
  }
}

Future<List<Book>> readBooksFromFile(String filePath) async {
  final file = File(filePath);
  List<Book> books = [];

  if (await file.exists()) {
    List<String> lines = await file.readAsLines();

    for (String line in lines) {
      List<String> parts = line.split(',');
      if (parts.length == 3) {
        books.add(Book(parts[0], parts[1], parts[2]));
      }
    }
  } else {
    print('File not found: $filePath');
  }

  return books;
}

void displayBooks(List<Book> books) {
  for (Book book in books) {
    book.display();
  }
}

void main() async {
  String filePath = 'books.txt';
  List<Book> books = await readBooksFromFile(filePath);

  displayBooks(books);
}
