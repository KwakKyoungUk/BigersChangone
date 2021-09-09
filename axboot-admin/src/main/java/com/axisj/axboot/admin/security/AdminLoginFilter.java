package com.axisj.axboot.admin.security;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import com.axisj.axboot.core.api.response.ApiResponse;
import com.axisj.axboot.core.code.ApiStatus;
import com.axisj.axboot.core.code.Constants;
import com.axisj.axboot.core.code.Params;
import com.axisj.axboot.core.domain.user.AdminLoginUser;
import com.axisj.axboot.core.domain.user.User;
import com.axisj.axboot.core.domain.user.UserService;
import com.axisj.axboot.core.domain.user.log.LoginLog;
import com.axisj.axboot.core.domain.user.log.LoginLogService;
import com.axisj.axboot.core.util.WebUtils;
import com.fasterxml.jackson.databind.ObjectMapper;

public class AdminLoginFilter extends AbstractAuthenticationProcessingFilter {

	private final AdminTokenAuthenticationService tokenAuthenticationService;
	private final AdminUserDetailsService userDetailsService;
	private final UserService userService;
	private final LoginLogService loginLogService;

	public AdminLoginFilter(String urlMapping, AdminTokenAuthenticationService tokenAuthenticationService, AdminUserDetailsService userDetailsService, AuthenticationManager authManager, UserService userService, LoginLogService loginLogService) {
		super(new AntPathRequestMatcher(urlMapping));

		this.userDetailsService = userDetailsService;
		this.tokenAuthenticationService = tokenAuthenticationService;
		this.userService = userService;
		this.loginLogService = loginLogService;
		this.setAuthenticationFailureHandler(new LoginFailureHandler());

		setAuthenticationManager(authManager);
	}

	@Override
	public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) throws AuthenticationException, IOException, ServletException {
		final AdminLoginUser user = new ObjectMapper().readValue(request.getInputStream(), AdminLoginUser.class);
		final UsernamePasswordAuthenticationToken loginToken = new UsernamePasswordAuthenticationToken(user.getUsername(), user.getPassword());
		return getAuthenticationManager().authenticate(loginToken);
	}

	@Override
	protected void successfulAuthentication(HttpServletRequest request, HttpServletResponse response, FilterChain chain, Authentication authentication) throws IOException, ServletException {
		final AdminLoginUser authenticatedUser = userDetailsService.loadUserByUsername(authentication.getName());
		final AdminUserAuthentication userAuthentication = new AdminUserAuthentication(authenticatedUser);

		tokenAuthenticationService.addAuthentication(response, userAuthentication);
		SecurityContextHolder.getContext().setAuthentication(userAuthentication);

		String username = authenticatedUser.getUsername();
		User user = userService.findOne(username);

		LoginLog log = new LoginLog();
		log.setId(username);
		log.setIp(request.getRemoteAddr());
		log.setSuccessYn(Params.Y);
		loginLogService.save(log);

		String sessionId = request.getSession().getId();
		long now = System.currentTimeMillis();

		//long loginTime = user.getLastLoginDate().getTime()+240 * 60;
		//if( System.currentTimeMillis() > user.getLastLoginDate().getTime()+240 * 60){
			//WebUtils.deleteCookie(request, response, Constants.AUTH_TOKEN_KEY);
		//}



	    user.setSessionCd(request.getSession().getId());
		user.setFailCnt(0);
		userService.save(user);
		userService.updateLastLoginDateTime(username);

		//LoginStore loginStore = LoginStore.getInstance();


		//LoginManager loginManager = LoginManager.getInstance();

		//request.getSession().setAttribute("username", username);
		///loginManager.setSession(request.getSession(), username);


		//loginStore.add(username, request.getSession());




	}

	class LoginFailureHandler implements AuthenticationFailureHandler {

		@Override
		public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
			String message = exception.getMessage();
			String username =  exception.getAuthentication().getName();
			User user = userService.findOne(username);

			//로그
			if(user != null){
				user.setFailCnt(user.getFailCnt()+1);
				userService.save(user);
				LoginLog log = new LoginLog();
				log.setId(username);
				log.setIp(request.getRemoteAddr());
				log.setSuccessYn(Params.N);
				loginLogService.save(log);
			}

			if (exception instanceof BadCredentialsException) {
				message = "비밀번호가 ("+user.getFailCnt()+"회) 틀렸습니다. 5회를 초과 하면 더 이상 계정을 사용 할 수 없습니다";
			}

			ApiResponse apiResponse = ApiResponse.error(ApiStatus.SYSTEM_ERROR, message);
			AdminAuthenticationEntryPoint.jsonExceptionResponse(request, response, apiResponse);
		}
	}
}
