package net.bigers.funeralsystem.crem0000.crem3000;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.axisj.axboot.core.domain.code.BasicCodeService;
import com.axisj.axboot.core.util.DozerBeanMapperUtils;
import com.axisj.axboot.core.vto.BasicCodeVTO;

import net.bigers.funeralsystem.crem0000.DisplayConstants;
import net.bigers.funeralsystem.crem0000.domain.hwaBrazier.HwaBrazier;
import net.bigers.funeralsystem.crem0000.domain.hwaBrazier.HwaBrazierService;
import net.bigers.funeralsystem.crem0000.domain.msgset.Msgset;
import net.bigers.funeralsystem.crem0000.domain.msgset.MsgsetService;
import net.bigers.funeralsystem.crem0000.domain.tts.Tts;
import net.bigers.funeralsystem.crem0000.domain.tts.TtsService;
import net.bigers.funeralsystem.crem0000.vto.HwaBrazierVTO;
import net.bigers.funeralsystem.crem0000.vto.MsgsetVTO;
import net.bigers.funeralsystem.crem0000.vto.TtsVTO;

/**
 *
 * @author user
 * @file_name CREM3010Controller.java
 *
 * 업무분류 : 화장진행
 * 기능분류 : 화장진행
 * 프로그램명 : CREM3010Controller
 * 설      명 : 화장 현재 상태 및 메세지 방송 기능
 * -----------------------------------------------------------
 *
 * 이력사항
 *     2016. 3. 24. user 최초작성
 */
@Controller
@Transactional
public class CREM3010Controller extends BaseController{

	@Autowired
	private HwaBrazierService hwaBrazierService;

	@Autowired
	private MsgsetService msgsetService;

	@Autowired
	private TtsService ttsService;

	@Autowired
	private BasicCodeService basicCodeService;

	/**
	 *
	 *
	 * 메소드 명칭 : findHwaBrazier
	 * 메소드 설명 : 관리자 페이지 - 화장진행 첫번째 그리드
	 * ----------------------------------------------------------
	 *
	 * 이력사항
	 *     2016. 3. 24. user 최초작성
	 */
	@RequestMapping(value="/CREM3010/findHwaBrazier", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse findHwaBrazier() throws Exception{
		List<HwaBrazier> list = hwaBrazierService.findTodaysData();
		return CommonListResponseParams.ListResponse.of(HwaBrazierVTO.of(list));
	}

	/**
	 *
	 *
	 * 메소드 명칭 : findMsgsetByMsgType
	 * 메소드 설명 : 메시지 형태로 메세지 데이터 반환
	 * ----------------------------------------------------------
	 *
	 * @param msgType
	 * @return
	 * @throws Exception
	 *
	 * 이력사항
	 *     2016. 3. 24. user 최초작성
	 */
	@RequestMapping(value="/CREM3010/findMsgsetByMsgType", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse findMsgsetByMsgType(String msgType) throws Exception{
		List<Msgset> list = msgsetService.findByMsgType(msgType);
		return CommonListResponseParams.ListResponse.of(MsgsetVTO.of(list));
	}

	/**
	 *
	 *
	 * 메소드 명칭 : saveTTS
	 * 메소드 설명 : 방송
	 * ----------------------------------------------------------
	 *
	 * @param ttsVTO
	 * @return
	 * @throws Exception
	 *
	 * 이력사항
	 *     2016. 3. 24. user 최초작성
	 */
	@RequestMapping(value="/CREM3010/saveTTS", method=RequestMethod.POST, produces=APPLICATION_JSON)
	public ApiResponse saveTTS(@RequestBody TtsVTO ttsVTO) throws Exception{
		ttsService.save(DozerBeanMapperUtils.map(ttsVTO, Tts.class));
		return ok();
	}

	/**
	 *
	 *
	 * 메소드 명칭 : updateHwaStatus
	 * 메소드 설명 :
	 * ----------------------------------------------------------
	 *
	 * @param params
	 * @return
	 * @throws Exception
	 *
	 * 이력사항
	 *     2016. 3. 24. SH 최초작성
	 */
	@RequestMapping(value="/CREM3010/updateHwaStatus", method=RequestMethod.POST, produces=APPLICATION_JSON)
	public ApiResponse updateHwaStatus(@RequestBody HwaBrazierVTO hwaBrazierVTO) throws Exception{
		hwaBrazierService.updateHwaStatus(DozerBeanMapperUtils.map(hwaBrazierVTO, HwaBrazier.class));
		return ok();
	}

	/**
	 *
	 *
	 * 메소드 명칭 : findBurnStatus
	 * 메소드 설명 : 그리드 select 항목
	 * ----------------------------------------------------------
	 *
	 * @param hwaBrazierVTO
	 * @return
	 * @throws Exception
	 *
	 * 이력사항
	 *     2016. 3. 28. SH 최초작성
	 */
	@RequestMapping(value="/CREM3010/findBurnStatus", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse findBurnStatus() throws Exception{
		return CommonListResponseParams.ListResponse.of(BasicCodeVTO.of(basicCodeService.findByBasicCd(DisplayConstants.BASIC_CODE_MASTER_BURN_STA)));
	}

	/**
	 *
	 *
	 * 메소드 명칭 : findMsgType
	 * 메소드 설명 : 그리드 select 항목
	 * ----------------------------------------------------------
	 *
	 * @return
	 * @throws Exception
	 *
	 * 이력사항
	 *     2016. 3. 28. user 최초작성
	 */
	@RequestMapping(value="/CREM3010/findMsgType", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse findMsgType() throws Exception{
		return CommonListResponseParams.ListResponse.of(BasicCodeVTO.of(basicCodeService.findByBasicCd(DisplayConstants.BASIC_CODE_MESSAGE_TYPE)));
	}
 }
