package net.bigers.funeralsystem.test;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.core.domain.program.Program;
import com.axisj.axboot.core.domain.program.ProgramRepository;
import com.axisj.axboot.core.domain.program.menu.Menu;
import com.axisj.axboot.core.domain.program.menu.MenuRepository;
import com.axisj.axboot.core.domain.user.User;

import net.bigers.funeralsystem.common.domain.applicant.ApplicantRepository;
import net.bigers.funeralsystem.common.domain.sales.Sales;
import net.bigers.funeralsystem.crem0000.domain.hwaBrazier.HwaBrazier;
import net.bigers.funeralsystem.crem0000.domain.hwaBrazier.HwaBrazierRepository;
import net.bigers.funeralsystem.crem0000.domain.hwacremation.HwaCremation;
import net.bigers.funeralsystem.crem0000.domain.hwacremation.HwaCremationRepository;
import net.bigers.funeralsystem.fune0000.domain.sale_stmt.SaleStmt;
import net.bigers.funeralsystem.fune0000.domain.sale_stmt.SaleStmtRepository;

@Controller
public class TestController extends BaseController{

	@Autowired
	HwaBrazierRepository hwaBrazierRepository;
	@Autowired
	ProgramRepository programRepository;
	@Autowired
	MenuRepository menuRepository;
	
	@Autowired
	SaleStmtRepository saleStmtRepository;
	


	@RequestMapping(value="/test/joinTest", produces=APPLICATION_JSON)
	public List<HwaBrazier> joinTest(){

		List<HwaBrazier> list =hwaBrazierRepository.findAll();

		return list;
	}

	@RequestMapping(value="/test/mappedBy", produces=APPLICATION_JSON)
	public Map<String, Object> mappedBy(){

		Program programlist =programRepository.findOne("samples-list");
		Menu menulist =menuRepository.findOne("samples-list");

		Map<String, Object> res = new HashMap<>();

		res.put("program", programlist);
		res.put("menu", menulist);

		return res;
	}


	@Autowired
	ApplicantRepository applicantRepository;

//	@RequestMapping(value="/test/pk_pluse", produces=APPLICATION_JSON)
//	public Applicant pk_pluse_일반컬럼_조인_테스트(){
//		return applicantRepository.findPayerYApplicant(1);
//	}

	@Autowired
	HwaCremationRepository cremationRepository;

	@RequestMapping(value="/test/joincondition", produces=APPLICATION_JSON)
	public List<HwaCremation> 엔티티_조인관계_조건_테스트(){
		return cremationRepository.findByCremDateBetweenAndThedeadDeadName(new Date(0L), new Date(), "홍길동", new PageRequest(0, 10)).getContent();
	}
	
	@RequestMapping(value="/test/loginTest", produces=APPLICATION_JSON)
	public List<User>  loginList(){
		
		HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
        String ip = req.getHeader("X-FORWARDED-FOR");
        if (ip == null)
            ip = req.getRemoteAddr();
		log.debug("ip =" + ip);
	
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		//SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		
		
		
		return null;

	}
	
	public static String getClientIpAddr(HttpServletRequest request) {  
	    String ip = request.getHeader("X-Forwarded-For");  
	    if (ip == null || ip.length() == 0 || ip.equalsIgnoreCase("unknown")) {  
	        ip = request.getHeader("Proxy-Client-IP");  
	    }  
	    if (ip == null || ip.length() == 0 || ip.equalsIgnoreCase("unknown")) {  
	        ip = request.getHeader("WL-Proxy-Client-IP");  
	    }  
	    if (ip == null || ip.length() == 0 || ip.equalsIgnoreCase("unknown")) {  
	        ip = request.getHeader("HTTP_X_FORWARDED_FOR");  
	    }  
	    if (ip == null || ip.length() == 0 || ip.equalsIgnoreCase("unknown")) {  
	        ip = request.getHeader("HTTP_X_FORWARDED");  
	    }  
	    if (ip == null || ip.length() == 0 || ip.equalsIgnoreCase("unknown")) {  
	        ip = request.getHeader("HTTP_X_CLUSTER_CLIENT_IP");  
	    }  
	    if (ip == null || ip.length() == 0 || ip.equalsIgnoreCase("unknown")) {  
	        ip = request.getHeader("HTTP_CLIENT_IP");  
	    }  
	    if (ip == null || ip.length() == 0 || ip.equalsIgnoreCase("unknown")) {  
	        ip = request.getHeader("HTTP_FORWARDED_FOR");  
	    }  
	    if (ip == null || ip.length() == 0 || ip.equalsIgnoreCase("unknown")) {  
	        ip = request.getHeader("HTTP_FORWARDED");  
	    }  
	    if (ip == null || ip.length() == 0 || ip.equalsIgnoreCase("unknown")) {  
	        ip = request.getHeader("HTTP_VIA");  
	    }  
	    if (ip == null || ip.length() == 0 || ip.equalsIgnoreCase("unknown")) {  
	        ip = request.getHeader("REMOTE_ADDR");  
	    }  
	    if (ip == null || ip.length() == 0 || ip.equalsIgnoreCase("unknown")) {  
	        ip = request.getRemoteAddr();  
	    }  
	    return ip;  
	}
	
	@RequestMapping(value="/test/kiosk/post/json", method=RequestMethod.POST ,produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse restemplite1(@RequestBody List<Sales> list){
		
		List<SaleStmt> stmt = new ArrayList<>();
		for (int i = 0; i < list.size(); i++) {
			SaleStmt saleStmt = new SaleStmt();
			saleStmt.setCustomerNo(list.get(i).getSaleDate().substring(0, 8));
			saleStmt.setPartCode("31-001");
			saleStmt.setBillNo(list.get(i).getOrderNo());
			//list.get(i).getOrderNo()
			stmt.add(saleStmt);
		}
		saleStmtRepository.save(stmt);
		
		return CommonListResponseParams.ListResponse.of(stmt);
	} 
	
	@RequestMapping(value="/test/kiosk/post/json", method=RequestMethod.PUT ,produces=APPLICATION_JSON)
	public List<Sales> restemplite61(@RequestBody List<Sales> list){
		log.debug(list.size()+"=======================");
		return list;
	} 
	
	@RequestMapping(value="/test/kiosk/post/get", method=RequestMethod.POST ,produces=TEXT_PLAIN)
	public String restemplite5(String aa){

		

		return aa +  "=postText";
	} 
	
	
	@RequestMapping(value="/test/kiosk/get/text", method=RequestMethod.GET ,produces=TEXT_PLAIN)
	public String restemplite2(String aa){

		
		return aa+" = gettext";
	} 
	
	@RequestMapping(value="/test/kiosk/get/text", method=RequestMethod.GET ,produces=APPLICATION_JSON)
	public String restemplite3(@RequestBody List<Sales> list){

		
		log.debug(list.size()+"=======================");

		return "getjson";
	} 


}
