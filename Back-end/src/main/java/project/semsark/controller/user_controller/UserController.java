package project.semsark.controller.user_controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import project.semsark.aspect.TokenValidationAspect;
import project.semsark.filter.BuildingFilterService;
import project.semsark.jwt.JwtUtil;
import project.semsark.model.entity.User;
import project.semsark.model.request_body.AdRequest;
import project.semsark.model.request_body.FaceRecognitionRequest;
import project.semsark.model.request_body.FilterRequest;
import project.semsark.model.response_body.AdResponse;
import project.semsark.model.response_body.VerifyNIDResponse;
import project.semsark.service.CustomUserDetailsService;
import project.semsark.service.user_service.AdService;
import project.semsark.service.user_service.FavouriteService;
import project.semsark.service.user_service.MachineService;

import java.util.List;

@RestController
@RequestMapping("/user")
@PreAuthorize("hasRole('ROLE_USER')")


public class UserController {
    @Autowired
    private AdService adService;
    @Autowired
    private BuildingFilterService buildingFilterService;
    @Autowired
    private FavouriteService favouriteService;
    @Autowired
    JwtUtil jwtUtil;
    @Autowired
    MachineService machineService;

    @Autowired
    private CustomUserDetailsService customUserDetailsService;

    ////////////////////////////// ADD //////////////////////////////////////
    @PostMapping("/createAd")
    @TokenValidationAspect
    void createAd(@RequestBody AdRequest adRequest) {
        adService.createAd(adRequest);
    }

    @PostMapping("/addFavourite/{id}")
    void addToFavourite(@PathVariable long id) {
        favouriteService.addToFavourite(id);
    }
    /////////////////////////////// UPDATE ////////////////////////////////////////
    @PatchMapping("/updateAd/{id}")
    @TokenValidationAspect
    void updateAd(@RequestBody AdRequest adRequest, @PathVariable long id) {
        adService.updateAd(adRequest, id);
    }

    @PatchMapping("/updateRate/{ownerEmail}/{rate}")
    @TokenValidationAspect
    void rateUser(@PathVariable String ownerEmail,@PathVariable Double rate) {
        adService.rateUser(ownerEmail,rate);
    }

    ////////////////////////////////// DELETE ///////////////////////////////////////////


    @DeleteMapping("/deleteFavourite/{id}")
    @TokenValidationAspect
    void deleteFavourite(@PathVariable long id) {
        favouriteService.deleteFavourite(id);
    }

    @DeleteMapping("/deleteAd/{id}")
    @TokenValidationAspect
    void deleteAd(@PathVariable long id) {
        adService.deleteAd(id,'u');
    }


    /////////////////////////////// GET ////////////////////////////////////////


    @GetMapping("/getMyAds")
    @TokenValidationAspect
    List<AdResponse> getMyAds() {
        return adService.getMyAds();
    }

    @GetMapping("/building/{id}")
    @TokenValidationAspect
    AdResponse getAd(@PathVariable long id) {
        return adService.getAd(id);
    }

    @GetMapping("/getUser")
    @TokenValidationAspect
    User getUser() {
        return jwtUtil.getUserDataFromToken();
    }

    @GetMapping("/getUser/{id}")
    @TokenValidationAspect
    String getUserById(@PathVariable long id) {
        return customUserDetailsService.getUserDataById(id);
    }

    @GetMapping("/getMyFavourite")
    @TokenValidationAspect
    List<AdResponse> getMyFavourites() {
        return favouriteService.getMyFavourites();
    }

    @GetMapping("/getMyFavouriteById/{id}")
    @TokenValidationAspect
    public ResponseEntity<Boolean> isBuildingInFavorites(@PathVariable long id) {
        return ResponseEntity.ok(favouriteService.getMyFavouriteById(id));
    }


    // #####################################################################################################
    @PostMapping("/filter")
    @TokenValidationAspect
    List<AdResponse> filterAttributes(@RequestBody FilterRequest filterRequest){
        return buildingFilterService.filterByAttributes(filterRequest);
    }

    // ##################################### Face recognition ###############################################

    @PostMapping("/faceRecognition")
    @TokenValidationAspect
    VerifyNIDResponse detectFace(@RequestBody FaceRecognitionRequest faceRecognitionRequest){
        return machineService.detectFace(faceRecognitionRequest);
    }
    @PostMapping("/recommendation/{id}")
    @TokenValidationAspect
    List<AdResponse> recommendation(@PathVariable long id){
        return machineService.recommendation(id);
    }
}
