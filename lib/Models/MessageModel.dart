class MessageModel{
  String? Message;
  String ?id;
  MessageModel({this.Message,this.id});
  factory MessageModel.fromJson(json){
    return MessageModel( Message: json["text"],id:json["id"] );

}
}