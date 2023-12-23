// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:books/config/constant.dart';
import 'package:books/features/import_export/bloc/import_export.bloc.dart';
import 'package:books/features/import_export/bloc/import_export_events.bloc.dart';
import 'package:books/features/import_export/data/models/file_backup.module.dart';
import 'package:books/features/import_export/data/services/import_export.service.dart';
import 'package:books/injection_container.dart';
import 'package:books/utilities/dialog_utils.dart';
import 'package:books/widgets/file_backup_widget.dart';
import 'package:flutter/material.dart';

///
/// Widget
///
class ListaFileBakcup extends StatelessWidget {
  final ImportExportBloc _importExportBloc;
  final List<FileBackupModel> _lstFileBackupModel;
  final num _nrTot;
  
  const ListaFileBakcup(
    this._importExportBloc, this._lstFileBackupModel, {super.key}
  ) : _nrTot = _lstFileBackupModel.length;

  _shareFileBackup(BuildContext context, FileBackupModel fileBackupModel) async {
    sl<ImportExportService>().shareFileBackup(fileBackupModel);
  }

  _deleteFileBackup(BuildContext context, FileBackupModel fileBackupModel) async {
    bool? isDeleteFileBackup = await DialogUtils.showConfirmationSiNo(
      context, "Vuoi eliminare il file:\n\n '${fileBackupModel.fileName} contente '${fileBackupModel.nrRecord}' libri ?"
    );
    if (context.mounted && isDeleteFileBackup != null && isDeleteFileBackup) {
      _importExportBloc.add(DeleteFileBackupEvent(fileBackupModel));
    }
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: _lstFileBackupModel.isEmpty
        ? Center(
          child: Column(
              children: <Widget>[
                const SizedBox(height: 20,),
                SizedBox(
                  height: 200,
                  child: Image.asset(Constant.assetImageDefault, fit: BoxFit.cover,)
                ),
                const Padding(
                  padding: EdgeInsets.all(40.0),
                ),
              ],
          ),
        )
        : ListView.builder(
          itemCount: _lstFileBackupModel.length,
          itemBuilder: (context, index) {
            final item = _lstFileBackupModel[index];

            return FileBackupWidget(item: item, index: index, nrTot: _nrTot, shareFileBackup: _shareFileBackup, deleteFileBackup: _deleteFileBackup);
          },
        )
    );
  }
  
  
}
