package net.bigers.funeralsystem.common;

import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.awt.image.PixelGrabber;
import java.io.File;
import java.util.Arrays;
import java.util.Date;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.swing.Icon;
import javax.swing.ImageIcon;
import javax.swing.filechooser.FileSystemView;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.FileResponse;
import com.axisj.axboot.core.api.response.ApiResponse;

/**
 *
*
* 기능분류   : 파일 업로드
* 프로그램명 : FileUploadController
* 설      명 : 파일 업로드 공통
* ------------------------------------------
*
* 이력사항 2016. 7. 13. SH 최초작성 <BR/>
 */
@Controller
public class FileUploadController extends BaseController {

	private String[] limitExtension={"jsp", "php", "exe", "bat", "sh", "asp"};

	@Autowired
	private Environment environment;

	@RequestMapping(value="/fileUpload", method=RequestMethod.POST, produces=APPLICATION_JSON)
	public FileResponse postFileUpload(
			HttpServletRequest request
			, MultipartFile part
			) throws Exception{

		//String realPath = request.getRealPath(".");
		HttpSession session = request.getSession();
		String realPath = session.getServletContext().getRealPath(".");


		//업로드 파일 유형을 정함. 빈소 사진은 photo를 넘김
		String uploadType = request.getParameter("uploadType");
		String customerNo = request.getParameter("customerNo");


		String ext = StringUtils.getFilenameExtension(part.getOriginalFilename());
		if(Arrays.asList(limitExtension).contains(ext)){
			throw new Exception(ext + " 확장자를 가진 파일은 업로드 할 수 없습니다.");
		}
		String saveName= "";
		String uploadedPath = "";
		String thumbPath = "";
		File file = null;

		if("photo".equals(uploadType)){
			//사진일 경우 고객 번호에 시간 붙임.
			saveName = customerNo + "_" + System.currentTimeMillis() + "." + ext;
			//일단 경로를 작성. config 에 있는 것 가져오게 수정 요함.  2017-11-17 KYM
//			uploadedPath = "/static/funeral/photo";
			uploadedPath = environment.getProperty("funeralsystem.fileupload.funeral.photo.path");
			File uploadedDir = new File(uploadedPath);
			if(!uploadedDir.exists()){
				uploadedDir.mkdirs();
			}
			file = new File(environment.getProperty("funeralsystem.fileupload.funeral.photo.real.path") + "/" + saveName);
		}else{
			saveName = "temp_" + System.currentTimeMillis() + "." + ext;
			uploadedPath = "/static/temp";
			File uploadedDir = new File(realPath+uploadedPath);
			if(!uploadedDir.exists()){
				uploadedDir.mkdirs();
			}
			file = new File(realPath+uploadedPath + "/" + saveName);
		}


		log.debug("fileName : " + part.getOriginalFilename());
		log.debug("getContentType : " + part.getContentType());
		log.debug("saveName : " + saveName);
		log.debug("getSize : " + part.getSize());
		log.debug("uploadedPath : " + uploadedPath);

		part.transferTo(file);

		int destWidth = 100;
		int destHeight = 100;

		Icon ico = FileSystemView.getFileSystemView().getSystemIcon(file);
		Image image = ((ImageIcon)ico).getImage();
		image = image.getScaledInstance(destWidth, destHeight, Image.SCALE_SMOOTH);

		int pixels[] = new int[destWidth * destHeight];
	    PixelGrabber pg = new PixelGrabber(image, 0, 0, destWidth, destHeight, pixels, 0, destWidth);

	    pg.grabPixels();

		BufferedImage bi = new BufferedImage(destWidth, destHeight, BufferedImage.TYPE_INT_RGB);
		bi.setRGB(0, 0, destWidth, destHeight, pixels, 0, destWidth);

		//파일 확장자 뒤에 또 .gif를 붙임????     일단 제거 KYM 수정 2017-11-17
		/*thumbPath = uploadedPath + "/" + saveName+".gif";
		ImageIO.write(bi, "gif", new File(realPath+thumbPath));*/

		//log.debug("thumbPath : " + thumbPath);

		return FileResponse.of(
						part.getOriginalFilename()
						, part.getContentType()
						, saveName
						, part.getSize()
						, uploadedPath
						, thumbPath
						);
	}

	@RequestMapping(value="/fileDelete", method=RequestMethod.POST, produces=APPLICATION_JSON)
	public ApiResponse postFileDelete(
			HttpServletRequest request
			,@RequestParam Map<String, String> params
			){

		log.debug(params.toString());

		String realPath = request.getRealPath(".");

		File file = new File(realPath+params.get("uploadedPath")+"/"+params.get("saveName"));
		File thumb = new File(realPath+params.get("thumbPath"));

		if(file.exists()){
			file.delete();
			log.debug("file 삭제 완료 : " + file.getPath());
		}

		if(thumb.exists()){
			thumb.delete();
			log.debug("thumb 삭제 완료 : " + thumb.getPath());
		}

		return ok();
	}
}
