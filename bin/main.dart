import 'package:ppcea/ler_dados.dart';
// import 'package:ppcea/ppcea.dart' as ppcea;

main(List<String> arguments) {
  LerDados a = LerDados('dados/a.txt');
  a.ler();
  print(a.toString());
  // print('Hello world: ${ppcea.calculate()}!');
}
