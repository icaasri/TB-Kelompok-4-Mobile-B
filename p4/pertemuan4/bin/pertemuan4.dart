// Abstraction (Abstraksi)
abstract class Animal {
  String name;
  int age;

  Animal(this.name, this.age);

  void makeSound(); // Abstract method
}

// Inheritance (Pewarisan) dan Encapsulation (Enkapsulasi)
class Rabbit extends Animal {
  String _color; // Private field

  Rabbit(String name, int age, this._color) : super(name, age);

  // Getter dan Setter (Encapsulation)
  String get color => _color;
  set color(String newColor) {
    if (newColor.isNotEmpty) {
      _color = newColor;
    }
  }

  // Polymorphism (Polimorfisme)
  @override
  void makeSound() {
    print("$name: ha ha! ");
  }

  void showInfo() {
    print("Hewan: $name, Usia: $age tahun, Warna: $_color");
  }
}

void main() {
  // Membuat objek Rabbit dengan dua nama berbeda
  Rabbit melody = Rabbit("Melody", 1, "Putih");
  Rabbit kuromi = Rabbit("Kuromi", 2, "abu");

  // Menampilkan informasi kelinci
  melody.showInfo();
  melody.makeSound();

  kuromi.showInfo();
  kuromi.makeSound();

  // Mengubah warna Kuromi melalui setter
  kuromi.color = "pink";

  // Menampilkan informasi setelah perubahan
  kuromi.showInfo();
}
