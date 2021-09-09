package net.bigers.funeralsystem.common;

import java.io.IOException;
import java.util.Properties;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;

import voiceware.libttsapi;

@Controller
//@RequestMapping(value = "/api/v1/public")
public class TTSController extends BaseController {

	
	@Autowired
	public Properties ttsconfig;
	
	//@Inject
	//MsgSetService msgSetService;
	
	protected Logger logger = Logger.getLogger(this.getClass());
	
	
	
	@RequestMapping(value="/tts", method = RequestMethod.GET , produces=TEXT_PLAIN)
	public String toSound(String msgId, @RequestParam(value="szText", required=false, defaultValue="")String szText , Model model ) throws Exception{
		
		
		int nReturn = 0;
		libttsapi ttsapi = new libttsapi();
		// tts file request test   
			
			
		try {
			ttsapi.SetConnectTimeout(100);
			String msg = "";
			//MsgSet msgSet = msgSetService.findByMsgId(msgId);
			//if(msgSet != null){
			//	msg = msgSet.getMsgContent().replace("$", szText);
			//}
			
//			nReturn = ttsapi.ttsRequestFile("127.0.0.1", 7000, szText , "", "javatest", ttsapi.TTS_HYERYUN_DB, ttsapi.FORMAT_OGG);
//			nReturn = ttsapi.ttsRequestBuffer("127.0.0.1", 7000, szText , ttsapi.TTS_HYERYUN_DB, ttsapi.FORMAT_OGG, 1, 1);
			//nReturn = ttsapi.ttsRequestBuffer("127.0.0.1", 7000, msg , ttsapi.TTS_HYERYUN_DB, ttsapi.FORMAT_OGG, 1, 1);
			//nReturn = ttsapi.ttsRequestBuffer("localhost", 7000, msg , ttsapi.TTS_HYERYUN_DB, ttsapi.FORMAT_WAV, 1, 1);
			//nReturn = ttsapi.ttsRequestBuffer("172.16.22.173", 7000, msg , ttsapi.TTS_HYERYUN_DB, ttsapi.FORMAT_WAV, 1, 1);
			nReturn = ttsapi.ttsRequestBuffer("127.0.0.1", 7000, szText , ttsapi.TTS_HYERYUN_DB, ttsapi.FORMAT_WAV, 1, 1);
			//nReturn = ttsapi.ttsRequestBuffer(ttsconfig.getProperty("tts.ip"), Integer.parseInt(ttsconfig.getProperty("tts.port")), szText , ttsapi.TTS_HYERYUN_DB, ttsapi.FORMAT_OGG, 1, 1);
			logger.info("Current connect timeout = " + ttsapi.GetConnectTimeout() + "(msec)");
		} catch (IOException e) {
			nReturn = -9;
			logger.error(e);
		}
    	  		
		if (nReturn == 1) {
			//logger.info("RequestFile Success!!!");
//			writeByteToFile("output.ogg", ttsapi.szVoiceData, ttsapi.nVoiceLength);
			model.addAttribute("bytes", ttsapi.szVoiceData);
			
		} else {
			//logger.info("RequestFile Failed (" + nReturn + ")!!!");
		}
		
		return "ttsView";
	}
}
