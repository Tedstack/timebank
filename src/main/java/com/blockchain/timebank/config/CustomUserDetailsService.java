package com.blockchain.timebank.config;

import java.util.ArrayList;
import java.util.List;

import com.blockchain.timebank.entity.UserAuthEntity;
import com.blockchain.timebank.entity.UserEntity;
import com.blockchain.timebank.service.UserAuthService;
import com.blockchain.timebank.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private UserService userService;

    @Autowired
    private UserAuthService userAuthService;

    @Transactional(readOnly = true)
    public UserDetails loadUserByUsername(String s) throws UsernameNotFoundException {
        UserEntity userEntity = userService.findUserEntityByPhone(s);
        if (userEntity == null) {
            System.out.println("User not found");
            throw new UsernameNotFoundException("Username not found");
        }
        List<UserAuthEntity> userAuthEntities = userAuthService.findAllByUserId(userEntity.getId());
        return new User(userEntity.getPhone(), userEntity.getPassword(),
                    true, true, true, true, getUserGrantedAuthorities(userAuthEntities));
    }

    private List<GrantedAuthority> getUserGrantedAuthorities(List<UserAuthEntity> userAuthEntities) {
        List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
        authorities.add(new SimpleGrantedAuthority(UserRole.ROLE_USER));
        for(UserAuthEntity userAuthEntity:userAuthEntities){
            authorities.add(new SimpleGrantedAuthority(userAuthEntity.getAuthority()));
        }
        return authorities;
    }

}
