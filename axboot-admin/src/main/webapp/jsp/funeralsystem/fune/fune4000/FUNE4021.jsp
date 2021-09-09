<%----------------------------------------------------------------------------------------
 - 파일이름	: FUNE4021.jsp
 - 설      명	: 생산 관리 > 식단관리 > 식단 작업 등록 팝업 화면
 - 작 성 자		: KYM
 - 추가내용 	:
 - 버전관리	: 1.0
 ----------------------------------------------------------
 - Date        Version   Auther   Description
 ----------------------------------------------------------
 - 2017.11.08  1.0        KYM      신규작성
------------------------------------------------------------------------------------------%>
<%@page import="java.util.Date"%>
<%@page import="com.axisj.axboot.core.util.DateUtils"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%@ taglib prefix="b" tagdir="/WEB-INF/tags" %>
<%
	request.setAttribute("title", "식단작업등록");
	request.setAttribute("yyyyMMdd", DateUtils.formatToDateString(new Date(), "yyyyMMdd"));
%>
<ax:layout name="blank.jsp">
    <ax:div name="header">

    </ax:div>
    <ax:div name="css">
    	<style type="text/css">
            .customer_title, .bill_no {
            	font-size: 20px;
            	font-weight: bolder;
            }
    	</style>
    </ax:div>
    <ax:div name="contents">

        <div class="ax-body">
            <div class="ax-wrap">
                <div class="ax-layer cx-content-layer">
                    <div class="ax-col-12 ax-content expand">
                        <!-- s.CXPage -->
                        <div id="CXPage">

                            <ax:row>
                                <ax:col >
                                	<div style="height: 30px;"></div>
                   					<ax:custom customid="table">
	                    				<ax:custom customid="tr">

			                        		<ax:custom customid="td" style="width:40%">
			                        			<div class="ax-button-group">
			                                        <div class="left">
														<h1><i class="axi axi-web"></i> 식단작업등록</h1>
			                                        </div>
			                                        <div class="ax-clear"></div>
			                                    </div>
			                                    <div class="ax-button-group">
				                                    <div class="right">
															<%-- <b:button text="조회" id="btn-itemSearch"></b:button> --%>
															<b:button text="선택식품추가" id="btn-addSelectedItem"></b:button>
				                                    </div>
			                                    </div>
			                                    <div class="ax-search" id="page-search-box"></div>
			                                    <div id="div-grid-item">
													<div id="div-grid-item1" style="height: 614px;"></div>
													<div id="div-grid-item2" style="height: 577px;"></div>
												</div>
	    	    	                        </ax:custom>

			                        		<ax:custom customid="td"> <!-- style="width: 770px;" -->
			                                    <div class="ax-button-group">
			                                        <div class="left">
														<b:button text="위로이동" id="btn-upItem"></b:button>
														<b:button text="아래로이동" id="btn-downItem"></b:button>
														<b:button text="삭제" id="btn-removeSelectedItem"></b:button>
			                                        </div>
			                                        <div class="right">
														<b:button text="식단저장" id="btn-save"></b:button>
														<b:button text="식단삭제" id="btn-deleteRecipe"></b:button>
														<b:button text="엑셀" id="btn-excel"></b:button>
														<b:button text="초기화" id="btn-init"></b:button>
			                                        </div>
			                                        <div class="ax-clear"></div>
			                                    </div>

												<div id="div-productionstmtbd-info"></div>
												<table cellpadding="0" cellspacing="0" class="AXGridTable">
												    <tbody>
												    	<tr>
												    		<th style='width:20%;'>조리일자 / 구분
												    		</th>
												    		<td>
												    			<input type="text" id="cook-date" name="cook-date" title="조리일자" class="AXInput" style="text-align:center;" disabled/>
												    			&nbsp;
												    			<select id="info-meal-gubun" name="info-meal-gubun" class="AXSelect W100"></select>
												    		</td>
												    	</tr>
												    	<tr>
												    		<th>계획량 / 조리량
												    		</th>
												    		<td>
												    			<input type="text" id="plan-qty" name="plan-qty" title="계획량" class="AXInput" style="text-align:center;"/>
												    			&nbsp;
												    			<input type="text" id="make-qty" name="make-qty" title="조리량" class="AXInput" disabled style="text-align:center;"/>
												    		</td>
												    	</tr>
												    </tbody>
												</table>



												<div id="div-grid-recipeItem" style="height: 740px;"></div>
	    	    	                        </ax:custom>

    	    	                        </ax:custom>
        	                        </ax:custom>

                                </ax:col>
                            </ax:row>
							<div id="div-hidden" style="width: 0px; height: 0px"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </ax:div>
    <ax:div name="scripts">
<!--         <script type="text/javascript" src="/static/plugins/axisj/lib/AXGrid.js"></script> -->
        <script type="text/javascript" src="/static/js/common/common.js"></script>
        <script type="text/javascript">

        	var bfRecipeItem = [];

            var fnObj = {
            	CODES: {
            		mealsGubun: Common.getCode("091")
            	},
            	CONSTANTS: {
            	},
            	data: {
            		  recipe 				: null
            		, recipeItem 		: null
            		, partCode 			: ""
            		, itemCode			: ""
            		, recipeCode		: ""
            		, recipeDate		: ""
            		, recipeGubun		: ""
            		//식단자료가져오기클릭
            		, getMenuItem		: ""
            		, concatRemark	: ""
            	},
            	condition: {
            		isAdd: function(){
            			return "${param.execute}" == "new";
            		}
            		, isMod: function(){
            			return "${param.execute}" == "mod";
            		}
            	},
                pageStart: function () {
              		this.data.partCode		= "${param.partCode}";
                    this.data.itemCode		= "${param.itemCode}";
                    this.data.recipeCode	= "${param.recipeCode}";

                    this.data.recipeDate		= this.data.recipeCode.substring(0,4) + "-" + this.data.recipeCode.substring(4,6) + "-" +this.data.recipeCode.substring(6,8);
                    if(this.data.recipeCode.length === 10){
                    	this.data.recipeGubun	= this.data.recipeCode.substring(8,10);
                    }

                    this.search.bind();
                    this.gridRecipeItem.bind();
                    this.gridItem1.bind();
                    this.gridItem2.bind();
                    this.bindEvent();
                    this.defaultFn.excute();
                    //this.search.submit();

                    //검색 테이블 밑에 상세검색 보여주기 텍스트 가리기
                    //display:false 로 주면 자동으로 이 부분이 생성됨.
                    $(".expandHandle").hide();
                    //식단 아이템 그리드 숨기기
                    $("#div-grid-item1").show();
                    $("#div-hidden").append($("#div-grid-item2"));
                },
                defaultFn: {
                	// 우측상단/우측 그리드 정보 표기
                	 searchMenuInfo: function(){
                		 //조리일자
                		 $("#cook-date").val(fnObj.data.recipeDate);
                		 //조/중/석식 콤보
                		 $("#info-meal-gubun").bindSelect({
                             options:fnObj.CODES.mealsGubun,
                             onchange: function(){
                            	 //로딩시 무조건 탄다. 결국 이 이벤트로 그리드 세팅.
                            	 fnObj.data.recipeCode = fnObj.data.recipeCode.substring(0,8) + this.value;
                            	 var params = "partCode="+ fnObj.data.partCode + "&itemCode="+fnObj.data.itemCode+"&recipeCode="+fnObj.data.recipeCode;
                            	 fnObj.gridRecipeItem.setPage(params);
					           }
                         });
                		 if(fnObj.condition.isMod) $("#info-meal-gubun").bindSelectSetValue(fnObj.data.recipeGubun);
                	}
                	, excute: function(){
                		//전화면에서 m 으로 실행할 함수를 전달해줌.
                		for(var key in this.fn){
                			this.fn[key]();
                		}
                		if("" == "${param.m}" || fnObj.defaultFn["${param.m}"] == undefined){
                			return;
                		}
                		fnObj.defaultFn["${param.m}"]();
                	}
                	, fn: {
                		initButtons: function(){
                			if(fnObj.condition.isAdd()){
                				console.log("ADD")
                			}else if(fnObj.condition.isAdd()){
                				console.log("MOD")
                			}
                		}
                	}
                },
                bindEvent: function () {
                	$.each($("button[id^=btn-]"), function(i, o){
                		var fn = fnObj.eventFn[o.id.substring("btn-".length)];
                		if(!fn){
                			console.log("button[id="+o.id+"] 의 이벤트 함수가 존재하지 않습니다.");
                		}else{
                			$(o).bind("click", fn);
                		}
                	});
                	//검색부분 품목코드 , 품목명 엔터 조회
                	$(".AXInput.searchInputTextItem").keydown(function (key) {
                        if(key.keyCode == 13){
                        	fnObj.eventFn.itemSearch();
                        }
                    });
                },
                //왼쪽 그리드 제어
                controlGrid: function(){
                	//체크 변경시 그리드 초기화 하려면 주석 제거
                	//fnObj.gridItem1.target.setData({list:[]});
                	//fnObj.gridItem2.target.setData({list:[]});

            		if(fnObj.data.getMenuItem == "all"){
            			$("#div-hidden").append($("#div-grid-item1"));
            			$("#div-grid-item").append($("#div-grid-item2"));
            		}else{
            			$("#div-grid-item").append($("#div-grid-item1"));
            			$("#div-hidden").append($("#div-grid-item2"));
            		}
            	}
                ,eventFn: {
                	 save: function(){
                		if(fnObj.gridRecipeItem.target.list.length == 0){
                			alert("저장할 항목이 없습니다!")
                			fnObj.defaultFn.searchMenuInfo();
                			return;
                		}
                		var gubun = $("#info-meal-gubun option:selected").text();
                		var confirmTxt = fnObj.data.recipeDate.date().print("yyyy년 mm월 dd일 ") + gubun;
                		if(!confirm(confirmTxt + " 식단을 저장 하시겠습니까?")){
							return;
						}

                		// 클릭 후 바로 저장 클릭 시 값 변화 없음 ※※※※※※※※※※※※※※※※※※※※문제※※※※※※※※※※※※※※※※※※※※※※※
                		var item_code 	= fnObj.data.itemCode;
                		var recipe_code 	= fnObj.data.recipeCode.substring(0,8);
                		recipe_code = recipe_code + $("#info-meal-gubun").val();
                		//레시피 이름 만들기
                		var recipe_nm = "#"+recipe_code.substring(4,6)+"/"+recipe_code.substring(6,8)+"(" + $("#info-meal-gubun option:selected").text() + ")";
                		if(fnObj.data.concatRemark !== ""){
                			var str_cut = jQuery.trim(fnObj.data.concatRemark).substring(0, 13).trim(this);
                			recipe_nm  = recipe_nm +  " - " + str_cut;
                		}

                		//새로 추가시 식단에서 가져오면 레시피코드를 기존 등록된 것으로 , 일반 아이템에서 가져오면 없는 채로 목록 구성됨.
                		//등록 할 레시피코드로 아이템 변경
                		var _target = fnObj.gridRecipeItem.target;
                    	$.each(_target.list, function(i, o){
                    		_target.updateItem(0, 3, i, recipe_code);
                    	});

                		 var recipe = {
                				 recipeItemList		: fnObj.gridRecipeItem.target.list
							,	bfRecipeItemList	: bfRecipeItem
                			,	partCode	 		: fnObj.data.partCode
                			, 	itemCode			: item_code
                			,   recipeCode			: recipe_code
                			,   recipeName			: recipe_nm
                			, 	menuPlanQty		: $("#plan-qty").val()
                			,	remark				: fnObj.data.concatRemark
                    	}
                		 console.log("sava beforer**********************",recipe);

                		app.ajax({
                            type: "POST",
                            url: "/FUNE4021/recipe",
                            data: Object.toJSON(recipe)
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{
                        		console.log("sava after**********************",res)
                        		fnObj.data.recipe 	= res.map.recipe;
                        		fnObj.data.recipeCode = fnObj.data.recipe.recipeCode;
                        		bfRecipeItem = $.extend(true, [], fnObj.data.recipe.recipeItem);


                        		// ▼▼▼▼▼▼▼▼▼▼▼부모창 변경.
                        		parent.fnObj.search.submit();
                            }
                        });
                	}
                	//좌측 선택 식품 추가
                	, addSelectedItem: function(){
                		var _target;
                		var checkedList 	= [];
                		var checkedListChange 	= [];
                		var add_target 	=	fnObj.gridRecipeItem.target;
                		if(fnObj.data.getMenuItem === "all"){
                			_target 			= fnObj.gridItem2.target;
                			checkedList 	= _target.getCheckedListWithIndex(0);
                		}else{
                			_target 			= fnObj.gridItem1.target;
                			checkedList 	= _target.getCheckedListWithIndex(0);
                		}

                		if(checkedList.length == 0){
                			alert("선택된 목록이 없습니다.");
                			return;
                		}
                		//체크 목록 복사 후 처리
                		checkedListChange = $.extend(true, [], checkedList);

            			//두 그리드 목록 패턴이 달라서 우측 그리드 recipe_item 에 맞추어 json 변형
            			var arrNewExtendList = [];
            			$.each(checkedListChange, function(i, o){
            				var obj = {};
            				obj.partCode 	= o.item.partCode;
            				if(typeof o.item.recipeCode === "undefined"){
            					obj.recipeCode	= "";
            				}else{
            					obj.recipeCode	= o.item.recipeCode;
            				}

            				if(fnObj.data.getMenuItem === "all"){
            					obj.item 			= {partCode:o.item.item.partCode, itemCode:o.item.mateCode , itemName:o.item.item.itemName, prodUnit:o.item.item.prodUnit};
            					obj.itemCode 	= o.item.itemCode;
            					obj.mateCode 	= o.item.mateCode;
            					obj.qty		 	= o.item.qty;
                				obj.remark	 	= o.item.remark;
                				obj.sortNo		= o.item.sortNo;
            				}else{
            					obj.item 			= {partCode:o.item.partCode, itemCode:o.item.itemCode , itemName:o.item.itemName, prodUnit:o.item.prodUnit};
            					obj.itemCode 	= "90-9998";
            					obj.mateCode 	= o.item.itemCode;
            					obj.qty		 	= "";
                				obj.remark	 	= "";
                				obj.sortNo		= "0";
            				}
            				arrNewExtendList.push(obj);
                    	});
            			console.log("ooo", arrNewExtendList);

            			//체크한 항목 체크 해제. 놔두면 추가로 체크할때 기 체크된 것까지 넘어감. 아예 체크를 해제해버림.
            			_target.checkedColSeq(0, false);
                		//console.log("checkedListChange@@@", JSON.stringify(arrNewExtendList));
                		add_target.pushList(arrNewExtendList);
                		fnObj.gridRecipeItem.gridReSort();
                		fnObj.gridRecipeItem.strConcat();
                	}
                	//우측 선택 삭제
                	, removeSelectedItem: function(){
                		var _target = fnObj.gridRecipeItem.target;

                		var checkedList = _target.getCheckedListWithIndex(0);
                		 if(checkedList.length == 0){
                             alert("선택된 목록이 없습니다. 삭제하시려는 목록을 체크하세요");
                             return;
                         }
                		 // checkedList = [{item:{item:}}]
                		_target.removeListIndex(checkedList);
                		fnObj.gridRecipeItem.strConcat();
                	}
                	//위로 이동
                	,upItem : function(){
                		var _target 				= fnObj.gridRecipeItem.target;
                		var checkedListIndex 	= _target.getCheckedListWithIndex(0);
                		var checkedList	 		= _target.getCheckedList(0);
                		//하나이상 선택 안됨.
                		if(checkedList.length == 0){
                			alert("선택된 목록이 없습니다.");
                			return;
                		}
                		//체크한 항목 복사
                		var chkItem 				= $.extend(true, [], checkedList);
                		var chkIndex 				= checkedListIndex[0].index;

                		if(checkedList.length > 1){
                			alert("하나의 로우만 선택 하세요!");
                			return;
                		}
                		chkIndex--;
                		if (chkIndex < 0) {
                			return;
                		}
                		_target.removeListIndex(checkedListIndex);
                		_target.pushList(chkItem, chkIndex);
                		fnObj.gridRecipeItem.gridReSort();
                		fnObj.gridRecipeItem.strConcat();
                	}
                	//아래로 이동
                	,downItem : function(){
                		var _target 				= fnObj.gridRecipeItem.target;
                		var checkedListIndex 	= _target.getCheckedListWithIndex(0);
                		var checkedList	 		= _target.getCheckedList(0);
                		if(checkedList.length == 0){
                			alert("선택된 목록이 없습니다.");
                			return;
                		}
                		//체크한 항목 복사
                		var chkItem 				= $.extend(true, [], checkedList);
                		var chkIndex 				= checkedListIndex[0].index;
                		//하나이상 선택 안됨.
                		if(checkedList.length > 1){
                			alert("하나의 로우만 선택 하세요!");
                			return;
                		}
                		chkIndex++;
                		if (chkIndex >= _target.list.length) {
                			return;
                		}
                		_target.removeListIndex(checkedListIndex);
                		_target.pushList(chkItem, chkIndex);
                		fnObj.gridRecipeItem.gridReSort();
                		fnObj.gridRecipeItem.strConcat();
                	}
                	//식단 삭제
                	, deleteRecipe: function(){
                		if(fnObj.data.recipeCode == null){
                			return;
                		}
                		var gubun = $("#info-meal-gubun option:selected").text();
                		var confirmTxt = fnObj.data.recipeDate.date().print("yyyy년 mm월 dd일 ") + gubun;
                		if(!confirm(confirmTxt + " 식단을 삭제 하시겠습니까?")){
							return;
						}
                		 var recipe = {
                 				partCode 		: fnObj.data.partCode
                 			,	itemCode 		: fnObj.data.itemCode
                 			,   recipeCode		: fnObj.data.recipeCode
                 			,	recipeItem		: bfRecipeItem
                     	}
                		 console.log("DELETE ",recipe);

                		app.ajax({
                            type: "DELETE",
                            url: "/FUNE4021/recipe",
                            data: Object.toJSON(recipe)
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{
								alert(fnObj.data.recipeDate.date().print("yyyy년 mm월 dd일 ") + gubun + " 식단이 삭제되었습니다.");
								parent.fnObj.search.submit();
								self.close();
                            }
                        });
                	}
                	,init:function(){
                		window.location.reload();
                	}
                	,//좌측 그리드 검색
                	itemSearch : function(){
                		var part_code = $("#"+fnObj.search.target.getItemId("groupCode")).val();
                		//식품분류코드 : 전체는 빈값
                		var group_code 	= $("#"+fnObj.search.target.getItemId("itemGroupCode")).val();
                		//품목코드
                		var item_code 	= $("#"+fnObj.search.target.getItemId("itemCode")).val();
                		//품목명
                		var item_name 	= $("#"+fnObj.search.target.getItemId("itemName")).val();
                		//▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼식단 자료 가져오기 파라미터▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼
                		var menu_date 	= $("#"+fnObj.search.target.getItemId("menuDate")).val();
                		var recipe_gubun = $("#"+fnObj.search.target.getItemId("recipeGubunCode")).val();
                		var recipe_code 	= menu_date.replace(/-/g, '') +recipe_gubun;
                		//▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲식단 자료 가져오기 파라미터▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲

                		var recipe_srch_url;
                		//식단 가져오기에 따라 검색 조건들이 달라짐.
                		recipe_srch_url = "/FUNE4021";
                		//기존 레시피에서 가져오기

                		if(fnObj.data.getMenuItem === "all"){
                			recipe_srch_url = recipe_srch_url +  "/recipe/recipeItem";
                			recipe_srch_url = recipe_srch_url + "?partCode="+ part_code +"&groupCode="+group_code+"&itemCode="+item_code+"&itemName="+item_name;
                			recipe_srch_url = recipe_srch_url + "&recipeCode="+recipe_code;
                		//아이템에서 가져오기
                		}else{
                			recipe_srch_url = recipe_srch_url +  "/recipe/item";
                			recipe_srch_url = recipe_srch_url + "?partCode="+ part_code + "&groupCode="+group_code+"&itemCode="+item_code+"&itemName="+item_name;
                		}

               			app.ajax({
                               type: "GET",
                               url: recipe_srch_url,
                               data: ""
                           },
                           function(res){
								if(res.error){
	                          		alert(res.error.message);
	                          	}else{
	                          		console.log(res);
	                          		if(fnObj.data.getMenuItem === "all"){
	                          			//식단 recipe_item 에서 취득
	                          			fnObj.gridItem2.target.setData({list:res.list});
	                          		}else{
	                          			//아이템 item 에서 취득
	                          			fnObj.gridItem1.target.setData({list:res.list});
	                          		}
	                          	}
                           });

                	},
                	excel: function(){
                     	var params = [];
                     	if(fnObj.gridRecipeItem.target.list.length == 0){
                     		alert("조회된 항목이 없습니다!")
                     		return;
                     	}
                     	partCode	= fnObj.data.partCode;
                     	itemCode	= fnObj.data.itemCode;
                     	recipeCode	= fnObj.data.recipeCode;

                 		params.push("partCode="+partCode);
                 		params.push("itemCode="+itemCode);
                 		params.push("recipeCode="+recipeCode);

                 		Common.report.go("/reports/changwon/fune/FUNE4022", "excel", params.join("&"));
                	}
                },
                search: {
                    target: new AXSearch(),
                    bind: function(){
                        var _this = this;
                        this.target.setConfig({
                            targetID:"page-search-box",
                            theme : "AXSearch",
                            onsubmit: function(){
                                // 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.
                                fnObj.search.submit();
                            },
                            rows:[
                                {display:true, addClass:"", style:"", list:[
									{label: "파트", labelWidth: "100", type: "selectBox", width: "100", key:"groupCode" , addClass:"" , valueBoxStyle:"" , value:"" ,
									    options:[],
									    AXBind:{
									        type:"select" , config:{
									       	 reserveKeys: {
									                options: "list",
									                optionValue: "partCode",
                                                    optionText: "partName"
									           },
									           ajaxUrl:"/FUNE4021/part",
									           ajaxPars:"partGroupCode=2",
									           setValue: fnObj.data.partCode,
									           alwaysOnChange: true,
									           onchange: function(){
									        	   fnObj.search.submit();
									           }
									        }
									    }
									}
									,{label:"", labelWidth:"", type:"checkBox", width:"145", key:"checkMenuInfo", addClass:"", valueBoxStyle:"", value:"",
										options:[{optionValue:"all", optionText:"식단자료가져오기", title:"식단자료가져오기"}],
										onChange: function(selectedObject, value){
											//체크박스 값 전역변수에서 관리
											fnObj.data.getMenuItem = value;
											// 안보여주고 강제 클릭
											$(".expandHandle").click();
											// 그리드 제어
											fnObj.controlGrid();
										}
									}
                                ]},
                                //display:false 주면 테이블 하단에 상세 검색이라고 확장 가능한 버튼이 생성된다.
                                {display:false, addClass:"", style:"", list:[
									{label:"조리일자/구분", labelWidth:"", type:"inputText", width:"100", key:"menuDate", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
											onChange: function(){
											}
											, AXBind:{
		        								type:"date", config:{
		        									align:"right", valign:"top", defaultDate:new Date().print(),
		        									onChange:function(){
		        									}
		        								}
		        							}
									},
									{label: "", labelWidth: "100", type: "selectBox", width: "100", key:"recipeGubunCode" , addClass:"" , valueBoxStyle:"" , value:"" ,
									    options:fnObj.CODES.mealsGubun
									}
                               ]},
                                {display:true, addClass:"", style:"", list:[
                                      {label: "식품분류", labelWidth: "100", type: "selectBox", width: "100", key:"itemGroupCode" , addClass:"" , valueBoxStyle:"" , value:"" ,
                                          options:[],
                                          AXBind:{
                                              type:"select" , config:{
                                             	 reserveKeys: {
                                                      options: "list",
                                                      optionValue: "groupCode",
                                                      optionText: "groupName"
                                                 },
                                                 ajaxUrl:"/FUNE4021/recipe/itemGroup",
             									ajaxPars:"partCode=" + fnObj.data.partCode,
                                                 alwaysOnChange: true,
                                                 isspace: true,
                                                 isspaceTitle: "전체",
                                                 setValue:"ALL",
                                                 onchange: function(){
                                                 	//fnObj.search.submit();
                                                 }
                                              }
                                          }
                                      }
                                 ]},
                                 {display:true, addClass:"", style:"", list:[
              						{label:"품목코드", labelWidth:"", type:"inputText", width:"150", key:"itemCode", addClass:"", valueBoxStyle:"", value:"",
              							onChange: function(){}
              						}
                               ]},
                               {display:true, addClass:"", style:"", list:[
              						{label:"품목명", labelWidth:"", type:"inputText", width:"150", key:"itemName", addClass:"", valueBoxStyle:"", value:"",
              							onChange: function(){}
              						},
              						//버튼이 위에 있어 추가를 누르려다가 조회를 눌러버리는 불편함 때문에 이곳으로 옮김. 기존화면과 맞추려면 이부분 제거 위에 조회 버튼 주석 제거
              						{label:"", labelWidth:"", type:"button", width:"50", key:"ensType", addClass:"", valueBoxStyle:"", value:"조회",
              							onclick: function(){
              								fnObj.eventFn.itemSearch();
              							}
              						}
                               ]}
                            ]
                        });

                    },
                    submit: function(){
                    	$("#"+fnObj.search.target.getItemId("groupCode")).bindSelectDisabled();
                    	var pars = fnObj.search.target.getParam();
                    	console.log("좌측 그리드 검색 파라미터들~~~",pars)
                    	//fnObj.gridItem1.setPage(pars);
                    }
                },

                //좌측 아이템 그리드
                gridItem1: {
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "div-grid-item1",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            colGroup : [
								{key:"index"			, label:"선택"			, width:"35"		, align:"center", formatter:"checkbox"},
                                {key:"partCode"		, label:"코드"			, width:"0"		, align:"left", display:false},
                                {key:"itemCode"		, label:"식품코드"	, width:"100"	, align:"left"},
                                {key:"itemName"		, label:"식품명"		, width:"150"	, align:"left"},
                                {key:"prodUnit"		, label:"단위"			, width:"80"		, align:"center"}
                            ],
                            body : {
                                ondblclick: function(i, o){
                                	//trace(o);
                                 	//check
                                  	var add_target 	=	fnObj.gridRecipeItem.target;
                        			var arrNewExtendList = [];
                    				var obj = {};
                    				obj.partCode = o.partCode;
                    				if(typeof o.recipeCode === "undefined"){
                    					obj.recipeCode	= "";
                    				}else{
                    					obj.recipeCode	= o.recipeCode;
                    				}

                    				if(fnObj.data.getMenuItem === "all"){
                    					obj.item 			= {partCode:o.partCode, itemCode:o.mateCode , itemName:o.itemName, prodUnit:o.prodUnit};
                    					obj.itemCode 	= o.itemCode;
                    					obj.mateCode 	= o.mateCode;
                    					obj.qty		 	= o.qty;
                        				obj.remark	 	= o.remark;
                        				obj.sortNo		= o.sortNo;
                    				}else{
                    					obj.item 			= {partCode:o.partCode, itemCode:o.itemCode , itemName:o.itemName, prodUnit:o.prodUnit};
                    					obj.itemCode 	= "90-9998";
                    					obj.mateCode 	= o.itemCode;
                    					obj.qty		 	= "";
                        				obj.remark	 	= "";
                        				obj.sortNo		= "0";
                    				}

                    				arrNewExtendList.push(obj);
                        			console.log("ooo", arrNewExtendList);

                            		add_target.pushList(arrNewExtendList);
                            		fnObj.gridRecipeItem.gridReSort();
                            		fnObj.gridRecipeItem.strConcat();
                            		fnObj.gridRecipeItem.target.scrollTop(fnObj.gridRecipeItem.target.list.length-1)
                                }
                            },
                            page: {
                                display: false,
                                paging: false,
                                onchange: function(pageNo){
                                    _this.setPage(pageNo);
                                }
                            }
                        });
                    },
                    setPage: function(searchParams){
                    }
                },
                //recipe_item 우측 품목 그리드 - 식단 자료 가져오기 클릭하면 보여 줄 그리드. 항목이 다름.
                gridItem2: {
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "div-grid-item2",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            colGroup : [
								{key:"index"			, label:"선택"			, width:"35"		, align:"center", formatter:"checkbox"},
                                {key:"partCode"		, label:"코드"			, width:"0"		, align:"left", display:false},
                                {key:"recipeCode"	, label:"코드"			, width:"0"		, align:"left", display:false},
                                {key:"itemCode"		, label:"코드"			, width:"0"		, align:"left", display:false},
                                {key:"mateCode"		, label:"식품코드"	, width:"100"	, align:"left"},
                                {key:"itemName"		, label:"식품명"		, width:"150"	, align:"left"
                                	, formatter: function(){
   	                                	if(this.item.item){
   		                               		return this.item.item.itemName;
   	                                	}else{
   	                                		return "";
   	                                	}
                                   	}
                                },
                                {key:"prodUnit"		, label:"단위"			, width:"50"		, align:"center"
                                	, formatter: function(){
	                                	if(this.item.item){
		                               		return this.item.item.prodUnit;
	                                	}else{
	                                		return "";
	                                	}
                                	}
                                },
                                {key:"qty"				, label:"수량"			, width:"50"		, align:"center"},
                                {key:"remark"			, label:"요리명"		, width:"100"	, align:"left"}
                            ],
                            body : {
                                ondblclick: function(){
                                	var add_target 	=	fnObj.gridRecipeItem.target;
                        			var arrNewExtendList = [];
                    				var obj = {};
                    				obj.partCode = o.partCode;
                    				if(typeof o.recipeCode === "undefined"){
                    					obj.recipeCode	= "";
                    				}else{
                    					obj.recipeCode	= o.recipeCode;
                    				}

                    				if(fnObj.data.getMenuItem === "all"){
                    					obj.item 			= {partCode:o.partCode, itemCode:o.mateCode , itemName:o.itemName, prodUnit:o.prodUnit};
                    					obj.itemCode 	= o.itemCode;
                    					obj.mateCode 	= o.mateCode;
                    					obj.qty		 	= o.qty;
                        				obj.remark	 	= o.remark;
                        				obj.sortNo		= o.sortNo;
                    				}else{
                    					obj.item 			= {partCode:o.partCode, itemCode:o.itemCode , itemName:o.itemName, prodUnit:o.prodUnit};
                    					obj.itemCode 	= "90-9998";
                    					obj.mateCode 	= o.itemCode;
                    					obj.qty		 	= "";
                        				obj.remark	 	= "";
                        				obj.sortNo		= "0";
                    				}

                    				arrNewExtendList.push(obj);
                        			console.log("ooo", arrNewExtendList);

                            		add_target.pushList(arrNewExtendList);
                            		fnObj.gridRecipeItem.gridReSort();
                            		fnObj.gridRecipeItem.strConcat();
                                	fnObj.gridRecipeItem.target.scrollTop(fnObj.gridRecipeItem.target.list.length-1)
                                }
                            },
                            page: {
                                display: false,
                                paging: false,
                                onchange: function(pageNo){
                                    _this.setPage(pageNo);
                                }
                            }
                        });
                    },
                    setPage: function(searchParams){
                    }
                }
                ,//우측 기 등록된 레시피 아이템 그리드
                gridRecipeItem: {
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "div-grid-recipeItem",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            colGroup : [
								 {key:"index"			, label:"선택"			, width:"35"		, align:"center", formatter:"checkbox"},
								 {key:"partCode"		, label:"코드"			, width:"0"		, align:"left", display:false},
								 {key:"itemCode"		, label:"코드"			, width:"0"		, align:"left", display:false},
								 {key:"recipeCode"	, label:"코드"			, width:"0"		, align:"left", display:false},
								 {key:"mateCode"		, label:"식품코드"	, width:"100"	, align:"left"},
                                 {key:"itemName"		, label:"식품명"		, width:"180"	, align:"left", formatter: function(){
   	                                	if(this.item.item){
   		                               		return this.item.item.itemName;
   	                                	}else{
   	                                		return "";
   	                                	}
                                   	}
                                },
                                {key:"prodUnit", label:"단위", width:"80", align:"center", formatter: function(){
	                                	if(this.item.item){
		                               		return this.item.item.prodUnit;
	                                	}else{
	                                		return "";
	                                	}
                                	}
                                },
                                {key:"qty", label:"수량", width:"80", align:"center", formatter: "number", editor:{
	                                    type:"number",
	                                    "range": { // 숫자일 경우 숫자자릿수와 소수점 자릿수 지정
	                                        "val": "9,1"
	                                        ,msg : '' // 자릿수를 초과 했을대 보여줄 메시지.
	                                    },
	                                    maxLength: 50,
	                                    beforeUpdate: function(val){
	                                    	return val < 0 || isNaN(Number(val)) ? 0 : val;
	                                    },
	                                    afterUpdate: function(){
	                                    	fnObj.gridRecipeItem.target.updateList(this.index, this.item);
	                                    }
	                                }
                                },
                                {key:"remark", label:"요리명", width:"150", align:"left", editor:{
                                    type:"text",
                                    maxLength: 20,
                                    afterUpdate:function(){
                                    	fnObj.gridRecipeItem.target.updateList(this.index, this.item);
                                    	fnObj.gridRecipeItem.strConcat();
                                    }
                              	}},
                              	{key:"sortNo"		, label:"코드"	, width:"100"	, align:"center",display:false}
                            ],
                            body : {
                            	ondblclick: function(){
                                },
                            },
                            page: {
                                display: false,
                                paging: false,
                                onchange: function(pageNo){
                                    _this.setPage(pageNo);
                                }
                            }
                        });
                    },
                    setPage: function(searchParams){
                    	console.log("setPAge",searchParams);
                    	var _target = this.target;
                    	app.ajax({
                            type: "GET",
                            url: "/FUNE4021/recipe?"+ searchParams,
                            data: ""
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{
                        		console.log(res.map.recipe)
                        		//레시피
                        		fnObj.data.recipe	= $.extend({}, res.map.recipe);
                        		//레시피 아이템 복사
								bfRecipeItem 		= $.extend(true, [], fnObj.data.recipe.recipeItem);
                        		//상단 계획/조리량 세팅
                        		$("#plan-qty").val(fnObj.data.recipe.menuPlanQty);
                        		$("#make-qty").val(fnObj.data.recipe.menuMakeQty);
                        		// 등록화면으로 들어오면 레시피 자체가 없다.
                        		if(fnObj.data.recipe.recipeItem === undefined){
                        			fnObj.gridRecipeItem.target.setData({list:[]});
                        		}else{
                        			//그리드 세팅
                        			fnObj.gridRecipeItem.target.setData({list:fnObj.data.recipe.recipeItem});
                        		}
                        	}
                        	fnObj.gridRecipeItem.strConcat();
                        });

                    }
                    //그리드 정렬번호 정리
                    ,gridReSort:function(item, itemIndex){
                    	var _target = this.target;
                    	var cnt = 1;
                    	$.each(_target.list, function(i, o){
                    		_target.updateItem(0, 9, i, cnt);
                    		cnt = cnt + 1
                    	});
                    }
                    //요리명 문자열 붙이기
                    , strConcat: function(){
                    	var targetList = this.target.list;
                    	var concatList = [];
                    	$.each(targetList, function(idx,val) {
                    		  var str = val.remark;
                    		  concatList.push(str);
                    	});
                    	fnObj.data.concatRemark = concatList.join("");
                    }

                }
            };
            $(document.body).ready(function () {
                fnObj.pageStart();
            });
            //새로고침 F5 키 detect
            /* $(document.body).on("keydown", this, function (event) {
                if (event.keyCode == 116 && fnObj.data.recipeCode  !==  null && fnObj.data.recipeCode  !==  "") {
                    var url = window.location.href;
		         	var separator = (url.indexOf('?') > -1) ? "&" : "?";
		         	var qs = "billNo=" + encodeURIComponent(fnObj.data.billNo);
		         	var str_url;
		         	if((url.indexOf('billNo') > -1)){
		         		str_url = url;
		         	}else{
		         		str_url = url + separator + qs;
		         	}
		         	window.location.href = str_url;
                }
            });  */
        </script>
    </ax:div>
</ax:layout>