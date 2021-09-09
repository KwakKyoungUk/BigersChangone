package net.bigers.funeralsystem.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;

@Controller
public class CommonController {

	@Autowired
	private CommonService commonService;

	@Scheduled(fixedDelay=1000)
	void esky() {
		commonService.crematereserve();
	}
}
