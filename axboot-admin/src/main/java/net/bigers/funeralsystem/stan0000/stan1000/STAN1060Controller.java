package net.bigers.funeralsystem.stan0000.stan1000;


import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.ListResponse;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.axisj.axboot.core.util.DozerBeanMapperUtils;

import net.bigers.funeralsystem.crem0000.domain.envset.Envset;
import net.bigers.funeralsystem.crem0000.domain.envset.EnvsetId;
import net.bigers.funeralsystem.crem0000.domain.envset.EnvsetService;
import net.bigers.funeralsystem.crem0000.vto.EnvsetVTO;

/**
 *
 * @author SH
 * @file_name STAN1060Controller.java
 *
 * 업무분류 : 운영
 * 기능분류 : 운영환경 등록
 * 프로그램명 : STAN1060Controller
 * 설      명 : 운영 환경 추가/수정/삭제
 * -----------------------------------------------------------
 *
 * 이력사항
 *     2016. 4. 26. SH 최초작성
 */
@Controller
public class STAN1060Controller extends BaseController{

	@Autowired
	private EnvsetService envsetService;

	/**
	 *
	 *
	 * 메소드 명칭 : findEnvset
	 * 메소드 설명 : 운영환경 목록 반환
	 * ----------------------------------------------------------
	 *
	 * @param from
	 * @param to
	 * @return
	 * @throws Exception
	 *
	 * 이력사항
	 *     2016. 4. 26. SH 최초작성
	 */
	@RequestMapping(value="/STAN1060/findEnvset", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public ListResponse findEnvset(@DateTimeFormat(pattern="yyyy-MM-dd") Date from, @DateTimeFormat(pattern="yyyy-MM-dd") Date to) throws Exception{
		List<Envset> list = envsetService.findByWorkDateBetween(from, to);
		return ListResponse.of(EnvsetVTO.of(list));
	}

	/**
	 *
	 *
	 * 메소드 명칭 : saveEnvset
	 * 메소드 설명 : 운영환경 저장
	 * ----------------------------------------------------------
	 *
	 * @param envsetVTO
	 * @return
	 * @throws Exception
	 *
	 * 이력사항
	 *     2016. 4. 26. SH 최초작성
	 */
	@RequestMapping(value="/STAN1060/saveEnvset", method={RequestMethod.PUT, RequestMethod.POST}, produces=APPLICATION_JSON)
	public ApiResponse saveEnvset(@RequestBody EnvsetVTO envsetVTO) throws Exception{
		envsetService.save(DozerBeanMapperUtils.map(envsetVTO, Envset.class));
		return ok();
	}

	/**
	 *
	 *
	 * 메소드 명칭 : deleteEnvset
	 * 메소드 설명 : 운영환경 삭제
	 * ----------------------------------------------------------
	 *
	 * @param envsetVTO
	 * @return
	 * @throws Exception
	 *
	 * 이력사항
	 *     2016. 4. 26. SH 최초작성
	 */
	@RequestMapping(value="/STAN1060/deleteEnvset", method={RequestMethod.DELETE}, produces=APPLICATION_JSON)
	public ApiResponse deleteEnvset(@RequestBody EnvsetVTO envsetVTO) throws Exception{
		envsetService.delete(EnvsetId.of(envsetVTO.getWorkDate(), envsetVTO.getSeqNo()));;
		return ok();
	}


}
