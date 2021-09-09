package net.bigers.funeralsystem.stan0000.stan1000;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.PageableResponseParams;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.axisj.axboot.core.dto.PageableTO;
import com.axisj.axboot.core.util.DozerBeanMapperUtils;
import com.wordnik.swagger.annotations.ApiOperation;

import net.bigers.funeralsystem.fune0000.domain.dc_rate.DcRate;
import net.bigers.funeralsystem.fune0000.domain.dc_rate.DcRateService;
import net.bigers.funeralsystem.stan0000.domain.pricelist.Pricelist;
import net.bigers.funeralsystem.stan0000.domain.pricelist.PricelistService;
import net.bigers.funeralsystem.stan0000.vto.PricelistVTO;

/**
*
* @author kdh
* @file_name STAN1020Controller.java
*
* 업무분류 : 기준정보
* 기능분류 : 이용요금기준관리
* 프로그램명 : STAN1020Controller
* 설      명 : 이용요금 추가/수정/삭제
* -----------------------------------------------------------
*
* 이력사항
*     2016. 6. 14. kdh 최초작성
*/

@Controller
public class STAN1020Controller extends BaseController{

	@Autowired
	private PricelistService pricelistService;
	
	@Autowired
	private DcRateService dcRateService;

	/**
	 *
	 *
	 * 메소드 명칭 : findPrice
	 * 메소드 설명 : 이용요금 목록 출력
	 * ----------------------------------------------------------
	 *
	 * @param searchParams
	 * @return
	 * @throws Exception
	 *
	 * 이력사항
	 *     2016. 6. 14. kdh 최초작성
	 */
	@RequestMapping(value="/STAN1020/findPriceList", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public PageableResponseParams.PageResponse findPriceList(Pageable pageable) throws Exception{
		Page<Pricelist> pricelist = pricelistService.findAll(pageable);		
		return PageableResponseParams.PageResponse.of(pricelist.getContent(), PageableTO.of(pricelist));
	}



	/**
	 *
	 *
	 * 메소드 명칭 : savePriceList
	 * 메소드 설명 : 이용요금 저장
	 * ----------------------------------------------------------
	 *
	 * @param pricelistVTO
	 * @return
	 * @throws Exception
	 *
	 * 이력사항
	 *     2016. 6. 14. kdh 최초작성
	 */
	@RequestMapping(value="/STAN1020/savePriceList", method={RequestMethod.PUT, RequestMethod.POST}, produces=APPLICATION_JSON)
	public ApiResponse savePriceList(@RequestBody List<PricelistVTO> pricelistVTO) throws Exception{

		List<Pricelist> pricelists = DozerBeanMapperUtils.mapList(pricelistVTO, Pricelist.class);
		pricelistService.save(pricelists);
		return ok();
	}

	/**
	 *
	 *
	 * 메소드 명칭 : deletePriceList
	 * 메소드 설명 : 이용요금정보 삭제
	 * ----------------------------------------------------------
	 *
	 * @param pricelistVTO
	 * @return ApiResponse ok
	 * @throws Exception
	 *
	 * 이력사항
	 *     2016. 6. 14. kdh 최초작성
	 */
	@RequestMapping(value="/STAN1020/deletePriceList", method={RequestMethod.DELETE}, produces=APPLICATION_JSON)
	public ApiResponse deletePriceList(@RequestBody List<PricelistVTO> pricelistVTO) throws Exception{
		List<Pricelist> pricelists = DozerBeanMapperUtils.mapList(pricelistVTO, Pricelist.class);
		pricelistService.deletePriceList(pricelists);


		return ok();
	}
	
	@ApiOperation(value = "이용요금관리", notes = "감면율")
	@RequestMapping(value="/STAN1020/findDcRateList", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public PageableResponseParams.PageResponse findDcRateList(Pageable pageable) throws Exception{
		Page<DcRate> dclist = dcRateService.findAll(pageable);		
		return PageableResponseParams.PageResponse.of(dclist.getContent(), PageableTO.of(dclist));
	}
	
	@ApiOperation(value = "이용요금관리", notes = "감면율")
	@RequestMapping(value="/STAN1020/saveDcRateList", method={RequestMethod.PUT, RequestMethod.POST}, produces=APPLICATION_JSON)
	public ApiResponse saveDcRateList(@RequestBody List<DcRate> dcRates) throws Exception{

		List<DcRate> dcRateList = DozerBeanMapperUtils.mapList(dcRates, DcRate.class);
		dcRateService.save(dcRateList);
		return ok();
	}
	
	@ApiOperation(value = "이용요금관리", notes = "감면율")
	@RequestMapping(value="/STAN1020/deleteDcRateList", method={RequestMethod.DELETE}, produces=APPLICATION_JSON)
	public ApiResponse deleteDcRateList(@RequestBody List<DcRate> dcRates) throws Exception{
		List<DcRate> dcRateList = DozerBeanMapperUtils.mapList(dcRates, DcRate.class);
		dcRateService.delete(dcRateList);
		return ok();
	}


}