package com.axisj.axboot.admin.controllers;

import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.axisj.axboot.core.converter.BaseConverter;
import com.axisj.axboot.core.domain.program.menu.Menu;
import com.axisj.axboot.core.domain.program.menu.MenuService;
import com.axisj.axboot.core.vto.MenuVTO;
import com.wordnik.swagger.annotations.Api;
import com.wordnik.swagger.annotations.ApiOperation;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.inject.Inject;
import java.util.List;

@Controller
@RequestMapping(value = "/api/v1/menus")
@Api(value = "Program Menu", description = "Program Menu API")
public class MenuController extends BaseController {

    @Inject
    private MenuService menuService;

    @Inject
    private BaseConverter baseConverter;

    @ApiOperation(value = "메뉴 목록", notes = "등록된 메뉴를 목록을 모두 보여준다.")
    @RequestMapping(method = RequestMethod.GET, produces = APPLICATION_JSON)
    public CommonListResponseParams.ListResponse list() {
        List<Menu> menus = menuService.findAllByOrderByMnuLvAscMnuIxAsc();
        return CommonListResponseParams.ListResponse.of(MenuVTO.of(menus));
    }

    @ApiOperation(value = "활성화된 메뉴 목록", notes = "등록된 메뉴들 중 활성화된 목록을 모두 보여준다.")
    @RequestMapping(value = "/actives", method = RequestMethod.GET, produces = APPLICATION_JSON)
    public CommonListResponseParams.ListResponse actives() {
        List<Menu> menus = menuService.findActiveMenus();
        return CommonListResponseParams.ListResponse.of(MenuVTO.of(menus));
    }

    @ApiOperation(value = "메뉴 등록/수정", notes = "메뉴를 등록/수정 한다.")
    @RequestMapping(method = {RequestMethod.POST, RequestMethod.PUT}, produces = APPLICATION_JSON)
    public ApiResponse save(@RequestBody List<MenuVTO> request) {
        List<Menu> menus = baseConverter.convert(request, Menu.class);
        menuService.saveMenus(menus);
        return ok();
    }
}
