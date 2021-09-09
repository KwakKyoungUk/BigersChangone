package net.bigers.funeralsystem.disp0000.disp0000;

import java.util.Date;
import java.util.List;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;

import com.axisj.axboot.admin.controllers.BaseController;
import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import net.bigers.funeralsystem.fune0000.domain.binso.Binso;
import net.bigers.funeralsystem.fune0000.domain.binso.BinsoService;
import net.bigers.funeralsystem.fune0000.domain.funeral.Funeral;
import net.bigers.funeralsystem.fune0000.domain.funeral.FuneralService;
import net.bigers.websocket.SessionManager;

@Controller
public class DisplayController extends BaseController{

	@Autowired
	@Qualifier("textSessionManager")
	private SessionManager sessionManager;


	@Scheduled(cron="0 0 0 * * *")
	public void board() throws InterruptedException{

		sessionManager.sendTextMessageToAll("refresh", "");

		Thread.sleep(2*60*1000);

	}


}
