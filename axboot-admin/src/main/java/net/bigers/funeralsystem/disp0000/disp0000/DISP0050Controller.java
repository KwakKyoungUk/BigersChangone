package net.bigers.funeralsystem.disp0000.disp0000;

import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;

import com.axisj.axboot.admin.controllers.BaseController;

import net.bigers.funeralsystem.fune0000.domain.funeral.Funeral;
import net.bigers.funeralsystem.fune0000.domain.funeral.FuneralService;
import net.bigers.websocket.SessionManager;

@Controller
public class DISP0050Controller extends BaseController{

	@Autowired
	private FuneralService funeralService;

	@Autowired
	@Qualifier("textSessionManager")
	private SessionManager sessionManager;

	@Scheduled(fixedDelay=3000)
	@Transactional
	public void board(){

		if(!sessionManager.containsByUri("/wst/DISP0050")){
			return;
		}

		Funeral funeral = this.funeralService.getCurrentBalinFuneral();

		sessionManager.sendTextMessageByUri("/wst/DISP0050", "board", funeral);

	}


}
