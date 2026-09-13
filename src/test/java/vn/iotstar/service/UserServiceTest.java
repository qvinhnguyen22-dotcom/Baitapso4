package vn.iotstar.service;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

import java.util.List;
import java.util.Optional;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;

import vn.iotstar.entity.User;
import vn.iotstar.repository.UserRepository;

public class UserServiceTest {

    private UserRepository userRepository;
    private FileStorageService fileStorageService;
    private UserService userService;

    @BeforeEach
    void setUp() {
        userRepository = mock(UserRepository.class);
        fileStorageService = mock(FileStorageService.class);
        when(fileStorageService.isValidImageUrl(anyString())).thenReturn(true);
        userService = new UserService(userRepository, fileStorageService, 5);
    }

    @Test
    void search_withoutKeyword_callsFindAll() {
        User user = new User();
        user.setId(1);
        user.setUsername("admin");
        Page<User> expected = new PageImpl<>(List.of(user));

        when(userRepository.findAll(any(Pageable.class))).thenReturn(expected);

        Page<User> result = userService.search(null, 1);
        assertNotNull(result);
        assertEquals(1, result.getTotalElements());
        verify(userRepository).findAll(any(Pageable.class));
    }

    @Test
    void search_withKeyword_callsSearch() {
        User user = new User();
        user.setId(1);
        user.setUsername("vinh");
        Page<User> expected = new PageImpl<>(List.of(user));

        when(userRepository.search(eq("vinh"), any(Pageable.class))).thenReturn(expected);

        Page<User> result = userService.search("vinh", 1);
        assertNotNull(result);
        assertEquals(1, result.getTotalElements());
        verify(userRepository).search(eq("vinh"), any(Pageable.class));
    }

    @Test
    void saveAdmin_duplicateEmail_throwsException() {
        User form = new User();
        form.setFullname("Nguyen Van A");
        form.setEmail("test@gmail.com");
        form.setUsername("usertest");
        form.setRole("USER");

        when(userRepository.existsByEmailIgnoreCase("test@gmail.com")).thenReturn(true);

        Exception ex = assertThrows(IllegalArgumentException.class, () -> {
            userService.saveAdmin(form, null, null, false, "123456");
        });
        assertTrue(ex.getMessage().contains("đã tồn tại"));
    }

    @Test
    void saveAdmin_validNewUser_savesUser() {
        User form = new User();
        form.setFullname("Nguyen Van A");
        form.setEmail("test@gmail.com");
        form.setUsername("usertest");
        form.setRole("USER");
        form.setStatus(true);

        when(userRepository.existsByEmailIgnoreCase("test@gmail.com")).thenReturn(false);
        when(userRepository.existsByUsernameIgnoreCase("usertest")).thenReturn(false);

        userService.saveAdmin(form, "https://images.unsplash.com/avatar.jpg", null, false, "123456");
        verify(userRepository).save(any(User.class));
    }

    @Test
    void delete_self_throwsException() {
        Exception ex = assertThrows(IllegalArgumentException.class, () -> {
            userService.delete(1, 1);
        });
        assertTrue(ex.getMessage().contains("Không thể xóa tài khoản đang đăng nhập"));
        verify(userRepository, never()).deleteById(anyInt());
    }

    @Test
    void delete_otherUser_success() {
        when(userRepository.existsById(2)).thenReturn(true);

        userService.delete(2, 1);
        verify(userRepository).deleteById(2);
    }
}
