package com.axisj.axboot.admin.controllers;

import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.axisj.axboot.core.converter.BaseConverter;
import com.axisj.axboot.core.domain.company.Company;
import com.axisj.axboot.core.domain.company.CompanyService;
import com.axisj.axboot.core.vto.CompanyVTO;
import com.wordnik.swagger.annotations.Api;
import com.wordnik.swagger.annotations.ApiOperation;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.inject.Inject;
import java.util.List;

@Controller
@RequestMapping(value = "/api/v1/companies")
@Api(value = "Company", description = "Company API")
public class CompanyController extends BaseController {
    @Inject
    private CompanyService companyService;

    @Inject
    private BaseConverter baseConverter;

    @ApiOperation(value = "회사 목록", notes = "등록된 회사 목록을 모두 보여준다.")
    @RequestMapping(method = RequestMethod.GET, produces = APPLICATION_JSON)
    public CommonListResponseParams.ListResponse list() {
        List<Company> companies = companyService.findAll();
        return CommonListResponseParams.ListResponse.of(CompanyVTO.of(companies));
    }

    @ApiOperation(value = "회사 등록/수정", notes = "회사 등록/수정 한다.")
    @RequestMapping(method = {RequestMethod.POST, RequestMethod.PUT}, produces = APPLICATION_JSON)
    public ApiResponse save(@RequestBody List<CompanyVTO> request) {
        List<Company> companies = baseConverter.convert(request, Company.class);
        companyService.save(companies);
        return ok();
    }
}
