package net.bigers.funeralsystem.fune0000.fune0000;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.core.api.response.ApiResponse;

import net.bigers.funeralsystem.fune0000.domain.part.Part;
import net.bigers.funeralsystem.fune0000.domain.part.PartService;
import net.bigers.funeralsystem.fune0000.domain.set_group.SetGroup;
import net.bigers.funeralsystem.fune0000.domain.set_group.SetGroupService;

@Controller
public class FUNE0050Controller extends BaseController{
	
	@Inject
	private PartService partService;
	
	@Inject
	private SetGroupService setGroupService;
	
	
	@RequestMapping(value="/FUNE0050/part", method={RequestMethod.POST}, produces=APPLICATION_JSON) // POST 방식을 사용하였는데, AXSearch 컴포넌트에서 AJAX 요청시 GET 방식으로 받아오지 않기에 POST방식으로 사용하였다.
	public CommonListResponseParams.ListResponse getPartList(){
		List<Part> list =  partService.findByOrderByPartCodeAsc();
		return CommonListResponseParams.ListResponse.of(list);
	}
	
	@RequestMapping(value="/FUNE0050/setGroup", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getSetGrouplist(
			@RequestParam(value="partCode", required=false, defaultValue="") String partCode, 
			@RequestParam(value="setCode", required=false, defaultValue="") String setCode, 
			@RequestParam(value="setName", required=false, defaultValue="") String setName){
		//List<SetGroup> list = setGroupService.getSetGroupList(partCode, setCode, setName);
		List<SetGroup> list = setGroupService.findByPartCodeStartingWithAndSetCodeStartingWithAndSetNameContainingOrderBySortNoAsc(
				partCode, setCode, setName
				);
		return CommonListResponseParams.ListResponse.of(list);
	}
	
	@RequestMapping(value="/FUNE0050/setGroup", method={RequestMethod.PUT}, produces=APPLICATION_JSON)
	public ApiResponse putSetGroup(@RequestBody List<SetGroup> list){
		setGroupService.save(list);
		return ok();
	}
	
	@RequestMapping(value="/FUNE0050/setGroup", method={RequestMethod.DELETE}, produces=APPLICATION_JSON)
	public ApiResponse deleteSetGroup(@RequestBody SetGroup setGroup){
		setGroupService.delete(setGroup);
		return ok();
	}

}
