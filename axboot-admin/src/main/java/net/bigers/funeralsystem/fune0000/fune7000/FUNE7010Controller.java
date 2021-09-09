/*****************************************************************************
 * 프로그램명  : FUNE7010Controller.java
 * 설     명  : 빈소 사진 관리 처리 컨트롤러
 * 참고  사항  : 없음
 *****************************************************************************
 * Date       Author  Version Description
 * ---------- ------- ------- -----------------------------------------------
 * 2017.11.17  KYM    1.0     초기작성
 *****************************************************************************/
package net.bigers.funeralsystem.fune0000.fune7000;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.ListResponse;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.MapResponse;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.wordnik.swagger.annotations.ApiOperation;

import net.bigers.funeralsystem.fune0000.domain.binso.BinsoService;
import net.bigers.funeralsystem.fune0000.domain.photo.Photo;
import net.bigers.funeralsystem.fune0000.domain.photo.PhotoService;
import net.bigers.funeralsystem.fune0000.domain.recipe.Recipe;
import net.bigers.funeralsystem.fune0000.vto.RecipeVTO;
import net.bigers.funeralsystem.lib.util.MapUtils;
import net.bigers.funeralsystem.lib.util.MapUtils.MapItem;

@Controller
public class FUNE7010Controller extends BaseController {

	@Autowired
	private BinsoService binsoService;

	@Autowired
	private PhotoService photoService;
	
	/**
	 * 빈소 목록 취득
	 * @param request Request객체
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "빈소 목록", notes = "빈소 목록")
	@RequestMapping(value="/FUNE7010/binso/photo" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public ListResponse binsoPhoto() throws Exception{
		return ListResponse.of(this.binsoService.getBinsoInfoPhoto());
	}
	
	
	/**
	 * 사진 저장
	 * @param Photo
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "식단 저장", notes = "식단 저장")
	@RequestMapping(value="/FUNE7010/photo" , method= RequestMethod.POST, produces=APPLICATION_JSON )
	public MapResponse savePhoto(@RequestBody Photo photo) throws Exception{
		return MapResponse.of(MapUtils.getMap(MapItem.of("photo", this.photoService.savePhoto(photo))));
	}
	
	/**
	 * 사진 삭제
	 * @param photo
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = " 사진 삭제", notes = "사진 삭제")
	@RequestMapping(value="/FUNE7010/photo" , method= RequestMethod.DELETE, produces=APPLICATION_JSON )
	public ApiResponse deletePPhoto(@RequestBody Photo photo) throws Exception{		
		this.photoService.deletePhoto(photo);
		return ok();
	}
	

}
