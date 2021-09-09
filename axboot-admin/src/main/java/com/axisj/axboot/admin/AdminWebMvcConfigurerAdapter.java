package com.axisj.axboot.admin;

import com.axisj.axboot.admin.interceptor.HttpRequestInterceptor;
import com.axisj.axboot.core.util.AxBootMappingJackson2JsonView;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.core.JsonEncoding;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.MapperFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.data.web.PageableHandlerMethodArgumentResolver;
import org.springframework.data.web.config.EnableSpringDataWebSupport;
import org.springframework.http.MediaType;
import org.springframework.web.accept.ContentNegotiationManager;
import org.springframework.web.accept.PathExtensionContentNegotiationStrategy;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.ContentNegotiatingViewResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Configuration//어노테이션 기반 환경 구성을 돕는다. 클래스가 하나 이상의 @Bean 메소드를 제공하고 스프링컨테이가
// Bean정의를 생성하고 런타임시 그 Bean들이 요청들을 처리할 것을 선언한다.
@EnableSpringDataWebSupport
public class AdminWebMvcConfigurerAdapter extends WebMvcConfigurerAdapter {
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/static/**").addResourceLocations("/static/");
        registry.addResourceHandler("/layout/**").addResourceLocations("/layout/");
        registry.addResourceHandler("/favicon.ico").addResourceLocations("/static/favicon.ico");
    }

    @Bean
    public HttpRequestInterceptor httpRequestInterceptor() {
        return new HttpRequestInterceptor();
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(httpRequestInterceptor());
    }

    @Bean
    public ObjectMapper objectMapper() {
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);//원는 값만(json) 포함 시킬수 있음(NON_NULL->Null을 제외한다)
        //문자열에서 네이티브 객체로 변환하는 것은 파싱(parsing)이라고 한다. 네트워크를 통해 전달할 수 있게 객체를 문자열로 변환하는 과장은 문자열화(Stringfication)이라고 한다.
        
        objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
        objectMapper.configure(SerializationFeature.FAIL_ON_EMPTY_BEANS, false);
        objectMapper.configure(MapperFeature.AUTO_DETECT_GETTERS, true);
        objectMapper.configure(MapperFeature.AUTO_DETECT_IS_GETTERS, true);
        objectMapper.configure(JsonParser.Feature.ALLOW_SINGLE_QUOTES, true);
        objectMapper.configure(MapperFeature.DEFAULT_VIEW_INCLUSION, false);
        return objectMapper;
        //objectMapper json 라이브러리 클래스. 생성 비용이 비싸기때문에 Bean/static으로 처리하는 것이 좋다
        //json을 java 객첼도 변환할수 있고, 반대로 java 객체를 json 객체로 serialization(직렬화). 할수 있다.
        
    }

    @Bean
    public ContentNegotiatingViewResolver contentNegotiatingViewResolver() {
        Map<String, MediaType> mediaTypeMaps = new HashMap<>();
        mediaTypeMaps.put("json", MediaType.APPLICATION_JSON);

        PathExtensionContentNegotiationStrategy pathExtensionContentNegotiationStrategy = new PathExtensionContentNegotiationStrategy(mediaTypeMaps);
        ContentNegotiationManager contentNegotiationManager = new ContentNegotiationManager(pathExtensionContentNegotiationStrategy);

        ContentNegotiatingViewResolver contentNegotiatingViewResolver = new ContentNegotiatingViewResolver();
        contentNegotiatingViewResolver.setContentNegotiationManager(contentNegotiationManager);
        contentNegotiatingViewResolver.setOrder(Ordered.HIGHEST_PRECEDENCE);
 
        List<View> views = new ArrayList<>();
        AxBootMappingJackson2JsonView chequerMappingJackson2JsonView = new AxBootMappingJackson2JsonView();
        chequerMappingJackson2JsonView.setEncoding(JsonEncoding.UTF8);
        chequerMappingJackson2JsonView.setExtractValueFromSingleKeyModel(true);
        chequerMappingJackson2JsonView.setPrefixJson(false);
        chequerMappingJackson2JsonView.setObjectMapper(objectMapper());

        views.add(chequerMappingJackson2JsonView);

        contentNegotiatingViewResolver.setDefaultViews(views);

        List<ViewResolver> viewResolvers = new ArrayList<>();

        InternalResourceViewResolver internalResourceViewResolver = new InternalResourceViewResolver();
        //Default(기본) 뷰 리졸버, JSp를 뷰로 사용할때 사용
        //DispatcherSevlet에게 아무런 뷰 리졸버를 등록하지 않으면, 기본으로 동작하는 뷰 리졸버
        //뷰 리졸버를 등록하지 않고 사용하는 일은 없다. 기본 뷰 리졸버도 프로퍼티를 수정해 줘야 편리하다.
        
        internalResourceViewResolver.setPrefix("/");
        internalResourceViewResolver.setSuffix(".jsp");
        //모델은 그대로고, 뷰의 형식만 바꾸고 싶다면 컨트로러는 그대로고 뷰 리졸버만 변경하면 된다.
        

        viewResolvers.add(internalResourceViewResolver);

        contentNegotiatingViewResolver.setViewResolvers(viewResolvers);
        //view를 찾기 위해 욫엉 URL의 확장자와 AcceptHeader를 사용하는 viewResolver. 자체적으로 Veiw를 찾진않고
        //viewResolvers에 설정된 리졸버를 사용하여 view 를 찾음.
        //하나의 Requeest Handler를 만들어 놓고 URL의 확장자 부분만을 바꿔서 여러 View를 렌더링 할수 있다.
        

        return contentNegotiatingViewResolver;
    }

    @Override
    public void addArgumentResolvers(List<HandlerMethodArgumentResolver> argumentResolvers) {
        PageableHandlerMethodArgumentResolver pageableHandlerMethodArgumentResolver = new PageableHandlerMethodArgumentResolver();
        pageableHandlerMethodArgumentResolver.setPageParameterName("pageNumber");
        pageableHandlerMethodArgumentResolver.setSizeParameterName("pageSize");
        //HandlerMethodArgumentResolver 컨트롤러의 메소드에 특정 파라미터가 있을 경우, 원하는 값을 바인딩 해주고자 할떄 사용
        //pageableHandlerMethodArgumentResolver는 Pageble객체가 사용될 때, 바인딩 동작을 정의해논 구현체다.
        //
        argumentResolvers.add(pageableHandlerMethodArgumentResolver);
    }

    @Override
    public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
        configurer.enable();
        super.configureDefaultServletHandling(configurer);
    }
}
