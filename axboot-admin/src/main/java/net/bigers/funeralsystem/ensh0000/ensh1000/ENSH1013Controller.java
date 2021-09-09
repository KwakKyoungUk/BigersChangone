package net.bigers.funeralsystem.ensh0000.ensh1000;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;

import net.bigers.funeralsystem.common.domain.addrhst.Addrhst;
import net.bigers.funeralsystem.common.domain.addrhst.AddrhstService;
import net.bigers.funeralsystem.common.vto.AddrhstVTO;

/**
*
* 업무분류   : 봉안관리
* 기능분류   : 신청자 정보 변경 이력
* 프로그램명 : 봉안 접수 관리
* 설      명 : 신청자 정보 변경 이력
* ------------------------------------------
*
* 이력사항 2016. 6. 23. 이승호 최초작성 <BR/>
*/
@Controller
public class ENSH1013Controller extends BaseController  {

	@Autowired
	private AddrhstService addrhstService;

	@RequestMapping(value="/ENSH1013/addrhst/{applId}", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getApplicant(
			@PathVariable("applId") Integer applId
			) throws Exception{

		List<Addrhst> addrhst = addrhstService.findByApplId(applId);

		return CommonListResponseParams.ListResponse.of(AddrhstVTO.of(addrhst));
	}


}
