import 'dart:io';

class FolderModel {
  String folderName;
  List<MediaModel> mediaList;
  FolderModel({
    required this.folderName,
    required this.mediaList,
  });
}

class MediaModel {
  String mediaType;
  File media;
  MediaModel({
    required this.mediaType,
    required this.media,
  });
}
