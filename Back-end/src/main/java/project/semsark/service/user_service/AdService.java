package project.semsark.service.user_service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;
import project.semsark.exception.HelperMessage;
import project.semsark.jwt.JwtUtil;
import project.semsark.mapper.AdMapper;
import project.semsark.model.entity.Building;
import project.semsark.model.entity.Favourites;
import project.semsark.model.entity.User;
import project.semsark.model.request_body.AdRequest;
import project.semsark.model.response_body.AdResponse;
import project.semsark.repository.BuildingRepository;
import project.semsark.repository.FavouriteRepository;
import project.semsark.repository.PhotosRepository;
import project.semsark.repository.UserRepository;
import project.semsark.validation.AdValidator;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class AdService {
    @Autowired
    AdValidator adValidator;
    @Autowired
    BuildingRepository buildingRepository;
    @Autowired
    UserRepository userRepository;
    @Autowired
    AdMapper adMapper;
    @Autowired
    JwtUtil jwtUtil;

    @Autowired
    PhotosRepository photosRepository;

    @Autowired
    FavouriteRepository favouriteRepository;


    public void createAd(AdRequest adRequest) {
        Building building = buildingRepository.getBuildingByLngAndLat(adRequest.getLng(), adRequest.getLat());
        while (building != null) {
            adRequest.setLng(adRequest.getLng() + 1);
            adRequest.setLat(adRequest.getLat() + 1);
            building = buildingRepository.getBuildingByLngAndLat(adRequest.getLng(), adRequest.getLat());
        }
        Building ad = new Building();
        adMapper.mapTo(adRequest, ad);
        User user = jwtUtil.getUserDataFromToken();

        ad.setUserId(user.getId());
        ad.setUser(user);
        Building myAd = buildingRepository.save(ad);
        adMapper.storeImg(myAd, adRequest);
        userRepository.save(user);
    }

    public void updateAd(AdRequest adRequest, long id) {
        Optional<Building> building = buildingRepository.findById(id);
        if (building.isPresent()) {
            adValidator.valid(id);
            adMapper.mapTo(adRequest, building.get());
            buildingRepository.save(building.get());
        } else
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, HelperMessage.BUILDING_NOT_FOUND);
    }


    /////////////////////////////////////////////////////////////////

    public List<AdResponse> getAllAds() {
        List<AdResponse> adResponseList = new ArrayList<>();
        for (Building obj : buildingRepository.findAll()) {
            adResponseList.add(adMapper.mapTo(obj));
        }
        return adResponseList;
    }

    public List<AdResponse> getMyAds() {
        User user = jwtUtil.getUserDataFromToken();
        List<AdResponse> result = new ArrayList<>();
        for (Building building : buildingRepository.getBuildingByUser(user)) {
            result.add(adMapper.mapTo(building));
        }
        return result;
    }

    public AdResponse getAd(Long id) {
        Optional<Building> building = buildingRepository.findById(id);
        if (building.isPresent()) {
            Building build = building.get();

            if (build.getUserId() != jwtUtil.getUserDataFromToken().getId())
                build.setViews(build.getViews() + 1);
            else
                build.setViews(build.getViews());

            return adMapper.mapTo(buildingRepository.save(build));
        } else
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, HelperMessage.BUILDING_NOT_FOUND);
    }

    public void rateUser(String ownerEmail, Double rate) {
        Optional<User> user = userRepository.findByEmail(ownerEmail);

        if (user.isPresent()) {
            User user1 = user.get();
            user1.setRateCounter(user1.getRateCounter() + 1);
            user1.setRateSum(user1.getRateSum() + rate);

            user1.setRate((user1.getRateSum()) / (user1.getRateCounter()));
            userRepository.save(user1);
        } else
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, HelperMessage.USER_NOT_FOUND);

    }

    // ########################################## Delete Ad #########################################################

    @Transactional
    public void deleteAd(long id, char type) {
        if (buildingRepository.findById(id).isPresent()) {
            Building building = buildingRepository.findById(id).get();
            if (type == 'u') {
                User user = jwtUtil.getUserDataFromToken();
                if (building.getUserId() == user.getId()) {
                    Favourites favourites = favouriteRepository.findByUserId(user.getId());
                    if (favourites != null && favourites.getBuildings().contains(building)) {
                        favourites.getBuildings().remove(building);
                        favouriteRepository.save(favourites);
                    }
                    photosRepository.deleteAll((photosRepository.getPhotosByBuilding(building)));
                } else
                    throw new ResponseStatusException(HttpStatus.BAD_REQUEST, HelperMessage.DONT_HAVE_AD);
            } else
                buildingRepository.deleteById(id);


        } else
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, HelperMessage.BUILDING_NOT_FOUND);
    }


}
