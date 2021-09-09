package net.bigers.funeralsystem.ensh0000.ensh3000;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.core.api.response.ApiResponse;

import net.bigers.funeralsystem.ensh0000.domain.ensmap.Ensmap;
import net.bigers.funeralsystem.ensh0000.domain.ensmap.EnsmapService;
import net.bigers.funeralsystem.ensh0000.domain.ensmatrix.Ensmatrix;
import net.bigers.funeralsystem.ensh0000.domain.ensmatrix.EnsmatrixId;
import net.bigers.funeralsystem.ensh0000.domain.ensmatrix.EnsmatrixService;
import net.bigers.funeralsystem.ensh0000.vto.EnsmapVTO;
import net.bigers.funeralsystem.ensh0000.vto.EnsmatrixVTO;
import net.bigers.funeralsystem.lib.util.MapUtils;
import net.bigers.funeralsystem.lib.util.MapUtils.MapItem;

/**
 *
 * 업무분류   :
 * 기능분류   :
 * 프로그램명 :
 * 설명 :
 * ------------------------------------------
 *
 * 이력사항 2016. 7. 4. kdh 최초작성<BR/>
 */
@Controller
public class ENSH3050Controller extends BaseController{

	@Autowired
	EnsmapService ensmapService;

	@Autowired
	EnsmatrixService ensmatrixService;

	/**
	 *
	 * 메소드명칭 : findEnsmap
	 * 메소드설명 : 해당 블럭 맵정보
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

	@RequestMapping(value="/ENSH3050/findEnsmap", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse  findEnsmap(@RequestParam(value="locCode" ,required = false) String locCode,
			@RequestParam(value="floorCode" ,required = false) String floorCode,
			@RequestParam(value="roomCode" ,required = false) String roomCode,
			@RequestParam(value="blockNum" ,required = false) int blockNum) throws Exception{

		List<Ensmap> ensmaps = ensmapService.findByLocCodeAndFloorCodeAndRoomCodeAndBlockNumOrderByMapIdxAsc(locCode, floorCode, roomCode, blockNum);

		return CommonListResponseParams.ListResponse.of(ensmaps);
	}

	@RequestMapping(value="/ENSH3050/ensmatrix/{locCode}/{floorCode}/{roomCode}/{blockNum}", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.MapResponse  findEnsmatrix(
				@PathVariable("locCode") String locCode
				, @PathVariable("floorCode") String floorCode
				, @PathVariable("roomCode") String roomCode
				, @PathVariable("blockNum") Integer blockNum
			) throws Exception{

		Ensmatrix ensmatrix = ensmatrixService.findOne(EnsmatrixId.of(locCode, floorCode, roomCode, blockNum));

		return CommonListResponseParams.MapResponse.of(MapUtils.getMap(MapItem.of("ensmatrixVTO", EnsmatrixVTO.of(ensmatrix))));
	}

	@RequestMapping(value="/ENSH3050/ensmap", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse  findEnsmap(
			String locCode
			, String floorCode
			, String roomCode
			, Integer blockNum
			) throws Exception{

		List<EnsmapVTO> ensmapVTOList = ensmapService.getMapInfo(locCode, floorCode, roomCode, blockNum);

		return CommonListResponseParams.ListResponse.of(ensmapVTOList);
	}

	@RequestMapping(value="/ENSH3050/ensmap/{locCode}/{floorCode}/{roomCode}/{blockNum}", method={RequestMethod.POST, RequestMethod.PUT}, produces=APPLICATION_JSON)
	public ApiResponse putEnsmap(
			@PathVariable("locCode") String locCode
			, @PathVariable("floorCode") String floorCode
			, @PathVariable("roomCode") String roomCode
			, @PathVariable("blockNum") Integer blockNum
			, @RequestBody List<EnsmapVTO> ensmapVTOList
			) throws Exception{

		ensmapService.deleteAndSave(locCode, floorCode, roomCode, blockNum, ensmapVTOList);

		return ok();
	}



}