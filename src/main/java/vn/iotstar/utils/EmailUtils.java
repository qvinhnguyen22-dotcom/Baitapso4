package vn.iotstar.utils;

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
    public static boolean sendEmail(String to, String subject, String body) {
        final String from = setting("MAIL_USERNAME", "mail.username", "");
        final String password = setting("MAIL_PASSWORD", "mail.password", "");
        if (from.isBlank() || password.isBlank()) {
            return false;
        }

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
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
        } catch (MessagingException e) {
            return false;
        }
        return true;
    }

    private static String setting(String environmentName, String propertyName, String defaultValue) {
        String value = System.getenv(environmentName);
        return value == null || value.isBlank() ? System.getProperty(propertyName, defaultValue) : value;
    }
}