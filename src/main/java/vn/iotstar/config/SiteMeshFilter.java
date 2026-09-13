package vn.iotstar.config;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

public class SiteMeshFilter extends ConfigurableSiteMeshFilter {

    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        builder.addDecoratorPath("/admin/*", "/WEB-INF/decorators/admin.jsp")
                .addDecoratorPath("/*", "/WEB-INF/decorators/web.jsp")
                .addExcludedPath("/assets/*")
                .addExcludedPath("/image")
                .addExcludedPath("/image/*");
    }
}
