package com.axisj.axboot.admin.controllers;

import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.axisj.axboot.core.converter.BaseConverter;
import com.axisj.axboot.core.domain.program.Program;
import com.axisj.axboot.core.domain.program.ProgramService;
import com.axisj.axboot.core.vto.ProgramVTO;
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
@RequestMapping(value = "/api/v1/programs")
@Api(value = "Program", description = "Program API")
public class ProgramController extends BaseController {

    @Inject
    private ProgramService programService;

    @Inject
    private BaseConverter baseConverter;

    @ApiOperation(value = "프로그램 목록", notes = "등록된 프로그램 목록을 모두 보여준다.")
    @RequestMapping(method = RequestMethod.GET, produces = APPLICATION_JSON)
    public CommonListResponseParams.ListResponse list(
            @ApiParam(value = "프로그램/코드명", required = false, defaultValue = "") @RequestParam(required = false, defaultValue = "") String searchParams) {
        List<Program> programs = programService.searchProgram(searchParams);
        return CommonListResponseParams.ListResponse.of(ProgramVTO.of(programs));
    }

    @ApiOperation(value = "프로그램 등록/수정", notes = "프로그램을 등록/수정한다.")
    @RequestMapping(method = RequestMethod.PUT, produces = APPLICATION_JSON)
    public ApiResponse save(@RequestBody List<ProgramVTO> request) {
        List<Program> programs = baseConverter.convert(request, Program.class);
        programService.saveAndCheckAuth(programs);
        return ok();
    }
}
