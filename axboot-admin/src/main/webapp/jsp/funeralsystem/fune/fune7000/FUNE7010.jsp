<%----------------------------------------------------------------------------------------
 - 파일이름	: FUNE7010.jsp
 - 설      명	: 빈소 사진 관리 화면
 - 작 성 자		: KYM
 - 추가내용 	:
 - 버전관리	: 1.0
 ----------------------------------------------------------
 - Date        Version   Auther   Description
 ----------------------------------------------------------
 - 2017.11.17  1.0        KYM      신규작성
------------------------------------------------------------------------------------------%>
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
             .button_group.vertical button{
            	width:144px;
            	height: 50px;
            	margin: 5px;
            	margin-bottom: 15px;
            	font-size: 18px;
            }
            .button_group.vertical.fixed{
            	right: 30px;
            	width: 150px;
            	text-align: center;
            }
             .binso{
            	margin: 5px;
            }
            .binso.assigned table td{
            	color: black;
            	background-color: white;
            }
            .binso.not_assigned table td{
            	color: gray;
            	background-color: lightgray;
            }
            .part.assigned td{
            	color: black;
            	background-color: white;
            }
            .part.not_assigned td{
            	color: gray;
            	background-color: lightgray;
            }
            .binso_list .binso.on, .each_sale .binso.on{
            	border: 4px solid blue;
            }
            .binso_list .binso.off, .each_sale .binso.off{
            	border: 1px solid black;
            }
           	.binso_list .part.on.assigned td, .each_sale .part.on.assigned td{
            	background-color: lightgray;
            }
            .binso_list .part.off.assigned td, .each_sale .part.off.assigned td{
            	background-color: white;
            }
            .binso_list .binso_title, .each_sale .binso_title{
            	font-size: 20px;
            	font-weight: bolder;
            }
            .money, .cnt{
            	text-align: right;
            }
            .absolute {
            	position: absolute;
            }
            .relative{
            	position: relative;
            }
            .fixed{
            	position: fixed;
            }
        </style>
    </ax:div>
    <ax:div name="contents">
        <ax:row>
            <ax:col>
                <ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}" function2Auth="${FUNCTION_2_AUTH}" function3Auth="${FUNCTION_3_AUTH}" function4Auth="${FUNCTION_4_AUTH}" function5Auth="${FUNCTION_5_AUTH}"></ax:custom>

				<ax:custom customid="table">
                    <ax:custom customid="tr">
                        <ax:custom customid="td">
							<table style="width: 100%;">
								<tr>
									<td class="binso_list">
									</td>
								</tr>
							</table>

                        </ax:custom>

                        <ax:custom customid="td" style="width:150px;" >
                        	<div class="button_group vertical fixed">
                        		<div class="AXUpload5" id="AXUpload5" style="display: none;"></div>
	                        	<b:button  text="사진업로드" id="btn-photo-upload"></b:button>
	                        	<b:button  text="사진삭제" id="btn-photo-del"></b:button>
                        	</div>
						</ax:custom>


                    </ax:custom>
                </ax:custom>


            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
    	<script type="text/javascript">
            var pb_data={
            		//선택 고객번호
                	selectedCustomerNo		: "",
                	selectedBinso				: "",
                	filePhoto						:[],
                	prePhotoImage				: "",
                	selectedIbkwanCode		: "",
                	selectedPerson01			: "",
                	selectedPerson02			: ""

            }
            var fnObj = {
            		upload:{
            			init:function(){
            				photoUpload = new AXUpload5();
            				photoUpload.setConfig({
            					isSingleUpload:true, // 싱글 모드
            					targetID:"AXUpload5",
            					targetButtonClass:"white",
            					uploadFileName:"part",
            					buttonTxt: "사진업로드",
            					fileDisplayHide: true,
            					file_types:"*/*",  //audio/*|video/*|image/*|MIME_type (accept)
            					// html 5를 지원하지 않는 브라우저를 위한 swf upload 설정 원치 않는 경우엔 선언 하지 않아도 됩니다. ------- s
            					flash_url : Common.page.host()+"/static/plugins/axisj/lib/swfupload.swf",
                            	flash9_url : Common.page.host()+"/static/plugins/axisj/lib/swfupload_fp9.swf",
            					// --------- e
            					onClickUploadedItem: function(){ // 업로드된 목록을 클릭했을 때.
            						//trace(this);
            						window.open(this.uploadedPath.dec() + this.saveName.dec(), "_blank", "width=500,height=500");
            					},

            					uploadMaxFileSize:(10*1024*1024), // 업로드될 개별 파일 사이즈 (클라이언트에서 제한하는 사이즈 이지 서버에서 설정되는 값이 아닙니다.)
            					uploadMaxFileCount:0, // 업로드될 파일갯수 제한 0 은 무제한 싱글모드에선 자동으로 1개

            					uploadUrl:"/fileUpload",
                                uploadPars:{"uploadType":"photo", "customerNo":pb_data.selectedCustomerNo},
                                deleteUrl:"/fileDelete",
                                deletePars:{userID:'tom', userName:'액시스'},

            					fileKeys:{ // 서버에서 리턴하는 json key 정의 (id는 예약어 사용할 수 없음)
            						name:"name",
            						type:"type",
            						saveName:"saveName",
            						fileSize:"fileSize",
            						uploadedPath:"uploadedPath",
            						thumbPath:"thumbUrl"
            					},
            					onComplete: function(){
            						//trace(this);
            						trace("onComplete");
            						pb_data.filePhoto = photoUpload.uploadedList;
            						fnObj.eventFunc.savePhoto();
            					},
            					onStart: function(){
            						//trace(this);
            						trace("onStart");

            					},
            					onDelete: function(){

            					},
            					onError: function(errorType, extData){
            						if(errorType == "html5Support"){
            							//dialog.push('The File APIs are not fully supported in this browser.');
            						}else if(errorType == "fileSize"){
            							trace(extData);
            							alert("파일사이즈가 초과된 파일을 업로드 할 수 없습니다. 업로드 목록에서 제외 합니다.\n("+extData.name+" : "+extData.size.byte()+")");
            						}else if(errorType == "fileCount"){
            							alert("업로드 갯수 초과 초과된 아이템은 업로드 되지 않습니다.");
            						}
            					}
            				});

            			}
            		}

            		,template: {
                    	keywords: [
                    		"[binsoName]"
                    		, "[binsoCode]"
                    		, "[deadName]"
                    		, "[customerNo]"
                    		, "[balinDate]"
                    		,"[photoImage]"
                    		,"[photoImageCd]"
                    		,"[photoImageWidth]"
                    		,"[photoImageHeight]"
                    		,"[ibkwanCode]"
                    		,"[person01]"
                    		,"[person02]"
                    	]
                    	, binso:
                    			"<div style='width: 230px; height:150px; display: inline-block;' class='binso off [assigned]' onclick='fnObj.eventFunc.selectBinso(this, \"[binsoCode]\", \"[customerNo]\",\"[photoImageCd]\", \"[ibkwanCode]\", \"[person01]\", \"[person02]\")'>"+
    				               	"<table class='AXFormTable' style='height:100%;'>"+
    				               		"<colgroup>"+
    				               			"<col/>"+
    				               			"<col width=120>"+
    				               		"</colgroup>"+
    				            		"<tr>"+
	    				            		"<th><div class='tdRel binso_title'>[binsoName]&nbsp;</div>"+
					            			"</th>"+
    				            			"<td rowspan='3' style='padding:0 0 0 0;line-height: 0px;'><div class='tdRel'><img width='[photoImageWidth]' height='[photoImageHeight]' src='[photoImage]'/></div>"+
    				            			"</td>"+
    				            		"</tr>"+
    				            		"<tr>"+
	    				            		"<td><div class='tdRel' style='text-align:center;'>[deadName]&nbsp;</div>"+
					            			"</td>"+
    				            		"</tr>"+
    				            		"<tr>"+
				            			"<td><div class='tdRel' style='text-align:center;'>[balinDate]&nbsp;</div>"+
				            			"</td>"+
				            		"</tr>"+
    				            	"</table>"+
    				        	"</div>"
    					, deleteKeywords: function(str){
    						return str.replace(/\[[^\[.*\]]*/gi, "").replace(/\]/g, "");
    					}
                    },
                pageStart: function(){
                	//this.search.bind();
                	this.drawBinsoList();
                    this.bindEvent();

                },
                drawBinsoList: function() {
                	//기선택 자료 초기화
                	pb_data.selectedCustomerNo = "";
                	pb_data.selectedBinso 			= "";
                	pb_data.filePhoto 				= [];
                	pb_data.selectedIbkwanCode = "";
             		pb_data.selectedPerson01		= "";
             		pb_data.selectedPerson02		= "";

                	app.ajax({
                        type: "GET",
                        url: "/FUNE7010/binso/photo",
                        data: ""
                    },
                    function(res){
                    	if(res.error){
                    		alert(res.error.message);
                    	}else{
							console.log("##",res)
                    		var binsoList = [];

                            $.each(res.list, function(i, o){

                            	var binso = fnObj.template.binso.replace("[binsoName]", o.displayBinso);
                            	binso = binso.replace("[binsoCode]", o.binsoCode);

                            	if(o.funeral){
	                            	binso = binso.replace("[customerNo]", o.funeral.customerNo);
	                            	binso = binso.replace("[deadName]", o.funeral.thedead.deadName);
	                            	binso = binso.replace("[balinDate]", o.funeral.balinDate.date().print("mm월dd일"));
                            	}
                            	if(o.photo){
                            		if(o.photo.photoImage){
	                            		binso = binso.replace("[photoImage]", o.photo.photoImage);
	                            		binso = binso.replace("[photoImageCd]", o.photo.photoImage);
	                            		binso = binso.replace("[photoImageWidth]", 119);
	                            		binso = binso.replace("[photoImageHeight]", 148);
                            		}

                            		binso = binso.replace("[ibkwanCode]", o.photo.ibkwanCode);
                            		binso = binso.replace("[person01]", o.photo.person01);
                            		binso = binso.replace("[person02]", o.photo.person02);
                            	}else{
                            		binso = binso.replace("[photoImage]", "");
                            		binso = binso.replace("[photoImageWidth]", 0);
                            		binso = binso.replace("[photoImageHeight]", 0);

                            	}
                            	binso = fnObj.template.deleteKeywords(binso);

								binsoList.push(binso);
                            });

                            $(".binso_list").html(binsoList.join(""));

                            //$(".money").number(true, 0);
                        }
                    });
                },
                bindEvent: function(){
                    var _this = this;
                    $("#ax-page-btn-search").bind("click", function(){
                        _this.drawBinsoList();
                    });
                    $("#btn-photo-upload").bind("click", fnObj.eventFunc.photoUpload);
                    $("#btn-photo-del").bind("click", fnObj.eventFunc.photoDel);
                },
                eventFunc: {
                	selectBinso: function(el, binsoCode, customerNo,photoImage,ibkwanCode,person01,person02){
                		$(".binso_list .binso.on, .each_sale .binso.on").removeClass("on").addClass("off");
                		$(el).removeClass("off");
                		$(el).addClass("on");
                		pb_data.selectedBinso 			= binsoCode;
                		pb_data.selectedCustomerNo 	= customerNo;
                		pb_data.prePhotoImage 		= photoImage;
                		pb_data.selectedIbkwanCode = ibkwanCode;
                 		pb_data.selectedPerson01		= person01;
                 		pb_data.selectedPerson02		= person02;

                		//화면 로딩시 초기화 하면 업로드 파라미터를 인식 못함. 선택된 고객이 있을때 초기화 함.
                		fnObj.upload.init();
                        //업로드 기본 버튼 숨기기
                        $("#AXUpload5_AX_selector").hide();
                	},
                	//사진업로드 팝업 호출
                	photoUpload: function(){
                		if(pb_data.selectedBinso !== "" && $.trim(pb_data.selectedCustomerNo)  === ""){
							alert("빈소에 고객정보가 없습니다.");
							return;
						}else if($.trim(pb_data.selectedCustomerNo)  === ""){
							alert("선택한 고객이 없습니다.");
							return;
						}
                		//업로드 버튼 강제 클릭
						$("#AXUpload5_AX_selector").click();
                	},
                	//디비에 저장
                	savePhoto:function(){
                		//일단 파일 삭제 후 업로드
                		var docSaveName;
                		var docPath;
                		if(pb_data.prePhotoImage !== ""){
                			docSaveName 	= pb_data.prePhotoImage.substr(pb_data.prePhotoImage.lastIndexOf("/")+1);
                			docPath 			= pb_data.prePhotoImage.substr(0, pb_data.prePhotoImage.lastIndexOf("/"));
                			var item = {};
                    		item.saveName 	= docSaveName;
                    		item.uploadedPath = docPath;
                    		console.log("item~~",item)
	                   		  app.ajax({
	                                type: "POST",
	                                url: "/fileDelete?"+$.param(item),
	                                async: false,
	                                data: ""
	                             }, function(res){
	                                 if(res.error){
	                                     alert(res.error.message);
	                                 }
	                                 else{
	                                 }
	                             });
                		}
                		/****************************************************************************/
                		//기존 값 그대로 세팅
                		var savePhoto = {
                				customerNo 	: pb_data.selectedCustomerNo,
                				ibkwanCode 	: pb_data.selectedIbkwanCode,
                				person01 		: pb_data.selectedPerson01,
                				person02 		: pb_data.selectedPerson02,
                				photoImage 	: pb_data.filePhoto[0].uploadedPath + "/" +  pb_data.filePhoto[0].saveName ,
                				photoUpdate 	: ""
                		}

                	 	app.ajax({
                            type: "POST",
                            url: "/FUNE7010/photo",
                            async: false,
                            data: Object.toJSON(savePhoto)
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{
                        		var photoInfo = {};
                        		photoInfo = $.extend(true, {}, res.map.photo);
                        		pb_data.selectedCustomerNo = photoInfo.customerNo;
                        		pb_data.prePhotoImage 		= photoInfo.photoImage;
                        		fnObj.drawBinsoList();
                            }
                        });
                	},
                	//사진 삭제
                	photoDel: function(){
                		if(pb_data.selectedBinso !== "" && $.trim(pb_data.selectedCustomerNo)  === ""){
							alert("빈소에 고객정보가 없습니다.");
							return;
						}else if($.trim(pb_data.selectedCustomerNo)  === ""){
							alert("선택한 고객이 없습니다.");
							return;
						}else if(pb_data.prePhotoImage === ""){
							alert("삭제할 사진이 없습니다.");
							return;
						}

                		var docSaveName;
                		var docPath;
                		if(pb_data.prePhotoImage === ""){
                			docSaveName 	= pb_data.filePhoto[0].saveName;
                			docPath			= pb_data.filePhoto[0].uploadedPath;
                		}else{
                			docSaveName 	= pb_data.prePhotoImage.substr(pb_data.prePhotoImage.lastIndexOf("/")+1);
                			docPath 			= pb_data.prePhotoImage.substr(0, pb_data.prePhotoImage.lastIndexOf("/"));
                		}
                		var item = {};
                		item.saveName 		= docSaveName;
                		item.uploadedPath 	= docPath;

               		  app.ajax({
                            type: "POST",
                            url: "/fileDelete?"+$.param(item),
                            async: false,
                            data: ""
                         }, function(res){
                             if(res.error){
                                 alert(res.error.message);
                             }
                             else{
                            	 var photo = {
                         				customerNo 	: pb_data.selectedCustomerNo,
                         				ibkwanCode 	: pb_data.selectedIbkwanCode,
                         				person01 		: pb_data.selectedPerson01,
                         				person02 		: pb_data.selectedPerson02,
                         				photoImage 	: docPath + "/" +  docSaveName,
                         				photoUpdate 	: ""
                         		}

                         	 	app.ajax({
                                     type: "DELETE",
                                     url: "/FUNE7010/photo",
                                     async: false,
                                     data: Object.toJSON(photo)
                                 },
                                 function(res){
                                 	if(res.error){
                                 		alert(res.error.message);
                                 	}else{
                                 		pb_data.selectedCustomerNo = "";
                                 		pb_data.prePhotoImage 		= "";
                                 		pb_data.selectedBinso 			= "";
                                 		pb_data.selectedIbkwanCode = "";
                                 		pb_data.selectedPerson01		= "";
                                 		pb_data.selectedPerson02		= "";
                                     	pb_data.filePhoto 				= [];
                                 		fnObj.drawBinsoList();

                                     }
                                 });
                             }
                         });

                	}
                }


            };
        </script>
    </ax:div>
</ax:layout>