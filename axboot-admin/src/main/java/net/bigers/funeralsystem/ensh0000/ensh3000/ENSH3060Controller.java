package net.bigers.funeralsystem.ensh0000.ensh3000;

import java.util.List;

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

import net.bigers.funeralsystem.ensh0000.domain.ensmap.Ensmap;
import net.bigers.funeralsystem.ensh0000.domain.ensmap.EnsmapService;
import net.bigers.funeralsystem.ensh0000.vto.EnsmapVTO;

/**
 *
 * 업무분류   :
 * 기능분류   :
 * 프로그램명 :
 * 설명 : 봉안맵  조회,수정
 * ------------------------------------------
 *
 * 이력사항 2016. 7. 19. kdh 최초작성<BR/>
 */
@Controller
public class ENSH3060Controller extends BaseController{

	@Autowired
	EnsmapService ensmapService;

	/**
	 *
	 * 메소드명칭 : findEnsmap
	 * 메소드설명 :
	 * ----------------------------------------
	 * 이력사항 2016. 7. 19. kdh 최초작성
	 *
	 * @param locCode
	 * @param floorCode
	 * @param roomCode
	 * @param blockNum
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/ENSH3060/findEnsmap", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse  findEnsmap(@RequestParam(value="locCode" ,required = false) String locCode,
			@RequestParam(value="floorCode" ,required = false) String floorCode,
			@RequestParam(value="roomCode" ,required = false) String roomCode,
			@RequestParam(value="blockNum" ,required = false) int blockNum) throws Exception{

		List<Ensmap> ensmaps = ensmapService.findByLocCodeAndFloorCodeAndRoomCodeAndBlockNumOrderByMapIdxAsc(locCode, floorCode, roomCode, blockNum);

		return CommonListResponseParams.ListResponse.of(ensmaps);
	}


	/**
	 *
	 * 메소드명칭 : saveEnsmapjunk
	 * 메소드설명 :
	 * ----------------------------------------
	 * 이력사항 2016. 7. 19. kdh 최초작성
	 *
	 * @param ensmapVTOs
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/ENSH3060/saveEnsmap", method={RequestMethod.PUT, RequestMethod.POST}, produces=APPLICATION_JSON)
	public ApiResponse saveEnsmapjunk(@RequestBody List<EnsmapVTO> ensmapVTOs) throws Exception{

		List<Ensmap> ensmaps = DozerBeanMapperUtils.mapList(ensmapVTOs, Ensmap.class);
		ensmapService.save(ensmaps);
		return ok();
	}




}