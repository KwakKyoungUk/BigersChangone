package com.axisj.axboot.admin.controllers;

import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.axisj.axboot.core.converter.BaseConverter;
import com.axisj.axboot.core.domain.asp.AspMaster;
import com.axisj.axboot.core.domain.asp.AspMasterService;
import com.axisj.axboot.core.vto.AspMasterVTO;
import com.wordnik.swagger.annotations.Api;
import com.wordnik.swagger.annotations.ApiOperation;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.inject.Inject;
import java.util.List;

@Controller
@RequestMapping(value = "/api/v1/asp/masters")
@Api(value = "ASP Master", description = "ASP Master")
public class AspMasterController extends BaseController {

	@Inject//autowrired와 동일하게 동작한다. maven이나 gradle에 javax 라이브러리 의존성을 추가해야한다
	private AspMasterService aspMasterService;

	@Inject
	private BaseConverter baseConverter;

	@ApiOperation(value = "ASP Master", notes = "ASP Master 정보")//swagger 어노테이션 적용 요청 URL의 매핑된 API에 대한 설명
	@RequestMapping(method = RequestMethod.GET, produces = APPLICATION_JSON)
	public CommonListResponseParams.ListResponse list() {
		List<AspMaster> aspMasterList = aspMasterService.findAll();
		return CommonListResponseParams.ListResponse.of(AspMasterVTO.of(aspMasterList));
	//get 방식으로 전송하고 CommonListResponseParams.ListResponse 결과값은 json 형태로 response 한다.
		
	@ApiOperation(value = "권한그룹 등록/수정", notes = "권한그룹을 등록/수정 한다.")
	@RequestMapping(method = {RequestMethod.POST, RequestMethod.PUT}, produces = APPLICATION_JSON)
	public ApiResponse save(@RequestBody List<AspMasterVTO> request) {
		List<AspMaster> aspMasterList = baseConverter.convert(request, AspMaster.class);
		aspMasterService.save(aspMasterList);
		return ok();//ok => Apiresponse
		
	}
}
