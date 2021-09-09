package net.bigers.funeralsystem.ensh0000.ensh3000;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.axisj.axboot.core.util.DozerBeanMapperUtils;

import net.bigers.funeralsystem.ensh0000.domain.ensfloor.Ensfloor;
import net.bigers.funeralsystem.ensh0000.domain.ensfloor.EnsfloorService;
import net.bigers.funeralsystem.ensh0000.vto.EnsfloorVTO;

/**
 * 
* 
* 업무분류   : 
* 기능분류   : 
* 프로그램명 : ENSH3020Controller.java
* 설      명 :  봉안층정보를 등록 조회,삭제하는 프로그램
*
* 이력사항 @2016. 6. 23. kdh 최초작성 <BR/>
*
 */
@Controller
public class ENSH3020Controller extends BaseController{

	@Autowired
	private  EnsfloorService ensfloorService;

	/**
	 * 
	 * 메소드명칭 : findEnsfloor
	 * 메소드설명 : 봉안층 코드정보 조회	
	 * ----------------------------------------
	 * 이력사항 2016. 6. 24. kdh 최초작성
	 *
	 * @param locCode
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/ENSH3020/findEnsfloor", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse findEnsfloor(@RequestParam(value="locCode" , required = true) String locCode ) throws Exception{
		
		
		List<Ensfloor> ensfloors =  ensfloorService.findByLocCode(locCode);
		
		return CommonListResponseParams.ListResponse.of(EnsfloorVTO.of(ensfloors));
		
	}
	
	/**
	 * 
	 * 메소드명칭 : saveEnsfloor
	 * 메소드설명 : 봉안층코드 정보 저장		
	 * ----------------------------------------
	 * 이력사항 2016. 6. 24. kdh 최초작성
	 *
	 * @param EnsfloorVTOs
	 * @return
	 * @throws Exception
	 */
	@Transactional
	@RequestMapping(value="/ENSH3020/saveEnsfloor", method={RequestMethod.PUT, RequestMethod.POST}, produces=APPLICATION_JSON)
	public ApiResponse saveEnsfloor(@RequestBody List<EnsfloorVTO> EnsfloorVTOs) throws Exception{		
		
		List<Ensfloor> Ensfloors = DozerBeanMapperUtils.mapList(EnsfloorVTOs, Ensfloor.class);
		ensfloorService.save(Ensfloors);
		return ok();
	}
	
	/**
	 * 
	 * 메소드명칭 : deleteEnsfloor
	 * 메소드설명 : 봉안층코드 정보 삭제	
	 * ----------------------------------------
	 * 이력사항 2016. 6. 24. kdh 최초작성
	 *
	 * @param floorCodes
	 * @return
	 * @throws Exception
	 */
	@Transactional
	@RequestMapping(value="/ENSH3020/deleteEnsfloor", method={RequestMethod.DELETE}, produces=APPLICATION_JSON)
	public ApiResponse deleteEnsfloor(@RequestBody List<Ensfloor> floorCodes) throws Exception{		
				
		floorCodes.forEach(floorCode -> ensfloorService.delete(floorCode));
		
		return ok();
	}

}