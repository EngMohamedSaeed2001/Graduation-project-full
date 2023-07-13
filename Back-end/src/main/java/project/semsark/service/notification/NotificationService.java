package project.semsark.service.notification;

import com.google.firebase.FirebaseApp;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import project.semsark.jwt.JwtUtil;
import project.semsark.model.entity.User;
import project.semsark.model.request_body.NotificationBody;
import project.semsark.repository.UserRepository;

@Service
public class NotificationService {
    @Autowired
    JwtUtil jwtUtil;
    @Autowired
    UserRepository userRepository;

    private final FirebaseApp firebaseApp;

    public NotificationService(FirebaseApp firebaseApp) {
        this.firebaseApp = firebaseApp;
    }

    public void sendNotification(NotificationBody notificationBody) throws FirebaseMessagingException {
        Notification notification = Notification.builder()
                .setTitle(notificationBody.getTitle())
                .setBody(notificationBody.getBody())
                .build();

        Message message = Message.builder()
                .setNotification(notification)
                .setToken(notificationBody.getDeviceId())
                .build();

        FirebaseMessaging.getInstance(firebaseApp).send(message);
    }

    public void getDeviceId(String token){
        User user = jwtUtil.getUserDataFromToken();
        user.setDeviceId(token);
        userRepository.save(user);
    }
}