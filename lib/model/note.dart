class NoteModel {
  final String title;
  final String Description;
  final timeSent;
  final String UserId;
  final String NoteId;
  NoteModel( {
    
    required this.title,
    required this.Description,
    required this.UserId,
    required this.NoteId,
    required this.timeSent,
  });

 

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'Description': Description,
      'UserId': UserId,
      'NoteId': NoteId,
      'timeSent' : timeSent,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      title: map['title'] as String,
      Description : map['Description'] as String,
      UserId : map['UserId'] as String,
      NoteId :map['NoteId'] as String,
      timeSent :map['timeSent'] as DateTime,
    );
  }

}
