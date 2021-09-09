package net.bigers.funeralsystem.fune0000.fune0000;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.ListResponse;
import com.axisj.axboot.core.api.response.ApiResponse;

import net.bigers.funeralsystem.fune0000.domain.customer.Customer;
import net.bigers.funeralsystem.fune0000.domain.part.Part;
import net.bigers.funeralsystem.fune0000.domain.part.PartService;

@Controller
public class FUNE0010Controller extends BaseController{

	@Inject
	private PartService partService;
	
	@RequestMapping(value="/FUNE0010/part", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public ListResponse getPartList(@RequestParam(value="partCode", required=false) String partCode, @RequestParam(value="partName", required=false) String partName){
		return ListResponse.of(partService.findByPartCodeStartingWithAndPartNameContaining(partCode, partName));
	}
	
	@RequestMapping(value="/FUNE0010/part", method={RequestMethod.PUT}, produces=APPLICATION_JSON)
	public ApiResponse addPart(@RequestBody List<Part> list){
		partService.save(list);
		return ok();
	}
	
	/**
	 * 
	 * 메소드명칭 : deletePart
	 * 메소드설명 : 파트삭제		
	 * ----------------------------------------
	 * 이력사항 2017. 11. 21. jin 추가작성
	 *
	 * @param empCodes
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/FUNE0010/part", method={RequestMethod.DELETE}, produces=APPLICATION_JSON)
	public ApiResponse deletePart(@RequestBody List<Part> list) throws Exception{
		partService.delete(list);
		return ok();
	}
	
}
