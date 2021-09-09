<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%
	request.setAttribute("callBack", request.getParameter("callBack"));
%>
<ax:layout name="modal.jsp">
	<ax:set name="title" value="고인검색" />
	<ax:set name="page_desc" value="" />

	<ax:div name="contents">
		<ax:row>
			<ax:col size="12" wrap="true">


                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-table"></i> 고인검색</h2>
                    </div>
                    <div class="right">
                    	<button id="btn-search" type="button" class="AXButton" ><i class="axi axi-ion-android-search"></i> 조회</button>
                    <!-- 	<button type="button" class="AXButton" id="ax-form-btn-new"><i class="axi axi-plus-circle"></i> 신규</button>
                    	<button type="button" class="AXButton" id="ax-form-btn-save"><i class="axi axi-save"></i> 저장</button> -->
                    </div>
                    <div class="ax-clear"></div>
                </div>

				<div class="ax-search" id="page-search-box"></div>
				<div class="ax-grid" id="page-grid-box" style="min-height: 200px;"></div>

				<ax:form id="form-info" name="form-info">
					<ax:fields>
						<ax:field label="고인번호">
							<input type="text" id="info-deadId" name="deadId" title="고인번호" placeholder="자동생성" class="AXInput W50" value="" readonly="readonly"/>
						</ax:field>
						<ax:field label="고인명">
							<input type="text" id="info-deadName" name="deadName" title="고인명" placeholder="고인명" maxlength="20" class="AXInput W150 av-required" value="" />
						</ax:field>
						<ax:field label="주민번호">
							<input type="text" id="info-deadJumin" name="deadJumin" title="주민번호" placeholder="주민번호" maxlength="14" class="AXInput W150" value=""/>
						</ax:field>
						<ax:field label="생년월일">
							<input type="text" id="info-deadBirthString" name="deadBirthString" title="생년월일" placeholder="생년월일" maxlength="20" class="AXInput W150" value=""/>
						</ax:field>
					</ax:fields>
					<ax:fields>
	                   	<ax:field label="사망자성별">
	                        <select id="info-deadSex" name="deadSex" class="AXSelect W160"></select>
	                    </ax:field>
                    	<ax:field label="사망일자*">
	                        <input type="text" id="info-deadDateString" name="deadDateString" title="사망일자" placeholder="사망일자" class="AXInput W150 av-required" value=""/>
	                    </ax:field>
	                    <ax:field label="사망시간">
	                        <input type="text" id="info-deadTimeString" name="deadTimeString" title="사망시간" placeholder="사망시간" maxlength="5" class="AXInput W150" value="" />
	                    </ax:field>
	                	<ax:field label="사망장소">
	                        <select id="info-deadPlace" name="deadPlace" class="AXSelect W160"></select>
	                    </ax:field>
					</ax:fields>
					<ax:fields>
	                	<ax:field label="사망사유*">
	                        <select id="info-deadReason" name="deadReason" class="AXSelect W160"></select>
	                    </ax:field>
                        <ax:field label="<span style='font-size:8px;'>장례식장명/개장장소</span>">
                            <input type="text" id="info-company" name="company" title="장례식장명" placeholder="장례식장명" class="AXInput W150" value="" />
                        </ax:field>
                        <ax:field label="임신주수">
                            <input type="number" id="info-bunmanwol" name="bunmanwol" title="임신주수" maxlength="2" class="AXInput W150" value="" />
                        </ax:field>
                        <ax:field label="사산사유">
                            <input type="text" id="info-sasansayu" name="sasansayu" title="사산사유" placeholder="사산사유" maxlength="100" class="AXInput W150" value="" />
                        </ax:field>
					</ax:fields>
					<ax:fields>
                        <ax:field label="유/분골">
                            <select id="info-boneGb" name="boneGb" class="AXSelect W160"></select>
                        </ax:field>
	                	<ax:field label="사망자국적구분">
	                        <select id="info-deadNationGb" name="deadNationGb" class="AXSelect W160"></select>
	                    </ax:field>
                        <ax:field label="감면구분*">
                            <select id="info-dcGubun" name="dcGubun" class="AXSelect W160"></select>
                        </ax:field>
                  		<ax:field label="주소코드" style="width: 194px;">
							<select id="info-addrCode" name="addrCode" class="AXSelect W150"></select>
						</ax:field>
					</ax:fields>
					<ax:fields>
                        <ax:field label="개장신고일자">
                        	<input type="text" id="info-openNtyDateString" name="openNtyDateString" title="개장신고일자" placeholder="개장신고일자" maxlength="2" class="AXInput W150" value="" />
                        </ax:field>
                        <ax:field label="개장사유">
                            <input type="text" id="info-fixgravereason" name="fixgravereason" title="개장사유" placeholder="개장사유" class="AXInput" style="width: 700px;" value="" />
                        </ax:field>
					</ax:fields>
					<ax:fields>
                        <ax:field label="<span style='font-size:8px;'>사망진단서 발급기관</span>">
                        	<input type="text" id="info-deadDocnm" name="deadDocnm" title="발급기관" placeholder="발급기관" class="AXInput W100 av-required" value="" />
                        </ax:field>
                        <ax:field label="<span style='font-size:8px;'>사망진단서 발급번호</span>">
	                     	<input type="text" id="info-deadDocno" name="deadDocno" title="발급번호" placeholder="발급번호" class="AXInput W100 av-required" value="" />
                        </ax:field>
                        <ax:field label="종교">
                            <select id="info-deadFaith" name="deadFaith" class="AXSelect W150"></select>
                        </ax:field>
					</ax:fields>
					<ax:fields>
                        <ax:field label="사망자 주소">
                            <select id="info-deadAddrGubun" name="deadAddrGubun" class="AXSelect W50"></select>
                            <input type="text" id="info-deadPost" name="deadPost" title="우편번호" readonly="readonly" placeholder="우편번호" class="AXInput W50" value="" />
                            <button type="button" class="AXButton" id="btn-deadpost"><i class="axi axi-local-post-office"></i> 우편번호</button>
                            <input type="text" id="info-deadAddr1" name="deadAddr1" title="사망자 주소" readonly="readonly" placeholder="" class="AXInput W300 av-required" value="" />
                            <input type="text" id="info-deadAddr2" name="deadAddr2" title="사망자 주소" placeholder="상세주소" class="AXInput W300" value="" />
                        </ax:field>
					</ax:fields>
					<ax:fields>
						<ax:field label="특이사항">
							<input type="text" id="info-deadRemark" name="deadRemark" title="특이사항" placeholder="특이사항" class="AXInput" style="width: 980px;" value=""/>
						</ax:field>
					</ax:fields>
				</ax:form>
			</ax:col>
		</ax:row>

	</ax:div>
	<ax:div name="buttons">
		<button type="button" class="AXButton" onclick="fnObj.control.select();">선택</button>
		<button type="button" class="AXButton" onclick="fnObj.control.cancel();">취소</button>
	</ax:div>

	<ax:div name="scripts">
       	<jsp:include page="/jsp/funeralsystem/common/postcode.jsp"></jsp:include>
		<script type="text/javascript">
			vdeadId = "";
			var fnObj = {
                CODES: {
                	"deadSex": Common.getCode("TCM05"),
                    "deadPlace": Common.getCode("TCM09"),
                    "deadReason": Common.getCode("TCM03"),
                    "boneGb": Common.getCode("TMC05"),
                    "deadNationGb": Common.getCode("TCM04"),
                    "addrPart": Common.getCode("TCM10"),
                    "addrGubun": Common.getCode("TCM07"),
                    "dcGubun": Common.getCode("TCM12"),
                    "deadFaith": Common.getCode("TCM06"),
                    "addrCode": Common.addr.getAddrCode()
                },
				pageStart: function(){
					this.form.bind();
					this.search.bind();
					this.grid.bind();
					
					this.bindEvent();
					this.search.defaultSearch();
					
					
				},
				pageResize: function(){
					parent.myModal.resize();					
				},
				bindEvent: function(){
					// click----------------------------------
					$("#btn-search").bind("click", function(){
						fnObj.search.submit();
					});
					$("#ax-form-btn-save").bind("click", function(){
						fnObj.form.save();
					});
                    $("#btn-deadpost").bind("click", function(){
                    	daumPopPostcode("info-deadPost", "info-deadAddr1", "info-deadAddr2");
                    });
					// click----------------------------------

					//change-----------------------------------
					Common.grid.changeValueToGrid("info-", fnObj.grid.target);
                    $("#info-deadAddr1").change(function(){
                    	Common.addr.getAddrPart(this.value, "info-addrCode", "info-addrPart");
                    });                    

                    /* $("#info-deadJumin").change(function(){
                    	if(this.value.length > 8){
                    		parseInt(this.value.substring(7,8), 10) % 2 == 1 ? $("#info-deadSex").bindSelectSetValue("TCM0500001") : $("#info-deadSex").bindSelectSetValue("TCM0500002");
                    		var year = parseInt(this.value.substring(0,1), 10)  == 0 ? "20" : "19";
                    		var birthday = year+this.value.substring(0,2)+"-"+ this.value.substring(2,4) +"-"+this.value.substring(4,6);
                    		                   		
                    		if("NaN-NaN-NaN" == new Date(birthday).print("yyyy-mm-dd")){
                    			$("#info-deadBirthString").val(new Date().print("yyyy-mm-dd"))
                    		}else{
                    			$("#info-deadBirthString").val(new Date(birthday).print("yyyy-mm-dd"));
                    		}
                    		
                    	}else{
                    		$("#info-deadSex").bindSelectSetValue("TCM0500003");
                    		$("#info-deadBirthString").val(new Date().print("yyyy-mm-dd"))
                    	}                    	
                    }) */
					//change-----------------------------------

					// select-----------------------------
					$("#info-deadSex").bindSelect({
        				options:fnObj.CODES.deadSex
        			});
                    $("#info-deadPlace").bindSelect({
        				options:fnObj.CODES.deadPlace
        				
        			});
                    $("#info-deadPlace").bindSelectSetValue("TCM0900002");
                    
                    $("#info-deadReason").bindSelect({
                        options:fnObj.CODES.deadReason
                    });
                    $("#info-boneGb").bindSelect({
        				options:fnObj.CODES.boneGb
        			});
                    $("#info-deadNationGb").bindSelect({
        				options:fnObj.CODES.deadNationGb
        			});
                    $("#info-addrPart").bindSelect({
                        options:fnObj.CODES.addrPart
                    });
                    $("#info-deadAddrGubun").bindSelect({
        				options:fnObj.CODES.addrGubun
        			});
                    $("#info-dcGubun").bindSelect({
                        options:fnObj.CODES.dcGubun
                    });
                    $("#info-deadFaith").bindSelect({
                        options:fnObj.CODES.deadFaith
                    });
                    $("#info-addrCode").bindSelect({
                        options:fnObj.CODES.addrCode
                    });
					// select-----------------------------

					// Date---------------------------------
					$("#info-deadBirthString").bindDate();
					$("#info-deadDateString").bindDate();
					$("#info-openNtyDateString").bindDate();
					// Date---------------------------------

					// custom---------------------------------
                    $("#info-deadJumin").bindPattern({pattern: "custom", max_length: 13, patternString:"999999-9999999"});
                    $("#info-deadTimeString").bindPattern({pattern: "custom", max_length: 5, patternString:"99:99"});
				                    
				},				
				search: {
                    target: new AXSearch(),
                    bind: function(){
                        var _this = this;
                        this.target.setConfig({
                            targetID:"page-search-box",
                            theme : "AXSearch",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            onsubmit: function(){
                                // 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.
                                fnObj.search.submit();
                            },
                            rows:[
                                {display:true, addClass:"", style:"", list:[
                                    {label:"", labelWidth:"", type:"selectBox", width:"150", key:"condition", addClass:"", valueBoxStyle:"", value:"",
                                    	options:[
												{optionValue:"deadName", optionText:"고인명"},
												{optionValue:"deadId", optionText:"고인번호"},
                                                 {optionValue:"cremDate", optionText:"화장일자"},  
                                                 
                                                 
                                             ],
               							AXBind:{
               								type:"select"
               								,alwaysOnChange: true
               								, config:{
               									onchange:function(){
    		   										
    												console.log(Object.toJSON(this));
    												
    												if(this.value == 'cremDate'){
    													$("#"+fnObj.search.target.getItemId("keyword")).hide();
    													$("#"+fnObj.search.target.getItemId("from")).show();
    													$("#"+fnObj.search.target.getItemId("to")).show();
    													//$(".AXanchorDateHandle").show();
    													$("#page-search-box .secondItem").show();
    												}else{    													
    													//$("#"+fnObj.search.target.getItemId("from")).hide();
    													//$("#"+fnObj.search.target.getItemId("to")).hide();
    													$("#"+fnObj.search.target.getItemId("keyword")).show();    													
    													$("#page-search-box .secondItem").hide();
    												}
    											}
               								}
		                                    
               							}
                                    },
                                    {label:"", labelWidth:"", type:"inputText", width:"150", key:"keyword", addClass:"firstItem", valueBoxStyle:"", value:"",},
                                    {label:"", labelWidth:"", type:"inputText", width:"100", key:"from", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
               							onChange: function(){}
               						},
               						{label:"", labelWidth:"", type:"inputText", width:"100", key:"to", addClass:"secondItem", valueBoxStyle:"padding-left:0px;", value:new Date().print(),
               							AXBind:{
               								type:"twinDate", config:{
               									align:"right", valign:"top", startTargetID:"from",
               									onChange:function(){

               									}
               								}
               							}
               						},
                                ]},
                                
                            ]
                        });
                    },
                    defaultSearch:function(){
                    	vdeadId = "${param.deadId}";
                    	var cremDate = "${param.cremDate}";
						
                    	if(vdeadId != ""){
                    		$("#"+fnObj.search.target.getItemId("condition")).val("deadId");
                    		Common.search.setValue(this.target, "keyword", vdeadId);
                    		//$("#"+fnObj.search.target.getItemId("condition")+" :eq(1)");
                    		//axdom("#"+fnObj.search.target.getItemId("condition")).bindSelectSetValue("deadId");
                    		$("#page-search-box .secondItem").hide();
                    		
							
                    	}else{
                    		$("#"+fnObj.search.target.getItemId("condition")).val("cremDate");
                    		Common.search.setValue(this.target, "from", cremDate);
                    		Common.search.setValue(this.target, "to", cremDate);                    		
                    		$("#"+fnObj.search.target.getItemId("keyword")).hide();
                    	}
                   
                    	 clone = '${param.clone}';
                         if(clone == 'true'){
                        	 $("#"+fnObj.search.target.getItemId("condition")).val("deadId");
                        	 Common.search.setValue(this.target, "keyword", vdeadId);
                        	 $("#page-search-box .secondItem").hide();
             				
                         }
                    	
                    	this.submit();
                    	
                    },
                    submit: function(){
                        var pars = this.target.getParam();
                       fnObj.grid.setPage(fnObj.grid.pageNo, pars);
                       
                    }
                },
				grid: {
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "page-grid-box",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                //{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"deadId", label:"고인번호", width:"100", align:"center"},
                                {key:"deadName", label:"고인명", width:"100", align:"center"},
                                {key:"deadJumin", label:"주민번호", width:"130", align:"center"
                                	, formatter: function(){
                                		return Common.pattern.custom(this.value, "999999-9999999");
                                	}
                                },
                                {key:"deadBirthString", label:"생년월일", width:"100", align:"center"
                                	, formatter:function(val){
                                		if(this.value){
	                                		return this.value.date().print();
                                		}
                                	}
                                },
                                {key:"deadSex", label:"성별", width:"100", align:"center"
                                	, formatter:function(){
                                		for(var i=0; i<fnObj.CODES.deadSex.length; i++){
                                			if(fnObj.CODES.deadSex[i].optionValue == this.value){
                                				return fnObj.CODES.deadSex[i].optionText;
                                			}
                                		}
                                	}
                                },
                                {key:"deadDateString", label:"사망일자", width:"100", align:"center"
                                	, formatter:function(val){
                                		if(this.value){
	                                		return this.value.date().print();
                                		}
                                	}
                                },
//                                 ,{key:"etc3", label:"선택타입", width:"150", align:"center",
//                                     formatter: function(val){
//                                         return fnObj.CODES._etc3[ ( (Object.isObject(this.value)) ? this.value.NM : this.value ) ];
//                                     }
//                                 }
                            ],
                            body : {
                                onclick: function(){
                                	fnObj.form.setJSON(this.item);
                                }
                            },
                            page: {
                                display: true,
                                paging: true
                                , onchange: function(pageNo){
                                    _this.setPage(pageNo);
                                }
                            }
                        });
                    },
                    setPage: function(pageNo, searchParams){
                        var _target = this.target;
                        this.pageNo = pageNo;
                        var keyword  = encodeURI($("#"+fnObj.search.target.getItemId("keyword")).val());                        
                        var keyword2 = encodeURI($("#"+fnObj.search.target.getItemId("to")).val());
                        if($("#"+fnObj.search.target.getItemId("condition")).val() == "cremDate"){
                        	keyword = encodeURI($("#"+fnObj.search.target.getItemId("from")).val());
                        }
						
                        app.ajax({
                            type: "GET",
                            url: "/ENSH1011/thedead/"+$("#"+fnObj.search.target.getItemId("condition")).val()+"/"+keyword,
                            data: "keyword2="+keyword2+"&dummy="+ axf.timekey() +"&pageNumber=" + (pageNo-1) + "&pageSize=50&sort=deadId,desc"
                        }, function(res){
                            if(res.error){
                                alert(res.error.message);
                            }
                            else
                            {
                                var gridData = {
                                    list: res.list
                                    , page:{
                                        pageNo: res.page.currentPage.number()+1,
                                        pageSize: res.page.pageSize,
                                        pageCount: res.page.totalPages,
                                        listCount: res.page.totalElements
                                    }
                                };
                                _target.setData(gridData);
                                clone = '${param.clone}';
                                deadId = '${param.deadId}';
                                if(clone != 'true' && res.list.length == 1){
                                	fnObj.grid.target.setFocus(0);
                    				$("#"+fnObj.grid.target.config.targetID+" .gridBodyTr.selected td").click();
                                }
                                if(clone == 'true'){
                                	fnObj.grid.target.setFocus(0);
                    				$("#"+fnObj.grid.target.config.targetID+" .gridBodyTr.selected td").click();
                    				$("#info-deadId").val("");
                    				clone = 'false';
                    				Common.search.setValue(fnObj.search.target, "keyword", "");
                    		
                    				
                                }
                                
                                
                                if(vdeadId == ""){
                                	//$('#ax-form-btn-new').click();
                                }
                                
                               // 
                               // axdom("#"+fnObj.search.target.getItemId("condition")).bindSelectSetValue("deadName");
                            }
                        });
                    }
                },
                /*******************************************************
                 * 상세 폼
                 */
                form: {
                    target: $('#form-info'),
                    validate_target: new AXValidator(),
                    bind: function() {
                        var _this = this;

                        this.validate_target.setConfig({
                            targetFormName : "form-info"
                        });

                        $('#ax-form-btn-new').click(function() {
                        	fnObj.grid.target.pushList({});
                        	fnObj.grid.target.setFocus(fnObj.grid.target.list.length-1);
                            fnObj.form.clear();
                            $("[id^='info-']").change();
                            $("#info-deadPlace").bindSelectSetValue("TCM0900002");
                        });
                        
                 
                        
                    },
                    setJSON: function(item) {
                        var _this = this;

                        // 수정시 입력 방지 처리 필드 처리
//                         $('#info-key').attr("readonly", "readonly");

                        var info = $.extend({}, item);
                        app.form.fillForm(_this.target, info, 'info-');
                        // 추가적인 값 수정이 필요한 경우 처리
                        // $('#info-useYn').bindSelectSetValue( info.useYn );
                    },
                    getJSON: function() {
                        return app.form.serializeObjectWithIds(this.target, 'info-');
                    },
                    save: function(){
                    	
                    	 var validateResult = fnObj.form.validate_target.validate();
                         if (!validateResult) {
                             var msg = fnObj.form.validate_target.getErrorMessage();
                             axf.alert(msg);
                             fnObj.form.validate_target.getErrorElement().focus();
                             return false;
                         }                    	
                    	app.ajax({
                            type: "PUT",
                            url: "/ENSH1011/thedead",
                            data: Object.toJSON(fnObj.form.getJSON())
                        }, function(res){
                            if(res.error){
                                alert(res.error.message);
                            }else{
                            	toast.push("저장하였습니다.");
                            	fnObj.form.clear();
                            	axdom("#"+fnObj.search.target.getItemId("condition")).bindSelectSetValue("deadId");                            	
                            	$("#"+fnObj.search.target.getItemId("keyword")).val(res.deadId);  
                            	vdeadId = res.deadId;  
                        		fnObj.search.submit();
                        		
                            }
                        });
                    },
                    clear: function() {
                        app.form.clearForm(this.target);
                    }
                }, // form
				control: {
					select: function(){

                        var item = fnObj.grid.target.getSelectedItem();
                        if(item.error){
                        	toast.push("고인을 선택해주세요.");
                        	return;
                        }
						app.modal.save("${callBack}", item.item);

					},
					cancel: function(){
						vdeadId = "";
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