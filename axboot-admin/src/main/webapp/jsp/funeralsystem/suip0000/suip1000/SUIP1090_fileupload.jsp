<%@page import="com.axisj.axboot.core.domain.user.AdminLoginUser"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%@ taglib prefix="b" tagdir="/WEB-INF/tags" %>
<ax:layout name="base.jsp">
    <ax:set name="title" value="${PAGE_NAME}" />
    <ax:set name="page_desc" value="${PAGE_REMARK}" />
    <ax:div name="css">
        <style type="text/css">
      		.al-expect-amount{
      		text-align: right;
      		}
        </style>
    </ax:div>
    <ax:div name="contents">
        <ax:row>
            <ax:col>
                <ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}" function2Auth="${FUNCTION_2_AUTH}" function3Auth="${FUNCTION_3_AUTH}" function4Auth="${FUNCTION_4_AUTH}" function5Auth="${FUNCTION_5_AUTH}"></ax:custom>
				
				<b:button  text="파일업로드" id="btn-add-files"></b:button>
										
            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
    	<script type="text/javascript">
            var resize_elements = [
                {id:"page-grid-box", adjust:-85}
            ];
            
            var fnObj = {
            	CODES: {
                	},
                pageStart: function(){
                    this.bindEvent();                 
                },
                bindEvent: function(){
                    var _this = this;        
                    
                    $("#btn-add-files").bind("click", function(){
                    	app.modal.open({
	                        url:"/jsp/funeralsystem/common/fileUpload.jsp",
	                        pars:"callBack=fnObj.ocrlistModalResult",
	                        width:600, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
	                        //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
	                    });
                    });
                },
                ocrlistModalResult: function(files){
                	var list = [];
                	for(var i=0; i<files.length; i++){
                		var item = {};
                		item.docName = files[i].name;
                		item.docPath = files[i].uploadedPath+"/"+files[i].saveName;
                		item.thumbPath = files[i].thumbPath;
                		list.push(item);
                	}
                	fnObj.save(list);
                	app.modal.close();
                },
                save: function(files){
                	app.ajax({
                        type: "POST",
                        url: "/SUIP1090/fileupload",                        
                        data: Object.toJSON(files)
                    }, function(res){
                        if(res.error){
                            alert(res.error.message);
                        }else{
                        }
                    });
                },
            };
        </script>
    </ax:div>
</ax:layout>