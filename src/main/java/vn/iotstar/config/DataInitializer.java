package vn.iotstar.config;

import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import vn.iotstar.entity.User;
import vn.iotstar.repository.UserRepository;

@Component
public class DataInitializer implements ApplicationRunner {

    private final UserRepository userRepository;

    public DataInitializer(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    @Transactional
    public void run(ApplicationArguments args) {
        userRepository.findByUsernameIgnoreCase("admin").ifPresent(user -> {
            if (user.getRole() == null || user.getRole().isBlank() || "USER".equalsIgnoreCase(user.getRole())) {
                user.setRole("ADMIN");
                user.setStatus(true);
                userRepository.save(user);
            }
        });

        userRepository.findAll().forEach(user -> {
            if (user.getRole() == null || user.getRole().isBlank()) {
                user.setRole("USER");
                userRepository.save(user);
            }
        });
    }
}
