package project.semsark.model.entity;

import lombok.*;

import javax.persistence.*;
import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder

@Entity
public class Building {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private long userId;
    private String signalPower;
    private String title;
    private String category; // rent or sell
    private String dailyPrice; // daily - monthly - yearly
    private String apartmentDetails;
    private String city; //
    private String gov;
    private String types;// duplex - apartment - villa
    private Double price; // min price - max price
    private long views;
    private LocalDate date;
    private Double lng;
    private Double lat;
    private long area; // min - max
    private long numOfRoom; // min - max
    private long numOfBathroom; // min - max
    private long numOfHalls; // min - max
    private long level;
    private boolean finished; // yes - no
    private boolean single; // yes - no
    private boolean acceptBusiness; // yes - no
    private boolean elevator;
    @ManyToOne
    private User user;


}
