package net.bigers.funeralsystem.ensh0000.ensh1000;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.admin.parameter.PageableResponseParams;
import com.axisj.axboot.admin.parameter.PageableResponseParams.PageResponse;
import com.axisj.axboot.core.dto.PageableTO;
import com.axisj.axboot.core.util.DozerBeanMapperUtils;

import net.bigers.funeralsystem.ensh0000.domain.ensdead.EnsdeadService;
import net.bigers.funeralsystem.ensh0000.domain.enshrine.Enshrine;
import net.bigers.funeralsystem.ensh0000.domain.enshrine.EnshrineService;
import net.bigers.funeralsystem.ensh0000.domain.ensmap.EnsmapService;
import net.bigers.funeralsystem.ensh0000.domain.ensret.Ensret;
import net.bigers.funeralsystem.ensh0000.domain.ensret.EnsretService;
import net.bigers.funeralsystem.ensh0000.vto.EnshrineVTO;
import net.bigers.funeralsystem.ensh0000.vto.EnsmapVTO;
import net.bigers.funeralsystem.ensh0000.vto.EnsretMapperVTO;
import net.bigers.funeralsystem.ensh0000.vto.EnsretVTO;
import net.bigers.funeralsystem.ensh0000.vto.EnssuccedVTO;
import net.bigers.funeralsystem.lib.util.MapUtils;
import net.bigers.funeralsystem.lib.util.MapUtils.MapItem;

@Controller
public class ENSH1017Controller extends BaseController  {

	@Autowired
	private EnsretService ensretService;

	@Autowired
	private EnshrineService enshrineService;

	@Autowired
	private EnsdeadService ensdeadService;

	@RequestMapping(value="/ENSH1017/ensret", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public PageableResponseParams.PageResponse getEnsmap(
			@RequestParam Map<String, String> requestBody
			, Pageable pageable
			) throws Exception{

		Page<EnsretMapperVTO> ensretPage = ensretService.findEnsret(requestBody, pageable);
		return PageableResponseParams.PageResponse.of(ensretPage.getContent(), PageableTO.of(ensretPage));

	}

}
