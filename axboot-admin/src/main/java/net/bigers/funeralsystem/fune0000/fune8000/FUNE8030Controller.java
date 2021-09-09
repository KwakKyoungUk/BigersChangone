package net.bigers.funeralsystem.fune0000.fune8000;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.ListResponse;

import net.bigers.funeralsystem.fune0000.domain.part.Part;
import net.bigers.funeralsystem.fune0000.domain.part.PartService;
import net.bigers.funeralsystem.fune0000.domain.user_mng_part.UserMngPartService;

@Controller
public class FUNE8030Controller extends BaseController{

	@Inject
	private UserMngPartService userMngPartService;
	
	@RequestMapping(value="/FUNE8030/part", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public ListResponse getPartList(){
		List<Part> list = this.userMngPartService.getByCurrentUser();
		return ListResponse.of(list);
	}
}
