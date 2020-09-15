class File {
  final String id;
  final String data; //this will be blob type data
  final DateTime dateTime;
  final String type; //file type => .jpg, .png, .pdf, .doc etc

  File({
    this.id,
    this.data,
    this.dateTime,
    this.type,
  });
}
