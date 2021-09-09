package com.axisj.axboot.admin.security;

import java.io.IOException;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.DatatypeConverter;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import com.axisj.axboot.core.code.Constants;
import com.axisj.axboot.core.domain.asp.AspMaster;
import com.axisj.axboot.core.domain.asp.AspMasterService;
import com.axisj.axboot.core.domain.program.menu.AuthorizedMenu;
import com.axisj.axboot.core.domain.program.menu.MenuService;
import com.axisj.axboot.core.domain.program.menu.UserMenuInfo;
import com.axisj.axboot.core.domain.user.AdminLoginUser;
import com.axisj.axboot.core.domain.user.User;
import com.axisj.axboot.core.domain.user.UserService;
import com.axisj.axboot.core.dto.PageContentTO;
import com.axisj.axboot.core.util.CommonUtils;
import com.axisj.axboot.core.util.DateUtils;
import com.axisj.axboot.core.util.RequestHelper;
import com.axisj.axboot.core.util.WebUtils;

@Service
public class AdminTokenAuthenticationService {

	private static final long TEN_DAYS = 1000 * 60 * 60 * 24 * 10;
	private static final int FOUR_HOURS = 60 * 60 * 4 * 1000;

	private final TokenHandler tokenHandler;

	@Inject
	private MenuService menuService;

	@Inject
	private AspMasterService aspMasterService;

	@Inject
	private UserService userService;

	@Inject
	public AdminTokenAuthenticationService(@Value("${token.secret}") String secret) {
		tokenHandler = new TokenHandler(DatatypeConverter.parseBase64Binary(secret));
	}

	public int userTokenCookieExpires() {
		if (CommonUtils.isProduction()) {
			return 60 * 30;
		} else if (CommonUtils.isProduction1()) {
			return 60 * 30;
		} else if (CommonUtils.isProduction2()) {
			return 60 * 30;
		} else if (CommonUtils.isProduction3()) {
			return 60 * 30;
		} else {
			return FOUR_HOURS;
		}
	}

	public void addAuthentication(HttpServletResponse response, AdminUserAuthentication authentication) throws IOException {
		final AdminLoginUser user = authentication.getDetails();
		user.setExpires(System.currentTimeMillis() + TEN_DAYS);
		setUserEnvironments(user, response);
	}

	public void setUserEnvironments(AdminLoginUser user, HttpServletResponse response) throws IOException {
		String token = tokenHandler.createTokenForUser(user);
		String defaultTheme = Constants.DEFAULT_THEME;

		AspMaster aspMaster = aspMasterService.findOne(Constants.AX_BOOT_ASP_ID);

		if (aspMaster != null) {
			defaultTheme = aspMaster.getTheme();
		}

		WebUtils.setCookie(response, Constants.AUTH_TOKEN_KEY, token, userTokenCookieExpires());
		WebUtils.setCookie(response, Constants.THEME, defaultTheme);
	}

	public Authentication getAuthentication(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		final RequestHelper requestHelper = RequestHelper.of(request);
		final String token = WebUtils.getStringCookieValue(request, Constants.AUTH_TOKEN_KEY);
		final String pageId = FilenameUtils.getBaseName(request.getServletPath());
		final String requestUri = request.getRequestURI();




		if (token == null) {
			return deleteCookieAndReturnNullAuthentication(request, response);
		}



		AdminLoginUser user = tokenHandler.parseUserFromToken(token);

		if (user == null) {
			return deleteCookieAndReturnNullAuthentication(request, response);
		}

		User loginUser = userService.findOne(user.getUsername());
		if(loginUser != null) {
			Date loingDate = loginUser.getLastLoginDate();
			if(loingDate != null){
				loingDate.setSeconds(FOUR_HOURS);
			}
		}

//    	if(request.getSession() != null){
//    		if(!loginUser.getSessionCd().equals(request.getSession().getId())){
//
//    			if(loingDate.getTime() < System.currentTimeMillis()){
//
//        		}else{
//        			//if(!request.getRequestURI().contains("login")){
//        				deleteCookieAndReturnNullAuthentication(request, response);
//        				response.sendRedirect("/api/logout");
//        			//}
//    			}
//			}
//    	}

		if (!requestUri.startsWith(Constants.API_CONTEXT_PATH)) {
			String menuJsonHash = requestHelper.getSessionAttributeString(PageContentTO.MENU_JSON_HASH);

			Map<String, AuthorizedMenu> authorizedMenuMap;

			if (StringUtils.isEmpty(menuJsonHash) || (!menuJsonHash.equals(user.getMenuJsonHash()))) {
				UserMenuInfo userMenuInfo = menuService.getUserMenuInfo(user.getUsername());

				requestHelper.setSessionAttribute(PageContentTO.MENU_MAP, userMenuInfo.getAuthorizedMenuMap());
				requestHelper.setSessionAttribute(PageContentTO.MENU_JSON, userMenuInfo.getMainMenuJson());
				requestHelper.setSessionAttribute(PageContentTO.MENU_JSON_HASH, userMenuInfo.getMainMenuJsonHash());

				user.setMenuJsonHash(userMenuInfo.getMainMenuJsonHash());
			}

			authorizedMenuMap = (Map<String, AuthorizedMenu>) requestHelper.getSessionAttributeObject(PageContentTO.MENU_MAP);
			AuthorizedMenu authorizedMenu = authorizedMenuMap.get(pageId);
			PageContentTO pageContent = PageContentTO.of(pageId, authorizedMenu);

			requestHelper.setSessionAttributes(pageContent, user);

			user.setAuthorizedMenuMap(authorizedMenuMap);

			setUserEnvironments(user, response);

			//WebUtils.setLastNavigatedPage(request, response);
		}

		return new AdminUserAuthentication(user);
	}

	private Authentication deleteCookieAndReturnNullAuthentication(HttpServletRequest request, HttpServletResponse response) {
		WebUtils.deleteCookie(request, response, Constants.AUTH_TOKEN_KEY);
		return null;
	}
}
