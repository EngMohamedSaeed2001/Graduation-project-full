package project.semsark.controller.admin_controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import project.semsark.aspect.TokenValidationAspect;
import project.semsark.jwt.JwtUtil;
import project.semsark.model.entity.User;
import project.semsark.model.request_body.EmailRequest;
import project.semsark.model.response_body.UserResponse;
import project.semsark.service.admin_service.AdminService;
import project.semsark.service.user_service.AdService;

import java.util.List;

@RequestMapping("/admin")
@PreAuthorize("hasRole('ROLE_ADMIN')")
@RestController
public class AdminController {
    @Autowired
    AdminService adminService;
    @Autowired
    AdService adService;


    @Autowired
    private JwtUtil jwtUtil;

    @DeleteMapping(value = "/deleteUser")
    @TokenValidationAspect
    public void deleteUser(@RequestBody EmailRequest request) {
        adminService.deleteUser(request.getEmail());
    }

    @DeleteMapping("/deleteAd/{id}")
    @TokenValidationAspect
    public void deleteAd(@PathVariable long id) {
        adService.deleteAd(id,'r');
    }

    @PostMapping(value = "/suspendUser")
    @TokenValidationAspect
    public void suspendUser(@RequestBody EmailRequest request) {
        adminService.suspendUser(request.getEmail());
    }

    @PostMapping(value = "/unSuspendUser")
    @TokenValidationAspect
    public void unSuspendUser(@RequestBody EmailRequest request) {
        adminService.unSuspendUser(request.getEmail());
    }

    @PostMapping(value = "/verifyUser")
    @TokenValidationAspect
    public void verifyUser(@RequestBody EmailRequest request) {
        adminService.verifyUser(request.getEmail());
    }

    @PostMapping(value = "/unVerifyUser")
    @TokenValidationAspect
    public void unVerifyUser(@RequestBody EmailRequest request) {
        adminService.unVerifyUser(request.getEmail());
    }

    ///////////////////////////////////////////////////////////
    @GetMapping("/getAllUsers")
    @TokenValidationAspect
    List<UserResponse> getAllUsers() {
        return adminService.getAllUsers();
    }

    @GetMapping("/getAllPendingUsers")
    @TokenValidationAspect
    List<UserResponse> getAllPendingUsers() {
        return adminService.getPendingUsers();
    }

    @GetMapping("/test")
    @TokenValidationAspect
    User getTokenParam() {
        return jwtUtil.getUserDataFromToken();
    }

}
