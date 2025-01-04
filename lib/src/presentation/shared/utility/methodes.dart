import 'dart:html' as html;
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

import '../../../data/models/item_model.dart';
import '../../../data/models/order_item_model.dart';

Future<pw.Document> generateTicketPDF({
  required List<OrderItemModel> cartItems,
  required List<ItemModel> items,
}) async {
  final pdf = pw.Document();

  // Load custom font
  final fontData = await rootBundle.load("assets/fonts/Roboto-Regular.ttf");
  final ttf = pw.Font.ttf(fontData);

  // Header and Footer
  final header = pw.Container(
    padding: const pw.EdgeInsets.all(8),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text("LST / DEV / TEST",
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
        pw.Text("24 B RUE LEONARD DE VINCI, 91090 LISSES"),
        pw.Text("Tel: 01.80.81.7000"),
        pw.SizedBox(height: 8),
        pw.Text("Ticket N° 120432", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Text("Date: ${DateTime.now().toString().split(' ')[0]}"),
      ],
    ),
  );

  final footer = pw.Container(
    padding: const pw.EdgeInsets.all(8),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Divider(),
        pw.Text("Merci pour votre commande - À bientôt!",
            style: pw.TextStyle(fontSize: 12)),
      ],
    ),
  );

  // Group items by TVA and calculate totals
  final tvaSummary = <double, double>{};
  for (final cartItem in cartItems) {
    final item = items.firstWhere((i) => i.id == cartItem.itemId);
    final tvaRate = item.tvaRate; // Get the TVA rate directly from the item model

    // Calculate the price for this item
    final itemTotal = item.price * cartItem.quantity;

    // Add to the corresponding TVA group
    tvaSummary[tvaRate] = (tvaSummary[tvaRate] ?? 0) + itemTotal;
  }

  // Build TVA Table
  final tvaRows = tvaSummary.entries.map((entry) {
    final tvaRate = entry.key;
    final totalHT = entry.value;
    final totalTVA = totalHT * (tvaRate / 100); // Calculate TVA amount
    return pw.TableRow(
      children: [
        pw.Text("TVA ${tvaRate.toStringAsFixed(2)}%"),
        pw.Text("${totalHT.toStringAsFixed(2)} DT"),
        pw.Text("${totalTVA.toStringAsFixed(2)} DT"),
      ],
    );
  }).toList();

  // Build Cart Table
  final cartRows = cartItems.map((cartItem) {
    final item = items.firstWhere((i) => i.id == cartItem.itemId);
    return pw.TableRow(
      children: [
        pw.Text(item.name),
        pw.Text(cartItem.quantity.toString()),
        pw.Text("${item.tvaRate.toStringAsFixed(2)}%"),
        pw.Text("${(item.price * cartItem.quantity).toStringAsFixed(2)} DT"),
      ],
    );
  }).toList();

  // Total Price with TVA
  final totalPriceHT = cartItems.fold<double>(
    0.0,
    (sum, cartItem) {
      final item = items.firstWhere((i) => i.id == cartItem.itemId);
      return sum + (item.price * cartItem.quantity);
    },
  );

  final totalTVA = tvaSummary.entries.fold<double>(
    0.0,
    (sum, entry) => sum + (entry.value * (entry.key / 100)),
  );

  final totalPriceTTC = totalPriceHT + totalTVA;

  // Add content to PDF
  pdf.addPage(
    pw.MultiPage(
      theme: pw.ThemeData.withFont(base: ttf),
      header: (_) => header,
      footer: (_) => footer,
      build: (context) => [
        // Cart Table
        pw.Table(
          border: pw.TableBorder.all(),
          children: [
            pw.TableRow(
              children: [
                pw.Text("Produit", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text("Quantité", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text("TVA", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text("Prix Total", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              ],
            ),
            ...cartRows,
          ],
        ),
        pw.SizedBox(height: 20),

        // TVA Summary Table
        pw.Text("Résumé TVA",
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
        pw.Table(
          border: pw.TableBorder.all(),
          children: [
            pw.TableRow(
              children: [
                pw.Text("Type de TVA", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text("Total HT", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text("Total TVA", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              ],
            ),
            ...tvaRows,
          ],
        ),
        pw.SizedBox(height: 20),

        // Total Price
        pw.Text("Total HT: ${totalPriceHT.toStringAsFixed(2)} Dt",
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
        pw.Text("Total TVA: ${totalTVA.toStringAsFixed(2)} DT",
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
        pw.Text("Total TTC: ${totalPriceTTC.toStringAsFixed(2)} DT",
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
      ],
    ),
  );

  return pdf;
}

Future<String> savePDF(List<int> bytes) async {
  try {
    if (Platform.isAndroid) {
      // Android logic (already implemented)
      final status = await Permission.storage.request();
      if (status.isGranted) {
        final directory = await getExternalStorageDirectory();
        if (directory != null) {
          final file = File('${directory.path}/ticket.pdf');
          await file.writeAsBytes(bytes);
          return file.path;
        } else {
          throw Exception('Unable to find a directory to save the file.');
        }
      } else {
        throw Exception('Storage permission denied.');
      }
    } else if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
      // Desktop logic
      final directory = await getDownloadsDirectory();
      if (directory != null) {
        final file = File('${directory.path}/ticket.pdf');
        await file.writeAsBytes(bytes);
        return file.path;
      } else {
        throw Exception('Unable to find a downloads directory.');
      }
    } else {
      throw Exception('Unsupported platform.');
    }
  } catch (e) {
    throw Exception('Error saving PDF: $e');
  }
}


void savePDFWeb(List<int> bytes) {
  final blob = html.Blob([bytes]);
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.AnchorElement(href: url)
    ..target = 'blank'
    ..download = 'ticket.pdf'
    ..click();
  html.Url.revokeObjectUrl(url);
}