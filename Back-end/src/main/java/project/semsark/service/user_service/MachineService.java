package project.semsark.service.user_service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;
import project.semsark.client.Machine;
import project.semsark.jwt.JwtUtil;
import project.semsark.mapper.AdMapper;
import project.semsark.model.entity.Building;
import project.semsark.model.entity.User;
import project.semsark.model.request_body.FaceRecognitionRequest;
import project.semsark.model.response_body.AdResponse;
import project.semsark.model.response_body.VerifyNIDResponse;
import project.semsark.repository.BuildingRepository;
import project.semsark.repository.UserRepository;

import java.util.ArrayList;
import java.util.List;

@Service
public class MachineService {
    @Autowired
    Machine machine;
    @Autowired
    JwtUtil jwtUtil;
    @Autowired
    UserRepository userRepository;
    @Autowired
    BuildingRepository buildingRepository;
    @Autowired
    AdMapper adMapper;

    public VerifyNIDResponse detectFace(FaceRecognitionRequest faceRecognitionRequest){
        VerifyNIDResponse result = machine.detectFace(faceRecognitionRequest);
        User user = jwtUtil.getUserDataFromToken();
        user.setVerifyID(result.getResult());
        userRepository.save(user);
        return result;
    }
    public List<AdResponse> recommendation(long id){
        List<Long> ids = machine.recommendation(id);
        List<Building> ads = buildingRepository.findAllById(ids);
        List<AdResponse> result = new ArrayList<>();
        for(Building ad: ads)
            result.add(adMapper.mapTo(ad));
        return result;
    }
}
