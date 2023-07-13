package project.semsark.controller.user_controller;

import com.google.firebase.messaging.FirebaseMessagingException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import project.semsark.aspect.TokenValidationAspect;
import project.semsark.model.request_body.NotificationBody;
import project.semsark.service.notification.NotificationService;

@RestController

@RequestMapping("/user")
@PreAuthorize("hasRole('ROLE_USER')")
public class NotificationController {
    @Autowired
    NotificationService notificationService;
    @GetMapping("/deviceId/{token}")
    @TokenValidationAspect
    void getDeviceId(@PathVariable String token){
        notificationService.getDeviceId(token);
    }
    @PostMapping("/pushNotification")
    @TokenValidationAspect
    void pushNotification(@RequestBody NotificationBody notificationBody) throws FirebaseMessagingException {
        notificationService.sendNotification(notificationBody);
    }
}
