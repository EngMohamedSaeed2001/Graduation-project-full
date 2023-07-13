package project.semsark.client;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import project.semsark.model.request_body.FaceRecognitionRequest;
import project.semsark.model.response_body.VerifyNIDResponse;

import java.util.List;

@FeignClient( name = "face" , url = "${ml.api}")
public interface Machine {
    @PostMapping(value = "/face-comparison/")
    VerifyNIDResponse detectFace(@RequestBody FaceRecognitionRequest faceRecognitionRequest);
    @GetMapping(value = "/recommendation/{id}")
    List<Long> recommendation(@PathVariable long id);
}
