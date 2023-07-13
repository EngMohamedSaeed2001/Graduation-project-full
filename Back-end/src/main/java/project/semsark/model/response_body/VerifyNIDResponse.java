package project.semsark.model.response_body;

import lombok.*;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class VerifyNIDResponse {
    private String message;
    private Boolean result;
}
