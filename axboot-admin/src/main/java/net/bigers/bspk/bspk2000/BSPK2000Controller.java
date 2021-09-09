package net.bigers.bspk.bspk2000;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.ListResponse;
import com.axisj.axboot.core.api.response.ApiResponse;

import net.bigers.bspk.domain.BSPK2000Service;
import net.bigers.bspk.vto.SaleStmtBdVTO;
import net.bigers.bspk.vto.SaleStmtVTO;
import net.bigers.funeralsystem.fune0000.domain.part.Part;
import net.bigers.websocket.SessionManager;

@Controller
@RequestMapping("/api/v1")
public class BSPK2000Controller extends BaseController {

	@Autowired
	private BSPK2000Service bspk2000Service;

	@Autowired
	@Qualifier("textSessionManager")
	private SessionManager sessionManager;

	@Scheduled(fixedDelay = 500)
	@Transactional
	void sendBspkData() {

		// 퇴실안한 빈소의 전표들
		List<SaleStmtVTO> saleStmtList = this.bspk2000Service.selectSaleStmtByNotLastFlg();

		if(Objects.isNull(saleStmtList)) {
			return;
		}

		List<String> partCodeList = this.bspk2000Service.selectAllPartCode();

		partCodeList.parallelStream().forEach(partCode->{

			Map<String, Object> data = new HashMap<>();

			Part part = this.bspk2000Service.selectOnePartByPartCode(partCode);

			List<SaleStmtVTO> stmt = saleStmtList.stream().filter(ss->partCode.equals(ss.getPartCode())).collect(Collectors.toList());

			data.put("stmt", stmt);
			data.put("part", part);

			this.sessionManager.sendTextMessageByUri("/wst/bspk2000/"+partCode, "mainData", data);
		});

	}

	@RequestMapping(value="/BSPK2000/saleStmtBd" , method= RequestMethod.GET, produces = APPLICATION_JSON)
	public ListResponse getSaleStmtBd(String customerNo, String partCode, Integer billNo) throws Exception{

		List<SaleStmtBdVTO> stmtbdList = this.bspk2000Service.selectSaleStmtBdByCustomerNoAndPartCodeAndBillNo(customerNo, partCode, billNo);

		return ListResponse.of(stmtbdList);
	}

	@RequestMapping(value="/BSPK2000/saleStmt/status" , method= RequestMethod.POST, produces = APPLICATION_JSON)
	public ApiResponse updateSaleStmtStatus(String customerNo, String partCode, Integer billNo, String status) throws Exception{

		this.bspk2000Service.updateSaleStmtStatusByCustomerNoAndPartCodeAndBillNo(customerNo, partCode, billNo, status);

		return ok();
	}
}
