package project.semsark.aspect;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ResponseStatusException;
import project.semsark.model.entity.TokenStore;
import project.semsark.repository.TokensRepository;

import static project.semsark.global_methods.GlobalMethods.getToken;

@Aspect
@Component

public class TokenValidationAspectImp {

    @Autowired
    private TokensRepository tokenStoreRepository;

    @Before("@annotation(project.semsark.aspect.TokenValidationAspect)")
    public void validateToken(JoinPoint joinPoint) throws Throwable {
        // Extract token from request or headers
        String token = getToken();

        // Check if token exists in the token store
        TokenStore returnToken = tokenStoreRepository.findTokenStoreByToken(token);


        if (returnToken == null ) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED,"Token not valid!!");
        }
    }
}
