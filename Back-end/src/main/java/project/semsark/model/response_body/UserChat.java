package project.semsark.model.response_body;


import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserChat {
    private long id;
    private String email;
    private String username;
    private String image;

}
