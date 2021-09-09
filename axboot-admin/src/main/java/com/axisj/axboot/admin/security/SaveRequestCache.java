package com.axisj.axboot.admin.security;

import com.axisj.axboot.core.util.WebUtils;
import org.springframework.security.web.PortResolverImpl;
import org.springframework.security.web.savedrequest.DefaultSavedRequest;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SaveRequestCache extends HttpSessionRequestCache {
	@Override
	public void saveRequest(HttpServletRequest request, HttpServletResponse response) {
		DefaultSavedRequest savedRequest = new DefaultSavedRequest(request, new PortResolverImpl());

		if (savedRequest != null) {
			WebUtils.setLastNavigatedPage(request, response);
		}
	}
}
