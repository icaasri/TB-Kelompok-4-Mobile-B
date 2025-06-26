class Animal {
   final String name;
   final String species;
   final int age;
   final String gender;

  //Constructor
   Animal({required this.name, required this.species,required this.age,required this.gender });

void makan(String makanan){
  if (makanan == "daging") {
    print("Ini hewan karnivora");
  }else if (makanan == "tumbuhan"){
    print("Ini hewan herbivora");
  }else {
    print("Ini jenis hewan omnivora");
  }
}
}

//aturan penamaan
/*
nama class wajib Capitalize

atribut & variable & nama fungsi
wajib camelCase

*/

class cat extends Animal {

}