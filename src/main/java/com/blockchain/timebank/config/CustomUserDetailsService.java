package com.blockchain.timebank.config;

import java.util.ArrayList;
import java.util.List;

import com.blockchain.timebank.entity.UserEntity;
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

    @Transactional(readOnly = true)
    public UserDetails loadUserByUsername(String s) throws UsernameNotFoundException {
        System.out.println("s:" + s);
        UserEntity userEntity = userService.findUserEntityById(1L);
        if (userEntity == null) {
            System.out.println("User not found");
            throw new UsernameNotFoundException("Username not found");
        }
        return new User(userEntity.getPhone(), userEntity.getPassword(),
                true, true, true, true, getUserGrantedAuthorities());
    }

    private List<GrantedAuthority> getUserGrantedAuthorities() {
        List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
        authorities.add(new SimpleGrantedAuthority("ROLE_USER"));
        return authorities;
    }

}
