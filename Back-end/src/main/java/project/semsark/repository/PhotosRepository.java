package project.semsark.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import project.semsark.model.entity.Building;
import project.semsark.model.entity.Photos;

import java.util.List;

@Repository
public interface PhotosRepository extends JpaRepository<Photos,Long> {
    List<Photos> getPhotosByBuilding(Building building);
}
