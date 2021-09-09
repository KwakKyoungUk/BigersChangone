package net.bigers.machine;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.axisj.axboot.admin.controllers.BaseController;

@Controller
public class QLightController extends BaseController {

	@RequestMapping(value = "/api/v1/qlight/etn")
	@ResponseBody
	public String etn(String ip, String port, String light, String sound, HttpServletRequest request) throws IOException {
		String realPath = request.getRealPath("");
		Process process = Runtime.getRuntime().exec(realPath+"/static/downloads/ETN.exe " + " " + ip + " " + port + " " + light + " " + sound);
		return "";
	}
}
