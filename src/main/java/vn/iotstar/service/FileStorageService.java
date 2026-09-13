package vn.iotstar.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Locale;
import java.util.Set;

@Service
public class FileStorageService {

    private static final Set<String> ALLOWED = Set.of("jpg", "jpeg", "png", "gif");

    private final Path uploadDir;

    public FileStorageService(@Value("${app.upload-dir}") String uploadDir) {
        this.uploadDir = Paths.get(uploadDir);
    }

    public Path getUploadDir() {
        return uploadDir;
    }

    public String store(MultipartFile file, String prefix) throws IOException {
        if (file == null || file.isEmpty()) {
            return null;
        }

        String original = file.getOriginalFilename() == null ? "" : file.getOriginalFilename();
        String extension = extension(original);
        if (!ALLOWED.contains(extension)) {
            throw new IllegalArgumentException("Chỉ cho phép JPG, JPEG, PNG hoặc GIF.");
        }

        Files.createDirectories(uploadDir);
        String fileName = prefix + System.currentTimeMillis() + "." + extension;
        file.transferTo(uploadDir.resolve(fileName).toFile());
        return fileName;
    }

    public boolean isValidImageUrl(String url) {
        if (url == null || url.isBlank()) {
            return true;
        }
        return url.matches("(?i)^(https?://).+\\.(jpg|jpeg|png|gif)(\\?.*)?$");
    }

    private String extension(String fileName) {
        int dot = fileName.lastIndexOf('.');
        if (dot < 0 || dot == fileName.length() - 1) {
            return "";
        }
        return fileName.substring(dot + 1).toLowerCase(Locale.ROOT);
    }
}
