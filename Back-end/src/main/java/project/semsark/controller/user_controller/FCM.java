package project.semsark.controller.user_controller;

import com.google.firebase.FirebaseApp;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.messaging.FirebaseMessagingException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;
import project.semsark.aspect.TokenValidationAspect;
import project.semsark.exception.HelperMessage;
import project.semsark.jwt.JwtUtil;
import project.semsark.model.entity.ChatRoom;
import project.semsark.model.entity.Message;
import project.semsark.model.entity.User;
import project.semsark.model.request_body.ChatRequest;
import project.semsark.model.request_body.NotificationBody;
import project.semsark.model.response_body.UserChat;
import project.semsark.repository.ChatRoomRepository;
import project.semsark.repository.MessageRepository;
import project.semsark.repository.UserRepository;
import project.semsark.service.notification.NotificationService;
import project.semsark.service.user_service.ChatService;

import java.util.List;

@RestController
@PreAuthorize("hasRole('ROLE_USER')")
public class FCM {

    @Autowired
    UserRepository userRepository;
    @Autowired
    NotificationService notificationService;

    @Autowired
    ChatService chatService;
    @Autowired
    MessageRepository messageRepository;
    @Autowired
    ChatRoomRepository chatRoomRepository;
    @Autowired
    JwtUtil jwtUtil;


    private final FirebaseDatabase database;

    public FCM(FirebaseApp firebaseApp) {
        database = FirebaseDatabase.getInstance(firebaseApp);
    }


    public Message saveMessage(ChatRequest chatRequest) {
        User user = jwtUtil.getUserDataFromToken();
        Message message = Message.builder()
                .message(chatRequest.getMessage())
                .dates(chatRequest.getDate())
                .status(chatRequest.isStatus())
                .receiverEmail(chatRequest.getReceiverEmail())
                .senderEmail(user.getEmail())
                .build();
        return messageRepository.save(message);
    }

    public Long check(Long senderId, Long receiverId) {
        if (chatRoomRepository.findChatRoomBySenderIdAndReceiverId(senderId, receiverId).isPresent()) {
            return chatRoomRepository.findChatRoomBySenderIdAndReceiverId(senderId, receiverId).get().getId();
        } else if (chatRoomRepository.findChatRoomBySenderIdAndReceiverId(receiverId, senderId).isPresent())
            return chatRoomRepository.findChatRoomBySenderIdAndReceiverId(receiverId, senderId).get().getId();

        return -1L;
    }

    @PostMapping("/chat-semsark")
    @TokenValidationAspect
    public void sendMessage(@RequestBody ChatRequest chatMessage) throws FirebaseMessagingException {
        User receiverUser = userRepository.findByEmail(chatMessage.getReceiverEmail()).get();

        Long receiver = userRepository.findByEmail(chatMessage.getReceiverEmail()).get().getId();
        User user = jwtUtil.getUserDataFromToken();

        if (receiver == user.getId())
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, HelperMessage.CHAT_EXP);


        Long id = check(user.getId(), receiver);

        DatabaseReference ref;

        if (id != -1) {
            ref = database.getReference("chat/" + id);
        } else {
            ChatRoom chatRoom = ChatRoom.builder()
                    .senderId(user.getId())
                    .receiverId(receiver)
                    .build();

            ref = database.getReference("chat/" + chatRoomRepository.save(chatRoom).getId());
        }
        String notificationTitle = "New Message";
        String notificationBody = "You have received a new message";


        ref.push().setValueAsync(saveMessage(chatMessage));
        try {
            NotificationBody notificationRequest = NotificationBody.builder()
                    .title(notificationTitle)
                    .body(notificationBody)
                    .deviceId(receiverUser.getDeviceId())
                    .build();
            notificationService.sendNotification(notificationRequest);
        } catch (FirebaseMessagingException e) {
            // Handle exception if notification sending fails
            e.printStackTrace();
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST,HelperMessage.NOTIFICATION_FAILED);
        }
    }

    @GetMapping("/room-semsark/{receiverEmail}")
    @TokenValidationAspect
    public Long getRooms(@PathVariable String receiverEmail) {
        Long receiver = userRepository.findByEmail(receiverEmail).get().getId();
        User user = jwtUtil.getUserDataFromToken();
        if (receiver == user.getId())
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, HelperMessage.CHAT_EXP);

        Long id = check(user.getId(), receiver);


        if (id == -1) {
            ChatRoom chatRoom = ChatRoom.builder()
                    .senderId(user.getId())
                    .receiverId(receiver)
                    .build();

            return chatRoomRepository.save(chatRoom).getId();
        }

        return id;
    }

    @GetMapping("/chat/getChats")
    @TokenValidationAspect
    List<UserChat> getChats() {
        return chatService.getChats();
    }
}
