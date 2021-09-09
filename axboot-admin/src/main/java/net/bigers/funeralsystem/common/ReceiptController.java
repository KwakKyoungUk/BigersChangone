package net.bigers.funeralsystem.common;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.axisj.axboot.core.domain.code.BasicCode;
import com.axisj.axboot.core.domain.code.BasicCodeService;
import com.axisj.axboot.core.domain.user.User;
import com.axisj.axboot.core.domain.user.UserService;
import com.google.common.base.Optional;

import net.bigers.funeralsystem.common.vto.PayDataVTO;
import net.bigers.funeralsystem.fune0000.domain.funeral.Funeral;
import net.bigers.funeralsystem.fune0000.domain.funeral.FuneralService;
import net.bigers.funeralsystem.fune0000.domain.item_price.ItemPrice;
import net.bigers.funeralsystem.fune0000.domain.part.Part;
import net.bigers.funeralsystem.fune0000.domain.part.PartService;
import net.bigers.funeralsystem.fune0000.domain.payment.Payment;
import net.bigers.funeralsystem.fune0000.domain.payment.PaymentId;
import net.bigers.funeralsystem.fune0000.domain.payment.PaymentService;
import net.bigers.funeralsystem.fune0000.domain.sale_stmt.SaleStmt;
import net.bigers.funeralsystem.fune0000.domain.sale_stmt.SaleStmtId;
import net.bigers.funeralsystem.fune0000.domain.sale_stmt.SaleStmtService;
import net.bigers.funeralsystem.fune0000.domain.sale_stmt_bd.SaleStmtBd;

@Controller
public class ReceiptController extends BaseController{

	@Autowired
	private SaleStmtService saleStmtService;

	@Autowired
	private PaymentService paymentService;

	@Autowired
	private UserService userService;

	@Autowired
	private FuneralService funeralService;

	@Autowired
	private PartService partService;

	@Autowired
	private BasicCodeService basicCodeService;

	@Autowired
	private CommonService commonService;

	@RequestMapping("/receipt/saleStmt")
	public String getSaleStmt(String customerNo, String partCode, Integer billNo, Model model) {

		SaleStmt stmt = this.saleStmtService.findOne(SaleStmtId.of(customerNo, partCode, billNo));

		List<SaleStmtBd> saleStmtBd = stmt.getSaleStmtBd().stream().map(bd->{
			List<ItemPrice> priceList = bd.getItem().getItemPrice();
			priceList = priceList.stream().filter(p->p.getKind().intValue() == 0).collect(Collectors.toList());
			bd.getItem().setSalePrice(priceList.get(priceList.size()-1));
			return bd;
		}).collect(Collectors.toList());

		stmt.setSaleStmtBd(saleStmtBd);

		int amt = stmt.getAmount().intValue();
		int vat = stmt.getVatAmt().intValue();
		int taxFreeAmt = saleStmtBd.stream()
				.filter(bd->bd.getItem().getTaxFreeSale() == 1)
				.mapToInt(bd->bd.getAmount().intValue())
				.sum();
		int taxAmt = saleStmtBd.stream()
				.filter(bd->bd.getItem().getTaxFreeSale() == 0)
				.mapToInt(bd->bd.getAmount().intValue())
				.sum()-vat;

		User user = this.userService.findOne(stmt.getRegid());

		model.addAttribute("stmt", stmt);
		model.addAttribute("taxFreeAmt", taxFreeAmt);
		model.addAttribute("taxAmt", taxAmt);
		model.addAttribute("user", user);

		// 승인
		if(stmt.getJungsanKind().charAt(1) == '1') {
			return "jsp/funeralsystem/common/receipt/apprReceiptSaleStmt";
		}else {
			return "jsp/funeralsystem/common/receipt/cancelReceiptSaleStmt";
		}
	}

	@RequestMapping("/receipt/saleStmt/all")
	public String getSaleStmt(String customerNo, String partCode, Model model) {

		List<SaleStmt> stmt = null;
		if(StringUtils.isEmpty(partCode)) {
			stmt = this.saleStmtService.findByCustomerNo(customerNo);
		}else {
			stmt = this.saleStmtService.findByCustomerNoAndPartCode(customerNo, partCode);
		}


		List<SaleStmtBd> saleStmtBd = stmt.stream().flatMap(ss->ss.getSaleStmtBd().stream()).map(bd->{
			List<ItemPrice> priceList = bd.getItem().getItemPrice();
			priceList = priceList.stream().filter(p->p.getKind().intValue() == 0).collect(Collectors.toList());
			bd.getItem().setSalePrice(priceList.get(priceList.size()-1));
			return bd;
		}).collect(Collectors.toList());

		int amt = stmt.stream().mapToInt(ss->ss.getAmount().intValue()).sum();
		int vat = stmt.stream().filter(ss->Objects.nonNull(ss.getVatAmt())).mapToInt(ss->ss.getVatAmt().intValue()).sum();
		int taxFreeAmt = saleStmtBd.stream()
				.filter(bd->bd.getItem().getTaxFreeSale() == 1)
				.mapToInt(bd->bd.getItem().getSalePrice().getPrice().intValue())
				.sum();
		int taxAmt = saleStmtBd.stream()
				.filter(bd->bd.getItem().getTaxFreeSale() == 0)
				.mapToInt(bd->bd.getItem().getSalePrice().getPrice().intValue())
				.sum()-vat;

		Funeral funeral = this.funeralService.findOne(customerNo);

		model.addAttribute("stmt", stmt);
		model.addAttribute("saleStmtBd", saleStmtBd);
		model.addAttribute("taxFreeAmt", taxFreeAmt);
		model.addAttribute("taxAmt", taxAmt);
		model.addAttribute("vat", vat);
		model.addAttribute("amt", amt);
		model.addAttribute("funeral", funeral);

		return "jsp/funeralsystem/common/receipt/receiptSaleStmtAll";
	}

	@RequestMapping("/receipt/saleStmt/one")
	public String getSaleStmtOne(String customerNo, String partCode, Integer billNo, Model model) {

		SaleStmt stmt = this.saleStmtService.findOne(SaleStmtId.of(customerNo, partCode, billNo));

		List<SaleStmtBd> saleStmtBd = stmt.getSaleStmtBd().stream().map(bd->{
			List<ItemPrice> priceList = bd.getItem().getItemPrice();
			priceList = priceList.stream().filter(p->p.getKind().intValue() == 0).collect(Collectors.toList());
			bd.getItem().setSalePrice(priceList.get(priceList.size()-1));
			return bd;
		}).collect(Collectors.toList());

		stmt.setSaleStmtBd(saleStmtBd);

		int amt = Optional.fromNullable(stmt.getAmount()).or(new Double(0)).intValue();
		int vat = Optional.fromNullable(stmt.getVatAmt()).or(new Double(0)).intValue();
		int taxFreeAmt = saleStmtBd.stream()
				.filter(bd->bd.getItem().getTaxFreeSale() == 1)
				.mapToInt(bd->bd.getItem().getSalePrice().getPrice().intValue())
				.sum();
		int taxAmt = saleStmtBd.stream()
				.filter(bd->bd.getItem().getTaxFreeSale() == 0)
				.mapToInt(bd->bd.getItem().getSalePrice().getPrice().intValue())
				.sum()-vat;

		User user = this.userService.findOne(stmt.getRegid());

		Funeral funeral = this.funeralService.findOne(customerNo);
		if(Objects.nonNull(funeral)) {
			model.addAttribute("funeral", funeral);
		}
		Part part = this.partService.findOne(partCode);
		if(Objects.nonNull(part)) {
			model.addAttribute("part", part);
		}

		model.addAttribute("stmt", stmt);
		model.addAttribute("saleStmtBd", saleStmtBd);
		model.addAttribute("taxFreeAmt", taxFreeAmt);
		model.addAttribute("taxAmt", taxAmt);
		model.addAttribute("amt", amt);
		model.addAttribute("vat", vat);
		model.addAttribute("user", user);

		return "jsp/funeralsystem/common/receipt/receiptSaleStmtOne";
	}

	@RequestMapping("/receipt/payment/fune")
	public String getPaymentFune(String customerNo, Integer deadId, String tid, Integer seq, Model model) {

		Payment payment = this.paymentService.findOne(PaymentId.of(deadId, tid, seq));

		model.addAttribute("payment", payment);

		BasicCode kind = this.basicCodeService.findByBasicCdAndCode("300", payment.getKind());
		model.addAttribute("kind", kind);


		Funeral funeral = this.funeralService.findOne(customerNo);
		if(Objects.nonNull(funeral)) {
			model.addAttribute("funeral", funeral);
		}

		User user = this.userService.findOne(payment.getRegid());

		model.addAttribute("user", user);

		return "jsp/funeralsystem/common/receipt/funeReceiptPayment";
//		if(payment.getKind().charAt(1) == '1') {
//			return "jsp/funeralsystem/common/receipt/apprReceiptPayment";
//		}else {
//			return "jsp/funeralsystem/common/receipt/cancelReceiptPayment";
//		}

	}

	@RequestMapping("/receipt/payment/crem")
	public String getPaymentCrem(Integer deadId, String tid, Integer seq, Model model) {

		Payment payment = this.paymentService.findOne(PaymentId.of(deadId, tid, seq));

		model.addAttribute("payment", payment);

		BasicCode kind = this.basicCodeService.findByBasicCdAndCode("300", payment.getKind());
		model.addAttribute("kind", kind);

		User user = this.userService.findOne(payment.getRegid());

		model.addAttribute("user", user);

		return "jsp/funeralsystem/common/receipt/cremReceiptPayment";
	}

	@RequestMapping(value = "/receipt/payData", produces=APPLICATION_JSON, method=RequestMethod.PUT)
	public ApiResponse savePayData(@RequestBody PayDataVTO payData) {

		this.commonService.savePayData(payData);

		return ok();
	}
}
