package project.semsark.model.request_body;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class NotificationBody {
    private String title;
    private String body;
    private String deviceId;

}
