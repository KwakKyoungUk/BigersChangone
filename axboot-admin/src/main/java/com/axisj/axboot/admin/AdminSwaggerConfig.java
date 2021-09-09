package com.axisj.axboot.admin;

import com.mangofactory.swagger.configuration.SpringSwaggerConfig;
import com.mangofactory.swagger.models.dto.ApiInfo;
import com.mangofactory.swagger.plugin.EnableSwagger;
import com.mangofactory.swagger.plugin.SwaggerSpringMvcPlugin;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.web.bind.annotation.AuthenticationPrincipal;

import javax.inject.Inject;


@Configuration
@EnableSwagger
public class AdminSwaggerConfig {
    @Inject
    private SpringSwaggerConfig springSwaggerConfig;

    @Bean
    public SwaggerSpringMvcPlugin customImplementation() {
        return new SwaggerSpringMvcPlugin(this.springSwaggerConfig)
                .apiInfo(new ApiInfo("AXBoot Admin API", "AXBoot Admin API Documentation", "", "", "", ""))
                .includePatterns("/api/v1.*")
                .ignoredParameterTypes(AuthenticationPrincipal.class);
    }
}
