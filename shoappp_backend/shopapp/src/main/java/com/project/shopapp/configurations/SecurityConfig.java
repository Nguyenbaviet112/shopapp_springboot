package com.project.shopapp.configurations;

import com.project.shopapp.models.User;
import com.project.shopapp.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

@Configuration
@RequiredArgsConstructor
public class SecurityConfig {

    private final UserRepository userRepository;

    //user's detail object
    public UserDetailsService userDetailsService() {

        return phoneNumber -> {
            User existingUser = userRepository
                    .findByPhoneNumber(phoneNumber)
                    .orElseThrow(()  -> new UsernameNotFoundException("Cannot find user with phone number " + phoneNumber));

            return existingUser;
        }

    }

}
