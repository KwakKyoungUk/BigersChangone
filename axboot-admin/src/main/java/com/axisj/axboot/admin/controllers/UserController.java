package com.axisj.axboot.admin.controllers;

import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.ListResponse;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.axisj.axboot.core.converter.BaseConverter;
import com.axisj.axboot.core.domain.user.User;
import com.axisj.axboot.core.domain.user.UserService;
import com.axisj.axboot.core.vto.UserVTO;
import com.wordnik.swagger.annotations.Api;
import com.wordnik.swagger.annotations.ApiOperation;
import com.wordnik.swagger.annotations.ApiParam;

import net.bigers.funeralsystem.fune0000.domain.part.PartService;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.inject.Inject;
import java.util.List;

@Controller
@RequestMapping(value = "/api/v1/users")
@Api(value = "User", description = "User API")
public class UserController extends BaseController {

    @Inject
    private UserService userService;

    @Inject
    private PartService partService;

    @ApiOperation(value = "사용자 목록", notes = "전체 사용자 목록")
    @RequestMapping(method = RequestMethod.GET, produces = APPLICATION_JSON)
    public CommonListResponseParams.ListResponse list(
            @ApiParam(value = "사용자 코드", required = false, defaultValue = "0") @RequestParam(value = "userCd", required = false, defaultValue = "") String userCd,
            @ApiParam(value = "회사코드", required = false, defaultValue = "0") @RequestParam(value = "compCd", required = false, defaultValue = "") String compCd,
            @ApiParam(value = "회사코드", required = false, defaultValue = "0") @RequestParam(value = "userType", required = false, defaultValue = "") String userType) {
        List<User> users = userService.findByCompCdAndUserTypeAndUserCd(compCd, userType, userCd);
        return CommonListResponseParams.ListResponse.of(UserVTO.of(users));
    }

    @Inject
    private BaseConverter baseConverter;

    @ApiOperation(value = "사용자 등록/수정", notes = "사용자를 등록/수정 한다.")
    @RequestMapping(method = {RequestMethod.POST, RequestMethod.PUT}, produces = APPLICATION_JSON)
    public ApiResponse save(@RequestBody List<UserVTO> request) {
        List<User> users = baseConverter.convert(request, User.class);
        userService.updateUser(users);
        return ok();
    }

    @ApiOperation(value = "내 정보 수정", notes = "내 정보를 수정 한다.")
    @RequestMapping(value = "/updateMyInfo", method = {RequestMethod.POST, RequestMethod.PUT}, produces = APPLICATION_JSON)
    public ApiResponse updateMyInfo(@RequestBody UserVTO request) {
        User user = baseConverter.convert(request, User.class);
        userService.updateMyInfo(user);
        return ok();
    }

    @ApiOperation(value = "로그인 실패 횟수 저장", notes = "로그인 실패 횟수 저장")
    @RequestMapping(value = "/failCnt", method = {RequestMethod.POST}, produces = APPLICATION_JSON)
    public ApiResponse failCnt(@RequestBody UserVTO request) {
        User user = baseConverter.convert(request, User.class);
        user.setFailCnt(user.getFailCnt()+1);
        userService.save(user);
        return ok();
    }

    @ApiOperation(value = "전체 파트", notes = "전체 파트")
    @RequestMapping(value = "/part/all", method = {RequestMethod.GET}, produces = APPLICATION_JSON)
    public ListResponse getPartAll() {
    	return ListResponse.of(this.partService.findAll());
    }
}
