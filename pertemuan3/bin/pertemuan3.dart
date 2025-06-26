import 'animal.dart'
void main (){
  buatkopi();

  Animal kucing = Animal (name:"oren",species: "oren",age: :1, gender: "jantan" );

  print(kucing.name);
  kucing.makan("tumbuhan");

}


//Positional Parameter (Parameter harus berurutan)
//Named Parameter (Parameter yang di beri nama tidak harus berurutan)
//Opsional Prameter
void buatkopi(int air, int koipi, int gula){
    if(air ==500 && kopi ==100 && gula == 0) {
      print("Ini espresso");
    }else if(air > 500 && kopi > 100 && gula >100){
      print("Ini Kapal Api");
    }else if(air == 0 && kopi > 500 && gula >200){
      print("Ini Kopi belum di seduh");
    }else if(air == 0 && kopi > 600 && gula >500)
      print("Ini Kopi Expresco");{
      }else {
        print("jenis kopi tidak");
      }
}