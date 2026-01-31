import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ReportService {
  static const PdfColor primaryNavy = PdfColor.fromInt(0xFF1E4276);
  static const PdfColor accentOrange = PdfColor.fromInt(0xFFE96D3B);
  static const PdfColor successGreen = PdfColor.fromInt(0xFF10B981);

  static Future<Uint8List> generateProjectSummary({
    required String projectName,
    required String provider,
    required String domain,
  }) async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.quicksandRegular();
    final fontBold = await PdfGoogleFonts.quicksandBold();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Container(
                padding: const pw.EdgeInsets.all(20),
                decoration: const pw.BoxDecoration(color: primaryNavy),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('WP Launchpad Handover',
                        style: pw.TextStyle(font: fontBold, color: PdfColors.white, fontSize: 24)),
                    pw.Text('Project Summary',
                        style: pw.TextStyle(font: font, color: PdfColors.white, fontSize: 14)),
                  ],
                ),
              ),
              pw.SizedBox(height: 40),

              // Project Details
              pw.Text('Project Details', style: pw.TextStyle(font: fontBold, fontSize: 18, color: primaryNavy)),
              pw.Divider(color: accentOrange),
              pw.SizedBox(height: 10),
              _buildInfoRow('Project Name:', projectName, font, fontBold),
              _buildInfoRow('Hosting Provider:', provider, font, fontBold),
              _buildInfoRow('Domain Name:', domain, font, fontBold),
              _buildInfoRow('Status:', 'Live & Active', font, fontBold, valueColor: successGreen),

              pw.SizedBox(height: 40),

              // Handover Checklist
              pw.Text('Handover Checklist', style: pw.TextStyle(font: fontBold, fontSize: 18, color: primaryNavy)),
              pw.SizedBox(height: 10),
              _buildCheckItem('Server configured and secured', font),
              _buildCheckItem('DNS A records pointed to server IP', font),
              _buildCheckItem('MySQL Database & User created', font),
              _buildCheckItem('wp-config.php generated with secure salts', font),
              _buildCheckItem('WordPress installation verified', font),

              pw.SizedBox(height: 40),

              // Support Footer
              pw.Container(
                padding: const pw.EdgeInsets.all(15),
                decoration: pw.BoxDecoration(
                  color: PdfColors.orange50,
                  borderRadius: pw.BorderRadius.circular(8),
                ),
                child: pw.Text(
                  'Need further help? Visit the WP Launchpad Support Center for maintenance guides and tutorials.',
                  style: pw.TextStyle(font: font, fontSize: 10, color: PdfColors.black),
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  static Future<Uint8List> generateTechnicalReport({
    required String projectName,
    required Map<String, String> config,
    required List<String> commands,
  }) async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.quicksandRegular();
    final fontBold = await PdfGoogleFonts.quicksandBold();
    final mono = await PdfGoogleFonts.sourceCodeProRegular();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return [
            pw.Text('Detailed Technical Report',
                style: pw.TextStyle(font: fontBold, fontSize: 24, color: primaryNavy)),
            pw.SizedBox(height: 20),
            pw.Text('This document contains the exact parameters and commands used for the setup of $projectName.',
                style: pw.TextStyle(font: font, fontSize: 12)),
            pw.SizedBox(height: 30),

            pw.Text('Configuration Parameters', style: pw.TextStyle(font: fontBold, fontSize: 16)),
            pw.Divider(),
            ...config.entries.map((e) => pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 4),
                  child: pw.Row(children: [
                    pw.Text('${e.key}: ', style: pw.TextStyle(font: fontBold, fontSize: 10)),
                    pw.Text(e.value, style: pw.TextStyle(font: font, fontSize: 10)),
                  ]),
                )),

            pw.SizedBox(height: 30),
            pw.Text('Executed Commands Log', style: pw.TextStyle(font: fontBold, fontSize: 16)),
            pw.Divider(),
            ...commands.map((cmd) => pw.Container(
                  margin: const pw.EdgeInsets.only(top: 10),
                  padding: const pw.EdgeInsets.all(8),
                  decoration: const pw.BoxDecoration(color: PdfColors.grey100),
                  width: double.infinity,
                  child: pw.Text(cmd, style: pw.TextStyle(font: mono, fontSize: 9)),
                )),
          ];
        },
      ),
    );

    return pdf.save();
  }

  static pw.Widget _buildInfoRow(String label, String value, pw.Font font, pw.Font fontBold, {PdfColor? valueColor}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 5),
      child: pw.Row(
        children: [
          pw.SizedBox(width: 120, child: pw.Text(label, style: pw.TextStyle(font: fontBold, fontSize: 12))),
          pw.Text(value, style: pw.TextStyle(font: font, fontSize: 12, color: valueColor ?? PdfColors.black)),
        ],
      ),
    );
  }

  static pw.Widget _buildCheckItem(String text, pw.Font font) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        children: [
          pw.Container(
            width: 12,
            height: 12,
            decoration: pw.BoxDecoration(
              color: successGreen,
              shape: pw.BoxShape.circle,
            ),
            child: pw.Center(child: pw.Icon(const pw.IconData(0xe5ca), size: 10, color: PdfColors.white)),
          ),
          pw.SizedBox(width: 10),
          pw.Text(text, style: pw.TextStyle(font: font, fontSize: 12)),
        ],
      ),
    );
  }
}
