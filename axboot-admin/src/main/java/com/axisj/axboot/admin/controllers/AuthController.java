package com.axisj.axboot.admin.controllers;

import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.axisj.axboot.core.converter.BaseConverter;
import com.axisj.axboot.core.domain.user.auth.UserAuth;
import com.axisj.axboot.core.domain.user.auth.UserAuthService;
import com.axisj.axboot.core.domain.user.auth.group.AuthGroup;
import com.axisj.axboot.core.domain.user.auth.group.AuthGroupService;
import com.axisj.axboot.core.domain.user.auth.group.menu.AuthGroupMenu;
import com.axisj.axboot.core.domain.user.auth.group.menu.AuthGroupMenuService;
import com.axisj.axboot.core.vto.AuthGroupMenuVTO;
import com.axisj.axboot.core.vto.AuthGroupVTO;
import com.axisj.axboot.core.vto.UserAuthVTO;
import com.wordnik.swagger.annotations.Api;
import com.wordnik.swagger.annotations.ApiOperation;
import com.wordnik.swagger.annotations.ApiParam;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.inject.Inject;
import java.util.List;

@Controller
@RequestMapping(value = "/api/v1/auth")
@Api(value = "Auth", description = "Auth API")
public class AuthController extends BaseController {

	@Inject
	private AuthGroupService authGroupService;

	@Inject
	private AuthGroupMenuService authGroupMenuService;

	@Inject
	private UserAuthService userAuthService;

	@Inject
	private BaseConverter baseConverter;

	@ApiOperation(value = "권한그룹 목록", notes = "등록된 권한그룹 목록을 모두 보여준다.")
	@RequestMapping(value = "/groups", method = RequestMethod.GET, produces = APPLICATION_JSON)
	public CommonListResponseParams.ListResponse list() {
		List<AuthGroup> authGroups = authGroupService.findAll();
		return CommonListResponseParams.ListResponse.of(AuthGroupVTO.of(authGroups));
	}

	@ApiOperation(value = "권한그룹 등록/수정", notes = "권한그룹을 등록/수정 한다.")
	@RequestMapping(value = "/groups", method = {RequestMethod.POST, RequestMethod.PUT}, produces = APPLICATION_JSON)
	public ApiResponse save(@RequestBody List<AuthGroupVTO> request) {
		List<AuthGroup> authGroups = baseConverter.convert(request, AuthGroup.class);
		authGroupService.save(authGroups);
		return ok();
	}

	@ApiOperation(value = "권한그룹 삭제", notes = "권한그룹을 삭제 한다.")
	@RequestMapping(value = "/groups", method = {RequestMethod.DELETE}, produces = APPLICATION_JSON)
	public ApiResponse delete(@ApiParam(value = "권한그룹 코드", required = true, defaultValue = "0") @RequestParam(required = true, defaultValue = "") String grpAuthCd) {
		authGroupService.delete(grpAuthCd);
		return ok();
	}

	@ApiOperation(value = "권한그룹 내 메뉴 목록", notes = "등록된 권한그룹내 메뉴 목록을 모두 보여준다.")
	@RequestMapping(value = "/groups/menus", method = RequestMethod.GET, produces = APPLICATION_JSON)
	public CommonListResponseParams.ListResponse menuList(
			@ApiParam(value = "권한그룹 코드", required = false, defaultValue = "0") @RequestParam(required = true, defaultValue = "") String grpAuthCd) {
		List<AuthGroupMenu> authGroupMenuList = authGroupMenuService.findByGrpAuthCd(grpAuthCd);
		return CommonListResponseParams.ListResponse.of(AuthGroupMenuVTO.of(authGroupMenuList));
	}

	@ApiOperation(value = "권한그룹 메뉴 등록/수정", notes = "권한그룹 하위에 메뉴를 등록/수정 한다")
	@RequestMapping(value = "/groups/menus", method = {RequestMethod.POST, RequestMethod.PUT}, produces = APPLICATION_JSON)
	public ApiResponse saveMenu(@RequestBody List<AuthGroupMenuVTO> authGroupMenuVTOList) {
		List<AuthGroupMenu> authGroupMenuList = baseConverter.convert(authGroupMenuVTOList, AuthGroupMenu.class);
		authGroupMenuService.saveGroupMenus(authGroupMenuList);
		return ok();
	}


	@ApiOperation(value = "권한그룹 메뉴 삭제", notes = "권한그룹 하위에 메뉴 삭제")
	@RequestMapping(value = "/groups/menus", method = {RequestMethod.DELETE}, produces = APPLICATION_JSON)
	public ApiResponse deleteMenu(
			@ApiParam(value = "권한그룹 코드", required = false, defaultValue = "0") @RequestParam(required = true, defaultValue = "") String grpAuthCd,
			@ApiParam(value = "권한그룹 코드", required = false, defaultValue = "0") @RequestParam(value = "mnuCd", required = true) List<String> mnuCds) {

		authGroupMenuService.deleteByGrpAuthCdAndMnuCds(grpAuthCd, mnuCds);
		return ok();
	}


	@ApiOperation(value = "사용자가 가진 권한그룹 목록", notes = "해당 사용자가 가진 권한그룹을 보여준다.")
	@RequestMapping(value = "/users", method = RequestMethod.GET, produces = APPLICATION_JSON)
	public CommonListResponseParams.ListResponse authGroupListOnUser(
			@ApiParam(value = "사용자 코드", required = false, defaultValue = "0") @RequestParam(value = "userCd", required = true) String userCd) {

		List<UserAuth> userAuthList = userAuthService.findByUserCd(userCd);
		return CommonListResponseParams.ListResponse.of(UserAuthVTO.of(userAuthList));
	}

	@RequestMapping(value = "/users", method = {RequestMethod.POST, RequestMethod.PUT}, produces = APPLICATION_JSON)
	public ApiResponse saveAuthGroup(@RequestBody List<UserAuthVTO> request) {
		List<UserAuth> userAuthList = baseConverter.convert(request, UserAuth.class);
		userAuthService.deleteAndSave(userAuthList);
		return ok();
	}
}
