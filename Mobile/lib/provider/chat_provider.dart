import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:semsark/Repo/home_services.dart';
import 'package:semsark/Repo/profile_service.dart';
import 'package:semsark/Repo/remote/remote_status.dart';
import 'package:semsark/models/chat/chat_user_model.dart';
import 'package:semsark/models/response/user_details.dart';
import '../Repo/chat_services.dart';
import '../models/chat/chat_message_model.dart';

class ChatProvider with ChangeNotifier {
  String currentUserEmail = "";
  String? reciverEmail;
  UserDetails? curUser;
  UserDetails userById=UserDetails(id: 0, email: "");
  String userByIdImage="";
  String room = "";
  var uid='';
  ChatMessage message =
      ChatMessage(receiverEmail: "", message: "", status: true, date: "");
  final TextEditingController textEditingController = TextEditingController();

  List<ChatUsers> chatUsers = [];
  ChatUsers? reciver;
  List<ChatMessage> chatMessages = [];
  bool loading = false;
  ChatServices services = ChatServices();

  init() async {
    setLoading(true);
    await setUser();
    await getCurrentUser() ;
    setLoading(false);
  }

  setReciver(rec) async {
    setLoading(true) ;
    reciver = rec ;
    await getRoom();
    await getCurrentUser();
    setLoading(false);
    notifyListeners() ;
  }
  openChat(link){
    textEditingController.text = "Hi , I send to you about ur Ad:$link";
    notifyListeners();
  }
  setReciverEmail(email){
    reciverEmail = email ;
    notifyListeners() ;
  }
  getCurrentUser() async {
    var response = await ProfileServices().getUser() ;
    if(response is Success){
      curUser = response.response as UserDetails ;
      currentUserEmail = curUser!.email ;
    }
    else{
      currentUserEmail = "islammabououf@gmail.com";
    }
  }
  getUserById(id) async {
    var response = await HomeServices().getUserById(id) ;
    if(response is Success){
      userById = response.response as UserDetails ;
      userByIdImage=userById.img!;
    }
    notifyListeners();
  }

  ChatProvider() {
    init();
  }

  Future<void> setUser() async {
    var response = await services.getChatUser();
    if (response is Success) {
      chatUsers = response.response as List<ChatUsers>;
      print(chatUsers) ;
    }else if(response is Failure){
      print(response.errorResponse);
    }
    notifyListeners();
  }

  getAllMessage() async{
    //chatMessages=[];
    FirebaseApp firebaseApp = Firebase.app();
    FirebaseDatabase database = FirebaseDatabase.instanceFor(app:firebaseApp);

    database.ref('chat/$room/').onValue.listen((DatabaseEvent event) {
      final snapshot = event.snapshot.value;
      print("snapshot : $snapshot") ;
      if (snapshot != null) {
        // dataMap.forEach((key, value) {
        //   //chatMessages.add(ChatMessage( receiverEmail: value["receiverEmail"], message: value["message"], status: value["status"], date: value["dates"]));
        // });
        changeList(snapshot) ;
      }
      // chatMessages.removeWhere((element) => element.receiverEmail!=reciverEmail&&element.receiverEmail!=currentUserEmail);
      // chatMessages.sort((a, b) => a.date.compareTo(b.date));

    });
  }
  changeList(map){
    chatMessages = [];
    map.forEach((item,value) {
      chatMessages.add(ChatMessage( receiverEmail: value["receiverEmail"], message: value["message"], status: value["status"], date: value["dates"]));
    });
    chatMessages.removeWhere((element) => element.receiverEmail!=reciver!.email&&element.receiverEmail!=currentUserEmail);
    chatMessages.sort((a, b) => a.date.compareTo(b.date));
    notifyListeners();
  }
  Future<void> sendMessage() async {
    chatMessages.add(ChatMessage(receiverEmail: reciver!.email, message: message.message, status: true, date: message.date));
    await services.sendChatMessage(ChatMessage(receiverEmail: reciver!.email, message: message.message, status: true, date: message.date));
    //await getAllMessage();
    notifyListeners();
  }

  void setLoading(loading) {
    this.loading = loading;
    notifyListeners();
  }

  setMessage(message) {
    this.message.message = message;
    notifyListeners();
  }

  setUid(id){
    uid=id.toString();
    notifyListeners();
  }
  setDate(date) {
    this.message.date = date;
    notifyListeners();
  }

  // setReciverEmail(reciverEmail) {
  //   this.message.receiverEmail = reciverEmail;
  //   notifyListeners();
  // }

  getRoom() async {
    var response = await services.getChatRoom(reciver!.email);
    if (response is Success) {
      print(response.response);
      this.room = response.response.toString();
      await getAllMessage();
      //await getChatsFromFirebase();
    }
    notifyListeners();
  }
}
