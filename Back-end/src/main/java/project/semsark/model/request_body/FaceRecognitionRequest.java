package project.semsark.model.request_body;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class FaceRecognitionRequest {
    private String face1;
    private String face2;


}
