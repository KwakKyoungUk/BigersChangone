package net.bigers.funeralsystem.disp0000.disp0000;

import java.util.ArrayList;
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
public class DISP0012Controller extends BaseController{

	@Autowired
	private FuneralService funeralService;

	@Autowired
	@Qualifier("textSessionManager")
	private SessionManager sessionManager;

	private Pageable pageRequest = new PageRequest(0, 6);

	@Scheduled(fixedDelay=15000)
	@Transactional
	public void board(){

		if(!sessionManager.containsByUri("/wst/DISP0012/1") && !sessionManager.containsByUri("/wst/DISP0012/2")){
			return;
		}

		Page<Funeral> displayInfo = this.funeralService.getDisplayInfo(pageRequest);

		int firstIdx = displayInfo.getContent().size() < 3 ? displayInfo.getContent().size() : 3;
		int secondIdx = -1;

		if(displayInfo.getContent().size() >= 3){
			secondIdx = displayInfo.getContent().size() < 6 ? displayInfo.getContent().size() : 6;
		}


		List<Funeral> first = displayInfo.getContent().subList(0, firstIdx);
		List<Funeral> second = secondIdx < 0 ? new ArrayList<>(0) : displayInfo.getContent().subList(3, secondIdx);

		sessionManager.sendTextMessageByUri("/wst/DISP0012/1", "board", new Object() {
			@Getter
			@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "MM월 dd일 (E) a HH:mm", timezone = "Asia/Seoul")
			private Date now = new Date();
			@Getter
			private List<Funeral> content = first;
		});
		sessionManager.sendTextMessageByUri("/wst/DISP0012/2", "board", new Object() {
			@Getter
			@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "MM월 dd일 (E) a HH:mm", timezone = "Asia/Seoul")
			private Date now = new Date();
			@Getter
			private List<Funeral> content = second;
		});

		if(displayInfo.hasNext()) {
			this.pageRequest = pageRequest.next();
		}else {
			this.pageRequest = pageRequest.first();
		}
	}


}
