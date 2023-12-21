
import 'package:intl/intl.dart';

class FileBackupModel {
  final String siglaLibreria;
  final String fileName;
  final int nrRecord;
  final DateTime dtUltimaModifica;
  final int fileSize;

  FileBackupModel({
    required this.siglaLibreria,
    required this.fileName, 
    required this.nrRecord,
    DateTime? dtUltimaModifica, this.fileSize = 0}
  ) : dtUltimaModifica = dtUltimaModifica ?? DateTime.now();

  @override
  String toString() {
    return '$fileName => <Prefix>_${nrRecord}_${siglaLibreria}_${DateFormat('yyyyMMdd').format(dtUltimaModifica)}.json';
  }
}
