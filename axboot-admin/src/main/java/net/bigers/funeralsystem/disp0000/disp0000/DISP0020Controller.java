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
import org.springframework.data.domain.Sort;
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

/**
 *
 * 안치실 현황판 1080p
 * ------------------------------------------
 *
 * 이력사항 2018. 2. 1. kdh 최초작성<BR/>
 */
@Controller
public class DISP0020Controller extends BaseController{

	@Autowired
	private FuneralService funeralService;

	@Autowired
	@Qualifier("textSessionManager")
	private SessionManager sessionManager;

	private Pageable pageRequest = new PageRequest(0, 5, new Sort(Sort.Direction.ASC, "ibkwanDate"));

	private final String[] sort = {"01", "03", "05", "07", "09", "11", "13", "15", "17", "02", "04", "06", "08", "10", "12", "14", "16", "18"};

	@Scheduled(fixedDelay=10000)
	@Transactional
	public void board(){

		if(!sessionManager.containsByUri("/wst/DISP0020")){
			return;
		}

		Page<Funeral> _list = this.funeralService.getAnchiInfo(pageRequest);
		Page<Funeral> allPage = this.funeralService.getAnchiInfo(new PageRequest(0, 50));
		List<Funeral> _all = new ArrayList<Funeral>(18);

		for(String anchiRoom : this.sort) {
			Funeral funeral = null;
			for(Funeral f : allPage.getContent()) {
				if(anchiRoom.equals(f.getAnchiRoom())) {
					funeral = f;
				}
			}
			_all.add(funeral);
		}

		sessionManager.sendTextMessageByUri("/wst/DISP0020", "board", new Object() {
			@Getter
			@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy년 MM월 dd일 (E) a HH:mm", timezone = "Asia/Seoul")
			private Date now = new Date();
			@Getter
			@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
			private Date now2 = new Date();
			@Getter
			private List<Funeral> all = _all;
			@Getter
			private List<Funeral> list = _list.getContent();
		});

		if(_list.hasNext()) {
			this.pageRequest = pageRequest.next();
		}else {
			this.pageRequest = pageRequest.first();
		}
	}


}
