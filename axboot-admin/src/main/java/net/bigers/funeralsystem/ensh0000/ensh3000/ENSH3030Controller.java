package net.bigers.funeralsystem.ensh0000.ensh3000;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.axisj.axboot.core.util.DozerBeanMapperUtils;
import com.wordnik.swagger.annotations.ApiOperation;

import net.bigers.funeralsystem.common.vto.OptionVTO;
import net.bigers.funeralsystem.ensh0000.domain.ensfloor.Ensfloor;
import net.bigers.funeralsystem.ensh0000.domain.ensfloor.EnsfloorService;
import net.bigers.funeralsystem.ensh0000.domain.ensroom.Ensroom;
import net.bigers.funeralsystem.ensh0000.domain.ensroom.EnsroomService;
import net.bigers.funeralsystem.ensh0000.vto.EnsroomVTO;

/**
 *
*
* 업무분류   :
* 기능분류   :
* 프로그램명 : ENSH3030Controller.java
* 설      명 :  봉안호실 정보를 등록 조회,삭제하는 프로그램
*
* 이력사항 @2016. 6. 27. kdh 최초작성 <BR/>
*
 */
@Controller
public class ENSH3030Controller extends BaseController{

	@Autowired
	private  EnsroomService ensroomService;

	@Autowired
	private  EnsfloorService ensfloorService;

	/**
	 *
	 * 메소드명칭 : findEnsroom
	 * 메소드설명 : 봉호실정보 조회
	 * ----------------------------------------
	 * 이력사항 2016. 7. 1. kdh 최초작성
	 *
	 * @param floorCode
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/ENSH3030/findEnsroom", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse findEnsroom(
			@RequestParam(value="locCode" , required = true) String locCode
			,@RequestParam(value="floorCode" , required = true) String floorCode) throws Exception{


		List<Ensroom> ensrooms =  ensroomService.findByLocCodeAndFloorCode(locCode,floorCode);

		return CommonListResponseParams.ListResponse.of(EnsroomVTO.of(ensrooms));

	}

	/**
	 *
	 * 메소드명칭 : saveEnsroom
	 * 메소드설명 : 호실정보 저장
	 * ----------------------------------------
	 * 이력사항 2016. 7. 1. kdh 최초작성
	 *
	 * @param ensroomVTOs
	 * @return
	 * @throws Exception
	 */
	@Transactional
	@RequestMapping(value="/ENSH3030/saveEnsroom", method={RequestMethod.PUT, RequestMethod.POST}, produces=APPLICATION_JSON)
	public ApiResponse saveEnsroom(@RequestBody List<EnsroomVTO> ensroomVTOs) throws Exception{

		List<Ensroom> ensrooms = DozerBeanMapperUtils.mapList(ensroomVTOs, Ensroom.class);
		ensroomService.save(ensrooms);
		return ok();
	}

	/**
	 *
	 * 메소드명칭 : deleteEnsfloor
	 * 메소드설명 : 봉안층코드 정보 삭제
	 * ----------------------------------------
	 * 이력사항 2016. 6. 24. kdh 최초작성
	 *
	 * @param floorCodes
	 * @return
	 * @throws Exception
	 */
	@Transactional
	@RequestMapping(value="/ENSH3030/deleteEnsroom", method={RequestMethod.DELETE}, produces=APPLICATION_JSON)
	public ApiResponse deleteEnsroom(@RequestBody List<Ensroom> roomCodes) throws Exception{

		roomCodes.forEach(roomCode -> ensroomService.delete(roomCode));

		return ok();
	}

	/**
	 *
	 * 메소드명칭 : ensfloorSelectOption
	 * 메소드설명 : 층 정보 셀렉트
	 * ----------------------------------------
	 * 이력사항 2016. 7. 1. kdh 최초작성
	 *
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/ENSH3030/ensfloorSelectOption", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public List ensfloorSelectOption() throws Exception{

		List<Ensfloor> ensfloors =  ensfloorService.findAll();

		List<Map<String,String>> options = ensfloors.stream().map(ensfloor->{
			Map<String, String> item = new HashMap<>();
			item.put("optionValue", ensfloor.getLocCode()+ensfloor.getFloorCode());
			item.put("optionText", ensfloor.getCharnClassName());
			return item;
		}).collect(Collectors.toList());

		return options;
	}


	@ApiOperation(value = "호실정보", notes = "호실정보")
	@RequestMapping(value="/ENSH3030/ensRoom/option" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public List<OptionVTO> getEnsRoomOption() throws Exception{

		return this.ensroomService.findAll().stream().map(room->OptionVTO.of(room.getLocCode()+room.getFloorCode()+room.getRoomCode(), room.getRoomName())).collect(Collectors.toList());
	}


}