package net.bigers.funeralsystem.crem0000.crem2000;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.core.domain.code.BasicCode;
import com.axisj.axboot.core.domain.code.BasicCodeService;
import com.axisj.axboot.core.util.DateUtils;

import net.bigers.funeralsystem.crem0000.CremationConstants;
import net.bigers.funeralsystem.crem0000.domain.hwaBrazier.HwaBrazier;
import net.bigers.funeralsystem.crem0000.domain.hwaBrazier.HwaBrazierService;
import net.bigers.funeralsystem.crem0000.domain.rogrpchasu.Rogrpchasu;
import net.bigers.funeralsystem.crem0000.domain.rogrpchasu.RogrpchasuService;

/**
*
* 업무분류   : 화장관리
* 기능분류   : 화로 배정
* 프로그램명 : 화로 배정
* 설      명 : 화로 배정
* ------------------------------------------
*
* 이력사항 2016. 6. 22. 이승호 최초작성 <BR/>
*/
@Controller
public class CREM2011Controller extends BaseController {

	@Autowired
	private BasicCodeService basicCodeService;

	@Autowired
	private RogrpchasuService rogrpchasuService;

	@Autowired
	private HwaBrazierService hwaBrazierService;

	@RequestMapping(value="/CREM2011/waitRoom/colGroup", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getWaitRoomColGroup() throws Exception{

		List<BasicCode> waitRoomList = basicCodeService.findByBasicCd(CremationConstants.BASIC_CODE_WAIT_ROOM);

		List<Map<String, Object>> colGroup = new ArrayList<>();

//		{key:"chasuSeq", label:"차수", width:"100", align:"center"}
		waitRoomList.forEach(waitRoom->{
			Map<String, Object> map = new HashMap<>();
			map.put("key", waitRoom.getCode());
			map.put("label", waitRoom.getName());
			map.put("width", "60");
			map.put("align", "center");
			colGroup.add(map);
		});

		return CommonListResponseParams.ListResponse.of(colGroup);
	}

	@RequestMapping(value="/CREM2011/waitRoom", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getWaitRoom() throws Exception{

		List<Rogrpchasu> rogrpchasuList = rogrpchasuService.getInvokedChasu();
		List<BasicCode> waitRoomList = basicCodeService.findByBasicCd(CremationConstants.BASIC_CODE_WAIT_ROOM);
		List<Map<String, Object>> result = new ArrayList<>();
		List<HwaBrazier> todayHwaBrazier = hwaBrazierService.findByBurnDate(new Date());

		rogrpchasuList.forEach(rogrpchasu->{
			Map<String, Object> map = new HashMap<>();
			waitRoomList.forEach(waitRoom->{
				if(!map.containsKey(waitRoom.getCode())){
					map.put(waitRoom.getCode(), "0");
				}
				todayHwaBrazier.forEach(today->{
					if(
							today.getBurnChasu().equals(rogrpchasu.getChasuSeq())
							&& today.getWaitRoom().equals(waitRoom.getCode())
							){

						map.put(waitRoom.getCode(), "1");
					}
				});
			});
			map.put("chasuName", rogrpchasu.getChasuName());
			map.put("chasuSeq", rogrpchasu.getChasuSeq());
			map.put("strttimeString", DateUtils.formatToDateString(rogrpchasu.getStrtime(), "HH:mm"));
			map.put("endtimeString", DateUtils.formatToDateString(rogrpchasu.getEndtime(), "HH:mm"));
			result.add(map);
		});

		return CommonListResponseParams.ListResponse.of(result);
	}

	@RequestMapping(value="/CREM2011/byeRoom/colGroup", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getByeRoomColGroup() throws Exception{

		List<BasicCode> waitRoomList = basicCodeService.findByBasicCd(CremationConstants.BASIC_CODE_BYE_ROOM);

		List<Map<String, Object>> colGroup = new ArrayList<>();

//		{key:"chasuSeq", label:"차수", width:"100", align:"center"}
		waitRoomList.forEach(waitRoom->{
			Map<String, Object> map = new HashMap<>();
			map.put("key", waitRoom.getCode());
			map.put("label", waitRoom.getName());
			map.put("width", "60");
			map.put("align", "center");
			colGroup.add(map);
		});

		return CommonListResponseParams.ListResponse.of(colGroup);
	}

	@RequestMapping(value="/CREM2011/byeRoom", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getByeRoom() throws Exception{

		List<Rogrpchasu> rogrpchasuList = rogrpchasuService.getInvokedChasu();
		List<BasicCode> byeRoomList = basicCodeService.findByBasicCd(CremationConstants.BASIC_CODE_BYE_ROOM);
		List<Map<String, Object>> result = new ArrayList<>();
		List<HwaBrazier> todayHwaBrazier = hwaBrazierService.findByBurnDate(new Date());

		rogrpchasuList.forEach(rogrpchasu->{
			Map<String, Object> map = new HashMap<>();
			byeRoomList.forEach(byeRoom->{
				if(!map.containsKey(byeRoom.getCode())){
					map.put(byeRoom.getCode(), new Integer(0));
				}
				todayHwaBrazier.forEach(today->{
					if(
							today.getBurnChasu().equals(rogrpchasu.getChasuSeq())
							&& today.getWaitRoom().equals(byeRoom.getCode())
							){
						Integer a = (Integer)map.get(byeRoom.getCode());
						a++;
					}
				});
			});
			map.put("chasuName", rogrpchasu.getChasuName());
			map.put("chasuSeq", rogrpchasu.getChasuSeq());
			map.put("strttimeString", DateUtils.formatToDateString(rogrpchasu.getStrtime(), "HH:mm"));
			map.put("endtimeString", DateUtils.formatToDateString(rogrpchasu.getEndtime(), "HH:mm"));
			result.add(map);
		});

		return CommonListResponseParams.ListResponse.of(result);
	}

	@RequestMapping(value="/CREM2011/sugolRoom/colGroup", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getSugolRoomColGroup() throws Exception{

		List<BasicCode> sugolRoomList = basicCodeService.findByBasicCd(CremationConstants.BASIC_CODE_SUGOL_ROOM);

		List<Map<String, Object>> colGroup = new ArrayList<>();

//		{key:"chasuSeq", label:"차수", width:"100", align:"center"}
		sugolRoomList.forEach(sugolRoom->{
			Map<String, Object> map = new HashMap<>();
			map.put("key", sugolRoom.getCode());
			map.put("label", sugolRoom.getName());
			map.put("width", "60");
			map.put("align", "center");
			colGroup.add(map);
		});

		return CommonListResponseParams.ListResponse.of(colGroup);
	}

	@RequestMapping(value="/CREM2011/sugolRoom", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getSugolRoom() throws Exception{

		List<Rogrpchasu> rogrpchasuList = rogrpchasuService.getInvokedChasu();
		List<BasicCode> sugolRoomList = basicCodeService.findByBasicCd(CremationConstants.BASIC_CODE_SUGOL_ROOM);
		List<Map<String, Object>> result = new ArrayList<>();
		List<HwaBrazier> todayHwaBrazier = hwaBrazierService.findByBurnDate(new Date());

		rogrpchasuList.forEach(rogrpchasu->{
			Map<String, Object> map = new HashMap<>();
			sugolRoomList.forEach(sugolRoom->{
				if(!map.containsKey(sugolRoom.getCode())){
					map.put(sugolRoom.getCode(), new Integer(0));
				}
				todayHwaBrazier.forEach(today->{
					if(
							today.getBurnChasu().equals(rogrpchasu.getChasuSeq())
							&& today.getSugolRoom().equals(sugolRoom.getCode())
							){
						Integer a = (Integer)map.get(sugolRoom.getCode());
						a++;
					}
				});
			});
			map.put("chasuName", rogrpchasu.getChasuName());
			map.put("chasuSeq", rogrpchasu.getChasuSeq());
			map.put("strttimeString", DateUtils.formatToDateString(rogrpchasu.getStrtime(), "HH:mm"));
			map.put("endtimeString", DateUtils.formatToDateString(rogrpchasu.getEndtime(), "HH:mm"));
			result.add(map);
		});

		return CommonListResponseParams.ListResponse.of(result);
	}

}
