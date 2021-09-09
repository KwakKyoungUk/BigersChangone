package net.bigers.funeralsystem.crem0000.crem4000;

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

import net.bigers.funeralsystem.crem0000.domain.rogrp.Rogrp;
import net.bigers.funeralsystem.crem0000.domain.rogrp.RogrpService;
import net.bigers.funeralsystem.crem0000.domain.rogrpchasu.Rogrpchasu;
import net.bigers.funeralsystem.crem0000.domain.rogrpchasu.RogrpchasuService;
import net.bigers.funeralsystem.crem0000.vto.RogrpVTO;
import net.bigers.funeralsystem.crem0000.vto.RogrpchasuVTO;

/**
 *
 * @author SH
 * @file_name OPER1020Controller.java
 *
 * 업무분류 : 운영관리
 * 기능분류 : 화로정보 추가/수정/삭제
 * 프로그램명 : 화로정보 등록
 * 설      명 : 화로 그룹/차수 정보 등록/수정/삭제
 * -----------------------------------------------------------
 *
 * 이력사항
 *     2016. 4. 20. SH 최초작성
 */
@Controller
public class CREM4010Controller extends BaseController{

	@Autowired
	private RogrpService rogrpService;

	@Autowired
	private RogrpchasuService rogrpchasuService;

	/**
	 *
	 *
	 * 메소드 명칭 : findRogrpList
	 * 메소드 설명 : 화로 그룹 정보(전체)
	 * ----------------------------------------------------------
	 *
	 * @return
	 * @throws Exception
	 *
	 * 이력사항
	 *     2016. 4. 20. SH 최초작성
	 */
	@RequestMapping(value="/OPER1020/findRogrpList", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse findRogrp() throws Exception{
		List<Rogrp> data = rogrpService.findAll();
		return CommonListResponseParams.ListResponse.of(RogrpVTO.of(data));
	}


	/**
	 *
	 *
	 * 메소드 명칭 : saveRogrpList
	 * 메소드 설명 : 화로 그룹 저장
	 * ----------------------------------------------------------
	 *
	 * @param rogrpVTOList
	 * @return
	 * @throws Exception
	 *
	 * 이력사항
	 *     2016. 4. 20. SH 최초작성
	 */
	@RequestMapping(value="/OPER1020/saveRogrpList", method={RequestMethod.POST, RequestMethod.PUT}, produces=APPLICATION_JSON)
	public ApiResponse saveRogrpList(@RequestBody List<RogrpVTO> rogrpVTOList) throws Exception{
		rogrpService.save(DozerBeanMapperUtils.mapList(rogrpVTOList, Rogrp.class));
		return ok();
	}

	/**
	 *
	 *
	 * 메소드 명칭 : deleteRogrpList
	 * 메소드 설명 : 화로 그룹 삭제
	 * ----------------------------------------------------------
	 *
	 * @param rogrpVTOList
	 * @return
	 * @throws Exception
	 *
	 * 이력사항
	 *     2016. 4. 21. SH 최초작성
	 */
	@RequestMapping(value="/OPER1020/deleteRogrpList", method={RequestMethod.DELETE}, produces=APPLICATION_JSON)
	public ApiResponse deleteRogrpList(@RequestBody List<RogrpVTO> rogrpVTOList) throws Exception{
		rogrpService.deleteRogrp(DozerBeanMapperUtils.mapList(rogrpVTOList, Rogrp.class));
		return ok();
	}

	/**
	 *
	 *
	 * 메소드 명칭 : findRogrpChasuList
	 * 메소드 설명 : 화로 그룹의 차수 데이터 반환
	 * ----------------------------------------------------------
	 *
	 * @param grpGubun
	 * @return
	 * @throws Exception
	 *
	 * 이력사항
	 *     2016. 4. 20. SH 최초작성
	 */
	@RequestMapping(value="/OPER1020/findRogrpChasuList", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse findRogrpChasuList(@RequestParam String grpGubun) throws Exception{
		List<Rogrpchasu> rogrpchasuList = rogrpchasuService.findByGrpGubun(grpGubun);
		return CommonListResponseParams.ListResponse.of(RogrpchasuVTO.of(rogrpchasuList));
	}

	/**
	 *
	 *
	 * 메소드 명칭 : saveRogrChasuList
	 * 메소드 설명 : 화로 그룹의 차수 데이터 저장
	 * ----------------------------------------------------------
	 *
	 * @param rogrpchasuVTOList
	 * @return
	 * @throws Exception
	 *
	 * 이력사항
	 *     2016. 4. 20. SH 최초작성
	 */
	@RequestMapping(value="/OPER1020/saveRogrpchasuList", method={RequestMethod.POST, RequestMethod.PUT}, produces=APPLICATION_JSON)
	public ApiResponse saveRogrChasuList(@RequestBody List<RogrpchasuVTO> rogrpchasuVTOList) throws Exception{
		rogrpchasuService.save(DozerBeanMapperUtils.mapList(rogrpchasuVTOList, Rogrpchasu.class));
		return ok();
	}

	/**
	 *
	 *
	 * 메소드 명칭 : deleteRogrpchasuList
	 * 메소드 설명 : 화로 그룹 차수 삭제
	 * ----------------------------------------------------------
	 *
	 * @param rogrpchasuVTOList
	 * @return
	 * @throws Exception
	 *
	 * 이력사항
	 *     2016. 4. 21. SH 최초작성
	 */
	@RequestMapping(value="/OPER1020/deleteRogrpchasuList", method={RequestMethod.DELETE}, produces=APPLICATION_JSON)
	public ApiResponse deleteRogrpchasuList(@RequestBody List<RogrpchasuVTO> rogrpchasuVTOList) throws Exception{
		rogrpchasuService.delete(DozerBeanMapperUtils.mapList(rogrpchasuVTOList, Rogrpchasu.class));
		return ok();
	}
 }
