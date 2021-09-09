package net.bigers.funeralsystem.crem0000.crem1000;

import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.PageableResponseParams;
import com.axisj.axboot.core.dto.PageableTO;
import com.wordnik.swagger.annotations.ApiOperation;

import ch.qos.logback.classic.pattern.Util;
import net.bigers.funeralsystem.fune0000.domain.binso.Binso;
import net.bigers.funeralsystem.fune0000.domain.binso.BinsoService;
import net.bigers.funeralsystem.fune0000.domain.funeral.Funeral;
import net.bigers.funeralsystem.fune0000.domain.funeral.FuneralService;
import net.bigers.funeralsystem.fune0000.domain.payment.Payment;
import net.bigers.funeralsystem.fune0000.domain.payment.PaymentService;
import net.bigers.funeralsystem.fune0000.domain.total_part.TotalPart;
import net.bigers.funeralsystem.fune0000.domain.total_part.TotalPartService;

/**
*
* 업무분류   : 화장관리
* 기능분류   : 장례식장 조회
* 프로그램명 : 장례식장 조회
* 설      명 : 장례식장  조회
* ------------------------------------------
*
* 이력사항 2017. 10. 5. 김동호 최초작성 <BR/>
*/
@Controller
public class CREM1012Controller extends BaseController {

	@Autowired
	private FuneralService funeralService;

	@Autowired
	private BinsoService binsoService;

	@Autowired
	private PaymentService paymentService;

	@Autowired
	private TotalPartService totalPartService;

	@ApiOperation(value = "장례식장 접수 정보", notes = "장례식장 접수 정보를 조회")
	@RequestMapping(value="/CREM1012/funeral", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public PageableResponseParams.PageResponse findFuneral(
			@RequestParam Map<String, String> requestBody
			, Pageable pageable
			) throws Exception{

		Page<Funeral> funeralPage = funeralService.findFuneral(requestBody, pageable);

		List<Funeral> list = funeralPage.getContent().stream().map(f->{
			List<Payment> payments = this.paymentService.findByDeadId(f.getDeadId());
			if(Objects.isNull(payments) || payments.isEmpty()) {
				return null;
			}
			payments = payments.stream().filter(p->{
				return Objects.isNull(p.getCFlg()) || p.getCFlg() != 1;
			}).collect(Collectors.toList());
			f.setPayment(payments);

			List<TotalPart> totalPart = this.totalPartService.findByCustomerNo(f.getCustomerNo());

			if(Objects.isNull(totalPart) || totalPart.isEmpty()) {
				return null;
			}
			double charge = totalPart.stream().mapToDouble(tp->Optional.ofNullable(tp.getAmount()).orElse(0.0)-Optional.ofNullable(tp.getDcAmount()).orElse(0.0))
					.sum();
			double pay = payments.stream().mapToDouble(p->p.getCashAmt()+p.getCardAmt()).sum();

			// 정산금액이 부과금액보다 작을경우
			if(pay<charge) {
				return null;
			}

			return f;
		}).filter(Objects::nonNull).collect(Collectors.toList());

		return PageableResponseParams.PageResponse.of(list, PageableTO.of(funeralPage));
	}

	@ApiOperation(value = "빈소 정보", notes = "빈소 정보 전부 조회")
	@RequestMapping(value="/CREM1012/binso", method=RequestMethod.GET, produces=APPLICATION_JSON)
    public List list() {
        List<Binso> binso = binsoService.findAll();
        return binso;
    }


}
