package net.bigers.funeralsystem.common;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.OutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.AbstractView;


@Component(value="ttsView")
public class TTSView extends AbstractView{

    public TTSView() {
        setContentType("audio/mpeg;charset=utf-8");
    }
    
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		byte[] bytes = (byte[]) model.get("bytes");
		
		
		
		if( bytes != null && bytes.length > 0){
			response.setContentType(getContentType());
			response.setContentLength(bytes.length);
			   
		        String fileName = "tts_" + System.currentTimeMillis() + ".wav";
//		        String fileName = java.net.URLEncoder.encode(model.get("fileName")+"", "UTF-8");
		         		        
		        response.setHeader("Content-Disposition", "attachment;filename=\""+fileName+"\";");
		        response.setHeader("Content-Transfer-Encoding", "binary");
		         
		        OutputStream out = response.getOutputStream();
		        BufferedOutputStream bos = null;
		        ByteArrayInputStream bais = null;
		        BufferedInputStream bis = null;
		         
		        try {
		        	bais = new ByteArrayInputStream(bytes);
		        	bos = new BufferedOutputStream(out);
		        	bis = new BufferedInputStream(bais);
		            int data = -999;
		        	while((data=bis.read()) != -1){
		        		bos.write(data);
		        	}
		        	
		        	bos.flush();
		        	
		        } catch (Exception e) {
		            e.printStackTrace();
		        } finally {
		            if (bos != null) { try { bos.close(); } catch (Exception e2) {}}
		            if (out != null) { try { out.close(); } catch (Exception e2) {}}
		            if (bis != null) { try { bis.close(); } catch (Exception e2) {}}
		            if (bais != null) { try { bais.close(); } catch (Exception e2) {}}
		        }
		}
      
      
	}

}
