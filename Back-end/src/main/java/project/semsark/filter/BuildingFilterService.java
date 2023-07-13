package project.semsark.filter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import project.semsark.mapper.AdMapper;
import project.semsark.model.entity.Building;
import project.semsark.model.request_body.FilterRequest;
import project.semsark.model.response_body.AdResponse;
import project.semsark.repository.BuildingRepository;

import java.util.ArrayList;
import java.util.List;

@Service
public class BuildingFilterService {
    @Autowired
    BuildingRepository buildingRepository;

    @Autowired
    AdMapper adMapper;

    public List<AdResponse> filterByAttributes(FilterRequest filterRequest) {
        List<Building> buildings = buildingRepository.findAll();
        List<AdResponse> result = new ArrayList<>();
        for (Building building : buildings) {
            if (!filterRequest.getCategory().equals("") &&
                    !building.getCategory().equals(filterRequest.getCategory()))
                continue;
            if (!filterRequest.getCity().equals("") &&
                    !building.getCity().equals(filterRequest.getCity()))
                continue;
            if (!filterRequest.getTypes().isEmpty() &&
                    !filterRequest.getTypes().contains(building.getTypes().toLowerCase()))
                continue;
            if (filterRequest.isFinished() && !building.isFinished())
                continue;
            if (filterRequest.isAcceptBusiness() && !building.isAcceptBusiness())
                continue;
            if (filterRequest.isSingle() && !building.isSingle())
                continue;

            if (building.getPrice() >= filterRequest.getMinPrice() &&
                    building.getPrice() <= filterRequest.getMaxPrice() &&
                    building.getArea() >= filterRequest.getMinArea() &&
                    building.getArea() <= filterRequest.getMaxArea() &&
                    building.getNumOfRoom() >= filterRequest.getMinNumOfRoom() &&
                    building.getNumOfRoom() <= filterRequest.getMaxNumOfRoom() &&
                    building.getNumOfBathroom() >= filterRequest.getMinNumOfBathroom() &&
                    building.getNumOfBathroom() <= filterRequest.getMaxNumOfBathroom() &&
                    building.getNumOfHalls() >= filterRequest.getMinNumOfHalls() &&
                    building.getNumOfHalls() <= filterRequest.getMaxNumOfHalls()
            )

                result.add(adMapper.mapTo(building));
        }
        return result;
    }
}
