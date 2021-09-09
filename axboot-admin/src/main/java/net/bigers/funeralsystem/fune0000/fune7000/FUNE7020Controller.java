/*****************************************************************************
 * 프로그램명  : FUNE7020Controller.java
 * 설     명  : 입관 정보 관리 처리 컨트롤러
 * 참고  사항  : 없음
 *****************************************************************************
 * Date       Author  Version Description
 * ---------- ------- ------- -----------------------------------------------
 * 2017.11.20  KYM    1.0     초기작성
 *****************************************************************************/
package net.bigers.funeralsystem.fune0000.fune7000;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.ListResponse;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.MapResponse;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.axisj.axboot.core.domain.code.BasicCode;
import com.wordnik.swagger.annotations.ApiOperation;

import net.bigers.funeralsystem.common.vto.OptionVTO;
import net.bigers.funeralsystem.fune0000.domain.binso.BinsoService;
import net.bigers.funeralsystem.fune0000.domain.photo.Photo;
import net.bigers.funeralsystem.fune0000.domain.photo.PhotoService;
import net.bigers.funeralsystem.fune0000.domain.funeral.Funeral;
import net.bigers.funeralsystem.fune0000.domain.funeral.FuneralService;
import net.bigers.funeralsystem.fune0000.domain.funeral_code.FuneralCode;
import net.bigers.funeralsystem.fune0000.domain.funeral_code.FuneralCodeService;
import net.bigers.funeralsystem.lib.util.MapUtils;
import net.bigers.funeralsystem.lib.util.MapUtils.MapItem;

@Controller
public class FUNE7020Controller extends BaseController {

	@Autowired
	private BinsoService binsoService;

	@Autowired
	private PhotoService photoService;
	
	@Autowired
	private FuneralService funeralService;
	
	@Autowired
	private FuneralCodeService funeralCodeService;
	
	
	
	/**
	 * 입관 정보 목록 취득
	 * @param request Request객체
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "입관 정보 목록", notes = "입관 정보 목록")
	@RequestMapping(value="/FUNE7020/ibkwan" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public ListResponse ibkwanInfo(String ibkwanDate) throws Exception{
		return ListResponse.of(this.funeralService.getIbkwanInfo(ibkwanDate));
	}
	
	/**
	 * 입관실 목록 취득
	 * @param String ibkwanGubun
	 * @exception Exception 시스템예외
	 */
	@RequestMapping(value="/FUNE7020/code/gubunCd", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public List<OptionVTO> getCodeGubunCd(String ibkwanGubun){
		List<FuneralCode> gubunCd = funeralCodeService.findByIbkwanName(ibkwanGubun);
		return gubunCd.stream().map(gc->OptionVTO.of(gc.getIbkwanCode(), gc.getIbkwanName())).collect(Collectors.toList());
	}
	
	/**
	 * 입관 구분 수정
	 * @param Funeral
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "입관 구분 수정", notes = "입관 구분 수정")
	@RequestMapping(value="/FUNE7020/funeral/ibkwanGubun" , method= RequestMethod.POST, produces=APPLICATION_JSON )
	public ApiResponse saveIbkwanGubun(@RequestBody Funeral funeral) throws Exception{
		this.funeralService.saveFuneralIbkwanGubun(funeral);
		return ok();
	}
	
	

}
