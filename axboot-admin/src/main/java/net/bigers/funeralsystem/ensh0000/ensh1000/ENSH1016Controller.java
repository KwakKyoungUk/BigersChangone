package net.bigers.funeralsystem.ensh0000.ensh1000;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.MapResponse;
import com.axisj.axboot.core.util.DozerBeanMapperUtils;

import net.bigers.funeralsystem.ensh0000.domain.ensmap.EnsmapService;
import net.bigers.funeralsystem.ensh0000.vto.EnsmapVTO;
import net.bigers.funeralsystem.ensh0000.vto.EnssuccedVTO;
import net.bigers.funeralsystem.lib.util.MapUtils;
import net.bigers.funeralsystem.lib.util.MapUtils.MapItem;

/**
 *
*
* 업무분류   : 봉안맵 검색
* 기능분류   : 봉안맵 검색
* 프로그램명 : 봉안맵 검색
* 설      명 : 봉안맵 검색 및 봉안 고인 확인
* ------------------------------------------
*
* 이력사항 2016. 7. 25. SH 최초작성 <BR/>
 */
@Controller
public class ENSH1016Controller extends BaseController  {

	@Autowired
	private EnsmapService ensmapService;

	@RequestMapping(value="/ENSH1016/ensmap/{ensType}", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.MapResponse getEnsmap(
			@PathVariable("ensType") String ensType
			) throws Exception{

		EnsmapVTO ensmapVTO = DozerBeanMapperUtils.map(ensmapService.findPossible(ensType), EnsmapVTO.class);

		return CommonListResponseParams.MapResponse.of(MapUtils.getMap(MapItem.<String, Object>of("ensmapVTO", ensmapVTO)));
	}

/*	@RequestMapping(value="/ENSH1016/ensmap/{ensType}/{usingStatus}", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.MapResponse getRetnEnsmap(
			@PathVariable("ensType") String ensType
			) throws Exception{
		return CommonListResponseParams.MapResponse.of(ensmapService.getRetnEnsmap(ensType));
	}*/

	@RequestMapping(value="/ENSH1016/ensmap/{ensType}/{usingStatus}", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getRetnEnsmap(
			@PathVariable("ensType") String ensType
			) throws Exception{

		List<EnsmapVTO> ensmapVTO =  DozerBeanMapperUtils.mapList(ensmapService.getRetnEnsmap(ensType), EnsmapVTO.class);

		return CommonListResponseParams.ListResponse.of(ensmapVTO);
	}

	@RequestMapping(value="/ENSH1016/ensmap/ensRoom", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getEnsRoom(
			@RequestParam ("ensType") String ensType
			) throws Exception{

		List<EnsmapVTO> ensmapVTO =  DozerBeanMapperUtils.mapList(ensmapService.findByEnsRoom(ensType),EnsmapVTO.class);

		return CommonListResponseParams.ListResponse.of(ensmapVTO);
	}


}
