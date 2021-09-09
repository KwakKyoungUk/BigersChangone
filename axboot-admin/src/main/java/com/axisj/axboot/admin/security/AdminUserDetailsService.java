package com.axisj.axboot.admin.security;

import java.text.ParseException;
import java.time.LocalDateTime;
import java.util.Date;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.joda.time.DateTime;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.axisj.axboot.admin.LoginManager;
import com.axisj.axboot.core.code.Params;
import com.axisj.axboot.core.domain.company.Company;
import com.axisj.axboot.core.domain.company.CompanyService;
import com.axisj.axboot.core.domain.program.menu.MenuService;
import com.axisj.axboot.core.domain.program.menu.UserMenuInfo;
import com.axisj.axboot.core.domain.user.AdminLoginUser;
import com.axisj.axboot.core.domain.user.User;
import com.axisj.axboot.core.domain.user.UserService;
import com.axisj.axboot.core.util.DateUtils;

@Service
public class AdminUserDetailsService implements UserDetailsService {

	@Inject
	private UserService userService;

	@Inject
	private MenuService menuService;

	@Inject
	private CompanyService companyService;

	@Override
	public final AdminLoginUser loadUserByUsername(String username) throws UsernameNotFoundException {

		HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		User user = userService.findOne(username);
		if (user == null) {
			throw new UsernameNotFoundException("사용자 정보가 정확하지 않습니다.");
		}



		if(!req.getRemoteAddr().equals("211.252.203.11") && !req.getRemoteAddr().equals("211.252.203.12") && !req.getRemoteAddr().equals("27.101.154.140")){
			//throw new UsernameNotFoundException("허용된 사용자가 아닙니다.");
		}

		DateTime now = new DateTime();
		DateTime lastLoginDate = new DateTime(user.getLastLoginDate());
		if(lastLoginDate != null){
			lastLoginDate = lastLoginDate.plusMonths(6);
			if(lastLoginDate.compareTo(now) < 0){
				user.setUseYn("N");
				userService.save(user);
				throw new UsernameNotFoundException("이 ID는 6개월 이상 사용 하지 않아 잠금 처리 되었습니다. 시스템 관리자에게 문의 하세요.");
			}
		}

		if(user.getFailCnt() > 5){
			user.setUseYn("N");
			userService.save(user);
			throw new AccessDeniedException("접속시도 허용횟수(5회)를 초과 하였습니다. 이 계정은 더 이상 사용 할 수 없습니다. 시스템 관리자에게 문의 하세요.");
		}

		if (user.getUseYn().equals(Params.N)) {
			throw new AccessDeniedException("미사용 처리된 사용자 입니다.");
		}
		LoginManager loginManager = LoginManager.getInstance();
		//LoginStore loginStore = LoginStore.getInstance();
		//if(loginManager.isUsing(username)){
			//loginManager.getUserID(req.getSession());
			//throw new UsernameNotFoundException("이미 로그인중 입니다.");

		// }

		AdminLoginUser loginUser = new AdminLoginUser();
		loginUser.setUsername(user.getUserCd());
		loginUser.setUserNm(user.getUserNm());
		loginUser.setPassword(user.getUserPs());
		loginUser.setUserType(user.getUserType());

		if (user.getCompCd() != null) {
			Company company = companyService.findOne(user.getCompCd());

			if (company != null) {
				loginUser.setCompanyCode(company.getCompCd());
				loginUser.setCompanyName(company.getCompNm());
			}
		}

		UserMenuInfo userMenuInfo = menuService.getUserMenuInfo(loginUser.getUsername());

		loginUser.setMenuJsonHash(userMenuInfo.getMainMenuJsonHash());

		return loginUser;
	}

}
