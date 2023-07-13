package project.semsark.controller.without_token;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import project.semsark.model.response_body.AdResponse;
import project.semsark.service.CustomUserDetailsService;
import project.semsark.service.user_service.AdService;

import java.util.List;

@RestController
@RequestMapping("/common")
public class CommonApi {
    @Autowired
    private AdService adService;

    @Autowired
    private CustomUserDetailsService customUserDetailsService;

    @GetMapping("/getAllAds")
    List<AdResponse> getAllAds(){
        return adService.getAllAds();
    }

    @GetMapping("/exist/{email}")
    void isExist(@PathVariable String email){
        customUserDetailsService.findUserByEmail(email);
    }
}
