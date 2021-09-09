package net.bigers.funeralsystem.suip0000.suip1000;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;

import net.bigers.funeralsystem.suip0000.domain.appmng.AppMngDataService;
import net.bigers.funeralsystem.suip0000.domain.appmng.AppMngDataSrch;

@Controller
public class SUIP1140Controller extends BaseController{

	@Autowired
	private AppMngDataService appMngDataService;

	@RequestMapping(value="/SUIP1140/appMngCrm", method={RequestMethod.GET})
	public String goView() throws Exception{

		return "jsp/funeralsystem/suip0000/suip1000/SUIP1140";
	}

	@RequestMapping(value="/SUIP1140/appMngCrm", params="actionTp=appMngDataSrchCrmList", method={RequestMethod.POST})
	public String appMngList(AppMngDataSrch appMngDataSrchSearch, Model model) throws Exception{
		AppMngDataSrch appMngDataSrch = appMngDataService.appMngDataSrchCrmInsertDetailBiz(appMngDataSrchSearch);
		model.addAttribute("appMngDataSrchSearch", appMngDataSrchSearch);
		model.addAttribute("appMngDataSrch", appMngDataSrch);
		return "jsp/funeralsystem/suip0000/suip1000/SUIP1140";
	}

	@RequestMapping(value="/SUIP1140/appMngCrm", params="actionTp=appMngDataSrchCrmInsert", method={RequestMethod.POST})
	@Transactional
	public String appMngInsert(AppMngDataSrch appMngDataSrchSearch, Model model, HttpServletRequest request) throws Exception{

		String frmName = request.getParameter("frmName");
		System.out.println("frmName 타이틀 :" + frmName);

		String frmId = request.getParameter("frmId");
		System.out.println("frmId 프로그램id :" + frmId);


		String data = request.getParameter("data");
		System.out.println("조회 후 data 데이터 :" + data);

		//secondData = request.getParameter("seconddata");
		//System.out.println("조회 후 secondData 데이터 :" + data);

		String id = request.getParameter("id");
		System.out.println("id 사번 :" + id);

		String updtime = request.getParameter("updtime");
		System.out.println("updtime 작업일자시간 :" + updtime);

		AppMngDataSrch appMngDataSrch = appMngDataService.appMngDataSrchSqlInsertDetailBiz(appMngDataSrchSearch, frmName, frmId, data, id, updtime);
		appMngDataSrch = appMngDataService.appMngDataSrchCrmInsertDetailBiz(appMngDataSrchSearch);

		//  ms sql server에 insert dbo.TB_PAYMENT 테이블에서 max seq 가져오기
		appMngDataSrchSearch  = this.appMngDataService.appMngDataSrchMaxSeqBiz( appMngDataSrchSearch);
		appMngDataSrchSearch  = this.appMngDataService.appMngDataSrchSecondMaxSeqBiz(appMngDataSrchSearch);


		model.addAttribute("appMngDataSrch", appMngDataSrch);
		model.addAttribute("appMngDataSrchSearch", appMngDataSrchSearch);
		model.addAttribute("msg", "MS Sql Server에 저장이  완료되었습니다.");

		return "jsp/funeralsystem/suip0000/suip1000/SUIP1140";
	}
}