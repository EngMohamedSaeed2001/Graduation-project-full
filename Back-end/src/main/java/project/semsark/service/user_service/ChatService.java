package project.semsark.service.user_service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import project.semsark.jwt.JwtUtil;
import project.semsark.model.entity.ChatRoom;
import project.semsark.model.entity.User;
import project.semsark.model.response_body.UserChat;
import project.semsark.repository.ChatRoomRepository;
import project.semsark.repository.MessageRepository;
import project.semsark.repository.UserRepository;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class ChatService {
    @Autowired
    UserRepository userRepository;
    @Autowired
    MessageRepository messageRepository;
    @Autowired
    ChatRoomRepository chatRoomRepository;
    @Autowired
    JwtUtil jwtUtil;
    public List<UserChat> getChats(){
        User user = jwtUtil.getUserDataFromToken();
        List<ChatRoom> rooms = chatRoomRepository.findChatRoomBySenderId(user.getId());
        rooms.addAll(chatRoomRepository.findChatRoomByReceiverId(user.getId()));
        List<UserChat> userChats = new ArrayList<>();
        for (ChatRoom room:rooms){
            long id;
            if(room.getReceiverId()!= user.getId())
                id = room.getReceiverId();
            else
                id = room.getSenderId();

            Optional<User> user1 = userRepository.findById(id);
            if(user1.isPresent()){
                User finalUser = user1.get();
                userChats.add(UserChat.builder()
                        .email(finalUser.getEmail())
                        .username(finalUser.getUsername())
                        .image(finalUser.getImg())
                        .id(id)
                        .build());
            }
        }
        return userChats;
    }
}
