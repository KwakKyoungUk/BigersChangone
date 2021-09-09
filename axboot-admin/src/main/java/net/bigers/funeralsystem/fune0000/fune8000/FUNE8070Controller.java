/*****************************************************************************
 * 프로그램명  : FUNE8070Controller.java
 * 설     명  : 상조회 통계현황 처리 컨트롤러
 * 참고  사항  : 없음
 *****************************************************************************
 * Date       Author  Version Description
 * ---------- ------- ------- -----------------------------------------------
 * 2017.11.24  KYM    1.0     초기작성
 *****************************************************************************/
package net.bigers.funeralsystem.fune0000.fune8000;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import javax.inject.Inject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.ListResponse;
import com.axisj.axboot.core.domain.code.BasicCode;
import com.axisj.axboot.core.domain.code.BasicCodeService;
import com.wordnik.swagger.annotations.ApiOperation;

import net.bigers.funeralsystem.common.vto.OptionVTO;
import net.bigers.funeralsystem.fune0000.domain.item_group.ItemGroup;



@Controller
public class FUNE8070Controller extends BaseController{
	
	@Inject
	private BasicCodeService basicCodeService;
	
	@RequestMapping(value="/FUNE8070/basic-select-options", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getBasicSelectOptionList(String basic_code){
		List<BasicCode> list = basicCodeService.findByBasicCd(basic_code);
		return CommonListResponseParams.ListResponse.of(list);
	}
	
	@ApiOperation(value = "정렬순서", notes = "정렬순서")
	@RequestMapping(value="/FUNE8070/order" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public ListResponse getOrder() throws Exception{
		List<BasicCode> resList = basicCodeService.findByBasicCd("0");
		BasicCode basicCode = new BasicCode();
		basicCode.setBasicCd("BALIN_DATE");
		basicCode.setCode("BALIN_DATE");
		basicCode.setName("발인일자");		
		resList.add(basicCode);
		basicCode = new BasicCode();
		basicCode.setBasicCd("SANGJO_NM");
		basicCode.setCode("SANGJO_NM");
		basicCode.setName("상조회");		
		resList.add(basicCode);
		basicCode = new BasicCode();
		basicCode.setBasicCd("SANGJO_REMARK");
		basicCode.setCode("SANGJO_REMARK");		
		basicCode.setName("비고");
		resList.add(basicCode);
		
		resList.stream().map(gc->OptionVTO.of(gc.getBasicCd(), gc.getName())).collect(Collectors.toList());
				
		return ListResponse.of(resList);
	}
	
}
