<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%
	request.setAttribute("callBack", request.getParameter("callBack"));
%>
<ax:layout name="modal.jsp">
	<ax:set name="title" value="파일업로드" />
	<ax:set name="page_desc" value="" />

	<ax:div name="contents">
		<ax:row>
			<ax:col size="12" wrap="true">


                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-table"></i> 파일업로드</h2>
                    </div>
                    <div class="ax-clear"></div>
                </div>
				<div class="AXUpload5" id="AXUpload5"></div>
				<div class="H10"></div>
				<div id="uploadQueueBox" class="AXUpload5QueueBox" style="height:188px;"></div>
			</ax:col>
		</ax:row>

	</ax:div>
	<ax:div name="buttons">
		<button type="button" class="AXButton" onclick="fnObj.control.save();">저장</button>
		<button type="button" class="AXButton" onclick="fnObj.control.cancel();">취소</button>
	</ax:div>

	<ax:div name="scripts">
		<script type="text/javascript">

			var fnObj = {
                CODES: {
                },
				limitExtension:["jsp", "php", "exe", "bat", "sh", "asp"],
				canUpload: function(extension){
					for(var i=0; i<this.limitExtension.length; i++){
						if(this.limitExtension[i]==extension){
							return false;
						}
					}
					return true;
				},
				pageStart: function(){
					this.upload.init();
					this.bindEvent();
				},
				pageResize: function(){
					parent.myModal.resize();
				},
				bindEvent: function(){
				},
				upload: {
                    init: function(){
                    	myUpload = new AXUpload5();
                        myUpload.setConfig({
                            targetID:"AXUpload5",
                            targetButtonClass:"Green",
                            uploadFileName:"part",
                            file_types:"*/*",  //audio/*|video/*|image/*|MIME_type (accept)
                            dropBoxID:"uploadQueueBox",
                            queueBoxID:"uploadQueueBox", // upload queue targetID
                            //queueBoxAppendType:"(prepend || append)",
                            // html 5를 지원하지 않는 브라우저를 위한 swf upload 설정 원치 않는 경우엔 선언 하지 않아도 됩니다. ------- s
                            flash_url : Common.page.host()+"/static/plugins/axisj/lib/swfupload.swf",
                            flash9_url : Common.page.host()+"/static/plugins/axisj/lib/swfupload_fp9.swf",
                            flash_file_types:"*.*",
                            flash_file_types_description:"all",

                            // --------- e
                            onClickUploadedItem: function(){ // 업로드된 목록을 클릭했을 때.
                                //trace(this);
                                window.open(this.uploadedPath.dec() + this.saveName.dec(), "_blank", "width=500,height=500");
                            },

                            uploadMaxFileSize:(10*1024*1024), // 업로드될 개별 파일 사이즈 (클라이언트에서 제한하는 사이즈 이지 서버에서 설정되는 값이 아닙니다.)
                            uploadMaxFileCount:10, // 업로드될 파일갯수 제한 0 은 무제한
                            uploadUrl:"/fileUpload",
                            uploadPars:{userID:'tom', userName:'액시스'},
                            deleteUrl:"/fileDelete",
                            deletePars:{userID:'tom', userName:'액시스'},

                            buttonTxt:"파일올리기",

                            fileKeys:{ // 서버에서 리턴하는 json key 정의 (id는 예약어 사용할 수 없음)
                                name:"name",
                                type:"type",
                                saveName:"saveName",
                                fileSize:"fileSize",
                                uploadedPath:"uploadedPath",
                                thumbPath:"thumbPath" // 서버에서 키값을 다르게 설정 할 수 있다는 것을 확인 하기 위해 이름을 다르게 처리한 예제 입니다.
//                                 thumbPath:"thumbUrl" // 서버에서 키값을 다르게 설정 할 수 있다는 것을 확인 하기 위해 이름을 다르게 처리한 예제 입니다.
                            },

                            onbeforeFileSelect: function(){
								trace(4);
//                                 trace(this);
//                                 console.log(this);
                                return true;
                            },

                            onUpload: function(){
                                //trace(this);
                                trace(myUpload.uploadedList);
                                //trace("onUpload");
								trace(1);
                            },
                            onComplete: function(){
                                //trace(this);
                                //trace("onComplete");
//                                 $("#uploadCancelBtn").get(0).disabled = true; // 전송중지 버튼 제어
								trace(2);
                            },
                            onStart: function(){
                            	for(var i=0; i<this.length; i++){
                            		var ext = this[i].file.name.substr(this[i].file.name.lastIndexOf(".")+1);
                            		if(!fnObj.canUpload(ext)){
                            			alert(ext + " 확장자를 가진 파일은 업로드 할 수 없습니다.");
                            			myUpload.cancelUpload();
                            			return;
                            		}
                            	}
// 								trace(3);
// 								if(fnObj.canUpload(extension))
// 								myUpload.cancelUpload();
                                //trace(this);
                                //trace("onStart");
//                                 $("#uploadCancelBtn").get(0).disabled = false; // 전송중지 버튼 제어
                            },
                            onDelete: function(){
                                trace(this);
                                //trace("onDelete");
                            },
                            onError: function(errorType, extData){
                                if(errorType == "html5Support"){
                                    //dialog.push('The File APIs are not fully supported in this browser.');
                                }else if(errorType == "fileSize"){
                                    //trace(extData);
                                    alert("파일사이즈가 초과된 파일을 업로드 할 수 없습니다. 업로드 목록에서 제외 합니다.\n("+extData.name+" : "+extData.size.byte()+")");
                                }else if(errorType == "fileCount"){
                                    alert("업로드 갯수 초과 초과된 아이템은 업로드 되지 않습니다.");
                                }
                            }
                        });
                        // changeConfig

                        // 서버에 저장된 파일 목록을 불러와 업로드된 목록에 추가 합니다. ----------------------------- s
//                         var url = "fileListLoad.php";
//                         var pars = "dummy="+axf.timekey();
//                         new AXReq(url, {pars:pars, onsucc:function(res){
//                             if(!res.error){
//                                 myUpload.setUploadedList(res);
//                             }else{
//                                 alert(res.msg.dec());
//                             }
//                         }});
                        // 서버에 저장된 파일 목록을 불러와 업로드된 목록에 추가 합니다. ----------------------------- e

                    },
        			printMethodReturn: function(method, type){
        				var list = myUpload[method](type);
//         				trace(list);
//         				toast.push(Object.toJSON(list));
        			},
        			changeOption: function(){
        				// 업로드 갯수 등 업로드 관련 옵션을 동적으로 변경 할 수 있습니다.
        				myUpload.changeConfig({
        					/*
        					uploadUrl:"uploadFile.asp",
        					uploadPars:{userID:'tom', userName:'액시스'},
        					deleteUrl:"deleteFile.asp",
        					deletePars:{userID:'tom', userName:'액시스'},
        					*/
        					uploadMaxFileCount:10
        				});

        			}
        		},
				control: {
					save: function(){

						app.modal.save("${callBack}", myUpload.uploadedList);

					},
					cancel: function(){
						app.modal.cancel();
					}
				}
			};
			axdom(document.body).ready(function() {
				fnObj.pageStart();
			});
			axdom(window).resize(fnObj.pageResize);
		</script>
	</ax:div>
</ax:layout>