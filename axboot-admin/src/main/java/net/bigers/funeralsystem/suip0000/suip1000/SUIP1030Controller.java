/*****************************************************************************
 * 프로그램명  : SUIP1030Controller.java
 * 설     명  : 수입 관리 > 카드 입금 관리 처리 컨트롤러
 * 참고  사항  : 없음
 *****************************************************************************
 * Date       Author  Version Description
 * ---------- ------- ------- -----------------------------------------------
 * 2017.11.15  KYM    1.0     초기작성
 *****************************************************************************/
package net.bigers.funeralsystem.suip0000.suip1000;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.ListResponse;
import com.wordnik.swagger.annotations.Api;
import com.wordnik.swagger.annotations.ApiOperation;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.axisj.axboot.core.domain.code.BasicCode;
import com.axisj.axboot.core.domain.code.BasicCodeService;

import net.bigers.funeralsystem.fune0000.domain.payment.PaymentService;
import net.bigers.funeralsystem.fune0000.domain.sale_stmt.SaleStmtService;
import net.bigers.funeralsystem.fune0000.vto.SuipVTO;
import net.bigers.funeralsystem.common.domain.cardTrans.CardTransService;
import net.bigers.funeralsystem.common.domain.syicard.SyiCardService;
import net.bigers.funeralsystem.ftp.FtpSchedule;

@Controller
public class SUIP1030Controller extends BaseController{

	@Autowired
	private PaymentService paymentService;
	@Autowired
	private SaleStmtService saleStmtService;
	@Autowired
	private BasicCodeService basicCodeService;
	@Autowired
	private SyiCardService syiCardService;
	@Autowired
	private CardTransService cardTransService;
	@Autowired
	private ServletContext servletContext;
	@Autowired
	private FtpSchedule ftpSchedule;


	/**
	 * 베이직 코드 취득
	 */
	@RequestMapping(value="/SUIP1030/basic-select-options", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getBasicSelectOptionList(String basic_code){
		List<BasicCode> list = basicCodeService.findByBasicCd(basic_code);
		return CommonListResponseParams.ListResponse.of(list);
	}

	/**
	 * 입금 목록 취득
	 * @param String result 처리구분
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "입금 목록", notes = "입금 목록")
	@RequestMapping(value="/SUIP1030/syicard" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public ListResponse getSyiCard(String gubun, String result, String inDate, String cjob, String cgubun, String cgubunTrans) throws Exception{
		return ListResponse.of(this.syiCardService.findSyiCard(gubun, result,inDate, cjob, cgubun, cgubunTrans));
	}

	/**
	 * 카드 입금 관리 조회 목록 취득
	 * @param request Request객체
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "카드 입금 관리 조회", notes = "카드 입금 관리 조회")
	@RequestMapping(value="/SUIP1030/cardSend" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public List<Object[]> getCardSendList(@RequestParam Map<String, String> requestBody) throws Exception{

		List<Object[]> res 							= new ArrayList<Object[]>();

		String cjob = requestBody.get("cjob");

		if("F".equals(cjob)){
			//개별판매
			List<Object[]> cardSendListSaleStmt 	= saleStmtService.findCardSendListSaleStmt(requestBody);
			//빈소판매
			List<Object[]> carsSendListPayment 	= paymentService.findCardSendListPayment(requestBody);

			res.addAll(cardSendListSaleStmt);
			res.addAll(carsSendListPayment);
		}else{
			// 승화원
			List<Object[]> cens = paymentService.findCardSendListPaymentCEN(requestBody);
			res.addAll(cens);
		}

		return res;
	}

	/**
	 * 카드 입금 관리 입금처리
	 * @param SuipVTO
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = " 입금처리", notes = "입금처리")
	@RequestMapping(value="/SUIP1030/suipCard" , method= RequestMethod.POST, produces=APPLICATION_JSON )
	public ApiResponse updateIndatePaySale(@RequestBody SuipVTO suipVTO) throws Exception{
		paymentService.updateIndateSyiPaySale(suipVTO);
		return ok();
	}

	/**
	 * 카드 입금 관리 입금처리 취소
	 * @param SuipVTO
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = " 입금처리 취소", notes = "입금처리")
	@RequestMapping(value="/SUIP1030/suipCard/cancel" , method= RequestMethod.POST, produces=APPLICATION_JSON )
	public ApiResponse updateIndatePaySaleCancel(@RequestBody SuipVTO suipVTO) throws Exception{
		paymentService.updateIndateSyiPaySaleCancel(suipVTO);
		return ok();
	}

	/**
	 * ftp 배치실행
	 * @throws Exception
	 */
	@RequestMapping(value="/SUIP1030/ftp/{date}", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public ApiResponse ftp(@PathVariable("date") String date) throws Exception{
		syiCardService.syiCardBatch(date);
		cardTransService.cardTransBatch(date);
		return ok();
	}
	
	/**
	 * ftp 수동업로드 실행
	 * @throws Exception
	 * 20191015 김세현 XKQD-274 카드입금자료 수동업로드 기능 추가
	 */
	@ApiOperation(value = "Upload", notes = "파일업로드")
	@RequestMapping(value="/SUIP1030/upload", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public void upload(	@RequestBody List<Map<String, String>> requestBody) throws Exception{
		String realPath = servletContext.getRealPath(".");
		for (int i = 0; i < requestBody.size(); i++) {
			String ext = StringUtils.getFilenameExtension(requestBody.get(i).get("docName"));			
			String docPath = requestBody.get(i).get("docPath");
			String saveName = requestBody.get(i).get("saveName");
			String path = realPath+docPath;
			if(ext.equals("DDC") ) {
				ftpSchedule.insert(path+"\\", saveName);
			} else {
				cardTransService.insert(path+"\\", saveName);
			}
			
		}
				
	}
}
