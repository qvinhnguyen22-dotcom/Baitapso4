package vn.iotstar.config;

import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    private final AdminInterceptor adminInterceptor;
    private final LoginRequiredInterceptor loginRequiredInterceptor;

    public WebMvcConfig(AdminInterceptor adminInterceptor,
                        LoginRequiredInterceptor loginRequiredInterceptor) {
        this.adminInterceptor = adminInterceptor;
        this.loginRequiredInterceptor = loginRequiredInterceptor;
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(loginRequiredInterceptor)
                .addPathPatterns("/profile", "/profile/**", "/user/profile", "/user/profile/**");

        registry.addInterceptor(adminInterceptor)
                .addPathPatterns("/admin", "/admin/**");
    }

    @Bean
    public FilterRegistrationBean<SiteMeshFilter> siteMeshFilter() {
        FilterRegistrationBean<SiteMeshFilter> registration = new FilterRegistrationBean<>();
        registration.setFilter(new SiteMeshFilter());
        registration.addUrlPatterns("/*");
        registration.setName("sitemesh");
        registration.setOrder(Ordered.LOWEST_PRECEDENCE);
        return registration;
    }
}
