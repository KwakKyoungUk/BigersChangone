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
import com.axisj.axboot.core.domain.code.BasicCodeService;
import com.axisj.axboot.core.util.DozerBeanMapperUtils;

import net.bigers.funeralsystem.stan0000.domain.authIp.AuthIp;
import net.bigers.funeralsystem.stan0000.domain.authIp.AuthIpService;
import net.bigers.funeralsystem.stan0000.domain.pricelist.Pricelist;
import net.bigers.funeralsystem.stan0000.vto.PricelistVTO;



/**
 *
 * 업무분류   : IP 권한관리
 * 기능분류   : 권한을 가진 IP 등록 관리
 * 프로그램명 : IP 권한관리 프로그램
 * 설      명 : 권한을 가진 IP 등록 수정 삭제 관리 프로그램
 * ------------------------------------------
 *
 * 이력사항 2018. 11. 01. 김세현 최초작성
 */
@Controller
public class STAN1100Controller extends BaseController{

	@Autowired
	private AuthIpService authIpService;

	@Autowired
	private BasicCodeService basicCodeService;

	/**
	 *
		 *
		 * 메소드 명칭 : findAuthIp
		 * 메소드 설명 : 권한 Ip 검색
		 * ----------------------------------------
		 * 이력사항 2018. 11. 01. 김세현 최초작성
		 * 수정사항 		 *
		 * @param searchParams
		 * @return CommonListResponseParams.MapResponse
		 * @throws Exception
	 */
	@RequestMapping(value="/STAN1100/authIp", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse findAuthIp(
			@RequestParam(value = "condition") String condition
			,@RequestParam(value = "searchParams", defaultValue = "") String searchParams
			) throws Exception{

		List<AuthIp> authIp = authIpService.findAuthIp(condition, searchParams);

		return CommonListResponseParams.ListResponse.of(authIp);
	}
	
	/**
	 *
		 *
		 * 메소드 명칭 : saveAuthIp
		 * 메소드 설명 : 권한 Ip 저장/수정
		 * ----------------------------------------
		 * 이력사항 2018. 11. 01. 김세현 최초작성
		 * 수정사항 		 *
		 * @param searchParams
		 * @return CommonListResponseParams.MapResponse
		 * @throws Exception
	 */
	@RequestMapping(value="/STAN1100/saveAuthIp", method=RequestMethod.PUT, produces=APPLICATION_JSON)
	public ApiResponse saveAuthIp(@RequestBody List<AuthIp> authIpList){
		authIpService.save(authIpList);
		return ok();
	}
	
	/**
	 *
		 *
		 * 메소드 명칭 : deleteAuthIp
		 * 메소드 설명 : 권한 Ip 삭제
		 * ----------------------------------------
		 * 이력사항 2019. 05. 20. 김세현 최초작성
		 * 수정사항 		 *
		 * @param searchParams
		 * @return CommonListResponseParams.MapResponse
		 * @throws Exception
	 */
	@RequestMapping(value="/STAN1100/deleteAuthIp", method={RequestMethod.DELETE}, produces=APPLICATION_JSON)
	public ApiResponse deleteAuthIp(@RequestBody List<AuthIp> authIpList){
		authIpService.delete(authIpList);


		return ok();
	}
		
}
