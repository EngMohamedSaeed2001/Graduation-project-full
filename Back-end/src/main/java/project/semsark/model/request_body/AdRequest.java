package project.semsark.model.request_body;

import lombok.*;
import project.semsark.model.enums.TypesOfBuilding;

import java.util.Date;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AdRequest {
    List<String> photosList;
    private String signalPower;
    private boolean elevator;
    private boolean acceptBusiness; // yes - no
    private String dailyPrice; // daily - monthly - yearly

    private String title;
    private String category;
    private String apartmentDetails;
    private String city;
    private String gov;
    private Double price;
    private Double lng;
    private Double lat;
    private long area;
    private long numOfRoom;
    private long numOfBathroom;
    private long numOfHalls;
    private long level;
    private boolean finished;
    private boolean single;
    private TypesOfBuilding types;
}
