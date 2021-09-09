package net.bigers.funeralsystem.stan0000.stan1000;

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

import net.bigers.funeralsystem.stan0000.domain.facilityinfo.Facilityinfo;
import net.bigers.funeralsystem.stan0000.domain.facilityinfo.FacilityinfoService;
import net.bigers.funeralsystem.stan0000.vto.FacilityinfoVTO;

/**
*
* @author kdh
* @file_name STAN1010Controller.java
*
* 업무분류 : 기준
* 기능분류 : 시설정보관리
* 프로그램명 : STAN1010Controller
* 설      명 : 시설정보 추가/수정/삭제
* -----------------------------------------------------------
*
* 이력사항
*     2016. 6. 14. kdh 최초작성
*/

@Controller
public class STAN1010Controller extends BaseController{

	@Autowired
	private  FacilityinfoService facilityinfoService;

	/**
	 *
	 *
	 * 메소드 명칭 : findFac
	 * 메소드 설명 : 시설정보 목록 출력
	 * ----------------------------------------------------------
	 *
	 * @param searchParams
	 * @return
	 * @throws Exception
	 *
	 * 이력사항
	 *     2016. 6. 14. kdh 최초작성
	 */
	@RequestMapping(value="/STAN1010/findFac", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse findFac() throws Exception{
		List<Facilityinfo> facilityinfos = facilityinfoService.findAll();		
		return CommonListResponseParams.ListResponse.of(FacilityinfoVTO.of(facilityinfos));		
	}

	/**
	 *
	 *
	 * 메소드 명칭 : saveFac
	 * 메소드 설명 : 시설정보 저장
	 * ----------------------------------------------------------
	 *
	 * @param facilityinfoVTOs
	 * @return
	 * @throws Exception
	 *
	 * 이력사항
	 *     2016. 6. 14. kdh 최초작성
	 */
	@RequestMapping(value="/STAN1010/saveFac", method={RequestMethod.PUT, RequestMethod.POST}, produces=APPLICATION_JSON)
	public ApiResponse saveFac(@RequestBody FacilityinfoVTO facilityinfoVTO) throws Exception{
		Facilityinfo facilityinfo = DozerBeanMapperUtils.map(facilityinfoVTO, Facilityinfo.class);
		facilityinfoService.save(facilityinfo);
		return ok();
	}

	/**
	 *
	 *
	 * 메소드 명칭 : deleteFac
	 * 메소드 설명 : 시설정보 삭제
	 * ----------------------------------------------------------
	 *
	 * @param facIds
	 * @return ApiResponse ok
	 * @throws Exception
	 *
	 * 이력사항
	 *     2016. 6. 14. kdh 최초작성
	 */
	@Transactional
	@RequestMapping(value="/STAN1010/deleteFac", method={RequestMethod.DELETE}, produces=APPLICATION_JSON)
	public ApiResponse deleteFac() throws Exception{
		facilityinfoService.deleteAll();
		return ok();
	}

}