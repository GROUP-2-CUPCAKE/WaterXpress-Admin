import 'package:cloud_firestore/cloud_firestore.dart';

class Pesanan {
  String? id;
  String? alamat;
  String? email;
  int? ongkir;
  List<dynamic>? produk;
  int? subtotalProduk;
  DateTime? tanggalPesanan;
  int? total;
  String? userId;
  String? status;

  Pesanan({
    this.id,
    this.alamat,
    this.email,
    this.ongkir,
    this.produk,
    this.subtotalProduk,
    this.tanggalPesanan,
    this.total,
    this.userId,
    this.status,
  });

  // Factory constructor untuk membuat objek Pesanan dari Map
  factory Pesanan.fromMap(Map<String, dynamic>? map) {
    // Tambahkan null check
    if (map == null) {
      return Pesanan();
    }

    return Pesanan(
      id: map['id'] as String? ?? '',
      alamat: map['alamat'] as String? ?? '',
      email: map['email'] as String? ?? '',
      ongkir: _parseIntSafely(map['ongkir']),
      produk: map['produk'] is List ? List.from(map['produk']) : [],
      subtotalProduk: _parseIntSafely(map['subtotalProduk']),
      tanggalPesanan: _convertToDateTime(map['tanggalPesanan']),
      total: _parseIntSafely(map['total']),
      userId: map['userId'] as String? ?? '',
      status: map['status'] as String? ?? 'Menunggu Konfirmasi',
    );
  }

  // Metode statis untuk parsing integer dengan aman
  static int _parseIntSafely(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    return int.tryParse(value.toString()) ?? 0;
  }

  // Metode statis untuk konversi tanggal
  static DateTime? _convertToDateTime(dynamic date) {
    if (date == null) return null;

    if (date is DateTime) return date;

    if (date is Timestamp) return date.toDate();

    try {
      return DateTime.parse(date.toString());
    } catch (e) {
      print('Error parsing date: $e');
      return null;
    }
  }

  // Method toMap untuk konversi ke Map
  Map<String, dynamic> toMap() {
    return {
      'id': id ?? '',
      'alamat': alamat ?? '',
      'email': email ?? '',
      'ongkir': ongkir ?? 0,
      'produk': produk ?? [],
      'subtotalProduk': subtotalProduk ?? 0,
      'tanggalPesanan':
          tanggalPesanan != null ? Timestamp.fromDate(tanggalPesanan!) : null,
      'total': total ?? 0,
      'userId': userId ?? '',
      'status': status ?? 'Menunggu Konfirmasi',
    };
  }

  // Tambahan method untuk kemudahan penggunaan
  factory Pesanan.fromDocument(DocumentSnapshot doc) {
    return Pesanan.fromMap(doc.data() as Map<String, dynamic>?);
  }
}
