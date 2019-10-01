import 'dart:io';

class LerDados {
  final String arquivo;
  String dado;
  LerDados(this.arquivo);

  void ler() {
    print('Lendo do arquivo...');
    File file = File(arquivo);
    dado = file.readAsStringSync();
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Arquivo: ${arquivo}. Dado ${dado}';
  }
}
