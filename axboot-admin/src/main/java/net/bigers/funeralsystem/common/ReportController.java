package net.bigers.funeralsystem.common;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.pdfbox.multipdf.PDFMergerUtility;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;

import net.bigers.funeralsystem.lib.util.MapUtils;
import net.bigers.funeralsystem.lib.util.MapUtils.MapItem;
import net.bigers.funeralsystem.lib.util.SpringUtils;

/**
 *
*
* 기능분류   : 레포트 관련
* 프로그램명 : 레포트
* 설      명 : 레포트 url 등 레포트 관련 기능
* ------------------------------------------
*
* 이력사항 2016. 7. 12. SH 최초작성 <BR/>
 */
@Controller
public class ReportController  extends BaseController {

	@Autowired
	private Environment environment;


	@RequestMapping(value="/report/url", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.MapResponse getUrl(
				HttpServletRequest request
			){
		return CommonListResponseParams.MapResponse.of(MapUtils.getMap(MapItem.of("url", environment.getProperty("report.url")+request.getQueryString())));
	}

	@RequestMapping(value="/api/v1/public/report", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public void getPublicReport(
			HttpServletRequest request
			, HttpServletResponse response
			, @RequestParam("reportUnit") String reportUnit
			, @RequestParam("output") String output
			) throws Exception{
		this.getReport(request, response, reportUnit, output);
	}

	@RequestMapping(value="/report", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public void getReport(
			HttpServletRequest request
			, HttpServletResponse response
			, @RequestParam("reportUnit") String reportUnit
			, @RequestParam("output") String output
			) throws Exception{

		URL url = new URL(environment.getProperty("report.url")+request.getQueryString());

		HttpURLConnection con = (HttpURLConnection)url.openConnection();

		con.setRequestMethod("GET");
		int responseCode = con.getResponseCode();
		response.setContentType(con.getContentType());
		response.setContentLength(con.getContentLength());
		response.setStatus(responseCode);

		String ext = null;
		switch(output){
		case "pdf":
			ext = "pdf";
			break;
		case "excel":
			ext = "xls";
			break;
		}

		response.setHeader( "Content-Disposition", "filename=" + reportUnit.substring(reportUnit.lastIndexOf("/")+1)+"."+ext);

		System.out.println("GET Response Code :: " + responseCode);

		if (responseCode == HttpURLConnection.HTTP_OK) { // success

			try(
					BufferedInputStream in = new BufferedInputStream(con.getInputStream())
					; BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream())
					){
				int data = -999;
				while((data=in.read())!=-1){
					out.write(data);
				}
			};

		} else {
			response.getOutputStream().close();
		}

		con.disconnect();

	}

	/**
	 *
	 * ----------------------------------------------------------------
	 * 메소드 설명 : 2개이상의 pdf를 합쳐서 서버 내에 저장 후 리다이렉트를 이용하여 pdf페이지를 띄운다.
	 * 이력사항 2016. 11. 22. SH 최초작성 <BR/>
	 * ----------------------------------------------------------------
	 * @param request
	 * @param response
	 * @param reportQueryList
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/report/merge/pdf", method={RequestMethod.POST})
	public String mergePdf(
			HttpServletRequest request
			, HttpServletResponse response
//			, @RequestParam("reportQuery") List<String> reportQueryList
			, @RequestParam("url[]") List<String> querys
			) throws Exception{

		PDFMergerUtility merger = new PDFMergerUtility();
		List<PDDocument> documents = new ArrayList<PDDocument>();

		int responseCode = -1;

		for(String query : querys){

//			String querytSplit[] =query.split("__");
//			StringBuilder str =  new StringBuilder();
//			for (int i = 0; i < querytSplit.length; i++) {
//				if(querytSplit[i].indexOf("=") != -1){
//					String enc = querytSplit[i].substring(querytSplit[i].indexOf("=")+1, querytSplit[i].length());
//					str.append(querytSplit[i].substring(0, querytSplit[i].indexOf("="))+"="+URLEncoder.encode(enc, "UTF-8")+"&");
//				}
//			}

//			rep

			URL url = new URL(environment.getProperty("report.url")+query);

			HttpURLConnection con = (HttpURLConnection)url.openConnection();

			con.setRequestMethod("GET");

			responseCode = con.getResponseCode();
			if(responseCode != 200){
				break;
			}
			documents.add(PDDocument.load(con.getInputStream()));
			con.disconnect();
		}

		for(int i=1; i<documents.size(); i++){
			merger.appendDocument(documents.get(0), documents.get(i));
		}

		if (responseCode == HttpURLConnection.HTTP_OK) { // success

			File pdf = new File(SpringUtils.getRealPath()+"\\temp\\pdf_"+System.currentTimeMillis()+".pdf");

			documents.get(0).save(pdf);
			for(int i=0; i<documents.size(); i++){
				documents.get(i).close();
			}
			return redirect("/temp/"+pdf.getName());

		}

		return "";
	}

	/**
	 *
	 * ----------------------------------------------------------------
	 * 메소드 설명 : 2개이상의 pdf를 합쳐서 서버 내에 저장 후 리다이렉트를 이용하여 pdf페이지를 띄운다.
	 * 이력사항 2016. 11. 22. SH 최초작성 <BR/>
	 * ----------------------------------------------------------------
	 * @param request
	 * @param response
	 * @param reportQueryList
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/report/merge/pdf", method=RequestMethod.GET)
	public String mergePdfGet(
			HttpServletRequest request
			, HttpServletResponse response
			, @RequestParam("reportQuery") List<String> reportQueryList
			) throws Exception{

		PDFMergerUtility merger = new PDFMergerUtility();
		List<PDDocument> documents = new ArrayList<PDDocument>();

		int responseCode = -1;

		for(String query : reportQueryList){

			String querytSplit[] =query.split("__");
			StringBuilder str =  new StringBuilder();
			for (int i = 0; i < querytSplit.length; i++) {
				if(querytSplit[i].indexOf("=") != -1){
					String enc = querytSplit[i].substring(querytSplit[i].indexOf("=")+1, querytSplit[i].length());
					str.append(querytSplit[i].substring(0, querytSplit[i].indexOf("="))+"="+URLEncoder.encode(enc, "UTF-8")+"&");
				}
			}

			URL url = new URL(environment.getProperty("report.url")+str);

			HttpURLConnection con = (HttpURLConnection)url.openConnection();

			con.setRequestMethod("GET");

			responseCode = con.getResponseCode();
			if(responseCode != 200){
				break;
			}
			documents.add(PDDocument.load(con.getInputStream()));
			con.disconnect();
		}

		for(int i=1; i<documents.size(); i++){
			merger.appendDocument(documents.get(0), documents.get(i));
		}

		if (responseCode == HttpURLConnection.HTTP_OK) { // success

			File pdf = new File(SpringUtils.getRealPath()+"\\temp\\pdf_"+System.currentTimeMillis()+".pdf");

			documents.get(0).save(pdf);
			for(int i=0; i<documents.size(); i++){
				documents.get(i).close();
			}
			return redirect("/temp/"+pdf.getName());

		}

		return "";
	}

	/**
	 *
	 * 메소드명칭 : downloadExcel
	 * 메소드설명 :
	 * ----------------------------------------
	 * 이력사항 2017. 12. 16. sh 최초작성
	 *
	 * @param body
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/report/excel", method=RequestMethod.POST)
	public String downloadExcel(String filename, String excelFormat, HttpServletResponse response, Model model) throws Exception {

		model.addAttribute("excelFormat", excelFormat);
		model.addAttribute("filename", filename);
//		response.getOutputStream().write(excelFormat.getBytes());
//		response.getOutputStream().close();
		return "static/common/excelTemplate";
	}

}
