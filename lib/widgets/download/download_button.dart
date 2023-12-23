import 'package:books/features/import_export/data/models/file_backup.module.dart';
import 'package:books/features/libro/data/models/libro_view.module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

enum DownloadStatus {
  notDownloaded,
  fetchingDownload,
  downloading,
  downloaded,
}

@immutable
class DownloadButton extends StatelessWidget {
  const DownloadButton({
    super.key,
    required DownloadStatus status,
    double downloadProgress = 0.0,
    required void Function() onDownload,
    required void Function() onCancel,
    required Function onOpen,
    required FileBackupModel fileBackupModel,
    required List<LibroViewModel> lstLibriGiaPresenti,
    this.transitionDuration = const Duration(milliseconds: 500),
  }) : _lstLibriGiaPresenti = lstLibriGiaPresenti, _onOpen = onOpen, _onCancel = onCancel, _onDownload = onDownload, _downloadProgress = downloadProgress, _status = status;

  final DownloadStatus _status;
  final double _downloadProgress;
  final VoidCallback _onDownload;
  final VoidCallback _onCancel;
  final Function _onOpen;
  final List<LibroViewModel> _lstLibriGiaPresenti;
  final Duration transitionDuration;

  bool get _isDownloading => _status == DownloadStatus.downloading;

  bool get _isFetching => _status == DownloadStatus.fetchingDownload;

  bool get _isDownloaded => _status == DownloadStatus.downloaded;

  void _onPressed() {
    switch (_status) {
      case DownloadStatus.notDownloaded:
        _onDownload();
      case DownloadStatus.fetchingDownload:
        // do nothing.
        break;
      case DownloadStatus.downloading:
        _onCancel();
      case DownloadStatus.downloaded:
        _onOpen(_lstLibriGiaPresenti.isEmpty);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onPressed,
      child: Stack(
        children: [
          ButtonShapeWidget(
            transitionDuration: transitionDuration,
            isDownloaded: _isDownloaded,
            isDownloading: _isDownloading,
            isFetching: _isFetching,
            lstLibriGiaPresenti: _lstLibriGiaPresenti
          ),
          Positioned.fill(
            child: AnimatedOpacity(
              duration: transitionDuration,
              opacity: _isDownloading || _isFetching ? 1.0 : 0.0,
              curve: Curves.ease,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ProgressIndicatorWidget(
                    downloadProgress: _downloadProgress,
                    isDownloading: _isDownloading,
                    isFetching: _isFetching,
                  ),
                  if (_isDownloading)
                    const Icon(
                      Icons.stop,
                      size: 10,
                      color: CupertinoColors.activeBlue,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

@immutable
class ButtonShapeWidget extends StatelessWidget {
  const ButtonShapeWidget({
    super.key,
    required this.isDownloading,
    required this.isDownloaded,
    required this.isFetching,
    required this.transitionDuration,
    required this.lstLibriGiaPresenti
  });

  final bool isDownloading;
  final bool isDownloaded;
  final bool isFetching;
  final Duration transitionDuration;
  final List<LibroViewModel> lstLibriGiaPresenti;

  @override
  Widget build(BuildContext context) {
    var shape = const ShapeDecoration(
      shape: StadiumBorder(),
      // color: CupertinoColors.lightBackgroundGray,
      color: Colors.transparent,
    );

    if (isDownloading || isFetching) {
      shape = ShapeDecoration(
        shape: const CircleBorder(),
        color: Colors.white.withOpacity(0),
        // color: Colors.transparent,
      );
    }

    

    return AnimatedContainer(
      duration: transitionDuration,
      curve: Curves.ease,
      width: double.infinity,
      decoration: shape,
      child: AnimatedOpacity(
        duration: transitionDuration,
        opacity: isDownloading || isFetching ? 0.0 : 1.0,
        curve: Curves.ease,
        child: isDownloaded 
            ? lstLibriGiaPresenti.isEmpty 
              ? IconButton(
                icon: const Icon(Icons.check, color: Colors.green),
                onPressed: () => {} 
              )
              : IconButton(
                icon: Icon(Icons.view_headline, color: Colors.yellow[700]),
                onPressed: () => {} 
              )
            : IconButton(
              icon: Icon(MdiIcons.backupRestore, color: Colors.teal[500],),
              onPressed: () => {} 
            ) 
      ),
    );
  }
}

@immutable
class ProgressIndicatorWidget extends StatelessWidget {
  const ProgressIndicatorWidget({
    super.key,
    required this.downloadProgress,
    required this.isDownloading,
    required this.isFetching,
  });

  final double downloadProgress;
  final bool isDownloading;
  final bool isFetching;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: downloadProgress),
        duration: const Duration(milliseconds: 200),
        builder: (context, progress, child) {
          return CircularProgressIndicator(
            backgroundColor: isDownloading
                ? CupertinoColors.lightBackgroundGray
                : Colors.white.withOpacity(0),
            valueColor: AlwaysStoppedAnimation(isFetching
                ? CupertinoColors.lightBackgroundGray
                : CupertinoColors.activeBlue),
            strokeWidth: 2,
            value: isFetching ? null : progress,
          );
        },
      ),
    );
  }
}