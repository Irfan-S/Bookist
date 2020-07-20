class Book {
  final String assetName;
  final String isbn;
  final String title;
  final List<String> author;
  final String description;
  final String publisher;
  final List<String> notes;
  final List<String> chapters;

  Book(this.assetName, this.isbn, this.title, this.author, this.description,
      this.publisher, this.notes, this.chapters);

  static final List<Book> books = [
    Book('art_of_choosing_book.jpg', '112', 'Art Of Choosing',
        ['Sheena Iyengar'], 'How to choose everything', 'Penguin', [], []),
    Book('creativity_book.jpg', '132', 'Creativity Rules', ['Tina Seelig'],
        'Creativity is innate, you gotta unleash it', 'Penguin', [], []),
    Book('drive_book.jpg', '123', 'Drive', ['Daniel H. Pink'],
        'What drives us all, and how to drive yourself', 'Giraffe', [], []),
    Book('shoe_dog.jpg', '222', 'Shoe Dog', ['Phil Knight'],
        'Nike and how it was started', 'Penguin', [], []),
    Book(
        'thinking_book.jpg',
        '212',
        'Thinking, Fast and Slow',
        ['Daniel Kahneman'],
        'How to think and how we think',
        'Penguin',
        [],
        []),
    Book('art_of_choosing_book.jpg', '112', 'Art Of Choosing',
        ['Sheena Iyengar'], 'How to choose everything', 'Penguin', [], []),
    Book('art_of_choosing_book.jpg', '112', 'Art Of Choosing',
        ['Sheena Iyengar'], 'How to choose everything', 'Penguin', [], []),
    Book('art_of_choosing_book.jpg', '112', 'Art Of Choosing',
        ['Sheena Iyengar'], 'How to choose everything', 'Penguin', [], []),
    Book('art_of_choosing_book.jpg', '112', 'Art Of Choosing',
        ['Sheena Iyengar'], 'How to choose everything', 'Penguin', [], []),
    Book('art_of_choosing_book.jpg', '112', 'Art Of Choosing',
        ['Sheena Iyengar'], 'How to choose everything', 'Penguin', [], []),
    Book('art_of_choosing_book.jpg', '112', 'Art Of Choosing',
        ['Sheena Iyengar'], 'How to choose everything', 'Penguin', [], []),
    Book('art_of_choosing_book.jpg', '112', 'Art Of Choosing',
        ['Sheena Iyengar'], 'How to choose everything', 'Penguin', [], [])
  ];
}
