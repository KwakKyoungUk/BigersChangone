package com.axisj.axboot.admin;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.annotation.web.servlet.configuration.EnableWebMvcSecurity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.authentication.logout.SimpleUrlLogoutSuccessHandler;
import org.springframework.security.web.session.HttpSessionEventPublisher;
import org.springframework.web.filter.CharacterEncodingFilter;

import com.axisj.axboot.admin.security.AdminAuthenticationEntryPoint;
import com.axisj.axboot.admin.security.AdminAuthenticationFilter;
import com.axisj.axboot.admin.security.AdminLoginFilter;
import com.axisj.axboot.admin.security.AdminTokenAuthenticationService;
import com.axisj.axboot.admin.security.AdminUserDetailsService;
import com.axisj.axboot.admin.security.SaveRequestCache;
import com.axisj.axboot.core.code.Constants;
import com.axisj.axboot.core.domain.user.UserService;
import com.axisj.axboot.core.domain.user.log.LoginLogService;

@EnableWebMvcSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
@Configuration
@Order(1)
public class AdminSecurityConfig extends WebSecurityConfigurerAdapter {

	public static final String LOGIN_API = "/api/login";
	public static final String LOGOUT_API = "/api/logout";
	public static final String LOGIN_PAGE = "/jsp/login.jsp";

	@Inject//autowrired??? ???????????? ????????????. maven?????? gradle??? javax ??????????????? ???????????? ??????????????????
	private UserService userService;

	@Inject
	private AdminUserDetailsService userDetailsService;

	@Inject
	private LoginLogService loginLogService;


	@Inject
	private AdminTokenAuthenticationService tokenAuthenticationService;


	public AdminSecurityConfig() {
		super(true);
	}

	@Override
	public void configure(WebSecurity webSecurity) throws Exception {//websecrity ????????? ?????????????????? ??????
		webSecurity.ignoring().antMatchers(//????????? ??????????????? ?????? ??????
				"/resources/**",
				"/static/**",
				"/layouts/**",
				"/jsp/common/**",
				"/swagger/**",
				"/api-docs/**",
				"/jsp/funeralsystem/display/public/**",
//				"/test/**",
				"/kiosk",
				"/display/public/**",
				"/wst/**",
				"/wsb/**",
				"/api/v1/**",
				"/api/v1/basicCodes/groupSelect"
		);
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {//httpscurity -> ????????? ?????? ??????
		CharacterEncodingFilter filter = new CharacterEncodingFilter();//??? ????????? ????????? ?????? ????????? ??????
		filter.setEncoding("UTF-8");
		filter.setForceEncoding(true);//HttpServletResponse ?????? ????????? ??????. fasle ????????? filter?????? ???????????? ????????? ?????????.


	/*	http.sessionManagement()
		.invalidSessionUrl("/spring/error?error_code=1")
		.sessionAuthenticationErrorUrl("/spring/error?error_code=2")
		.maximumSessions(1)
		.expiredUrl("/spring/error?error_code=3")
		.maxSessionsPreventsLogin(true)
		.sessionRegistry(sessionRegistry());*/

		http
		.anonymous().and()
		.servletApi().and()
		.headers().cacheControl().and()
		.authorizeRequests().anyRequest().authenticated()
		.antMatchers(HttpMethod.POST, LOGIN_API).permitAll()
		.antMatchers(LOGIN_PAGE).permitAll().and()
		.formLogin().loginPage(LOGIN_PAGE).permitAll().and()
		.requestCache().requestCache(new SaveRequestCache()).and()
		.logout().logoutUrl(LOGOUT_API).deleteCookies(Constants.AUTH_TOKEN_KEY, Constants.LAST_NAVIGATED_PAGE).logoutSuccessHandler(new LogoutSuccessHandler(LOGIN_PAGE)).and()
		.exceptionHandling().authenticationEntryPoint(new AdminAuthenticationEntryPoint()).and()
		.addFilterBefore(filter, UsernamePasswordAuthenticationFilter.class)
		.addFilterBefore(new AdminLoginFilter(LOGIN_API, tokenAuthenticationService, userDetailsService, authenticationManager(), userService, loginLogService), UsernamePasswordAuthenticationFilter.class)
		.addFilterBefore(new AdminAuthenticationFilter(tokenAuthenticationService), UsernamePasswordAuthenticationFilter.class);

	}

	@Bean
	@Override
	public AuthenticationManager authenticationManagerBean() throws Exception {
		//Authentication??? ????????? ?????????????????? ???????????????
		return super.authenticationManagerBean();
	}

	@Bean
	public DaoAuthenticationProvider daoAuthenticationProvider() {
		DaoAuthenticationProvider daoAuthenticationProvider = new DaoAuthenticationProvider();
		daoAuthenticationProvider.setUserDetailsService(userDetailsService);
		daoAuthenticationProvider.setPasswordEncoder(new ShaPasswordEncoder(512));
		daoAuthenticationProvider.setHideUserNotFoundExceptions(false);
		return daoAuthenticationProvider;
	}

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.authenticationProvider(daoAuthenticationProvider());
	}

	@Override
	protected AdminUserDetailsService userDetailsService() {
		return userDetailsService;
	}

	class LogoutSuccessHandler extends SimpleUrlLogoutSuccessHandler {

		public LogoutSuccessHandler(String defaultTargetURL) {
			this.setDefaultTargetUrl(defaultTargetURL);
		}

		@Override
		public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
			request.getSession().invalidate();
			super.onLogoutSuccess(request, response, authentication);
		}
	}

	@Bean
	public SessionRegistry sessionRegistry() {
	    SessionRegistry sessionRegistry = new SessionRegistryImpl();
	    return sessionRegistry;
	}

	@Bean
    public HttpSessionEventPublisher httpSessionEventPublisher() {
            return new HttpSessionEventPublisher();
    }
}
