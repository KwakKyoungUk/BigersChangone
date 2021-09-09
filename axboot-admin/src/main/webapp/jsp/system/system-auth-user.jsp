<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>

<ax:layout name="base.jsp">
    <ax:set name="title" value="${PAGE_NAME}" />
    <ax:set name="page_desc" value="${PAGE_REMARK}" />

	<ax:div name="contents">
		<ax:row>
			<ax:col size="12">
                <ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}" function2Auth="${FUNCTION_2_AUTH}" function3Auth="${FUNCTION_3_AUTH}" function4Auth="${FUNCTION_4_AUTH}" function5Auth="${FUNCTION_5_AUTH}"></ax:custom>
				<div class="ax-search" id="page-search-box"></div>

                <ax:custom customid="table">
                    <ax:custom customid="tr">
                        <ax:custom customid="td" style="width:40%;">
                            <h2><i class="axi axi-list-alt"></i> 사용자정보</h2>
                            <div class="ax-grid" id="page-grid-box"></div>

                        </ax:custom>
                        <ax:custom customid="td">
                            <div class="ax-button-group">
                                <div class="left">
                                    <h2><i class="axi axi-table"></i> 사용자등록</h2>
                                </div>
                                <div class="right">
                                    <button type="button" class="AXButton" id="ax-form-btn-add"><i class="axi axi-plus-circle"></i> 신규</button>
                                </div>
                                <div class="ax-clear"></div>
                            </div>

                            <ax:form name="table-form" id="table-form" method="post">
                                <input type="hidden" name="act_tp" id="act_tp" value="" />
                                <ax:fields>
                                    <ax:field label="업체" width="220px">
                                        <input type="text" name="compCd" id="compCd" title="업체코드" class="av-required AXInput W50" value="" readonly="readonly" />
                                        <input type="text" name="compNm" id="compNm" title="업체명" class="AXInput W100" value="" readonly="readonly" />
                                        <label>
                                            &nbsp;상단 검색바에서 업체를 선택하세요.
                                        </label>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="구분" width="220px">
                                        <select name="userType" id="userType" class="AXSelect W150">
                                        </select>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="이름" width="220px">
                                        <input type="text" name="userNm" id="userNm" maxlength="15" title="이름" class="av-required AXInput W120" value="" />
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="아이디" width="220px">
                                        <input type="text" name="userCd" id="userCd" maxlength="10" title="아이디" class="av-required AXInput W150" value="" />
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="비밀번호 변경" width="220px">
                                        <input type="text" id="password_change" name="password_change" class="AXInput W60" value="사용" />
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="비밀번호" width="220px">
                                        <input type="password" name="userPs" id="userPs" maxlength="128" class="AXInput W120" value="" />
                                    </ax:field>
                                    <ax:field label="비밀번호 확인" width="220px">
                                        <input type="password" name="userPs_chk" id="userPs_chk" maxlength="128" class="AXInput W120" value="" />
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="이메일" width="220px">
                                        <input type="text" name="email" id="email" maxlength="50" title="이메일" placeholder="abc@abc.com" class="av-email AXInput W180" value="" />
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="핸드폰번호" width="220px">
                                        <input type="text" name="hpNo" id="hpNo" maxlength="15" placeholder="" class="av-phone AXInput W120" value="" />
                                    </ax:field>
                                </ax:fields>

                                <ax:fields>
                                    <ax:field label="사용여부" width="220px">
                                        <select name="useYn" id="useYn" class="AXSelect W100">
                                            <option value="Y">사용</option>
                                            <option value="N">사용안함</option>
                                        </select>
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="비고" width="220px">
                                        <input type="text" name="remark" id="remark" maxlength="100" class="AXInput W300" value="" />
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                    <ax:field label="아이피" width="220px">
                                        <input type="text" name="accessIp" id="accessIp" class="AXInput W300" value=""  maxlength="15"/>
                                    </ax:field>
                                </ax:fields>
                            </ax:form>

                            <div id="grid-userMngPart" style="height: 450px;"></div>

                        </ax:custom>
                    </ax:custom>
                </ax:custom>

			</ax:col>
		</ax:row>
	</ax:div>
	<ax:div name="scripts">
	    <script type="text/javascript">	    
        var resize_elements = [
            {id:"page-grid-box", adjust:-97}
        ];
	    var fnObj = {
	    		CODES: {
                    /* "userType": (function(){
                    	var result;
                    	app.ajax({
                    			async: false,
	                            type: "GET",
	                            url: "/api/v1/auth/groups",
	                            data: ""
	                        },
	                        function(res){
	                        	result = res;
                        	}
                        );
                    	return result;
                    }()),	    		 */
                    userType : [{optionValue:"S", optionText:"슈퍼 관리자"}
		       		,{optionValue:"A", optionText:"관리자"}
		       		,{optionValue:"U", optionText:"일반 사용자"}
		       		]
	    			, part: null
	    	},
            compCd: "",
            compNm: "",
	        pageStart: function(){
	            this.search.bind();
	            this.grid.bind();
	            this.gridUserMngPart.bind();
                this.form.bind();
	            this.bindEvent();
	            this.getPart();
	        },
	        bindEvent: function(){
	            var _this = this;
                $("#ax-page-btn-search").bind("click", function(){
                    _this.search.submit();
                });
                $("#ax-page-btn-save").bind("click", function(){
                    setTimeout(function() {
                        _this.save();
                    }, 500);
                });
                $("#ax-page-btn-excel").bind("click", function(){
                    app.modal.excel({
                        pars:"target=${className}"
                    });
                });

                $("#ax-form-btn-add").bind("click", function(){
                    _this.form.add();
                });

                $("#ax-stor-finder").bind("click", function(){
                    if(fnObj.compCd == ""){
                        alert("상단 검색바에서 업체를 선택 해주세요");
                        return;
                    }
                    app.modal.open({
                        url:"/jsp/info/info-shop-search-modal-01.jsp",
                        pars:"callBack=fnObj.setStoreCd&compCd=" + fnObj.compCd + "&compNm=" + fnObj.compNm.dec(),
                        width: 600
                    });
                });


	        },
            setStoreCd: function(item){
                $("#storCd").val(item.storCd);
                $("#storNm").val(item.storNm);
                app.modal.close();
            },
            save: function(){
                fnObj.form.save();
            },
            excel: function(){

            },
            getPart: function(){

            	app.ajax({
                    type: "GET",
                    url: "/api/v1/users/part/all",
                    data: ""
                }, function(res){
                    if(res.error){
                        alert(res.error.message);
                    }
                    else
                    {
                        fnObj.CODES.part = $.map(res.list, function(o){
                        	o.___checked = [];
                        	o.___checked.push(false);
                        	return o;
                        });
                    }
                });
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
                                {label:"업체", labelWidth:"", type:"selectBox", width:"150", key:"compCd", addClass:"", valueBoxStyle:"", value:"",
                                    options:[],
                                    AXBind:{
                                        type:"select", config:{
                                            reserveKeys: {
                                                options: "list",
                                                optionValue: "compCd",
                                                optionText: "compNm"
                                            },
				                            method:"GET", ajaxUrl: "/api/v1/companies", ajaxPars: "menuType=SYSTEM&pageNumber=0&pageSize=50",
                                            isspace: false, isspaceTitle: "",
                                            setValue:"",
                                            alwaysOnChange: true,
                                            onchange:function(){
                                                //console.log(this);
                                                fnObj.compCd = this.value;
                                                fnObj.compNm = this.text.dec();
                                                //toast.push(Object.toJSON(this));
                                                fnObj.search.submit();
                                            }
                                        }
                                    }
                                },
                                {label:"검색", labelWidth:"", type:"inputText", width:"150", key:"searchParams", addClass:"secondItem", valueBoxStyle:"", value:"",
                                    onChange: function(changedValue){
                                        //아래 2개의 값을 사용 하실 수 있습니다.
                                        //toast.push(Object.toJSON(this));
                                        //dialog.push(changedValue);
                                    }
                                }
                            ]}
                        ]
                    });
                },
	            submit: function(){
	                var pars = this.target.getParam();
	                //toast.push("콘솔창에 파라미터 정보를 출력하였습니다.");
                    fnObj.grid.setPage(fnObj.grid.pageNo, pars);
                    fnObj.form.add();
	            }
	        },
	        grid: {
                pageNo: 0,

                userYn: {Y:"사용", N:"사용안함"},
	            target: new AXGrid(),
	            bind: function(){
                    var _this = this;
                    _this.target.setConfig({
	                    targetID : "page-grid-box",
	                    theme : "AXGrid",
                        colHeadAlign:"center",
                        /*
	                    mediaQuery: {
	                        mx:{min:0, max:767}, dx:{min:767}
	                    },
	                    */
	                    colGroup : [
	                        {key:"compCd", label:"업체코드", width:"70", align:"center"},
                            {key:"userCd", label:"아이디", width:"80"},
	                        {key:"userNm", label:"이름", width:"120"},
	                        {key:"userType", label:"구분", width:"80", formatter: function(){
	                        	return Common.grid.codeFormatter("userType", this.value);
                            }},
                            {key:"useYn", label:"사용여부", width:"80", formatter: function(){
                                return fnObj.grid.userYn[this.value];
                            }},
                            {key:"accessIp", label:"아이피", width:"120"}
	                    ],
	                    body : {
	                        onclick: function(){
	                            //toast.push(Object.toJSON({index:this.index, item:this.item}));
                                fnObj.form.edit(this.item);
	                        }
	                    },
	                    page:{
                            display:true,
                            paging:false,
                            onchange: function(pageNo){
                                _this.setPage(pageNo);
                            }
	                    }
	                });
	            },
                setPage: function(pageNo, searchParams) {
                    var _this = this;
                    _this.pageNo = pageNo;
                    app.ajax({
                        type: "GET",
                        url: "/api/v1/users",
                        data: "pageNumber=" + (pageNo) + "&pageSize=50&" + (searchParams||"")
                    }, function(res){
                        if(res.error){
                            alert(res.error.message);
                        }
                        else
                        {
                            var gridData = {
                                list: res.list,
                                page:{
                                    pageNo: res.page.currentPage.number()+1,
                                    pageSize: res.page.pageSize,
                                    pageCount: res.page.totalPages,
                                    listCount: res.page.totalElements
                                }
                            };
                            _this.target.setData(gridData);
                        }
                    });
                }
	        },
	        gridUserMngPart: {
                pageNo: 0,
	            target: new AXGrid(),
	            bind: function(){
                    var _this = this;
                    _this.target.setConfig({
	                    targetID : "grid-userMngPart",
	                    theme : "AXGrid",
                        colHeadAlign:"center",
                        /*
	                    mediaQuery: {
	                        mx:{min:0, max:767}, dx:{min:767}
	                    },
	                    */
	                    colGroup : [
	                        {key:"chk", label:"", width:"70", align:"center", formatter: "checkbox"},
                            {key:"partCode", label:"파트코드", width:"120"},
	                        {key:"partName", label:"파트명", width:"120"},
	                    ],
	                    body : {
	                        onclick: function(){
	                        }
	                    },
	                    page:{
                            display:true,
                            paging:false,
                            onchange: function(pageNo){
                                _this.setPage(pageNo);
                            }
	                    }
	                });
	            },
                setPage: function(pageNo, searchParams) {
                }
	        },
            form: {
                target: $(document["table-form"]),
                validate_target: new AXValidator(),
                bind: function(){
                    this.validate_target.setConfig({
                        targetFormName : "table-form"
                    });

                    $("#password_change").bindSwitch({on:"사용", off:"사용안함", onchange:function(){
                        if(this.value == "사용안함"){
                            $("#userPs").attr("disabled", "disabled");
                            $("#userPs_chk").attr("disabled", "disabled");
                        }else{
                            $("#userPs").removeAttr("disabled");
                            $("#userPs_chk").removeAttr("disabled");
                        }
                    }});
                    $("#useYn").bindSelect();
                    /* $("#userType").bindSelect({
                        onchange: function(){
                            //trace(this.value);
                            if(this.value == "S"){
                                $("#ax-stor-finder").removeAttr("disabled");
                            }else{
                                $("#ax-stor-finder").attr("disabled", "disabled");
                            }
                        }
                    }); */
                    $("#userType").bindSelect({
                        options:fnObj.CODES.userType
                    });
                    $("#hpNo").bindPattern({
                        pattern: "phone"
                    });
                },
                init:function(){
                    /*
                    var collect = [];
                    axf.each(fnObj.grid2.target.list, function(i, item){
                        collect.push({ index: i, item: item });
                    });
                    if(collect.length >0 ) fnObj.grid2.target.removeListIndex(collect);
                    */
                },
                add: function(){
                    this.init();
                    app.form.clearForm(this.target);
                    fnObj.gridUserMngPart.target.setData({list: JSON.parse(JSON.stringify( fnObj.CODES.part ))});
                    $("#compCd").val(fnObj.compCd);
                    $("#compNm").val(fnObj.compNm);
                    $("#password_change").setValueInput("사용");
                    $("#act_tp").val("C");
                    $("#userCd").removeAttr("readonly");
                },
                edit: function(item){
                    this.init();
                    $("#act_tp").val("U");
                    $("#userCd").attr("readonly", "readonly");
                    item = $.extend({}, item);
                    delete item.userPs;
                    item.password_change = "사용안함";
                    app.form.fillForm(this.target, item);


                    var part = JSON.parse(JSON.stringify( fnObj.CODES.part ));
                    var partCodes = $.map(item.userMngPart, function(o){
                    	return o.partCode;
                    });

                    var userMngPart = $.map(part, function(o){
                   		o.___checked = [];
                    	o.___checked.push(partCodes.indexOf(o.partCode) != -1);
                    	return o;
                    });

                    fnObj.gridUserMngPart.target.setData({list: userMngPart});
                },
                save: function(){

                    var validateResult = this.validate_target.validate();
                    if (!validateResult) {
                        var msg = this.validate_target.getErrorMessage();
                        AXUtil.alert(msg);
                        this.validate_target.getErrorElement().focus();
                        return false;
                    }

                    var item = app.form.serializeObjectWithIds(this.target);
                    var checkedList = fnObj.gridUserMngPart.target.getCheckedListWithIndex(0);// colSeq
                    item.userMngPart = $.map(checkedList, function(o){
                    	o.item.userCd = item.userCd;
                    	return o.item;
                    });
                    //console.log(item);
                    
                    if(item.password_change == "사용"){
                    	if(Common.security.chkPw(item.userCd, item.userPs, item.userPs_chk) != true){
                        	return false;
                        }
                    }

                    app.ajax({
                        type: "PUT",
                        url: "/api/v1/users",
                        data: Object.toJSON([item])
                    }, function(res){
                        if(res.error){
                            alert(res.error.message);
                        }
                        else
                        {
                            // 그리드 새로고침
                            fnObj.search.submit();
                        }
                    });
                }
            }
	    };
	    </script>
	</ax:div>
</ax:layout>