package net.bigers.funeralsystem.stan0000.stan1000;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.admin.parameter.PageableResponseParams;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.axisj.axboot.core.dto.PageableTO;
import com.axisj.axboot.core.util.DozerBeanMapperUtils;

import net.bigers.funeralsystem.common.domain.addrgroup.Addrgroup;
import net.bigers.funeralsystem.common.domain.addrgroup.AddrgroupService;
import net.bigers.funeralsystem.common.domain.addrpart.Addrpart;
import net.bigers.funeralsystem.common.domain.addrpart.AddrpartService;
import net.bigers.funeralsystem.common.vto.AddrgroupVTO;
import net.bigers.funeralsystem.common.vto.AddrpartVTO;
import net.bigers.funeralsystem.crem0000.domain.rogrp.Rogrp;
import net.bigers.funeralsystem.crem0000.vto.RogrpVTO;
import net.bigers.funeralsystem.stan0000.domain.docform.Docform;
import net.bigers.funeralsystem.stan0000.vto.DocformVTO;

/**
 * 
 * 업무분류   :
 * 기능분류   :
 * 프로그램명 :
 * 설명 :
 * ------------------------------------------
 *
 * 이력사항 2016. 7. 19. kdh 최초작성<BR/>
 */
@Controller
public class STAN1050Controller extends BaseController{

	@Autowired
	private AddrgroupService addrgroupService;
	
	@Autowired
	private AddrpartService addrpartService;

	/**
	 * 
	 * 메소드명칭 : findAddrgroup
	 * 메소드설명 : 지역코드 그룹 조회		
	 * ----------------------------------------
	 * 이력사항 2016. 7. 19. kdh 최초작성
	 *
	 * @param pageable
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/STAN1050/findAddrgroup", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public PageableResponseParams.PageResponse findAddrgroup(Pageable pageable) throws Exception{

		Page<Addrgroup> addrgroupList = addrgroupService.findAll(pageable);

		return PageableResponseParams.PageResponse.of(AddrgroupVTO.of(addrgroupList.getContent()), PageableTO.of(addrgroupList));

	}
	/**
	 * 
	 * 메소드명칭 : deleteAddrgroup
	 * 메소드설명 : 지역코드그룹 삭제		
	 * ----------------------------------------
	 * 이력사항 2016. 7. 19. kdh 최초작성
	 *
	 * @param addrgroupVTOs
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/STAN1050/deleteAddrgroup", method=RequestMethod.DELETE, produces=APPLICATION_JSON)
	public ApiResponse deleteAddrgroup(@RequestBody List<AddrgroupVTO> addrgroupVTOs) throws Exception{

		addrgroupService.delete(DozerBeanMapperUtils.mapList(addrgroupVTOs, Addrgroup.class));
		return ok();
	}
	
	/**
	 * 
	 * 메소드명칭 : saveAddrgroup
	 * 메소드설명 : 지역대분류 코드 저장		
	 * ----------------------------------------
	 * 이력사항 2016. 7. 19. kdh 최초작성
	 *
	 * @param addrgroupVTOs
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/STAN1050/saveAddrgroup", method={RequestMethod.POST, RequestMethod.PUT}, produces=APPLICATION_JSON)
	public ApiResponse saveAddrgroup(@RequestBody List<AddrgroupVTO> addrgroupVTOs) throws Exception{
		addrgroupService.save(DozerBeanMapperUtils.mapList(addrgroupVTOs, Addrgroup.class));
		return ok();
	}
	
	/**
	 * 
	 * 메소드명칭 : saveAddrpart
	 * 메소드설명 : 지역소분류 코드 저장		
	 * ----------------------------------------
	 * 이력사항 2016. 7. 19. kdh 최초작성
	 *
	 * @param addrpartVTOs
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/STAN1050/saveAddrpart", method={RequestMethod.POST, RequestMethod.PUT}, produces=APPLICATION_JSON)
	public ApiResponse saveAddrpart(@RequestBody List<AddrpartVTO> addrpartVTOs) throws Exception{
		addrpartService.save(DozerBeanMapperUtils.mapList(addrpartVTOs, Addrpart.class));
		return ok();
	}
	
	/**
	 * 
	 * 메소드명칭 : deleteAddrpart
	 * 메소드설명 : 지역코드 소분류 삭제		
	 * ----------------------------------------
	 * 이력사항 2016. 7. 20. kdh 최초작성
	 *
	 * @param addrpartVTOs
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/STAN1050/deleteAddrpart", method={RequestMethod.POST, RequestMethod.DELETE}, produces=APPLICATION_JSON)
	public ApiResponse deleteAddrpart(@RequestBody List<AddrpartVTO> addrpartVTOs) throws Exception{
		addrpartService.delete(DozerBeanMapperUtils.mapList(addrpartVTOs, Addrpart.class));
		return ok();
	}
	
	
	/**
	 * 
	 * 메소드명칭 : findAddrpart
	 * 메소드설명 : 지역코드 소분류 조회		
	 * ----------------------------------------
	 * 이력사항 2016. 7. 20. kdh 최초작성
	 *
	 * @param addrgrCode
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/STAN1050/findAddrpart", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse findAddrpart(@RequestParam (value="addrgrCode", required = true) String addrgrCode) throws Exception{

		List<Addrpart> addrpartList = addrpartService.findByAddrgrCode(addrgrCode);

		return CommonListResponseParams.ListResponse.of(addrpartList);

	}
}