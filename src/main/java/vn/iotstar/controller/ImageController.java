package vn.iotstar.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

import org.springframework.http.MediaType;
import org.springframework.http.MediaTypeFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.service.FileStorageService;

@Controller
public class ImageController {

    private final FileStorageService fileStorageService;

    public ImageController(FileStorageService fileStorageService) {
        this.fileStorageService = fileStorageService;
    }

    @GetMapping("/image")
    public void image(@RequestParam("fname") String fileName, HttpServletResponse response) throws IOException {
        if (fileName == null || fileName.contains("..") || fileName.contains("/") || fileName.contains("\\")) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        Path file = fileStorageService.getUploadDir().resolve(fileName);
        if (!Files.exists(file)) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        MediaType mediaType = MediaTypeFactory.getMediaType(fileName).orElse(MediaType.IMAGE_JPEG);
        response.setContentType(mediaType.toString());
        Files.copy(file, response.getOutputStream());
    }
}
