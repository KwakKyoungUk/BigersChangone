package net.bigers.funeralsystem.fune0000.fune5000;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.ListResponse;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.MapResponse;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.wordnik.swagger.annotations.ApiOperation;

import net.bigers.funeralsystem.fune0000.domain.binso.BinsoService;
import net.bigers.funeralsystem.fune0000.domain.binso_assign.BinsoAssignService;
import net.bigers.funeralsystem.fune0000.domain.funeral.Funeral;
import net.bigers.funeralsystem.fune0000.domain.funeral.FuneralService;
import net.bigers.funeralsystem.fune0000.domain.total_part.TotalPartService;
import net.bigers.funeralsystem.lib.util.MapUtils;

@Controller
public class FUNE5010Controller extends BaseController {

	@Autowired
	private BinsoService binsoService;

	@Autowired
	private BinsoAssignService binsoAssignService;

	@Autowired
	private TotalPartService totalPartService;

	@Autowired
	private FuneralService funeralService;

	@Scheduled(fixedDelay = 5000)
	@Transactional
	public void outBinso() {

		List<Funeral> moveOut = funeralService.getBinsoToMoveOutList();

		moveOut.forEach(f->{

			try {
				this.binsoAssignService.inoutBinso(f.getCustomerNo(), f.getBinsoCode(), 1);
			} catch (Exception e) {
//				e.printStackTrace();
			}
		});

	}

	@ApiOperation(value = "빈소정보", notes = "정산소")
	@RequestMapping(value="/FUNE5010/binso/part" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public ListResponse binsoPart() throws Exception{

		return ListResponse.of(this.binsoService.getCalculateBinsoInfo2());
	}

	@ApiOperation(value = "파트마감", notes = "파트마감")
	@RequestMapping(value="/FUNE5010/binso/close/{customerNo}" , method= RequestMethod.PUT, produces=APPLICATION_JSON )
	public ApiResponse closePart(
			@PathVariable("customerNo") String customerNo
			) throws Exception{

		this.totalPartService.closeAllPart(customerNo);

		return ok();
	}

	@ApiOperation(value = "빈소 퇴실 처리", notes = "빈소 퇴실 처리")
	@RequestMapping(value="/FUNE5010/binso/out/{customerNo}/{binsoCode}" , method= RequestMethod.POST, produces=APPLICATION_JSON )
	public ApiResponse outBinso(
			@PathVariable("customerNo") String customerNo
			, @PathVariable("binsoCode") String binsoCode
			) throws Exception{

		this.binsoAssignService.inoutBinso(customerNo, binsoCode, 1);

		return ok();
	}

	@ApiOperation(value = "전체 파트 마감 여부", notes = "전체 파트 마감 여부 확인")
	@RequestMapping(value="/FUNE5010/isClose" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public MapResponse isClose(
			String customerNo
			) throws Exception{

		boolean res = this.totalPartService.isCloseAll(customerNo);

		return MapResponse.of(MapUtils.getMap("isClose", res));
	}

//	@ApiOperation(value = "파트 Code", notes = "파트 Code")
//	@RequestMapping(value="/FUNE5010/partCode/option" , method= RequestMethod.PUT, produces=APPLICATION_JSON )
//	public List<OptionVTO> getPartOption() throws Exception{
//
//		return this.part;
//	}
}
