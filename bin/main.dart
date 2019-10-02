import 'package:ppcea/ler_dados.dart';
import 'package:ppcea/ppcea.dart' as ppcea;
import 'package:mongo_dart/mongo_dart.dart';

main(List<String> arguments) async {
  // print('Hello world: ${ppcea.calculate()}!');
  LerDados a = LerDados('dados/a.txt');
  // a.ler();
  // print(a.toString());
  Db db = Db('mongodb://localhost:27017/ppcea2');
  await db.open();
  print('conectado ao mongo');

  DbCollection discCol = db.collection('disciplina');

  var disc = await discCol.find().toList();
  print(disc);

  // var disc = await discCol.find(where.eq('id', 125)).toList();
  // print(disc);

//   var disc = await discCol.find();
// await disc.listen((Map<String,dynamic> doc){
// for (var item in doc.entries) {
//   // print(item.key);
//   print(item.value);
// }
// });

  // await db.close();
}
