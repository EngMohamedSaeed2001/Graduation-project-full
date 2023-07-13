
package project.semsark.repository;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import project.semsark.model.entity.ChatRoom;

import java.util.List;
import java.util.Optional;

@Repository
public interface ChatRoomRepository extends JpaRepository<ChatRoom, Long> {
    Optional<ChatRoom> findChatRoomBySenderIdAndReceiverId(Long senderId, Long receiverId);
    List<ChatRoom> findChatRoomBySenderId(Long senderId);
    List<ChatRoom> findChatRoomByReceiverId(Long receiverId);


}
