class MessageModel
{
  final String message;

  MessageModel(this.message);


  factory MessageModel.fromJson(json)=>
      MessageModel(
          json['message']
      );
}