package net.bigers.funeralsystem.fune0000.fune3000;

import java.text.ParseException;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.MapResponse;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.axisj.axboot.core.util.DateUtils;

import net.bigers.funeralsystem.fune0000.domain.part.Part;
import net.bigers.funeralsystem.fune0000.domain.part.PartService;
import net.bigers.funeralsystem.fune0000.domain.stock.StockService;
import net.bigers.funeralsystem.fune0000.domain.user_mng_part.UserMngPartService;
import net.bigers.funeralsystem.lib.util.MapUtils;

@Controller
public class FUNE3120Controller extends BaseController{

	@Autowired
	private StockService stockService;

	@Autowired
	private UserMngPartService userMngPartService;

	@Autowired
	private PartService partService;

	@RequestMapping(value="/FUNE3120/part", method={RequestMethod.GET, RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getPart(){

		return CommonListResponseParams.ListResponse.of(this.userMngPartService.getByCurrentUser());
	}

	@RequestMapping(value="/FUNE3120/stock", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getStock(String partCode, String jobYm){

		return CommonListResponseParams.ListResponse.of(this.stockService.getStockOfPart(partCode, jobYm));
	}

	@RequestMapping(value="/FUNE3120/arrangeStock", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public ApiResponse arrangeStock(String partCode, String jobYm) throws Exception{

		this.stockService.arrangeStock(partCode, jobYm);
		return ok();
	}

	@RequestMapping(value="/FUNE3120/stock/sendNextMonth", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public MapResponse sendNextMonth(String partCode, String jobYm) throws Exception{

		return MapResponse.of(MapUtils.getMap("nextYm", this.stockService.sendNextMonth(partCode, jobYm)));
	}

	@RequestMapping(value="/FUNE3120/stock/arrangeStock/alldays", method={RequestMethod.GET}, produces=APPLICATION_JSON)
//	@Transactional
	public ApiResponse sendNextMonth() throws Exception{

		List<Part> parts = this.partService.findByPartGroupCodeNot("7");

		Date now = new Date();
		int nowYm = Integer.parseInt(DateUtils.formatToDateString(now, "yyyyMM"));


		parts.stream()
//			.filter(p->!p.getPartCode().equals("10-001") && !p.getPartCode().equals("20-001") && !p.getPartCode().equals("21-001"))
			.filter(p->p.getPartCode().equals("60-001"))
			.forEach(p->{

			try {
				this.stockService.sendNextMonth(p.getPartCode(), "2015-03");
			} catch (Exception e1) {
				e1.printStackTrace();
			}

			Date date = null;
			try {
				date = DateUtils.parseDate("2015-04-01", "yyyy-MM-dd");
			} catch (ParseException e1) {
				e1.printStackTrace();
			}

			while(true){

				int ym = Integer.parseInt(DateUtils.formatToDateString(date, "yyyyMM"));

				if(nowYm < ym){
					break;
				}

				try {
					this.stockService.arrangeStock(p.getPartCode(), DateUtils.formatToDateString(date, "yyyy-MM"));
				} catch (Exception e) {
					e.printStackTrace();
				}
				this.stockService.flush();
				try {
					this.stockService.sendNextMonth(p.getPartCode(), DateUtils.formatToDateString(date, "yyyy-MM"));
				} catch (Exception e) {
					e.printStackTrace();
				}

				date.setMonth(date.getMonth()+1);
			}



		});


		return ok();
	}

}
