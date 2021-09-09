package com.axisj.axboot.admin.controllers;

import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.axisj.axboot.core.converter.BaseConverter;
import com.axisj.axboot.core.domain.code.BasicCode;
import com.axisj.axboot.core.domain.code.BasicCodeService;
import com.axisj.axboot.core.vto.BasicCodeVTO;
import com.wordnik.swagger.annotations.Api;
import com.wordnik.swagger.annotations.ApiOperation;
import com.wordnik.swagger.annotations.ApiParam;

import net.bigers.funeralsystem.common.domain.applicant.ApplicantService;
import net.bigers.funeralsystem.common.domain.thedead.ThedeadService;
import net.bigers.funeralsystem.common.vto.OptionVTO;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.inject.Inject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping(value = "/api/v1/basicCodes")
@Api(value = "BasicCode", description = "BasicCode API")
public class BasicCodeController extends BaseController {

    @Inject
    private BasicCodeService basicCodeService;

    @Inject
    private BaseConverter baseConverter;

    @Inject
    private ThedeadService thedeadService;

    @ApiOperation(value = "기초코드 목록", notes = "등록된 기초코드 목록을 모두 보여준다.")
    @RequestMapping(method = RequestMethod.GET, produces = APPLICATION_JSON)
    public CommonListResponseParams.ListResponse list(
            @ApiParam(value = "코드/코드명", required = false, defaultValue = "") @RequestParam(required = false, defaultValue = "") String searchParams) {
        List<BasicCode> basicCodes = basicCodeService.searchBasicCode(searchParams);
        return CommonListResponseParams.ListResponse.of(BasicCodeVTO.of(basicCodes));
    }

    @ApiOperation(value = "기초코드 그룹 목록", notes = "등록된 기초코드 중 해당 그룹 목록을 모두 보여준다.")
    @RequestMapping(value = "/group", method = RequestMethod.GET, produces = APPLICATION_JSON)
    public CommonListResponseParams.ListResponse groupList(
            @ApiParam(value = "기초코드 그룹", required = false, defaultValue = "0") @RequestParam(required = false, defaultValue = "0") String basicCd) {

        List<BasicCode> basicCodes = basicCodeService.findByBasicCd(basicCd);

        return CommonListResponseParams.ListResponse.of(BasicCodeVTO.of(basicCodes));
    }

    @ApiOperation(value = "기초코드 그룹 목록(select)", notes = "등록된 기초코드 중 해당 그룹 목록을 <select>의 옵션값으로 가지고 온다.")
    @RequestMapping(value = "/groupSelect", method = RequestMethod.GET, produces = APPLICATION_JSON)
    public List groupOptionList(
    		@ApiParam(value = "기초코드 그룹", required = false, defaultValue = "0") @RequestParam(required = false, defaultValue = "0") String basicCd) {

    	List<BasicCode> basicCodes = basicCodeService.findByBasicCd(basicCd);

    	List<Map<String, String>> res = basicCodes.stream().map(basicCode->{
    		Map<String, String> item = new HashMap<>();
//    		{optionValue:"", optionText:"직접입력"}
    		item.put("optionName", basicCode.getBasicNm());
    		item.put("optionValue", basicCode.getCode());
    		item.put("optionText", basicCode.getName());
    		return item;
    	}).collect(Collectors.toList());

    	return res;
    }

    @ApiOperation(value = "기초코드 등록/수정", notes = "기초코드를 등록/수정 한다.")
    @RequestMapping(method = {RequestMethod.POST, RequestMethod.PUT}, produces = APPLICATION_JSON)
    public ApiResponse save(@RequestBody List<BasicCodeVTO> request) {
        List<BasicCode> basicCodes = baseConverter.convert(request, BasicCode.class);
        basicCodeService.save(basicCodes);
        return ok();
    }

    @ApiOperation(value = "기초코드 그룹 목록", notes = "등록된 사망원인 기초코드 중 사산사유를 제외한 모두 보여준다.")
    @RequestMapping(value = "/deadReason", method = RequestMethod.GET, produces = APPLICATION_JSON)
    public CommonListResponseParams.ListResponse reasonList(
            @ApiParam(value = "기초코드 그룹", required = false, defaultValue = "0") @RequestParam(required = false, defaultValue = "0") String basicCd) {

        List<BasicCode> basicCodes = basicCodeService.findByBuyCodeOfDr("TCM03", "", "Y");

        return CommonListResponseParams.ListResponse.of(BasicCodeVTO.of(basicCodes));
    }

    @ApiOperation(value = "기초코드 그룹 목록", notes = "등록된 사망원인 기초코드 중 사산사유를 제외한 모두 보여준다.")
    @RequestMapping(value = "/deadReason/option", method = RequestMethod.GET, produces = APPLICATION_JSON)
    public  List<OptionVTO> reasonOption(
            @ApiParam(value = "기초코드 그룹", required = false, defaultValue = "0") @RequestParam(required = false, defaultValue = "0") String basicCd) {

        List<BasicCode> basicCodes = basicCodeService.findByBuyCodeOfDr("TCM03", "", "Y");
        List<OptionVTO> result = new ArrayList<>();
        basicCodes.forEach((item)->{
			result.add(OptionVTO.of(item.getCode(), item.getName()));
		});

        return result;
    }

    @ApiOperation(value = "기초코드 그룹 목록", notes = "등록된 사망원인 기초코드 중 사산사유를 모두 보여준다.")
    @RequestMapping(value = "/deadReasonB", method = RequestMethod.GET, produces = APPLICATION_JSON)
    public CommonListResponseParams.ListResponse reasonListB(
            @ApiParam(value = "기초코드 그룹", required = false, defaultValue = "0") @RequestParam(required = false, defaultValue = "0") String basicCd) {

        List<BasicCode> basicCodes = basicCodeService.findByBuyCodeOfDrB("TCM03", "TMC0300003");

        return CommonListResponseParams.ListResponse.of(BasicCodeVTO.of(basicCodes));
    }

    @ApiOperation(value = "기초코드 그룹 목록", notes = "등록된 사망원인 기초코드 중 사산사유를 모두 보여준다.")
    @RequestMapping(value = "/deadReasonB/option", method = RequestMethod.GET, produces = APPLICATION_JSON)
    public List<OptionVTO> reasonOptionB(
            @ApiParam(value = "기초코드 그룹", required = false, defaultValue = "0") @RequestParam(required = false, defaultValue = "0") String basicCd) {

        List<BasicCode> basicCodes = basicCodeService.findByBuyCodeOfDrBAndUseYn("TCM03", "TMC0300003","Y");
        List<OptionVTO> result = new ArrayList<>();
        basicCodes.forEach((item)->{
			result.add(OptionVTO.of(item.getCode(), item.getName()));
		});
        return result;
    }


    @ApiOperation(value = "기초코드 그룹 목록", notes = "등록된 사망원인 기초코드 중 사산사유를 제외한 모두 보여준다.")
    @RequestMapping(value = "/deadPlace/option", method = RequestMethod.GET, produces = APPLICATION_JSON)
    public  List<OptionVTO> placeOption(
            @ApiParam(value = "기초코드 그룹", required = false, defaultValue = "0") @RequestParam(required = false, defaultValue = "0") String basicCd) {

        List<BasicCode> basicCodes = basicCodeService.findByBuyCodeOfDr("TCM09", "", "Y");
        List<OptionVTO> result = new ArrayList<>();
        basicCodes.forEach((item)->{
			result.add(OptionVTO.of(item.getCode(), item.getName()));
		});

        return result;
    }

    @ApiOperation(value = "기초코드 그룹 목록", notes = "등록된 사망원인 기초코드 중 사산사유를 모두 보여준다.")
    @RequestMapping(value = "/deadPlaceB/option", method = RequestMethod.GET, produces = APPLICATION_JSON)
    public List<OptionVTO> placeOptionB(
            @ApiParam(value = "기초코드 그룹", required = false, defaultValue = "0") @RequestParam(required = false, defaultValue = "0") String basicCd) {

        List<BasicCode> basicCodes = basicCodeService.findByBuyCodeOfDrBAndUseYn("TCM09", "TMC0300003","Y");
        List<OptionVTO> result = new ArrayList<>();
        basicCodes.forEach((item)->{
			result.add(OptionVTO.of(item.getCode(), item.getName()));
		});
        return result;
    }

    @ApiOperation(value = "기초코드 그룹 목록", notes = "등록된 외국인중 입력된 국적을 모두 보여준다.")
    @RequestMapping(value = "/deadNationGbNm/option", method = RequestMethod.GET, produces = APPLICATION_JSON)
    public  CommonListResponseParams.ListResponse deadNationGbNm() {

        List<String> option = thedeadService.findByDeadNationGbNm();
        return  CommonListResponseParams.ListResponse.of(option);
    }
}
