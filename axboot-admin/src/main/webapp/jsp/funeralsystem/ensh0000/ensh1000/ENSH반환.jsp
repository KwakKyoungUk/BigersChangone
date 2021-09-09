<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%
	request.setAttribute("callBack", request.getParameter("callBack"));
%>
<ax:layout name="modal.jsp">
	<ax:set name="title" value="반환" />
	<ax:set name="page_desc" value="" />

	<ax:div name="contents">
		<ax:row>
			<ax:col size="12" wrap="true">


                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-table"></i> 반환관리</h2>
                    </div>
                    <div class="right">
                        <button type="button" class="AXButton" id="btn-return-new"><i class="axi axi-plus-circle"></i> 신규</button>
                    	<button type="button" class="AXButton" id="btn-return-delete"><i class="axi axi-minus-circle"></i> 삭제</button>
                    	<button type="button" class="AXButton" id="btn-return-save"><i class="axi axi-save"></i> 저장</button>
                    </div>
                    <div class="ax-clear"></div>
                </div>

				<div id="div-grid-ensdead" style="height: 300px;"></div>
                <ax:form id="form-info-return" name="form-info-return" method="get">
                                        <input type="hidden" id="info-return-ensDateString" name="ensDateString"/>
                                        <input type="hidden" id="info-return-ensSeq" name="ensSeq"/>
                                        <input type="hidden" id="info-return-deadSeq" name="deadSeq"/>
		                        		<ax:fields>
		                                    <ax:field label="반환일자" style="width:200px;">
		                                        <input type="text" id="info-return-retDateString" name="retDateString" title="반환일자" maxlength="10" placeholder="반환일자" class="AXInput W100 av-required" value="" />
		                                    </ax:field>
		                                    <ax:field label="연번" style="width:150px;">
		                                        <input type="text" id="info-return-retSeq" name="retSeq" title="연번" maxlength="10" placeholder="연번" class="AXInput W100" value="" readonly="readonly" />
		                                    </ax:field>
		                                    <ax:field label="사용시작일" style="width:150px;">
		                                        <input type="text" id="info-return-strDateString" name="strDateString" title="사용시작일" maxlength="10" placeholder="사용시작일" class="AXInput W100" value="" />
		                                    </ax:field>
		                                    <ax:field label="사용종료일" style="width:150px;">
		                                        <input type="text" id="info-return-endDateString" name="endDateString" title="사용종료일" maxlength="10" placeholder="사용종료일" class="AXInput W100" value="" />
		                                    </ax:field>
		                        		</ax:fields>
		                        		<ax:fields>
		                                    <ax:field label="수납액" style="width:200px;">
		                                        <input type="number" id="info-return-receiptAmt" name="receiptAmt" title="수납액" maxlength="15" placeholder="사용료" class="AXInput W100 av-required" value="" />
		                                    </ax:field>
		                                    <ax:field label="반환율" style="width:150px;">
		                                        <input type="number" id="info-return-retRate" name="retRate" title="반환율" maxlength="3" placeholder="반환율" class="AXInput W100" value="" />
		                                    </ax:field>
		                                    <ax:field label="반환금액" style="width:150px;">
		                                        <input type="number" id="info-return-retAmt" name="retAmt" title="반환금액" maxlength="15" placeholder="반환금액" class="AXInput W100" value="" />
		                                    </ax:field>
		                                    <ax:field label="반환방법" style="width:150px;">
		                                        <input type="text" id="info-return-retMethod" name="retMethod" title="반환방법" maxlength="10" placeholder="반환방법" class="AXInput W100" value="" />
		                                    </ax:field>
		                        		</ax:fields>
		                        		<ax:fields>
		                                    <ax:field label="반환계좌" style="width:98%;">
		                                        <input type="text" id="info-return-retAccno" name="retAccno" title="반환계좌" maxlength="100" placeholder="반환계좌" class="AXInput" style="width: 98%;" value="" />
		                                    </ax:field>
		                        		</ax:fields>
		                        		<ax:fields>
		                                    <ax:field label="반환사유" style="width:98%;">
		                                        <input type="text" id="info-return-retReason" name="retReason" title="반환사유" maxlength="200" placeholder="반환사유" class="AXInput W100" value="" style="width:98%;" />
		                                    </ax:field>
		                        		</ax:fields>
	                        		</ax:form>




			</ax:col>
		</ax:row>

	</ax:div>
	<ax:div name="buttons">
<!-- 		<button type="button" class="AXButton" onclick="fnObj.control.save();">저장</button> -->
		<button type="button" class="AXButton" onclick="fnObj.control.cancel();">닫기</button>
	</ax:div>

	<ax:div name="scripts">
		<jsp:include page="/jsp/funeralsystem/common/postcode.jsp"></jsp:include>
		<script type="text/javascript">
			var enshrine = null;
			var fnObj = {
				 CODES: {
	                    "deadSex": Common.getCode("TCM05"),
				 },


				pageStart: function(){

					this.bindEvent();
					this.gridEnsdead.bind();
					this.formEnsret.bind();
					this.gridEnsdead.setPage();

				},
				pageResize: function(){
					parent.myModal.resize();
				},
				bindEvent: function(){

					$("#info-return-ensDateString").val("${param.ensDate}");
					$("#info-return-ensSeq").val("${param.ensSeq}");


					$("#btn-return-new").bind("click",function(){

						var item = fnObj.gridEnsdead.target.getSelectedItem();
                        if(item.error){
                        	toast.push("고인을 선택해주세요.");
                        	return;
                        }
                        if($("#info-return-retSeq").val() != "" && $("#info-return-deadSeq").val() != ""){
                        	toast.push("반환처리 된 고인입니다.");
                        	return;
                        }

                		var ensDateString = "${param.ensDate}";
						var ensSeq =  "${param.ensSeq}";
						var retnDate = $("#info-return-retDateString").val();
						var deadSeq = fnObj.gridEnsdead.target.getSelectedItem().item.deadSeq;




						fnObj.formEnsret.clear();
						$("#info-return-deadSeq").val(deadSeq);
						$("#info-return-ensDateString").val(ensDateString);
						$("#info-return-ensSeq").val(ensSeq);
						$("#info-return-retDateString").bindDate();
						retnDate != ""	? $("#info-return-retDateString").val(retnDate) : $("#info-return-retDateString").val(new Date().print());

						$("#info-return-receiptAmt").val(enshrine.charge);
						$("#info-return-strDateString").val(enshrine.extStrDateString).blur();
						$("#info-return-endDateString").val(enshrine.extEndDateString).blur();
						app.ajax({
	                        type: "GET",
	                        url: "/ENSH1010/retlist/"+$("#info-return-strDateString").val().date().print("yyyymmdd")+"/"+$("#info-return-retDateString").val().date().print("yyyymmdd"),
	                        data: ""
	                    },
	                    function(res){
	                    	if(res.error){
	                    		alert(res.error.message);
	                    	}else{
	                    		if(res.map.retlistVTO == null){
	                    			toast.push("감면율이 등록되지 않았습니다.");
	                    			return;
	                    		}
	                    		$("#info-return-retRate").val(res.map.retlistVTO.retRate);
	                    		$("#info-return-retAmt").val(($("#info-return-receiptAmt").val() * res.map.retlistVTO.retRate / 100).toFixed(0));
	                        }
	                    });
					});
					$("#btn-return-delete").bind("click",function(){
						fnObj.formEnsret.del();
					});
					$("#btn-return-save").bind("click",function(){
						fnObj.formEnsret.save();
					});
					$("#info-return-strDateString").bindDate();
					$("#info-return-endDateString").bindDate();

				},
                searchApplicantModalResult: function(applicant){
                	var applId = $("#info-enssucced-applId").val();
                	for(var key in applicant){
                		$("#info-enssucced-"+key).val(applicant[key]);
                		$("#info-enssucced-"+key).bindSelectSetValue(applicant[key]);
                	}
                	var succId = $("#info-enssucced-applId").val();
                	$("#info-enssucced-applId").val(applId);
                	$("#info-enssucced-succId").val(succId);

               		app.modal.target.close();
                },
                formEnsret: {
                    target: $('#form-info-return'),
                    validate_target: new AXValidator(),
                    bind: function() {
                        var _this = this;

                        this.validate_target.setConfig({
                            targetFormName : "form-info-return"
                        });

                    },
                    setJSON: function(item) {
                        var _this = this;

                        // 수정시 입력 방지 처리 필드 처리
//                         $('#info-key').attr("readonly", "readonly");

                        var info = $.extend({}, item);
                        app.form.fillForm(_this.target, info, 'info-return-');
                        // 추가적인 값 수정이 필요한 경우 처리
                        // $('#info-useYn').bindSelectSetValue( info.useYn );
                    },
                    getJSON: function() {
                        return app.form.serializeObjectWithIds(this.target, 'info-return-');
                    },
                    clear: function() {
                        app.form.clearForm(this.target);
                    },
                    save: function(){

                    	if(!confirm("반환자료를 저장하시겠습니까?")){

     						return;
     					}

                    	var validateResult = fnObj.formEnsret.validate_target.validate();
                        if (!validateResult) {
                            var msg = fnObj.formEnsret.validate_target.getErrorMessage();
                            axf.alert(msg);
                            fnObj.formEnsret.validate_target.getErrorElement().focus();
                            return false;
                        }

                    	app.ajax({
                            type: "PUT",
                            url: "/ENSH1010/ensret",
                            data: Object.toJSON(fnObj.formEnsret.getJSON())
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else
                            {
                                toast.push("저장하였습니다.");
                                fnObj.gridEnsdead.setPage();
                                parent.fnObj.searchEnshrine.submit();
                            }
                        });
                    },
                    del: function(){
                    	app.ajax({
                            type: "DELETE",
                            url: "/ENSH1010/ensret/"+Common.str.replaceAll($("#info-return-retDateString").val(), "-", "")
                            		+"/"+Common.str.replaceAll($("#info-return-retSeq").val(), "-", "") ,
                            data: ""
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else
                            {
                                toast.push("삭제되었습니다.");
                                fnObj.formEnsret.clear();
                                parent.fnObj.searchEnshrine.submit();
                            }
                        });
                    }
                },
                gridEnsdead: {
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "div-grid-ensdead",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                //{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"deadName", label:"고인명", width:"150", align:"center"},
                                {key:"deadJumin", label:"주민번호", width:"200", align:"center"
                                	, formatter: function(val){
                                		return Common.pattern.custom(this.value, "999999-9999999");
                                	}
                                },
                                {key:"deadDateString", label:"사망일자", width:"100", align:"center"
                                	, formatter: function(val){
                                		if(this.value){
	                                		return this.value.date().print("yyyy-mm-dd");
                                		}else{
                                			return "";
                                		}
                                	}
                                },
                                {key:"deadSex", label:"성별", width:"100", align:"center"
                                	, formatter:function(val){
                                		for(var i=0; i<fnObj.CODES.deadSex.length; i++){
                                			if(this.value == fnObj.CODES.deadSex[i].optionValue){
                                				return fnObj.CODES.deadSex[i].optionText;
                                			}
                                		}
                                	}
                                },
                            ],
                            body : {
                                onclick: function(){
									console.log(this)
									//$("#form-info [id^='info-dead']").val("");
									fnObj.formEnsret.clear();

	                                if(enshrine.ensType == "TFM1000003"){
	                                	 fnObj.formEnsret.setJSON(enshrine.ensdeadVTOList[0].ensretVTO);
	                                	$("#info-return-deadSeq").val(1);
	                                }else{
	                                	 fnObj.formEnsret.setJSON(this.item.ensretVTO);
	                                	$("#info-return-deadSeq").val(this.item.deadSeq);
	                                }

	                            	$("#info-return-ensDateString").val("${param.ensDate}");
	            					$("#info-return-ensSeq").val("${param.ensSeq}");


                                }
                            },
                            page: {
                                display: false,
                                paging: false
                            }
                        });
                        fnObj.gridEnsdead.target.setData({list:[{}]});
                        //fnObj.gridEnsdead.target.setFocus(0);
                    },
                    setPage: function(pageNo, searchParams){

                    	 var _target = this.target;
                    	 app.ajax({
                 			async: false,
                             type: "GET",
                             url: "/ENSH1010/enshrine/${param.ensDate}/${param.ensSeq}",
                             data: ""
                         },
                         function(res){
                             if(res.error){
                                 alert(res.error.message);
                             }
                             else
                             {
                            	 if(res.map.enshrineVTO.ensdeadVTOList){
                         			for(var i=0; i<res.map.enshrineVTO.ensdeadVTOList.length; i++){
                         				fnObj.gridEnsdead.target.setData({list:[]})

                         				if(res.map.enshrineVTO.ensdeadVTOList[i].thedeadVTO){
 			                        		$.each(res.map.enshrineVTO.ensdeadVTOList[i].thedeadVTO, function(key, value){
 			                        			res.map.enshrineVTO.ensdeadVTOList[i][key] = value;
 			                        		});
                         				}
                         			}
                         			enshrine = res.map.enshrineVTO;
 	                        		fnObj.gridEnsdead.target.pushList(res.map.enshrineVTO.ensdeadVTOList);
 	                        		fnObj.formEnsret.setJSON(res.map.enshrineVTO);
                         		}

                             }
                         });
                     }
                },
				control: {
					save: function(){

                        var item = fnObj.grid.target.getSelectedItem();
                        if(item.error){
                        	toast.push("고인을 선택해주세요.");
                        	return;
                        }
						app.modal.save("${callBack}", item.item);

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