package project.semsark.mapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import project.semsark.model.entity.Building;
import project.semsark.model.entity.Photos;
import project.semsark.model.request_body.AdRequest;
import project.semsark.model.response_body.AdResponse;
import project.semsark.repository.PhotosRepository;
import project.semsark.repository.UserRepository;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


@Component
public class AdMapper {
    @Autowired
    PhotosRepository photosRepository;
    @Autowired
    UserRepository userRepository;
    @Autowired
    UserDetailsMapper userDetailsMapper;
    public void mapTo(AdRequest adRequest, Building building) {

        building.setDate(LocalDate.now());


        if (adRequest.getApartmentDetails() != null) {
            building.setApartmentDetails(adRequest.getApartmentDetails());
        }
        if (adRequest.getCategory() != null) {
            building.setCategory(adRequest.getCategory());
        }
        if (adRequest.getCity() != null) {
            building.setCity(adRequest.getCity());
        }
        if (adRequest.getGov() != null) {
            building.setGov(adRequest.getGov());
        }

        if (adRequest.isElevator()) {
            building.setElevator(true);
        }

        if (adRequest.getSignalPower() != null) {
            building.setSignalPower(adRequest.getSignalPower());
        }
        if (adRequest.getTitle() != null) {
            building.setTitle(adRequest.getTitle());
        }
        if (adRequest.getTypes() != null) {
            building.setTypes(adRequest.getTypes().name());
        }
        if (adRequest.getPrice() != 0) {
            building.setPrice(adRequest.getPrice());
        }
        if (adRequest.getLng() != 0) {
            building.setLng(adRequest.getLng());
        }

        if (adRequest.getLat() != 0) {
            building.setLat(adRequest.getLat());
        }
        if (adRequest.getArea() != 0) {
            building.setArea(adRequest.getArea());
        }
        if(adRequest.getLevel()!=0){
            building.setLevel(adRequest.getLevel());
        }
        if(adRequest.getNumOfBathroom()!=0){
            building.setNumOfBathroom(adRequest.getNumOfBathroom());
        }
        if(adRequest.getNumOfHalls()!=0){
            building.setNumOfHalls(adRequest.getNumOfHalls());
        }
        if(adRequest.getNumOfRoom()!=0){
            building.setNumOfRoom(adRequest.getNumOfRoom());
        }
        if (adRequest.isFinished()) {
            building.setFinished(true);
        }
        if (adRequest.isSingle()) {
            building.setSingle(true);
        }
        if (adRequest.isAcceptBusiness()) {
            building.setAcceptBusiness(true);
        }
        if(adRequest.getDailyPrice()!=null && !adRequest.getDailyPrice().equals(""))
            building.setDailyPrice(adRequest.getDailyPrice());



    }
    public void storeImg(Building building, AdRequest adRequest){
        for (String p: adRequest.getPhotosList()){
            Photos ph = Photos.builder()
                    .imgLink(p)
                    .building(building)
                    .build();
            photosRepository.save(ph);
//            building.getPhotosList().add(photo);
        }
    }
    public AdResponse mapTo(Building building ){
        List<String> photos = new ArrayList<>();
        for(Photos photo: photosRepository.getPhotosByBuilding(building))
            photos.add(photo.getImgLink());
        return AdResponse.builder()
                .id(building.getId())
                .user(userDetailsMapper.mapTo(userRepository.findById(building.getUserId()).get()))
                .photosList(photos)
                .signalPower(building.getSignalPower())
                .title(building.getTitle())
                .category(building.getCategory())
                .apartmentDetails(building.getApartmentDetails())
                .city(building.getCity())
                .gov(building.getGov())
                .types(building.getTypes())
                .price(building.getPrice())
                .lng(building.getLng())
                .lat(building.getLat())
                .area(building.getArea())
                .numOfRoom(building.getNumOfRoom())
                .numOfBathroom(building.getNumOfBathroom())
                .numOfHalls(building.getNumOfHalls())
                .level(building.getLevel())
                .finished(building.isFinished())
                .single(building.isSingle())
                .views(building.getViews())
                .date(building.getDate())
                .elevator(building.isElevator())
                .dailyPrice(building.getDailyPrice())
                .acceptBusiness(building.isAcceptBusiness())
                .build();
    }


}
