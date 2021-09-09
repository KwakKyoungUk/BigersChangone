package net.bigers.funeralsystem.stan0000.stan1000;

import java.util.List;

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

import net.bigers.funeralsystem.stan0000.domain.retlist.Retlist;
import net.bigers.funeralsystem.stan0000.domain.retlist.RetlistService;
import net.bigers.funeralsystem.stan0000.vto.RetlistVTO;

/**
*
* @author kdh
* @file_name STAN1030Controller.java
*
* 업무분류 : 기준정보
* 기능분류 : 반환요금기준관리
* 프로그램명 : STAN1030Controller
* 설      명 : 반환요금 추가/수정/삭제
* -----------------------------------------------------------
*
* 이력사항
*     2016. 6. 23. kdh 최초작성
*/

@Controller
public class STAN1030Controller extends BaseController{

	@Autowired
	private  RetlistService retlistService;

	/**
	 *
	 *
	 * 메소드 명칭 : findRetList
	 * 메소드 설명 : 반환요금 목록 출력
	 * ----------------------------------------------------------
	 *
	 * @param jobGubun , priceGubun
	 * @return
	 * @throws Exception
	 *
	 * 이력사항
	 *     2016. 6. 23. kdh 최초작성
	 */
	@RequestMapping(value="/STAN1030/findRetList", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse findRetList(
			@RequestParam(required = true) String jobGubun
			,@RequestParam(required = true) String priceGubun
			) throws Exception{


		List<Retlist> retlists =  retlistService.findByJobGubunAndPriceGubun(jobGubun, priceGubun);

		return CommonListResponseParams.ListResponse.of(RetlistVTO.of(retlists));

	}

	/**
	 *
	 *
	 * 메소드 명칭 : saveRetList
	 * 메소드 설명 : 반환요금 정보 저장
	 * ----------------------------------------------------------
	 *
	 * @param retlistVTOs
	 * @return
	 * @throws Exception
	 *
	 * 이력사항
	 *     2016. 6. 23. kdh 최초작성
	 */
	@RequestMapping(value="/STAN1030/saveRetList", method={RequestMethod.PUT, RequestMethod.POST}, produces=APPLICATION_JSON)
	public ApiResponse saveRetList(@RequestBody List<RetlistVTO> retlistVTOs) throws Exception{

		List<Retlist> retlists = DozerBeanMapperUtils.mapList(retlistVTOs, Retlist.class);
		retlistService.save(retlists);
		return ok();
	}

	/**
	 *
	 *
	 * 메소드 명칭 : deleteRetList
	 * 메소드 설명 : 반환요금정보 삭제
	 * ----------------------------------------------------------
	 *
	 * @param facIds
	 * @return ApiResponse ok
	 * @throws Exception
	 *
	 * 이력사항
	 *     2016. 6. 23. kdh 최초작성
	 */
	@RequestMapping(value="/STAN1030/deleteRetList", method={RequestMethod.DELETE}, produces=APPLICATION_JSON)
	public ApiResponse deletePriceList(@RequestBody List<RetlistVTO> pricelistVTO) throws Exception{
		List<Retlist> retlists = DozerBeanMapperUtils.mapList(pricelistVTO, Retlist.class);
		retlistService.deleteRetList(retlists);


		return ok();
	}

}