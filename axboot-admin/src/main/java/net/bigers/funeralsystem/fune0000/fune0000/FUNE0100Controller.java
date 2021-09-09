package net.bigers.funeralsystem.fune0000.fune0000;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.ListResponse;
import com.axisj.axboot.core.api.response.ApiResponse;

import net.bigers.funeralsystem.fune0000.domain.customer.Customer;
import net.bigers.funeralsystem.fune0000.domain.binso.Binso;
import net.bigers.funeralsystem.fune0000.domain.binso.BinsoService;

@Controller
public class FUNE0100Controller extends BaseController{

	@Inject
	private BinsoService binsoService;

	@RequestMapping(value="/FUNE0100/binso", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public ListResponse getPartList(@RequestParam(value="binsoCode", required=false) String binsoCode, @RequestParam(value="binsoName", required=false) String binsoName){
		return ListResponse.of(binsoService.findByBinsoCodeStartingWithAndBinsoNameContaining(binsoCode, binsoName));
	}

	@RequestMapping(value="/FUNE0100/binso", method={RequestMethod.PUT}, produces=APPLICATION_JSON)
	public ApiResponse addBinso(@RequestBody List<Binso> list){
		binsoService.save(list);
		return ok();
	}

	/**
	 *
	 * 메소드명칭 : deletePart
	 * 메소드설명 : 파트삭제
	 * ----------------------------------------
	 * 이력사항 2017. 11. 21. jin 추가작성
	 *
	 * @param empCodes
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/FUNE0100/binso", method={RequestMethod.DELETE}, produces=APPLICATION_JSON)
	public ApiResponse deleteBinso(@RequestBody List<Binso> list) throws Exception{
		binsoService.delete(list);
		return ok();
	}

}
