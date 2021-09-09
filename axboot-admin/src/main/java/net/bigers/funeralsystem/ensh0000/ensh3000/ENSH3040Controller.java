package net.bigers.funeralsystem.ensh0000.ensh3000;

import java.util.List;

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

import net.bigers.funeralsystem.ensh0000.domain.ensmatrix.Ensmatrix;
import net.bigers.funeralsystem.ensh0000.domain.ensmatrix.EnsmatrixService;
import net.bigers.funeralsystem.ensh0000.domain.ensroom.Ensroom;
import net.bigers.funeralsystem.ensh0000.domain.ensroom.EnsroomService;
import net.bigers.funeralsystem.ensh0000.vto.EnsmatrixVTO;
import net.bigers.funeralsystem.ensh0000.vto.EnsroomVTO;

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
public class ENSH3040Controller extends BaseController{

	@Autowired
	EnsmatrixService ensmatrixService;
	
	@Autowired 
	EnsroomService ensroomService;
	
	/**
	 * 
	 * 메소드명칭 : findMatrix
	 * 메소드설명 :		
	 * ----------------------------------------
	 * 이력사항 2016. 7. 4. kdh 최초작성
	 *
	 * @param locCode
	 * @param floorCode
	 * @param roomCode
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value="/ENSH3040/findMatrix", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse findMatrix(@RequestParam(value="locCode" ,required = false) String locCode,
			@RequestParam(value="floorCode" ,required = false) String floorCode,
			@RequestParam(value="roomCode" ,required = false) String roomCode) throws Exception{
		
		List<Ensmatrix> ensrooms = null;
		
		if(!"".equals(locCode)){
			ensrooms  =  ensmatrixService.findByLocCodeAndFloorCodeAndRoomCode(locCode, floorCode, roomCode);
		}else{
			 ensrooms =  ensmatrixService.findAll();
		}	
		
		return CommonListResponseParams.ListResponse.of(EnsmatrixVTO.of(ensrooms));
		
	}
	
	/**
	 * 
	 * 메소드명칭 : findMatrix
	 * 메소드설명 :		
	 * ----------------------------------------
	 * 이력사항 2016. 7. 4. kdh 최초작성
	 *
	 * @param locCode
	 * @param floorCode
	 * @param roomCode
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value="/ENSH3040/findMatrixBlock", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public Object findMatrixBlock(@RequestParam(value="locCode" ,required = false) String locCode,
			@RequestParam(value="floorCode" ,required = false) String floorCode,
			@RequestParam(value="roomCode" ,required = false) String roomCode,
		@RequestParam(value="blockNum" ,required = false) int blockNum) throws Exception{
		
		Ensmatrix ensmatrix  =  ensmatrixService.findByLocCodeAndFloorCodeAndRoomCodeAndBlockNum(locCode, floorCode, roomCode, blockNum);
		
		
		return EnsmatrixVTO.of(ensmatrix);
		
	}
	
	/**
	 * 
	 * 메소드명칭 : saveEnsMatrix
	 * 메소드설명 :		
	 * ----------------------------------------
	 * 이력사항 2016. 7. 5. kdh 최초작성
	 *
	 * @param ensmatrixVTO
	 * @return
	 * @throws Exception
	 */
	@Transactional
	@RequestMapping(value="/ENSH3040/saveEnsMatrix", method={RequestMethod.PUT, RequestMethod.POST}, produces=APPLICATION_JSON)
	public ApiResponse saveEnsMatrix(@RequestBody EnsmatrixVTO ensmatrixVTO) throws Exception{		
		
		Ensmatrix ensmatrix = DozerBeanMapperUtils.map(ensmatrixVTO, Ensmatrix.class);
		ensmatrixService.saveEnsMatrix(ensmatrix);
		
		return ok();
	}
	
	/**
	 * 
	 * 메소드명칭 : deleteEnsMatrix
	 * 메소드설명 :		
	 * ----------------------------------------
	 * 이력사항 2016. 7. 5. kdh 최초작성
	 *
	 * @param ensmatrixVTOs
	 * @return
	 * @throws Exception
	 */
	@Transactional
	@RequestMapping(value="/ENSH3040/deleteEnsMatrix", method={RequestMethod.DELETE}, produces=APPLICATION_JSON)
	public ApiResponse deleteEnsMatrix(@RequestBody List<EnsmatrixVTO> ensmatrixVTOs) throws Exception{		
				
		List<Ensmatrix> ensmatrixs = DozerBeanMapperUtils.mapList(ensmatrixVTOs, Ensmatrix.class);		
		ensmatrixService.deleteEnsMatrix(ensmatrixs);
		return ok();
	}
}