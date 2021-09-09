package net.bigers.funeralsystem.crem0000.crem1000;

import java.beans.BeanInfo;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import javax.inject.Inject;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.axisj.axboot.core.code.ApiStatus;
import com.axisj.axboot.core.converter.BaseConverter;
import com.axisj.axboot.core.util.DozerBeanMapperUtils;
import com.fasterxml.jackson.databind.ObjectMapper;

import net.bigers.funeralsystem.crem0000.domain.hwabooking.HwaBooking;
import net.bigers.funeralsystem.crem0000.domain.hwabooking.HwaBookingId;
import net.bigers.funeralsystem.crem0000.domain.hwabooking.HwaBookingService;
import net.bigers.funeralsystem.crem0000.domain.rogrp.Rogrp;
import net.bigers.funeralsystem.crem0000.domain.rogrp.RogrpService;
import net.bigers.funeralsystem.crem0000.domain.rogrpchasu.Rogrpchasu;
import net.bigers.funeralsystem.crem0000.domain.rogrpchasu.RogrpchasuService;
import net.bigers.funeralsystem.crem0000.vto.HwaBookingVTO;
import net.bigers.funeralsystem.crem0000.vto.RogrpchasuVTO;
import net.bigers.funeralsystem.lib.validation.ValidationResult;
import net.bigers.funeralsystem.lib.validation.Validator;

/**
*
* 업무분류   : 화장관리
* 기능분류   : 화장 예약 접수
* 프로그램명 : 화장예약등록
* 설      명 : e하늘 화장예약 접수 또는 직접 접수
* ------------------------------------------
*
* 이력사항 2016. 2. 29. 이승호 최초작성 <BR/>
*/
@Controller
public class CREM1010Controller extends BaseController {

	@Autowired
	private RogrpchasuService rogrpchasuService;

	@Autowired
	private RogrpService rogrpService;

	@Autowired
	private HwaBookingService hwaBookingService;

    @Inject
    private BaseConverter baseConverter;

	@RequestMapping(value="/CREM1010/findRogrpchasu/{date}", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse findRogrpchasuByDate(@PathVariable("date") String date){

		List<RogrpchasuVTO> rogrpchasuVTOList = RogrpchasuVTO.of(rogrpchasuService.getInvokedChasu());

		String bookDate = date.replaceAll("-", "");

		rogrpchasuVTOList = rogrpchasuVTOList.stream().map(rogrpchasu->{

			try {

				BeanInfo beanInfo = Introspector.getBeanInfo(rogrpchasu.getClass());

				for(PropertyDescriptor propertyDescriptor : beanInfo.getPropertyDescriptors()){
					for(int i=1; i<=20; i++){
						if(propertyDescriptor.getDisplayName().equals("ro"+StringUtils.leftPad(new Integer(i).toString(), 2, "0"))){
							HwaBooking hwaBooking = hwaBookingService.findOne(HwaBookingId.of(bookDate, rogrpchasu.getChasuSeq(), StringUtils.leftPad(new Integer(i).toString(), 2, "0")));
							if(hwaBooking == null){
								continue;
							}
							Method setMethod = propertyDescriptor.getWriteMethod();
							setMethod.invoke(rogrpchasu, hwaBooking.getBookDeadName());
						}
						if(propertyDescriptor.getDisplayName().equals("ro"+StringUtils.leftPad(new Integer(i).toString(), 2, "0")+"booking")){
							HwaBooking hwaBooking = hwaBookingService.findOne(HwaBookingId.of(bookDate, rogrpchasu.getChasuSeq(), StringUtils.leftPad(new Integer(i).toString(), 2, "0")));
							if(hwaBooking == null){
								continue;
							}
							Method setMethod = propertyDescriptor.getWriteMethod();
							setMethod.invoke(rogrpchasu, HwaBookingVTO.of(hwaBooking));
						}
					}
				}
			} catch (Exception e1) {
				e1.printStackTrace();
			}

			return rogrpchasu;
		}).collect(Collectors.toList());

		return CommonListResponseParams.ListResponse.of(rogrpchasuVTOList);
	}

	@RequestMapping(value="/CREM1010/hwaBooking/{condition}/{bookDate}", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse findHwaBooking(
			@PathVariable("condition") String condition
			, @PathVariable("bookDate") String bookDate
			) throws Exception{
		return findHwaBooking(condition, bookDate, "");
	}

	@RequestMapping(value="/CREM1010/hwaBooking/{condition}/{bookDate}/{keyword}", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse findHwaBooking(
				@PathVariable("condition") String condition
				, @PathVariable("bookDate") String bookDate
				, @PathVariable("keyword") String keyword
			) throws Exception{
		List<HwaBooking> hwaBookingList = null;

		if(bookDate.contains("-")){
			bookDate = bookDate.replaceAll("-", "");
		}
//		condition
//		<option value="all">전체</option>
//		<option value="applicant">신청자</option>
//		<option value="deadman">고인</option>
		switch (condition) {
		case "a":
			hwaBookingList = hwaBookingService.findByBookDateAndBookApplName(bookDate, keyword);
			break;
		case "d":
			hwaBookingList = hwaBookingService.findByBookDateAndBookDeadName(bookDate, keyword);
			break;
		case "ad":
			hwaBookingList = hwaBookingService.findByBookDateAndBookDeadName(bookDate, keyword);
			hwaBookingList.addAll(hwaBookingService.findByBookDateAndBookApplName(bookDate, keyword));
			break;
		case "all":
			hwaBookingList = hwaBookingService.findByBookDate(bookDate);
			break;

		default:
			break;
		}

		hwaBookingList = Objects.isNull(hwaBookingList) ? new ArrayList<>(0) : hwaBookingList;

		this.hwaBookingService.addBookStatus(hwaBookingList);
		List<HwaBookingVTO> vtoList = baseConverter.convert(hwaBookingList, HwaBookingVTO.class);
		hwaBookingService.addFuneral(vtoList);

		return CommonListResponseParams.ListResponse.of(vtoList);
	}


	@RequestMapping(value="/CREM1010/roSelectOption", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public List roSelectOption() throws Exception{
		return roSelectOption(new Date());
	}

	@RequestMapping(value="/CREM1010/roSelectOption/{date}", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public List roSelectOption(
				@PathVariable("date") @DateTimeFormat(pattern="yyyyMMdd") Date date
			) throws Exception{

		Rogrp rogrpchasu = rogrpService.getInvokedRogrp(date);

		List<Map<String, String>> options = IntStream.range(1, Integer.parseInt(rogrpchasu.getTotRocnt())).boxed().map(i->{
			Map<String, String> item = new HashMap<>();
			item.put("optionValue", StringUtils.leftPad(new Integer(i).toString(), 2, "0"));
			item.put("optionText", StringUtils.leftPad(new Integer(i).toString(), 2, "0"));
			return item;
		}).collect(Collectors.toList());

		return options;
	}

	@RequestMapping(value="/CREM1010/chasuSelectOption", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public List chasuSelectOption() throws Exception{

		List<Rogrpchasu> rogrpchasuList = rogrpchasuService.getInvokedChasu();

		List<Map<String,String>> options = rogrpchasuList.stream().map(rogrpchasu->{
			Map<String, String> item = new HashMap<>();
			item.put("optionValue", rogrpchasu.getChasuSeq());
			item.put("optionText", rogrpchasu.getChasuSeq());
			return item;
		}).collect(Collectors.toList());

		return options;
	}

	@RequestMapping(value="/CREM1010/hwaBooking", method=RequestMethod.PUT, produces=APPLICATION_JSON)
	public ApiResponse saveHwaBooking(
			@RequestBody HwaBookingVTO hwaBookingVTO
			) throws Exception{

		HwaBooking hwaBooking = DozerBeanMapperUtils.map(hwaBookingVTO, HwaBooking.class);

		hwaBookingService.save(hwaBooking);
		return ok();

	}

	@RequestMapping(value="/CREM1010/hwaBooking", method=RequestMethod.DELETE, produces=APPLICATION_JSON)
	public ApiResponse deleteHwaBooking(
			@RequestBody List<HwaBookingVTO> deleteList
			) throws Exception{

		deleteList.stream().forEach(item->{
			hwaBookingService.delete(HwaBookingId.of(item.getBookDate(), item.getBookChasu(), item.getBookChasuSeq()));
		});

		return ok();
	}

}
