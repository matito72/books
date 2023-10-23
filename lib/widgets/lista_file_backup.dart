// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:books/features/import_export/blocs/import_export_bloc.dart';
import 'package:books/features/import_export/blocs/import_export_events.dart';
import 'package:books/features/import_export/data/models/file_backup.dart';
import 'package:books/features/import_export/data/repository/import_export_service.dart';
import 'package:books/injection_container.dart';
import 'package:books/utilities/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ListaFileBakcup extends StatelessWidget {
  final BuildContext parentContext; 
  final ImportExportBloc importExportBloc;
  final List<FileBackupModel> lstFileBackupModel;
  final num nrTot;
  
  const ListaFileBakcup(
    this.parentContext, this.importExportBloc, this.lstFileBackupModel, {super.key}
  ) : nrTot = lstFileBackupModel.length;
  
  _restoreFileBackup(BuildContext context, FileBackupModel fileBackupModel) async {
    bool? isRestoreFileBackup = await DialogUtils.showConfirmationSiNo(
      context, "Vuoi ripristinare il file:\n\n '${fileBackupModel.fileName} contente '${fileBackupModel.nrRecord}' libri ?"
    );
    if (context.mounted && isRestoreFileBackup != null && isRestoreFileBackup) {
      importExportBloc.add(ImportFileBackupEvent(null, fileBackupModel));
    }
  }

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
            return Card( //                           <-- Card
              child: Column(
                children: <Widget>[
                  ListTile(
                    onTap: () async {
                        // fnViewDettaglioLibro(parentContext, importExportBloc, item);
                    },
                    // leading: (item.immagineCopertina != '')
                    //     ? buildImage(index, item.immagineCopertina)
                    //     : const Text('-'),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 9,
                          child: Text(
                            '${item.fileName.substring(0, item.fileName.indexOf('_'))} - ${item.nrRecord} libri',
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white) ,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Text(
                          '${index+1}/$nrTot',
                          style: Theme.of(context).textTheme.labelSmall,
                          textAlign: TextAlign.right,
                        )
                      ]
                    ),
                    subtitle: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            // DateFormat('yyyyMMdd').format(item.dtUltimaModifica),
                            '${item.dtUltimaModifica.toString()}\t\t ${item.fileSize} KB',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              fontStyle: FontStyle.italic,
                              color: Colors.white70
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: Wrap(
                      // spacing: 0,
                      children: [
                        IconButton(
                          icon: const Icon(MdiIcons.backupRestore, color: Colors.green,),
                          onPressed: () => {_restoreFileBackup(context, item)} // {_goToHomeLibriLibreria(context, libreria)},
                        ),
                        IconButton(
                          icon: const Icon(Icons.share, color:Color.fromARGB(202, 176, 235, 158),),
                          onPressed: () => {_shareFileBackup(context, item)},
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.orange.shade800),
                          onPressed: () => {_deleteFileBackup(context, item)},
                        ),
                      ], 
                    ),
                  ),
                  Visibility(
                    maintainSize: true, 
                    maintainAnimation: true,
                    maintainState: true,
                    visible: true, 
                    child: LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width - 10,
                      animation: true,
                      lineHeight: 5.0,
                      animationDuration: 2000,
                      percent: 1.0,
                      // center: const Text("100.0%"),
                      // linearStrokeCap: LinearStrokeCap.roundAll,
                      progressColor: Colors.greenAccent,
                    ),
                  ),
                ],
              ),
            );
          },
        )
    );
  }
  
  
}
