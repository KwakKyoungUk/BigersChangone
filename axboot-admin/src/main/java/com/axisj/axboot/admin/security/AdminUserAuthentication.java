package com.axisj.axboot.admin.security;

import com.axisj.axboot.core.domain.user.AdminLoginUser;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;

import java.util.Collection;

public class AdminUserAuthentication implements Authentication {

	private final AdminLoginUser user;

	private boolean authenticated = true;

	public AdminUserAuthentication(AdminLoginUser user) {
		this.user = user;
	}

	@Override
	public String getName() {
		return user.getUsername();
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return user.getAuthorities();
	}

	@Override
	public Object getCredentials() {
		return user.getPassword();
	}

	@Override
	public AdminLoginUser getDetails() {
		return user;
	}

	@Override
	public Object getPrincipal() {
		return user;
	}

	@Override
	public boolean isAuthenticated() {
		return authenticated;
	}

	@Override
	public void setAuthenticated(boolean authenticated) {
		this.authenticated = authenticated;
	}
}
