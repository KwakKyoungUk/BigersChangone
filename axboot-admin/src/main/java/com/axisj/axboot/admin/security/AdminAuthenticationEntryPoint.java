package com.axisj.axboot.admin.security;

import com.axisj.axboot.admin.AdminSecurityConfig;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.axisj.axboot.core.code.Constants;
import com.axisj.axboot.core.util.JsonUtils;
import com.axisj.axboot.core.util.WebUtils;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.www.BasicAuthenticationEntryPoint;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AdminAuthenticationEntryPoint extends BasicAuthenticationEntryPoint {

	@Override
	public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException authException) throws IOException, ServletException {
		WebUtils.deleteCookie(request, response, Constants.AUTH_TOKEN_KEY);

		if (request.getMethod().equals(RequestMethod.GET.toString()) && !request.getRequestURI().startsWith(Constants.API_CONTEXT_PATH)) {
			redirectToLoginPage(request, response);
		} else {
			jsonExceptionResponse(request, response, ApiResponse.redirect(AdminSecurityConfig.LOGIN_PAGE));
		}
	}

	public static void jsonExceptionResponse(HttpServletRequest request, HttpServletResponse response, ApiResponse apiResponse) throws IOException {
		response.setContentType(WebUtils.getJsonContentType(request));
		response.getWriter().write(JsonUtils.toJson(apiResponse));
		response.getWriter().flush();
	}

	public static void redirectToLoginPage(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.sendRedirect(AdminSecurityConfig.LOGIN_PAGE);
	}
}

