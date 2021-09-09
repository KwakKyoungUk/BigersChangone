package net.bigers.funeralsystem.disp0000.disp0000;

import java.util.List;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;

import com.axisj.axboot.admin.controllers.BaseController;

import net.bigers.funeralsystem.fune0000.domain.binso.Binso;
import net.bigers.funeralsystem.fune0000.domain.binso.BinsoService;
import net.bigers.funeralsystem.fune0000.domain.funeral.Funeral;
import net.bigers.funeralsystem.fune0000.domain.funeral.FuneralService;
import net.bigers.websocket.SessionManager;

@Controller
public class DISP0030Controller extends BaseController{

	@Autowired
	private BinsoService binsoService;

	@Autowired
	@Qualifier("textSessionManager")
	private SessionManager sessionManager;

	@Scheduled(fixedDelay=10000)
	@Transactional
	public void board(){

		if(!sessionManager.containsByUri("/wst/DISP0030")){
			return;
		}

		List<Funeral> displayInfo = this.binsoService.getDisplayInfo();

		displayInfo.stream().forEach(di->{
			sessionManager.sendTextMessageByUri("/wst/DISP0030/"+di.getBinsoCode(), "board", di);
		});


	}


}
