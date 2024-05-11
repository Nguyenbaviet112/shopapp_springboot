package com.project.shopapp.services;

import com.project.shopapp.components.JwtTokenUtil;
import com.project.shopapp.dtos.UserDTO;
import com.project.shopapp.exceptions.DataNotFoundException;
import com.project.shopapp.models.Role;
import com.project.shopapp.models.User;
import com.project.shopapp.repositories.RoleRepository;
import com.project.shopapp.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserService implements IUserService {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtTokenUtil jwtTokenUtil;
    private final AuthenticationManager authenticationManager;

    @Override
    public User createUser(UserDTO userDTO) {

        String phoneNumber = userDTO.getPhoneNumber();

        if (userRepository.existsByPhoneNumber(phoneNumber))
        {
            throw new DataIntegrityViolationException("Phone number already exists");
        }

        // convert userDTO => user
        User newUser = User.builder()
                .fullName(userDTO.getFullName())
                .phoneNumber(userDTO.getPhoneNumber())
                .password(userDTO.getPassword())
                .address(userDTO.getAddress())
                .dateOfBirth(userDTO.getDateOfBirth())
                .facebookAccountId(userDTO.getFacebookAccountId())
                .googleAccountId(userDTO.getGoogleAccountId())
                .build();

        try {
            Role role = roleRepository.findById(userDTO.getRoldId())
                    .orElseThrow(() -> new DataNotFoundException("Role not found"));
            newUser.setRole(role);
        } catch (DataNotFoundException e) {
            throw new RuntimeException(e);
        }

        if (userDTO.getFacebookAccountId() == 0 || userDTO.getGoogleAccountId() == 0)
        {
            String password = userDTO.getPassword();
            String encoderPassword = passwordEncoder.encode(password);
            newUser.setPassword(encoderPassword);
        }

        return userRepository.save(newUser);
    }

    @Override
    public String login(String phoneNumber, String password) throws DataNotFoundException {

        Optional<User> user = userRepository.findByPhoneNumber(phoneNumber);
        if (user.isEmpty())
        {
            throw new DataNotFoundException("Invalid phone number or password");
        }

        User existingUser = user.get();
        // Check password
        if (existingUser.getFacebookAccountId() == 0 && existingUser.getGoogleAccountId() == 0)
        {
            if (!passwordEncoder.matches(password, existingUser.getPassword()))
            {
                throw new BadCredentialsException("Wrong phone number or password");
            }
        }

        UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken = new UsernamePasswordAuthenticationToken(
                phoneNumber, password,
                existingUser.getAuthorities()
        );

        // Authenticate with java spring security
        authenticationManager.authenticate(usernamePasswordAuthenticationToken);
        return jwtTokenUtil.generateToken(existingUser);

    }
}
