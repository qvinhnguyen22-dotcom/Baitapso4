package vn.iotstar.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import vn.iotstar.entity.User;
import vn.iotstar.repository.UserRepository;

@Service
public class UserService {

    private final UserRepository userRepository;
    private final FileStorageService fileStorageService;
    private final int pageSize;

    public UserService(UserRepository userRepository,
                       FileStorageService fileStorageService,
                       @Value("${app.page-size:5}") int pageSize) {
        this.userRepository = userRepository;
        this.fileStorageService = fileStorageService;
        this.pageSize = pageSize;
    }

    public Page<User> search(String keyword, int page) {
        Pageable pageable = PageRequest.of(Math.max(page - 1, 0), pageSize, Sort.by("id").descending());
        if (keyword == null || keyword.isBlank()) {
            return userRepository.findAll(pageable);
        }
        return userRepository.search(keyword.trim(), pageable);
    }

    public User findById(int id) {
        return userRepository.findById(id).orElse(null);
    }

    public User findByUsername(String username) {
        return username == null ? null : userRepository.findByUsernameIgnoreCase(username.trim()).orElse(null);
    }

    public User findByEmail(String email) {
        return email == null ? null : userRepository.findByEmailIgnoreCase(email.trim()).orElse(null);
    }

    @Transactional
    public void save(User user) {
        userRepository.save(user);
    }

    @Transactional
    public void saveAdmin(User form, String imageUrl, MultipartFile uploadFile, boolean update, String rawPassword) {
        String fullname = trim(form.getFullname());
        String email = normalize(form.getEmail());
        String username = trim(form.getUsername());
        String phone = trim(form.getPhone());
        String role = form.getRole() == null ? "USER" : form.getRole().trim().toUpperCase();

        if (fullname == null || fullname.length() < 2 || fullname.length() > 200) {
            throw new IllegalArgumentException("Họ tên phải từ 2 đến 200 ký tự.");
        }
        if (email == null || !email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
            throw new IllegalArgumentException("Email không hợp lệ.");
        }
        if (username == null || !username.matches("^[A-Za-z0-9_]{3,50}$")) {
            throw new IllegalArgumentException("Username phải từ 3 đến 50 ký tự và chỉ gồm chữ, số, dấu gạch dưới.");
        }
        if (phone != null && !phone.isEmpty() && !phone.matches("^[0-9]{10,11}$")) {
            throw new IllegalArgumentException("Số điện thoại phải gồm 10 hoặc 11 chữ số.");
        }
        if (!"ADMIN".equals(role) && !"USER".equals(role)) {
            throw new IllegalArgumentException("Vai trò không hợp lệ.");
        }
        if (update) {
            User existing = userRepository.findById(form.getId())
                    .orElseThrow(() -> new IllegalArgumentException("Không tìm thấy người dùng."));
            if (userRepository.existsByEmailIgnoreCaseAndIdNot(email, existing.getId())) {
                throw new IllegalArgumentException("Email đã tồn tại.");
            }
            if (userRepository.existsByUsernameIgnoreCaseAndIdNot(username, existing.getId())) {
                throw new IllegalArgumentException("Username đã tồn tại.");
            }
            existing.setFullname(fullname);
            existing.setEmail(email);
            existing.setUsername(username);
            existing.setPhone(phone);
            existing.setRole(role);
            existing.setStatus(form.isStatus());
            if (rawPassword != null && !rawPassword.isBlank()) {
                if (rawPassword.length() < 6 || rawPassword.length() > 200) {
                    throw new IllegalArgumentException("Mật khẩu phải từ 6 đến 200 ký tự.");
                }
                existing.setPassword(rawPassword);
            }
            applyImage(existing, imageUrl, uploadFile, true);
            userRepository.save(existing);
            return;
        }

        if (rawPassword == null || rawPassword.length() < 6 || rawPassword.length() > 200) {
            throw new IllegalArgumentException("Mật khẩu phải từ 6 đến 200 ký tự.");
        }
        if (userRepository.existsByEmailIgnoreCase(email) || userRepository.existsByUsernameIgnoreCase(username)) {
            throw new IllegalArgumentException("Email hoặc username đã tồn tại.");
        }

        User created = new User();
        created.setFullname(fullname);
        created.setEmail(email);
        created.setUsername(username);
        created.setPassword(rawPassword);
        created.setPhone(phone);
        created.setRole(role);
        created.setStatus(form.isStatus());
        applyImage(created, imageUrl, uploadFile, false);
        userRepository.save(created);
    }

    @Transactional
    public void updateProfile(User user, String fullname, String phone, MultipartFile uploadFile) {
        if (fullname == null || fullname.length() < 2 || fullname.length() > 200) {
            throw new IllegalArgumentException("Họ tên phải từ 2 đến 200 ký tự.");
        }
        if (phone != null && !phone.isEmpty() && !phone.matches("^[0-9]{10,11}$")) {
            throw new IllegalArgumentException("Số điện thoại phải gồm 10 hoặc 11 chữ số.");
        }
        user.setFullname(fullname.trim());
        user.setPhone(phone == null || phone.isBlank() ? null : phone.trim());
        applyImage(user, null, uploadFile, true);
        userRepository.save(user);
    }

    @Transactional
    public void delete(int id, int currentUserId) {
        if (id == currentUserId) {
            throw new IllegalArgumentException("Không thể xóa tài khoản đang đăng nhập.");
        }
        if (!userRepository.existsById(id)) {
            throw new IllegalArgumentException("Không tìm thấy người dùng.");
        }
        userRepository.deleteById(id);
    }

    private void applyImage(User user, String imageUrl, MultipartFile uploadFile, boolean update) {
        try {
            String stored = fileStorageService.store(uploadFile, "user_");
            if (stored != null) {
                user.setImages(stored);
                user.setAvatar(stored);
            } else if (imageUrl != null && !imageUrl.isBlank()) {
                String value = imageUrl.trim();
                if (value.startsWith("http://") || value.startsWith("https://")) {
                    if (!fileStorageService.isValidImageUrl(value)) {
                        throw new IllegalArgumentException("Link ảnh không hợp lệ.");
                    }
                }
                user.setImages(value);
                user.setAvatar(value);
            }
        } catch (Exception ex) {
            throw new IllegalArgumentException(ex.getMessage());
        }
    }

    private String trim(String value) {
        return value == null ? null : value.trim();
    }

    private String normalize(String email) {
        return email == null ? null : email.trim().toLowerCase(java.util.Locale.ROOT);
    }
}
