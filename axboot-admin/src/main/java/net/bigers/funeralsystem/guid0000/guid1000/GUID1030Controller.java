package net.bigers.funeralsystem.guid0000.guid1000;

import javax.inject.Inject;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.PageableResponseParams;
import com.axisj.axboot.core.dto.PageableTO;
import com.wordnik.swagger.annotations.ApiOperation;

import net.bigers.funeralsystem.common.domain.thedead.Thedead;
import net.bigers.funeralsystem.common.domain.thedead.ThedeadService;
import net.bigers.funeralsystem.common.vto.ThedeadVTO;

@Controller
@RequestMapping(value="/display/public/")
public class GUID1030Controller extends BaseController {

	@Inject
	private ThedeadService thedeadService;

	@ApiOperation(value = "고인검색 ", notes = "고인검색 리스트")
	@RequestMapping(value="GUID1030/findDeadList" ,method = RequestMethod.GET ,produces = APPLICATION_JSON)
	public PageableResponseParams.PageResponse findDeadList(Pageable pageable,String deadName, String jobGubun) throws Exception{

		Page<ThedeadVTO> pages = thedeadService.findDeadList(pageable,deadName,jobGubun);

		return PageableResponseParams.PageResponse.of(pages.getContent(), PageableTO.of(pages));


		

	}	
}
