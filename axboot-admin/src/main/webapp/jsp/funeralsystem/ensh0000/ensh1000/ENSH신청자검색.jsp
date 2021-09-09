<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%
	request.setAttribute("callBack", request.getParameter("callBack"));
%>
<ax:layout name="modal.jsp">
	<ax:set name="title" value="신청자검색" />
	<ax:set name="page_desc" value="" />

	<ax:div name="contents">
		<ax:row>
			<ax:col size="12" wrap="true">


                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-table"></i> 신청자검색</h2>
                    </div>
                    <div class="right">
                    	<button id="btn-search" type="button" class="AXButton" ><i class="axi axi-ion-android-search"></i> 조회</button>
                    	<button type="button" class="AXButton" id="ax-form-btn-new"><i class="axi axi-plus-circle"></i> 신규</button>
                    	<button type="button" class="AXButton" id="ax-form-btn-save"><i class="axi axi-save"></i> 저장</button>
                    	<button type="button" class="AXButton" id="btn-save-applicant-addrhst"><i class="axi axi-save"></i> 주소변경기록</button>
                    </div>
                    <div class="ax-clear"></div>
                </div>

				<div class="ax-search" id="page-search-box"></div>
				<div class="ax-grid" id="page-grid-box" style="min-height: 200px;"></div>

				<ax:form id="form-info" name="form-info">
					<ax:fields>
	                    <ax:field label="신청자번호*">
	                        <input type="number" id="info-applId" name="applId" title="신청자번호" placeholder="신청자번호" readonly="readonly" maxlength="100" class="AXInput W100 av-required" value=""/>
	                    </ax:field>
                        <ax:field label="신청자명*">
                            <input type="text" id="info-applName" name="applName" title="신청자" placeholder="신청자" maxlength="100" class="AXInput W100 av-required" value=""/>
                        </ax:field>
                        <ax:field label="신청자 주민번호">
                            <input type="text" id="info-applJumin" name="applJumin" title="신청자 주민번호" placeholder="신청자 주민번호" maxlength="14" class="AXInput W100" value=""/>
                        </ax:field>
					</ax:fields>
					<ax:fields>
                        <ax:field label="전화번호">
                            <input type="text" id="info-applTelno1" name="applTelno1" title="전화번호" maxlength="3" placeholder="000" class="AXInput W40" value=""/>
                            <input type="text" id="info-applTelno2" name="applTelno2" title="전화번호" maxlength="4" placeholder="0000" class="AXInput W40" value=""/>
                            <input type="text" id="info-applTelno3" name="applTelno3" title="전화번호" maxlength="4" placeholder="0000" class="AXInput W40" value=""/>
                        </ax:field>
                        <ax:field label="휴대폰*">
                            <input type="text" id="info-applMobileno1" name="applMobileno1" title="휴대폰" maxlength="3" placeholder="000" class="AXInput W40 av-required" value=""/>
                            <input type="text" id="info-applMobileno2" name="applMobileno2" title="휴대폰" maxlength="4" placeholder="0000" class="AXInput W40 av-required" value=""/>
                            <input type="text" id="info-applMobileno3" name="applMobileno3" title="휴대폰" maxlength="4" placeholder="0000" class="AXInput W40 av-required" value=""/>
                        </ax:field>
                        <ax:field label="email">
                            <input type="text" id="info-emailId" name="emailId" title="email" placeholder="email" class="AXInput W100" value="" />@<input
                            type="text" id="info-emailProvider" name="emailProvider" title="email" placeholder="이메일 서비스" class="AXInput W150" value="" />
                        </ax:field>
					</ax:fields>
					<ax:fields>
                        <ax:field label="신청자국적">
                            <select id="info-applNationGb" name="applNationGb" class="AXSelect W50"></select>
                        </ax:field>
                        <ax:field label="신청자 주소*">
                            <select id="info-applAddrGubun" name="applAddrGubun" class="AXSelect W50"></select>
                            <input type="text" id="info-applPost" name="applPost" title="우편번호" readonly="readonly" placeholder="우편번호" class="AXInput W50" value="" />
                            <button type="button" class="AXButton" id="btn-applpost"><i class="axi axi-local-post-office"></i> 우편번호</button>
                            <input type="text" id="info-applAddr1" name="applAddr1" title="신청자 주소" readonly="readonly" placeholder="" class="AXInput W290 av-required" value="" />
                            <input type="text" id="info-applAddr2" name="applAddr2" title="신청자 주소" placeholder="상세주소" class="AXInput W250" value="" />
                        </ax:field>
					</ax:fields>
					<ax:fields>
  						<ax:field label="특이사항">
							<input type="text" id="info-applRemark" name="applRemark" title="특이사항" placeholder="특이사항" class="AXInput" style="width: 980px;" value=""/>
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
			vapplId = "";
			var fnObj = {
                CODES: {
                	"deadSex": Common.getCode("TCM05"),
   					"applNationGb": Common.getCode("TCM11"),
                    "addrGubun": Common.getCode("TCM07"),
                },

				pageStart: function(){
					this.search.bind();
					this.grid.bind();
					this.form.bind();
					this.bindEvent();
					this.search.defaultSeach();
					
				},
				pageResize: function(){
					parent.myModal.resize();
				},
				bindEvent: function(){
					// click----------------------------------------------------------------
					$("#btn-search").bind("click", function(){
						fnObj.search.submit();
					});
					$("#ax-form-btn-save").bind("click", function(){
						fnObj.form.save(false);
					});
                    $("#btn-applpost").bind("click", function(){
                    	daumPopPostcode("info-applPost", "info-applAddr1", "info-applAddr2");
                    });
					// click----------------------------------------------------------------

					//change------------------------------------------------------------
					Common.grid.changeValueToGrid("info-", fnObj.grid.target);
					//change------------------------------------------------------------

					// select ---------------------------------------------------------------
                   	$("#info-applNationGb").bindSelect({
	       				options:fnObj.CODES.applNationGb
	       			});
                  	$("#info-applAddrGubun").bindSelect({
	       				options:fnObj.CODES.addrGubun
	       			});
					// select ---------------------------------------------------------------

					// custom----------------------------------------------------------------
					$("#info-applJumin").bindPattern({pattern: "custom", max_length: 13, patternString:"999999-9999999"});
					// custom----------------------------------------------------------------

					
				
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
                                                 {optionValue:"applId", optionText:"신청자번호"},
                                                 {optionValue:"applName", optionText:"신청자명"},
                                                 {optionValue:"applJumin", optionText:"주민번호"}
                                             ],
               							AXBind:{
               								type:"select", config:{
               									onchange:function(){
               										
               										console.log(Object.toJSON(this));
               										if(this.value == 'applJumin'){
               											//$("#"+fnObj.search.target.getItemId("keyword")).bindPattern({pattern: "custom", max_length: 13, patternString:"999999-9999999"});
               									
               										}else if(this.value == 'applName'){
               											
               											//$("#"+fnObj.search.target.getItemId("keyword")).removeAttr("data-axbind");
               										}else if(this.value == 'applId'){
               											//$("#"+fnObj.search.target.getItemId("keyword")).val("${param.applId}");
               											//$("#"+fnObj.search.target.getItemId("keyword")).bindPattern({pattern: "numberint",max_length : 11});
               										}
               										
               									}
               								}
               							}
                                    },
                                    {label:"", labelWidth:"", type:"inputText", width:"150", key:"keyword", addClass:"", valueBoxStyle:"", value:"",
                                    	 
										},
                                    	
                                ]}
                            ]
                        });
                    },
                    defaultSeach:function(){
                    	vapplId = "${param.applId}";
                    	
                    	if(vapplId != ""){
	                    	Common.search.setValue(this.target, "keyword", vapplId);
	                    	this.submit();
                    	}else{
                    		$("#"+fnObj.search.target.getItemId("condition")).val("applName");
                    		$('#ax-form-btn-new').click();
                    	}
                    	
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
                                {key:"applName", label:"신청자명", width:"100", align:"center"},
                                {key:"applJumin", label:"주민번호", width:"130", align:"center"},
                                {key:"phone", label:"휴대폰", width:"130", align:"center"},
                                {key:"tel", label:"전화번호", width:"130", align:"center"},
                                {key:"applEmail", label:"이메일", width:"130", align:"center"},
                                {key:"fullAddr", label:"주소", width:"400", align:"center"},
//                                 ,{key:"etc3", label:"선택타입", width:"150", align:"center",
//                                     formatter: function(val){
//                                         return fnObj.CODES._etc3[ ( (Object.isObject(this.value)) ? this.value.NM : this.value ) ];
//                                     }
//                                 }
                            ],
                            body : {
                                onclick: function(){
                                	fnObj.form.clear();
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

                        app.ajax({
                            type: "GET",
                            url: "/ENSH1012/applicant/"+$("#"+fnObj.search.target.getItemId("condition")).val()+"/"+encodeURI($("#"+fnObj.search.target.getItemId("keyword")).val()),
                            data: "dummy="+ axf.timekey() +"&pageNumber=" + (pageNo-1) + "&pageSize=50"
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
                                if(vapplId == ""){
                                	$('#ax-form-btn-new').click();
                                }
                                if(res.list.length == 1){
                                	fnObj.grid.target.setFocus(0);
                    				$("#"+fnObj.grid.target.config.targetID+" .gridBodyTr.selected td").click();
                                }
                                
                                //axdom("#"+fnObj.search.target.getItemId("condition")).bindSelectSetValue("applName");
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
                        });

                        $("#btn-save-applicant-addrhst").bind("click", function(){
                        	fnObj.form.save(true);
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
                    save: function(change){
                    	app.ajax({
                            type: "PUT",
                            url: "/ENSH1012/applicant/"+change,
                            data: Object.toJSON(fnObj.form.getJSON())
                        }, function(res){
                            if(res.error){
                                alert(res.error.message);
                            }else{
                            	toast.push("저장하였습니다.");
                            	//fnObj.search.submit();
                            	//fnObj.form.clear();
                            	
                            	fnObj.form.clear();
                            	axdom("#"+fnObj.search.target.getItemId("condition")).bindSelectSetValue("applId");                            	
                            	$("#"+fnObj.search.target.getItemId("keyword")).val(res.applId);  
                        		vapplId = res.applId;
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
                        	toast.push("신청자를 선택해주세요.");
                        	return;
                        }
						app.modal.save("${callBack}", item.item);

					},
					cancel: function(){
						vapplId = "";
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