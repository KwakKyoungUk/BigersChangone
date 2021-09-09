package net.bigers.funeralsystem.fune0000.fune0000;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.core.api.response.ApiResponse;

import net.bigers.funeralsystem.fune0000.domain.customer.Customer;
import net.bigers.funeralsystem.fune0000.domain.customer.CustomerId;
import net.bigers.funeralsystem.fune0000.domain.customer.CustomerService;
import net.bigers.funeralsystem.fune0000.domain.part.Part;
import net.bigers.funeralsystem.fune0000.domain.part.PartService;

@Controller
public class FUNE0020Controller extends BaseController{

	@Inject
	private CustomerService customerService;

	@Inject
	private PartService partService;

	@RequestMapping(value="/FUNE0020/part", method={RequestMethod.POST}, produces=APPLICATION_JSON) // POST 방식을 사용하였는데, AXSearch 컴포넌트에서 AJAX 요청시 GET 방식으로 받아오지 않기에 POST방식으로 사용하였다.
	public CommonListResponseParams.ListResponse getPartList(){
		List<Part> list =  partService.findByOrderByPartCodeAsc();
		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/FUNE0020/customer", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getCustomerList(
			@RequestParam(value="partCode", required=false, defaultValue="") String partCode,
			@RequestParam(value="custCode", required=false, defaultValue="") String custCode,
			@RequestParam(value="custName", required=false, defaultValue="") String custName){

		List<Customer> list = customerService.findByPartCodeStartingWithAndCustCodeStartingWithAndCustNameContainingOrderBySortNoAsc(partCode, custCode, custName);

		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/FUNE0020/customer", method={RequestMethod.PUT}, produces=APPLICATION_JSON)
	public ApiResponse saveCustomer(@RequestBody List<Customer> list){
		customerService.save(list);
		return ok();
	}

	/**
	 *
	 * 메소드명칭 : deleteCust
	 * 메소드설명 : 거래처삭제
	 * ----------------------------------------
	 * 이력사항 2017. 11. 21. JIN 추가작성
	 *
	 * @param empCodes
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/FUNE0020/customer", method={RequestMethod.DELETE}, produces=APPLICATION_JSON)
	public ApiResponse deleteCustomer(@RequestBody List<Customer> list) throws Exception{
		customerService.delete(list);
		return ok();
	}

}
