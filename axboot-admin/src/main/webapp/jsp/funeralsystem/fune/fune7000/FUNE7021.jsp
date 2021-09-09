<%----------------------------------------------------------------------------------------
 - 파일이름	: FUNE7021.jsp
 - 설      명	: 입관 정보 관리 > 정보 수정 화면
 - 작 성 자		: KYM
 - 추가내용 	:
 - 버전관리	: 1.0
 ----------------------------------------------------------
 - Date        Version   Auther   Description
 ----------------------------------------------------------
 - 2017.11.20  1.0        KYM      신규작성
------------------------------------------------------------------------------------------%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%	
	request.setAttribute("callBack", request.getParameter("callBack"));
	request.setAttribute("customerNo", request.getParameter("customerNo"));
	request.setAttribute("ibkwanDate", request.getParameter("ibkwanDate"));
	
%>
<ax:layout name="modal.jsp">
	<ax:set name="title" value="입관정보수정" />
	<ax:set name="page_desc" value="" />

	<ax:div name="contents">
		<div class="bodyHeightDiv" style="height:325px;">
			<ax:row>
				<ax:col size="12" wrap="true">
					<ax:custom customid="table">
						<ax:custom customid="tr">
									<ax:custom customid="td">
										<table cellpadding="0" cellspacing="0" class="AXGridTable" style="height: 45px;">												    
									    <tbody>
									    	<tr>								    		
									    		<th>
									    			<span id="goin-info" style="font-size: 17px;"></span>								    											    									    			
									    		</th>								    		
									    	</tr>
									    	</tbody>
									    	</table>
									</ax:custom>
							</ax:custom>
					</ax:custom>
	
					<ax:custom customid="table">
						<ax:custom customid="tr">
							<ax:custom customid="td">
								<table cellpadding="0" cellspacing="0" class="AXGridTable">												    
								    <tbody>
								    	<tr>
								    		<td rowspan="4" style='width:25%;padding:0 0 0 0;line-height: 0px;'>								    			
								    			<img id="goin_img" width='0' height='0' src=""/>
								    		</td>
								    		<th style='width:20%;'>입관일시
								    		</th>
								    		<td>
								    			<input type="text" id="info-ibkwan-date" name="info-ibkwan-date" title="입관일자" class="AXInput" style="text-align:center;"/>
								    			&nbsp;
								    			<input type="text" id="info-ibkwan-time" name="info-ibkwan-time" title="입관시간" class="AXInput" style="text-align:center;"/>							    			
								    		</td>												    														    		
								    	</tr>
								    	
								    	<tr>
								    		<th>상례사
								    		</th>
								    		<td>
								    			<select id="info-ibkwan-person01" name="info-ibkwan-person01" class="AXSelect W100"></select>
								    		</td>												    		
								    	</tr>
								    	<tr>
								    		<th>상례사
								    		</th>
								    		<td>
								    			<select id="info-ibkwan-person02" name="info-ibkwan-person02" class="AXSelect W100"></select>
								    		</td>												    		
								    	</tr>
								    	<tr>
								    		<th>입관실
								    		</th>
								    		<td>
								    			<select id="info-ibkwan-code" name="info-ibkwan-code" class="AXSelect W100"></select>
								    		</td>												    		
								    	</tr>												    	
								    </tbody>
								</table>
							</ax:custom>
						</ax:custom>
					</ax:custom>
		                    							
				</ax:col>
			</ax:row>
</div>
	</ax:div>
	<ax:div name="buttons">
		<button type="button" class="AXButton" onclick="fnObj.control.save();">변경</button>
		<button type="button" class="AXButton" onclick="fnObj.control.cancel();">닫기</button>
	</ax:div>

	<ax:div name="scripts">
		<script type="text/javascript">
			var customerNo = "${customerNo}"
			var parentIbkwanDate = "${ibkwanDate}"

			var fnObj = {
                CODES: {
                	ibkwan_code	: Common.getCodeByUrl("/FUNE7021/code/gubunCd?ibkwanGubun=03")
                	,person			: Common.getCode("117")
                },			
				pageStart: function(){
					parent.myModal.resize();
					this.bindEvent();
					this.searchCustomerInfo();
				},				
				pageResize: function(){
					parent.myModal.resize();
				},
				bindEvent: function(){
					//각 컨트롤 바인드
					$("#info-ibkwan-date").bindDate();
					$("#info-ibkwan-time").bindPattern({pattern: "time"});
					
					$("#info-ibkwan-code").bindSelect({
                        options:fnObj.CODES.ibkwan_code
                    });
				   $("#info-ibkwan-person01").bindSelect({
                       options:fnObj.CODES.person,                       
                       isspace: true, 
                       isspaceTitle: "전체",
                       setValue:"ALL",
                   });
				   $("#info-ibkwan-person02").bindSelect({
                       options:fnObj.CODES.person,                       
                       isspace: true, 
                       isspaceTitle: "전체",
                       setValue:"ALL",
                   });
				},
				//고인 정보 취득
				searchCustomerInfo: function(){
					app.ajax({
                        type: "GET",
                        url: "/FUNE7021/ibkwan?customerNo="+ customerNo,
                        data: ""
                    },
                    function(res){
                    	if(res.error){
                    		alert(res.error.message);
                    	}else{                    		
                    		var goin = res.customerNo + "  |  " + res.thedead.deadName + "  |  " + res.binso.binsoName + "  |  " + res.balinDate
                    		$("#goin-info").html(goin);
                    		
                    		$("#info-ibkwan-date").val(res.ibkwanDate.substring(0,10));
                    		$("#info-ibkwan-time").val(res.ibkwanDate.substring(11,16));
                    		if(res.photo){
                    			$("#info-ibkwan-person01").bindSelectSetValue(res.photo.person01);
             				   	$("#info-ibkwan-person02").bindSelectSetValue(res.photo.person02);
								$("#info-ibkwan-code").bindSelectSetValue(res.photo.ibkwanCode);
								$("#goin_img").attr("src", res.photo.photoImage);
								$("#goin_img").attr("width", "130");
								$("#goin_img").attr("height", "125");
																								
								//이유는 모르겠으나 창이 열리면서 콤보 위치(top)가 이상해짐. 강제로 위치 조정.
								/*var person01_obj 		= $("#AXselect_AX_info-ibkwan-person01").offset();
								var person02_obj 		= $("#AXselect_AX_info-ibkwan-person02").offset();
								var ibkwan_code_obj 	= $("#AXselect_AX_info-ibkwan-code").offset();
								 $("#AXselect_AX_info-ibkwan-person01").css("top", person01_obj.top+14);
								$("#AXselect_AX_info-ibkwan-person02").css("top", person02_obj.top+14);
								$("#AXselect_AX_info-ibkwan-code").css("top", ibkwan_code_obj.top+14); */
                    		}else{
                    			$("#goin_img").attr("src", "/static/ui/bigers/images/profile.png");
								$("#goin_img").attr("width", "130");
								$("#goin_img").attr("height", "125");
                    		}
                    	}
                    });
				},
				control: {
					save: function(){
						var funeral = {
								customerNo	: customerNo,
								ibkwanDate : $("#info-ibkwan-date").val() + " " + $("#info-ibkwan-time").val() + ":00",
								photo			: {
									customerNo	: customerNo,
									person01	: $("#info-ibkwan-person01").val(),
									person02	: $("#info-ibkwan-person02").val(),
									ibkwanCode	: $("#info-ibkwan-code").val()
								}
						}
												
						app.ajax({
                            type: "POST",
                            url: "/FUNE7021/funeral/ibkwan",
                            data: Object.toJSON(funeral)
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{                        		
                        		app.modal.save("${callBack}", "ibkwanDate=" + parentIbkwanDate);
                            }
                        });						
					},
					cancel: function(){
						app.modal.cancel();
					}
				}
			};
			axdom(document.body).ready(function() {
				fnObj.pageStart();				
			});
//			axdom(window).resize(fnObj.pageResize);
		</script>
	</ax:div>
</ax:layout>