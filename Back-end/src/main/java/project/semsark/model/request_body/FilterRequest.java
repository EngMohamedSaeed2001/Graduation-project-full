package project.semsark.model.request_body;

import lombok.*;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FilterRequest {
    private String category; // rent or sell
    private String city; //
    private List<String> types;// duplex - apartment - villa
    private Double minPrice; // min price - max price
    private Double maxPrice; // min price - max price

    private long minArea; // min - max
    private long maxArea; // min - max

    private long minNumOfRoom; // min - max
    private long maxNumOfRoom; // min - max

    private long minNumOfBathroom; // min - max
    private long maxNumOfBathroom; // min - max

    private long minNumOfHalls; // min - max
    private long maxNumOfHalls; // min - max
    private boolean finished; // yes - no
    private boolean single; // yes - no
    private boolean acceptBusiness; // yes - no

}
