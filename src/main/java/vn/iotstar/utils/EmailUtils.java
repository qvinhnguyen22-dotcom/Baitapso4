package vn.iotstar.utils;

import java.io.InputStream;
import java.util.Properties;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailUtils {

    private static final Properties configProps = new Properties();

    static {
        try (InputStream input = EmailUtils.class.getClassLoader().getResourceAsStream("email.properties")) {
            if (input != null) {
                configProps.load(input);
            }
        } catch (Exception ignored) {
        }
    }

    public static boolean sendEmail(String to, String subject, String body) {
        // In mã OTP và thông tin ra Console để phục vụ kiểm thử tiện lợi (ngay cả khi chưa setup SMTP)
        System.out.println("==================================================");
        System.out.println("  [HỆ THỐNG GỬI MÃ XÁC THỰC OTP]");
        System.out.println("  Người nhận : " + to);
        System.out.println("  Tiêu đề    : " + subject);
        System.out.println("  Nội dung   : " + body);
        System.out.println("==================================================");

        final String from = getSetting("MAIL_USERNAME", "mail.username");
        final String password = getSetting("MAIL_PASSWORD", "mail.password");

        // Nếu chưa cấu hình email thật hoặc để giá trị mẫu
        if (from == null || from.isBlank() || from.contains("your-email") 
                || password == null || password.isBlank() || password.contains("your-16-character")) {
            System.out.println("  [LƯU Ý] Chưa cấu hình tài khoản Gmail trong email.properties hoặc biến môi trường.");
            System.out.println("  -> Vui lòng dùng mã OTP in ở trên để tiếp tục kiểm thử!");
            return false;
        }

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setText(body);
            Transport.send(message);
            System.out.println("  [THÀNH CÔNG] Đã gửi email thực tế đến " + to);
            return true;
        } catch (MessagingException e) {
            System.err.println("  [LỖI GỬI EMAIL]: " + e.getMessage());
            return false;
        }
    }

    private static String getSetting(String envName, String propName) {
        String val = System.getenv(envName);
        if (val != null && !val.isBlank()) {
            return val.trim();
        }
        val = System.getProperty(propName);
        if (val != null && !val.isBlank()) {
            return val.trim();
        }
        val = configProps.getProperty(propName);
        return val != null ? val.trim() : "";
    }
}