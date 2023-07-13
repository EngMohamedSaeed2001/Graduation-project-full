package project.semsark.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import project.semsark.model.entity.Building;
import project.semsark.model.entity.Favourites;
import project.semsark.model.entity.User;

import java.util.List;

@Repository
public interface BuildingRepository extends JpaRepository<Building,Long> {
    Building getBuildingByLngAndLat(Double lng,Double lat);
    List<Building> getBuildingByUser(User user);

}
