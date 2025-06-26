
void main(){
  // VARIABLE
  // x = 5
  // y = 10
  //DEKLARASI VARIABLE
  String name = "Bubuy"; // String
  int age = 20; //  Integer
  double weight = 50.5; //Double
  bool isTall = false; // Boolean
  List <String> fruits = ["Strawbery", "Orange",]; // List
  Map<String, String> countries = {
    //KEY | VALUE
  "country": "Japan","capital_city":"Tokyo"
  };//Map

/*Hallo nama saya bubuy,berumur 20 tahun dengan berat badan 50,5 dan saya menyukai buah-buahan berikut[],dan ini kota yang ingin saya kunjungi{
\"country\": \"Japan\",
\"capital_city\":"Tokyo"}*/

print(
"Hallo nama saya $name,berumur $age tahun dengan berat badan $weight dan saya menyukai buah-buahan berikut $fruits[],dan ini kota yang ingin saya kunjungi $countries",
);
}