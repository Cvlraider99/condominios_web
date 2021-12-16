import 'package:condominios_web/manejoInfo/formatoContabilidad.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:convert';
import 'dart:html';


Future <void> crearInforme (listaVentas, int totalEnRecibo) async{

  //Creates a new PDF document
  PdfDocument document = PdfDocument();

//Adds page settings
  document.pageSettings.orientation = PdfPageOrientation.landscape;
  document.pageSettings.margins.all = 50;

//Adds a page to the document
  PdfPage page = document.pages.add();
  PdfGraphics graphics = page.graphics;

  PdfBrush solidBrush = PdfSolidBrush(PdfColor(126, 151, 173));
  Rect bounds = Rect.fromLTWH(0, 50, graphics.clientSize.width, 30);

//Draws a rectangle to place the heading in that region
  graphics.drawRectangle(brush: solidBrush, bounds: bounds);

//Creates a font for adding the heading in the page
  PdfFont subHeadingFont = PdfStandardFont(PdfFontFamily.timesRoman, 14);

//Creates a text element to add the invoice number
  PdfTextElement element =
  PdfTextElement(text: 'Asociacion de propietarios Real Verona A.C', font: subHeadingFont);
  element.brush = PdfBrushes.white;

//Draws the heading on the page
  PdfLayoutResult result = element.draw(
      page: page, bounds: Rect.fromLTWH(10, bounds.top + 8, 0, 0));
  String currentDate = 'Fecha' + DateFormat.yMMMd().format(DateTime.now());

//Measures the width of the text to place it in the correct location
  Size textSize = subHeadingFont.measureString(currentDate);

//Draws the date by using drawString method
  graphics.drawString(currentDate, subHeadingFont,
      brush: element.brush,
      bounds: Offset(graphics.clientSize.width - textSize.width - 10,
          result.bounds.top) &
      Size(textSize.width + 2, 20));

//Draws a line at the bottom of the address
  graphics.drawLine(
      PdfPen(PdfColor(126, 151, 173), width: 0.7),
      Offset(0, result.bounds.bottom + 3),
      Offset(graphics.clientSize.width, result.bounds.bottom + 3));

  //Creates a PDF grid
  PdfGrid grid = PdfGrid();

//Add the columns to the grid
  grid.columns.add(count: 7);

//Add header to the grid
  grid.headers.add(1);

//Set values to the header cells
  PdfGridRow header = grid.headers[0];
  header.cells[0].value = 'ID Transaccion';
  header.cells[1].value = 'Nombre Condominio';
  header.cells[2].value = 'Edificio';
  header.cells[3].value = 'Nº Dep';
  header.cells[4].value = 'Metodo de Pago';
  header.cells[5].value = 'Fecha del pago';
  header.cells[6].value = 'Cantidad';

//Creates the header style
  PdfGridCellStyle headerStyle = PdfGridCellStyle();
  headerStyle.borders.all = PdfPen(PdfColor(126, 151, 173));
  headerStyle.backgroundBrush = PdfSolidBrush(PdfColor(126, 151, 173));
  headerStyle.textBrush = PdfBrushes.white;
  headerStyle.font = PdfStandardFont(PdfFontFamily.timesRoman, 14,
      style: PdfFontStyle.regular);

//Adds cell customizations
  for (int i = 0; i < header.cells.count; i++) {
    if (i == 0 || i == 1) {
      header.cells[i].stringFormat = PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle);
    } else {
      header.cells[i].stringFormat = PdfStringFormat(
          alignment: PdfTextAlignment.right,
          lineAlignment: PdfVerticalAlignment.middle);
    }
    header.cells[i].style = headerStyle;
  }

  for (int i = 0; i < listaVentas.length; i++)
  {
    PdfGridRow row = grid.rows.add();
    row.cells[0].value = "${listaVentas[i]['id_transaccion']}";
    row.cells[1].value = "${listaVentas[i]['nombre_condom']}";
    row.cells[2].value = "${listaVentas[i]['nombre_edificio']}";
    row.cells[3].value = "${listaVentas[i]['numero_dep']}";
    row.cells[4].value = "${listaVentas[i]['metodoPago']}";
    row.cells[5].value = "${listaVentas[i]['fechaPago']}";
    row.cells[6].value = "${formatocontabilidad(listaVentas[i]['cantidad'])}";
  }

//Set padding for grid cells
  grid.style.cellPadding = PdfPaddings(left: 2, right: 2, top: 2, bottom: 2);

//Creates the grid cell styles
  PdfGridCellStyle cellStyle = PdfGridCellStyle();
  cellStyle.borders.all = PdfPens.white;
  cellStyle.borders.bottom = PdfPen(PdfColor(217, 217, 217), width: 0.70);
  cellStyle.font = PdfStandardFont(PdfFontFamily.timesRoman, 12);
  cellStyle.textBrush = PdfSolidBrush(PdfColor(131, 130, 136));
//Adds cell customizations
  for (int i = 0; i < grid.rows.count; i++) {
    PdfGridRow row = grid.rows[i];
    for (int j = 0; j < row.cells.count; j++) {
      row.cells[j].style = cellStyle;
      if (j == 0 || j == 1) {
        row.cells[j].stringFormat = PdfStringFormat(
            alignment: PdfTextAlignment.left,
            lineAlignment: PdfVerticalAlignment.middle);
      } else {
        row.cells[j].stringFormat = PdfStringFormat(
            alignment: PdfTextAlignment.right,
            lineAlignment: PdfVerticalAlignment.middle);
      }
    }
  }

//Creates layout format settings to allow the table pagination
  PdfLayoutFormat layoutFormat =
  PdfLayoutFormat(layoutType: PdfLayoutType.paginate);

//Draws the grid to the PDF page
  PdfLayoutResult gridResult = grid.draw(
      page: page,
      bounds: Rect.fromLTWH(0, result.bounds.bottom + 20,
          graphics.clientSize.width, graphics.clientSize.height - 100),
      format: layoutFormat);

  gridResult.page.graphics.drawString(
      'Total Recaudado:\$${formatocontabilidad(totalEnRecibo.toString())}', subHeadingFont,
      brush: PdfSolidBrush(PdfColor(126, 155, 203)),
      bounds: Rect.fromLTWH(520, gridResult.bounds.bottom + 30, 0, 0));


  List<int> bytes = document.save();
  document.dispose();
  //Download the output file
  AnchorElement(
  href:
  "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
    ..setAttribute("download", "output.pdf")
    ..click();

}