import 'dart:io';
import 'package:mongo_dart/mongo_dart.dart';

class Template1 {
  Template1();
  StringBuffer template = StringBuffer();

  void executar() async {
    Db db = Db('mongodb://localhost:27017/ppcea1');
    await db.open();
    print('conectado ao mongo');
    DbCollection discCol = db.collection('disciplina');
    DbCollection prereqCol = db.collection('prerequisito');
    DbCollection ementaCol = db.collection('ementa');
    DbCollection bibCol = db.collection('bibliografia');

    var discList = await discCol.find().toList();
    for (var disc in discList) {
      String nome = limparAcentos(disc['nome']);
      print(nome);
      var saida =
          File("./dados/template1/${nome}.tex").openWrite(mode: FileMode.write);
      template.clear();
      beginDocument();
      template.writeln('\nDisciplina: ${disc['nome']}');
      template.writeln('\nCódigo: ${disc['codigo']}');
      template.writeln('\nPeríodo: ${disc['periodo']}');
      template.writeln('\nCategoria: ${disc['categoria']}');
      template.writeln('\nCH Teórica: ${disc['chteorica']}');
      template.writeln('\nCH Prática: ${disc['chpratica']}');
      //+++ PreReq
      template.write('\n\n\n\nPré-requisito:');
      template.writeln();
      template.write(r'\begin{enumerate}');
      template.writeln();
      var prereqList = await prereqCol.find({'id': disc['id']}).toList();
      for (var prereq in prereqList) {
        print("* ${prereq['disc_prereq_nome']}");
        template.write(r"\item ");
        template.write("${prereq['disc_prereq_nome']}");
        template.writeln();
      }
      template.write(r'\end{enumerate}');
      //--- PreReq
      //+++ Ementa
      template.write('\n\nEmenta:');
      template.writeln();
      template.write(r'\begin{enumerate}');
      template.writeln();
      var ementaList = await ementaCol.find({'disc_id': disc['id']}).toList();
      ementaList.sort((a, b) => a['ordem'].compareTo(b['ordem']));
      for (var ementa in ementaList) {
        print("* ${ementa['item']}");
        template.write(r"\item ");
        template.write("${ementa['item']}");
        template.writeln();
      }
      template.write(r'\end{enumerate}');
      //--- Ementa

      // //+++ Bibliografia lista
      // template.write('\n\nBibliografia:');
      // template.writeln();
      // template.write(r'\begin{enumerate}');
      // template.writeln();
      // var bibList = await bibCol.find({'disc_id': disc['id']}).toList();
      // for (var bib in bibList) {
      //   print("* ${bib['citacao']}");
      //   template.write(r"\item ");
      //   template.write("Qde: ${bib['quantidade']} - Tipo: ${bib['tipo']} - Uso: ${bib['uso']} - isbn-issn: ${bib['isbn_issn']} - Citação: ${bib['citacao']}");
      //   template.writeln();
      // }
      // template.write(r'\end{enumerate}');
      // //--- Bibliografia Lista

      //+++ Bibliografia tabela
      template.write('\n\n\n\nBibliografia:\n\n');
      template.writeln();
      template.write(r'\begin{tabular}{llllp{8cm}}');
      template.writeln();
      template.write(r"Qde & Tipo & Uso & isbn-issn & Citação \\");
      template.writeln();
      var bibList2 = await bibCol.find({'disc_id': disc['id']}).toList();
      bibList2.sort((a, b) => a['uso'].compareTo(b['uso']));
      for (var bib in bibList2) {
        print("* ${bib['citacao']}");
        template.write(
            "${bib['quantidade']}&${bib['tipo']}&${bib['uso']}&${bib['isbn_issn']}&${bib['citacao']}\\\\");
        template.writeln();
      }
      template.write(r'\end{tabular}');
      //--- Bibliografia tabela

      endDocument();
      saida.write(template.toString());
      await saida.close();
    }
  }

  String limparAcentos(String texto) {
    return texto
        .trim()
        .replaceAll(' ', '-')
        .replaceAll('ç', 'c')
        .replaceAll('â', 'a')
        .replaceAll('ã', 'a')
        .replaceAll('á', 'a')
        .replaceAll('é', 'e')
        .replaceAll(',', '')
        .replaceAll('ó', 'o')
        .replaceAll('õ', 'o')
        .replaceAll('í', 'i')
        .replaceAll('ú', 'u');
  }

  void beginDocument() {
    template.write(r"""
\documentclass[12pt,a4paper,twoside]{report}
%+++ PACOTES
%\usepackage[portuges]{babel} 
\usepackage[utf8]{inputenc} 
%--- PACOTES
%+++ LAYOUT DA PAGINA
\setlength{\topmargin}{1.0cm} 
\setlength{\headheight}{0.0cm} 
\setlength{\headsep}{0.5cm} 
\setlength{\textheight}{26cm} 
\setlength{\oddsidemargin}{1.0cm} 
\setlength{\evensidemargin}{1.0cm} 
\setlength{\textwidth}{19cm} 
\setlength{\footskip}{1cm} 
\setlength{\columnsep}{.5cm} 
\addtolength{\oddsidemargin}{-1in} 
\addtolength{\evensidemargin}{-1in} 
\addtolength{\topmargin}{-1in}
%--- LAYOUT DA PAGINA
\begin{document}

""");
  }

  void endDocument() {
    template.write(r"""


\end{document}
    """);
  }
}
