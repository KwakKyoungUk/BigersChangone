package net.bigers.funeralsystem.fune0000.fune1000;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.ListResponse;
import com.axisj.axboot.core.api.response.ApiResponse;

import net.bigers.funeralsystem.fune0000.domain.sale_stmt.SaleStmt;
import net.bigers.kiosk.KioskService;

@Controller
public class FUNE1130Controller extends BaseController {

	@Autowired
	private KioskService kioskService;

	@RequestMapping(value="/FUNE1130/kiosk", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public ListResponse getKioskData(@DateTimeFormat(pattern="yyyy-MM-dd") Date workDate){

		List<SaleStmt> saleStmt = this.kioskService.getKioskData(workDate);

		return ListResponse.of(saleStmt);
	}

	@RequestMapping(value="/FUNE1130/kiosk", method=RequestMethod.POST, produces=APPLICATION_JSON)
	public ApiResponse postKioskData(@RequestBody List<SaleStmt> kioskData) throws Exception{

		this.kioskService.saveKioskData(kioskData);

		return ok();
	}

}
