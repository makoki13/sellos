import 'dart:io';
import 'dart:convert' show utf8, LineSplitter;
Future<void> main(List<String> arguments) async {
  var ficheroOrigen = '../sellos_plantilla.json';  
  var ficheroDestino = 'sellos_test.json';

  final destino = File(ficheroDestino).openWrite(mode: FileMode.write);
  final origen = utf8.decoder
      .bind(File(ficheroOrigen).openRead())
      .transform(const LineSplitter());

  
  try {    
    bool lineaAnteriorEsJson = false;
    await for (final linea in origen) {      
      if (linea.contains('.json') == true) {
        if (lineaAnteriorEsJson == true) {
          guardaLineaSinCodificar(destino,",");
        }
        await inoculaFicheroAnyos(destino,linea);
        lineaAnteriorEsJson = true;
      }
      else {      
        guardaLineaSinCodificar(destino,linea);
        lineaAnteriorEsJson = false;
      }
    }
  } catch (_) {    
    await _handleError(ficheroOrigen);
  }

  await destino.close();
}

Future<void> _handleError(String path) async {
  stderr.writeln('error: $path');
  
}

void guardaLineaSinCodificar(destino,linea) {
  stdout.writeln(linea);
  destino.writeln(linea);
}

Future<void> inoculaFicheroAnyos(destino,linea) async {
  String ficheroTrimmed = linea.toString().trim();
  if (ficheroTrimmed.substring(1,7) != "schema") {
    String fichero = '';
    if (ficheroTrimmed.substring(ficheroTrimmed.length - 1,ficheroTrimmed.length) == ',' ) {    
      fichero = ficheroTrimmed.substring(1,ficheroTrimmed.length-2);
    }
    else {
      fichero = ficheroTrimmed.substring(1,ficheroTrimmed.length-1);
    }  
    String anyo = fichero.substring(0,4);
    String ficheroOrigen = "../series/" + anyo + "/" + fichero;
    //print("@" + ficheroOrigen + "@");

    final origen = utf8.decoder
        .bind(File(ficheroOrigen).openRead())
        .transform(const LineSplitter());

    try {          
      await for (final linea in origen) {        
        if (linea.contains('.json') == true) {
          //inoculaFicheroAnyos(destino,linea);
          guardaLineaSinCodificar(destino,linea);
        }
        else {      
          //print(linea);
          guardaLineaSinCodificar(destino,linea);
        }
      }
    } catch (_) {      
      await _handleError(ficheroOrigen);
    }
  }
}
