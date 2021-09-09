package net.bigers.funeralsystem.stan0000.stan1000;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.PageableResponseParams;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.axisj.axboot.core.dto.PageableTO;
import com.axisj.axboot.core.util.DozerBeanMapperUtils;

import net.bigers.funeralsystem.stan0000.domain.docform.Docform;
import net.bigers.funeralsystem.stan0000.domain.docform.DocformService;
import net.bigers.funeralsystem.stan0000.vto.DocformVTO;

/**
*
* @author kdh
* @file_name STAN1040Controller.java
*
* 업무분류 : 기준
* 기능분류 : 서식기준정보관리
* 프로그램명 : STAN1040Controller
* 설      명 : 서식정보 추가/수정/삭제
* -----------------------------------------------------------
*
* 이력사항
*     2016. 6. 14. kdh 최초작성
*/

@Controller
public class STAN1040Controller extends BaseController{

	@Autowired
	private  DocformService docformService;

	/**
	 *
	 *
	 * 메소드 명칭 : findDoc
	 * 메소드 설명 : 서식 목록 출력
	 * ----------------------------------------------------------
	 *
	 * @param searchParams
	 * @return
	 * @throws Exception
	 *
	 * 이력사항
	 *     2016. 6. 14. kdh 최초작성
	 */
	@RequestMapping(value="/STAN1040/findDoc", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public PageableResponseParams.PageResponse findDoc(Pageable pageable
			, @RequestParam(value = "condition") String condition
			, @RequestParam(value = "searchParams") String searchParams) throws Exception{

		Page<Docform> docformList = docformService.findDoc(condition,searchParams,pageable);

		return PageableResponseParams.PageResponse.of(DocformVTO.of(docformList.getContent()), PageableTO.of(docformList));

	}

	/**
	 *
	 *
	 * 메소드 명칭 : saveDoc
	 * 메소드 설명 : 서식정보 저장
	 * ----------------------------------------------------------
	 *
	 * @param docformVTO
	 * @return
	 * @throws Exception
	 *
	 * 이력사항
	 *     2016. 6. 14. kdh 최초작성
	 */
	@RequestMapping(value="/STAN1040/saveDoc", method={RequestMethod.PUT, RequestMethod.POST}, produces=APPLICATION_JSON)
	public ApiResponse saveDoc(@RequestBody DocformVTO docformVTO) throws Exception{
		docformService.save(DozerBeanMapperUtils.map(docformVTO, Docform.class));
		return ok();
	}

	/**
	 *
	 *
	 * 메소드 명칭 : deleteDoc
	 * 메소드 설명 : 서식정보 삭제
	 * ----------------------------------------------------------
	 *
	 * @param facIds
	 * @return ApiResponse ok
	 * @throws Exception
	 *
	 * 이력사항
	 *     2016. 6. 14. kdh 최초작성
	 */
	@RequestMapping(value="/STAN1040/deleteDoc", method={RequestMethod.DELETE}, produces=APPLICATION_JSON)
	public ApiResponse deleteFac(@RequestParam(value="docCode") String docCode) throws Exception{
		docformService.delete(docCode);
		return ok();
	}

}