import 'package:flutter/painting.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:convert';
import 'dart:html';

Future <void> crearRecibo (
    String idMovimiento, //listo
    String cantidad, //listo
    String tipoPago, //listo
    String fechaMovimiento, //listo
    String motivoPago, //listo
    String edificio,
    String numeroCasa,
    String condominio,
    String fechaActual
    ) async{
  PdfDocument document = PdfDocument ();

  final page = document.pages.add();

  PdfTextElement element =
  PdfTextElement(text: 'INVOICE 001');
  element.brush = PdfBrushes.white;

  element = PdfTextElement(
      text: 'Asociacion de propietarios Real Verona A.C',
      font: PdfStandardFont(PdfFontFamily.timesRoman, 25,
          style: PdfFontStyle.bold),
  );
  element.brush = PdfSolidBrush(PdfColor(126, 155, 203));

  PdfLayoutResult result = element.draw(
      page: page);

  result = element.draw(
      page: page);

  //nuevo elemento en el pdf

  element = PdfTextElement(text: 'Id Movimiento: $idMovimiento',
      font: PdfStandardFont(PdfFontFamily.courier, 30));
  element.brush = PdfBrushes.black;
  result = element.draw(
      page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 25, 0, 0));

  //nuevo elemento en el pdf

  element = PdfTextElement(text: 'Cantidad: $cantidad ',
      font: PdfStandardFont(PdfFontFamily.courier, 30));
  element.brush = PdfBrushes.black;
  result = element.draw(
      page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 25, 0, 0));

  //nuevo elemento en el pdf

  element = PdfTextElement(text: 'Metodo de pago: $tipoPago',
      font: PdfStandardFont(PdfFontFamily.courier, 30));
  element.brush = PdfBrushes.black;
  result = element.draw(
      page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 25, 0, 0));

  //nuevo elemento en el pdf

  element = PdfTextElement(text: 'Fecha del movimiento:',
      font: PdfStandardFont(PdfFontFamily.courier, 30));
  element.brush = PdfBrushes.black;
  result = element.draw(
      page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 25, 0, 0));

  //nuevo elemento en el pdf

  element = PdfTextElement(text: '$fechaMovimiento',
      font: PdfStandardFont(PdfFontFamily.courier, 30));
  element.brush = PdfBrushes.black;
  result = element.draw(
      page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 25, 0, 0));

  //nuevo elemento en el pdf

  element = PdfTextElement(text: 'Motivo:',
      font: PdfStandardFont(PdfFontFamily.courier, 30));
  element.brush = PdfBrushes.black;
  result = element.draw(
      page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 25, 0, 0));

  //nuevo elemento en el pdf

  element = PdfTextElement(text: '$motivoPago',
      font: PdfStandardFont(PdfFontFamily.courier, 20));
  element.brush = PdfBrushes.black;
  result = element.draw(
      page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 25, 0, 0));

  //nuevo elemento en el pdf

  element = PdfTextElement(text: 'Edificio: $edificio ',
      font: PdfStandardFont(PdfFontFamily.courier, 30));
  element.brush = PdfBrushes.black;
  result = element.draw(
      page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 25, 0, 0));

  //nuevo elemento en el pdf

  element = PdfTextElement(text: 'Número de casa: $numeroCasa ',
      font: PdfStandardFont(PdfFontFamily.courier, 30));
  element.brush = PdfBrushes.black;
  result = element.draw(
      page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 25, 0, 0));

  //nuevo elemento en el pdf

  element = PdfTextElement(text: 'Condominio: $condominio ',
      font: PdfStandardFont(PdfFontFamily.courier, 30));
  element.brush = PdfBrushes.black;
  result = element.draw(
      page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 25, 0, 0));

  //nuevo elemento en el pdf

  element = PdfTextElement(text: 'Fecha Actual: $fechaActual',
      font: PdfStandardFont(PdfFontFamily.courier, 30));
  element.brush = PdfBrushes.black;
  result = element.draw(
      page: page, bounds: Rect.fromLTWH(10, result.bounds.bottom + 25, 0, 0));


  final bytes = document.save();
  document.dispose();
  AnchorElement(
      href:
      "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
    ..setAttribute("download", "output.pdf")
    ..click();
}