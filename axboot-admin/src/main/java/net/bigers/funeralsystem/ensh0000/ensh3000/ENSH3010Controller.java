package net.bigers.funeralsystem.ensh0000.ensh3000;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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

import net.bigers.funeralsystem.ensh0000.domain.ensloc.Ensloc;
import net.bigers.funeralsystem.ensh0000.domain.ensloc.EnslocService;
import net.bigers.funeralsystem.ensh0000.vto.EnslocVTO;

/**
 * 
* 
* 업무분류   : 
* 기능분류   : 
* 프로그램명 : ENSH3010Controller.java
* 설      명 :  봉안구역정보 등록하는 프로그램
*
* 이력사항 @2016. 6. 23. kdh 최초작성 <BR/>
*
 */
@Controller
public class ENSH3010Controller extends BaseController{

	@Autowired
	private  EnslocService enslocService;

	/**
	 * 
	 * 메소드명칭 : findEnsloc
	 * 메소드설명 : 봉안구역코드 조회		
	 * ----------------------------------------
	 * 이력사항 2016. 6. 24. kdh 최초작성
	 *
	 * @param jobGubun
	 * @param priceGubun
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/ENSH3010/findEnsloc", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse findEnsloc() throws Exception{
		
		
		List<Ensloc> enslocs =  enslocService.findAll();		
		
		return CommonListResponseParams.ListResponse.of(EnslocVTO.of(enslocs));
		
	}
	
	/**
	 * 
	 * 메소드명칭 : enslocSelectOption
	 * 메소드설명 : 봉안구역 셀렉트박스		
	 * ----------------------------------------
	 * 이력사항 2016. 6. 27. kdh 최초작성
	 *
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/ENSH3010/enslocSelectOption", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public List enslocSelectOption() throws Exception{

		List<Ensloc> enslocs =  enslocService.findAll();	

		List<Map<String,String>> options = enslocs.stream().map(ensloc->{
			Map<String, String> item = new HashMap<>();
			item.put("optionValue", ensloc.getLocCode());
			item.put("optionText", ensloc.getLocName());
			return item;
		}).collect(Collectors.toList());

		return options;
	}
	
	/**
	 * 
	 * 메소드명칭 : saveEnsloc
	 * 메소드설명 : 봉안구역코드 저장		
	 * ----------------------------------------
	 * 이력사항 2016. 6. 24. kdh 최초작성
	 *
	 * @param enslocVTOs
	 * @return
	 * @throws Exception
	 */
	@Transactional
	@RequestMapping(value="/ENSH3010/saveEnsloc", method={RequestMethod.PUT, RequestMethod.POST}, produces=APPLICATION_JSON)
	public ApiResponse saveEnsloc(@RequestBody List<EnslocVTO> enslocVTOs) throws Exception{		
		
		List<Ensloc> enslocs = DozerBeanMapperUtils.mapList(enslocVTOs, Ensloc.class);
		enslocService.save(enslocs);
		return ok();
	}
	
	/**
	 * 
	 * 메소드명칭 : deleteEnsloc
	 * 메소드설명 : 봉안구역코드 삭제		
	 * ----------------------------------------
	 * 이력사항 2016. 6. 24. kdh 최초작성
	 *
	 * @param locCodes
	 * @return
	 * @throws Exception
	 */
	@Transactional
	@RequestMapping(value="/ENSH3010/deleteEnsloc", method={RequestMethod.DELETE}, produces=APPLICATION_JSON)
	public ApiResponse deleteEnsloc(@RequestParam (value="locCode" ) List<String> locCodes) throws Exception{		
				
		locCodes.forEach(locCode -> enslocService.delete(locCode));
		
		return ok();
	}

}