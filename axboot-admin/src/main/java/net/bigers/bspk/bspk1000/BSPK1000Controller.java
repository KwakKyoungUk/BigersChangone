package net.bigers.bspk.bspk1000;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.env.Environment;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.ListResponse;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.MapResponse;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.axisj.axboot.core.code.ApiStatus;
import com.axisj.axboot.core.util.DateUtils;

import net.bigers.bspk.domain.BSPK1000Service;
import net.bigers.bspk.vto.ItemVTO;
import net.bigers.bspk.vto.SaleStmtBdVTO;
import net.bigers.bspk.vto.SaleStmtVTO;
import net.bigers.funeralsystem.fune0000.domain.funeral.Funeral;
import net.bigers.funeralsystem.fune0000.domain.item_group.ItemGroup;
import net.bigers.funeralsystem.lib.util.MapUtils;
import net.bigers.websocket.SessionManager;

@Controller
@RequestMapping("/api/v1")
public class BSPK1000Controller extends BaseController {

	public final static String BINSO_LOGGED_IN = "BINSO_LOGGED_IN";

	@Autowired
	private BSPK1000Service bspkService;

	@Autowired
	@Qualifier("textSessionManager")
	private SessionManager sessionManager;

	@Scheduled(fixedDelay = 500)
	void sendDefaultData() {

		Map<String, Object> data = new HashMap<>();

		String aKKmm = DateUtils.formatToDateString(new Date(), "yyyy년 MM월 dd일 a KK:mm");

		data.put("date_aKKmm", aKKmm);

		sessionManager.sendTextMessageToAll("defaultData", data);
	}

	@Scheduled(fixedDelay = 500)
	@Transactional
	void sendBspkData() {

		List<Funeral> funeral = this.bspkService.selectBinsoInfo();

		if(Objects.isNull(funeral)) {
			return;
		}

		funeral.stream()
			.filter(f->!"8".equals(f.getBinso().getBinsoType()))
			.filter(f->!"9".equals(f.getBinso().getBinsoType()))
			.forEach(f->{

			Map<String, Object>	sendData = new HashMap<>();

			List<SaleStmtVTO> saleStmtList = this.bspkService.selectSaleStmtByCustomerNo(f.getCustomerNo());
			int totalBspkCnt = saleStmtList.size();
			int totalBspkAmt = saleStmtList.stream().filter(s->Objects.nonNull(s.getAmount())).mapToInt(s->s.getAmount().intValue()).sum();
			int status10Cnt = (int)saleStmtList.stream().filter(s->"BSPK000010".equals(s.getBspkStatus())).count();
			int status20Cnt = (int)saleStmtList.stream().filter(s->"BSPK000020".equals(s.getBspkStatus())).count();
			int status30Cnt = (int)saleStmtList.stream().filter(s->"BSPK000030".equals(s.getBspkStatus())).count();
			int status40Cnt = (int)saleStmtList.stream().filter(s->"BSPK000040".equals(s.getBspkStatus())).count();

			sendData.put("saleStmtList", saleStmtList);
			sendData.put("totalBspkCnt", totalBspkCnt);
			sendData.put("totalBspkAmt", totalBspkAmt);
			sendData.put("status10Cnt", status10Cnt);
			sendData.put("status20Cnt", status20Cnt);
			sendData.put("status30Cnt", status30Cnt);
			sendData.put("status40Cnt", status40Cnt);

			sessionManager.sendTextMessageByUri("/wst/bspk1000/"+f.getBinso().getBinsoCode(), "mainData", sendData);
		});

	}



	@RequestMapping(value="/BSPK1000/binsoData" , method= RequestMethod.GET, produces = APPLICATION_JSON)
	public MapResponse getBinsoData(String binsoCode) throws Exception{

		Funeral funeral = this.bspkService.selectBinsoInfo(binsoCode);

		return MapResponse.of(MapUtils.getMap("binso", funeral));
	}

	@RequestMapping(value="/BSPK1000/login" , method= RequestMethod.POST, produces = APPLICATION_JSON)
	public ApiResponse login(String binsoCode, String binsoPassword, HttpServletRequest request) throws Exception{

		if(this.bspkService.login(binsoCode, binsoPassword)) {
			HttpSession session = request.getSession();
			session.setAttribute(BINSO_LOGGED_IN, BINSO_LOGGED_IN);
			return ok();
		}else {
			return ApiResponse.error(ApiStatus.SYSTEM_ERROR, "비밀번호를 확인해 주세요.");
		}

	}

	@RequestMapping(value="/BSPK1000/password" , method= RequestMethod.POST, produces = APPLICATION_JSON)
	public ApiResponse password(String binsoCode, String binsoPassword, HttpServletRequest request) throws Exception{

//		HttpSession session = request.getSession();
//		String binsoLoggedIn = (String) session.getAttribute(BINSO_LOGGED_IN);

		if(this.bspkService.login(binsoCode, binsoPassword)) {
			return ok();
		}else {
			return ApiResponse.error(ApiStatus.SYSTEM_ERROR, "비밀번호를 확인해 주세요.");
		}

	}

	@RequestMapping(value="/BSPK1000/logout" , method= RequestMethod.POST, produces = APPLICATION_JSON)
	public ApiResponse logout(String binsoCode, String binsoPassword, HttpServletRequest request) throws Exception{

		HttpSession session = request.getSession();
		session.removeAttribute(BINSO_LOGGED_IN);
		return ok();

	}

	@RequestMapping(value="/BSPK1000/isLoggedIn" , method= RequestMethod.POST, produces = APPLICATION_JSON)
	public ApiResponse isLoggedIn(String binsoCode, HttpServletRequest request) throws Exception{

		HttpSession session = request.getSession();
		Object binsoLoggedIn = session.getAttribute(BINSO_LOGGED_IN);
		if(Objects.nonNull(binsoLoggedIn)) {
			return ok();
		}else {
			return ApiResponse.of(ApiStatus.SYSTEM_ERROR, "로그인해 주세요.");
		}

	}

	@RequestMapping(value="/BSPK1000/itemGroup" , method= RequestMethod.GET, produces = APPLICATION_JSON)
	public MapResponse getItemGroup(@RequestParam List<String> partCode) throws Exception{

		List<ItemGroup> itemGroup = this.bspkService.selectItemGroupInPartCode(partCode);

		return MapResponse.of(MapUtils.getMap("itemGroups", itemGroup));
	}

	@RequestMapping(value="/BSPK1000/item" , method= RequestMethod.GET, produces = APPLICATION_JSON)
	public ListResponse getItems(String partCode, String groupCode) throws Exception{

		List<ItemVTO> items= this.bspkService.selectItemByPartCodeAndGroupCode(partCode, groupCode);

		return ListResponse.of(items);
	}

	@RequestMapping(value="/BSPK1000/bspk" , method= RequestMethod.PUT, produces = APPLICATION_JSON)
	public ApiResponse saveBspkItems(String binsoCode, String customerNo, @RequestBody List<ItemVTO> bspkItems) throws Exception{

		this.bspkService.saveBspkItems(binsoCode, customerNo, bspkItems);

		return ok();
	}

	@RequestMapping(value="/BSPK1000/saleStmtBd" , method= RequestMethod.GET, produces = APPLICATION_JSON)
	public ListResponse getSaleStmtBd(String customerNo, String partCode, Integer billNo) throws Exception{

		List<SaleStmtBdVTO> items= this.bspkService.selectSaleStmtBdByCustomerNoAndPartCodeAndBillNo(customerNo, partCode, billNo);

		return ListResponse.of(items);
	}

	@RequestMapping(value="/BSPK1000/saleStmt" , method= RequestMethod.DELETE, produces = APPLICATION_JSON)
	public ApiResponse deleteSaleStmt(String customerNo, String partCode, Integer billNo) throws Exception{

		this.bspkService.deleteSaleStmt(customerNo, partCode, billNo);

		return ok();
	}

	@RequestMapping(value="/BSPK1000/saleStmtBd/status/one" , method= RequestMethod.POST, produces = APPLICATION_JSON)
	public MapResponse updateSaleStmtBdStatusOne(String customerNo, String partCode, Integer billNo, Integer seqNo) throws Exception{

		String status = this.bspkService.updateSaleStmtBdStatusOne(customerNo, partCode, billNo, seqNo);

		Map<String, Object> res = new HashMap<>();

		List<SaleStmtBdVTO> list= this.bspkService.selectSaleStmtBdByCustomerNoAndPartCodeAndBillNo(customerNo, partCode, billNo);

		res.put("list", list);
		res.put("status", status);

		return MapResponse.of(res);
	}

	@RequestMapping(value="/BSPK1000/saleStmt/status" , method= RequestMethod.POST, produces = APPLICATION_JSON)
	public ApiResponse updateSaleStmtStatus(String customerNo, String partCode, Integer billNo) throws Exception{

		this.bspkService.updateSaleStmtStatus(customerNo, partCode, billNo);

		return ok();
	}

}
