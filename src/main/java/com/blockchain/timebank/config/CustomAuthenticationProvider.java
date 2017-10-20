package com.blockchain.timebank.config;


import com.blockchain.timebank.entity.UserEntity;
import com.blockchain.timebank.service.UserService;
import com.blockchain.timebank.service.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class CustomAuthenticationProvider implements AuthenticationProvider {

    @Autowired
    private UserService userService=new UserServiceImpl();

    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        String phone = authentication.getName();
        String password = (String) authentication.getCredentials();
        UserEntity user = userService.findUserEntityByPhone(phone);

        if(user == null){
            System.out.println("Username not found.");
            return null;
        }

        //加密过程在这里体现
        if (!password.equals(user.getPassword())) {
            System.out.println("Wrong password.");
            return null;
        }

        return new UsernamePasswordAuthenticationToken(user, password, getUserGrantedAuthorities());
    }

    public boolean supports(Class<?> authentication) {
        return UsernamePasswordAuthenticationToken.class.equals(authentication);
    }

    private List<GrantedAuthority> getUserGrantedAuthorities() {
        List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
        authorities.add(new SimpleGrantedAuthority("ROLE_USER"));
        return authorities;
    }
}
