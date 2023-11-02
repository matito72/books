// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:books/features/import_export/blocs/import_export_bloc.dart';
import 'package:books/features/import_export/blocs/import_export_events.dart';
import 'package:books/features/import_export/data/models/file_backup.dart';
import 'package:books/features/import_export/data/repository/import_export_service.dart';
import 'package:books/injection_container.dart';
import 'package:books/utilities/dialog_utils.dart';
import 'package:books/widgets/file_backup_widget.dart';
import 'package:flutter/material.dart';

///
/// Widget
///
class ListaFileBakcup extends StatelessWidget {
  final BuildContext parentContext; 
  final ImportExportBloc importExportBloc;
  final List<FileBackupModel> lstFileBackupModel;
  final num nrTot;
  
  const ListaFileBakcup(
    this.parentContext, this.importExportBloc, this.lstFileBackupModel, {super.key}
  ) : nrTot = lstFileBackupModel.length;

  _shareFileBackup(BuildContext context, FileBackupModel fileBackupModel) async {
    sl<ImportExportService>().shareFileBackup(fileBackupModel);
  }

  _deleteFileBackup(BuildContext context, FileBackupModel fileBackupModel) async {
    bool? isDeleteFileBackup = await DialogUtils.showConfirmationSiNo(
      context, "Vuoi eliminare il file:\n\n '${fileBackupModel.fileName} contente '${fileBackupModel.nrRecord}' libri ?"
    );
    if (context.mounted && isDeleteFileBackup != null && isDeleteFileBackup) {
      importExportBloc.add(DeleteFileBackupEvent(fileBackupModel));
    }
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: lstFileBackupModel.isEmpty
        ? Center(
          child: Column(
              children: <Widget>[
                const SizedBox(height: 20,),
                SizedBox(
                  height: 200,
                  child: Image.asset('assets/images/waiting.png',fit: BoxFit.cover,)
                ),
                const Padding(
                  padding: EdgeInsets.all(40.0),
                ),
              ],
          ),
        )
        : ListView.builder(
          itemCount: lstFileBackupModel.length,
          itemBuilder: (context, index) {
            final item = lstFileBackupModel[index];

            return FileBackupWidget(item: item, index: index, nrTot: nrTot, shareFileBackup: _shareFileBackup, deleteFileBackup: _deleteFileBackup);
          },
        )
    );
  }
  
  
}
