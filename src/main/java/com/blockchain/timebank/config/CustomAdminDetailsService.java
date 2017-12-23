package com.blockchain.timebank.config;

import com.blockchain.timebank.entity.UserAuthEntity;
import com.blockchain.timebank.service.UserAuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;


@Service
public class CustomAdminDetailsService implements UserDetailsService {

    @Autowired
    UserAuthService userAuthService;

    //@Transactional(readOnly = true)
    public UserDetails loadUserByUsername(String s) throws UsernameNotFoundException {
        UserAuthEntity userAuthEntity = userAuthService.findUserAuthEntityByPhone(s);
        if (userAuthEntity == null) {
            System.out.println("User not found");
            throw new UsernameNotFoundException("Username not found");
        }
        return new User(userAuthEntity.getPhone(), userAuthEntity.getPassword(), true, true, true, true, getUserGrantedAuthorities(userAuthEntity.getAuthority()));
    }

    private List<GrantedAuthority> getUserGrantedAuthorities(String authority) {
        List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
        authorities.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
        List<String> auth_list = userAuthService.getAllAuthoritiesFromJSONString(authority);
        for (String auth : auth_list) {
            authorities.add(new SimpleGrantedAuthority(auth));
        }
        return authorities;
    }
}
