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


                <ax:custom customid="table">
                    <ax:custom customid="tr">
                        <ax:custom customid="td">
                            <!-- <h2><i class="axi axi-list-alt"></i> 정보리스트</h2> -->
                            <%-- %%%%%%%%%% 그리드 (업체정보) %%%%%%%%%% --%>
                            <div class="ax-button-group">
                                <div class="right">
                                    <button type="button" class="AXButton" id="ax-form-btn-add"><i class="axi axi-plus-circle"></i> 선택품목추가</button>
                                </div>
                                <div class="ax-clear"></div>
                            </div>
                            <div class="ax-search" id="page-search-box"></div>
                            <div class="ax-grid" id="page-grid-box" style="min-height: 300px;"></div>
                        </ax:custom>

                        <ax:custom customid="td">
                            <%-- %%%%%%%%%% 신규 버튼 (업체등록) %%%%%%%%%% --%>
                            <div class="ax-button-group">
                                <div class="left">
                                    <button type="button" class="AXButton" id="ax-form-btn-up"><i class="axi axi-keyboard-arrow-up"></i> 위로이동</button>
                                    <button type="button" class="AXButton" id="ax-form-btn-down"><i class="axi axi-keyboard-arrow-down"></i> 아래로이동</button>
                                    <button type="button" class="AXButton" id="ax-form-btn-del"><i class="axi axi-minus-circle"></i> 선택품목제거</button>
                                </div>
                                <div class="right">
                                    <!-- <button type="button" class="AXButton" id="ax-form-btn-save"><i class="axi axi axi-save"></i> 저장</button>
                                    <button type="button" class="AXButton" id="ax-form-btn-excel"><i class="axi axi-file-excel-o"></i> 엑셀</button> -->
                                </div>
                                <div class="ax-clear"></div>
                            </div>

                            <div class="ax-search" id="set-search-box"></div>
							<div class="ax-grid" id="set-group-grid-box" style="min-height: 300px;"></div>
                        </ax:custom>
                    </ax:custom>
                </ax:custom>

            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
        <script type="text/javascript">
            var resize_elements = [
                {id:"page-grid-box", adjust:-135}
                , {id:"set-group-grid-box", adjust:-97}
            ];
            var fnObj = {
                CODES: {
                    "etc3": [
                        {CD:'1', NM:"코드"},
                        {CD:'2', NM:"CODE"},
                        {CD:'4', NM:"VA"}
                    ],
                    "_etc3": {"1":"코드", "2":"CODE", "4":"VA"}
                },

                pageStart: function(){

                    this.search.bind();
                    this.grid.bind();
                    //this.form.bind();
                    this.bindEvent();
                    this.setGroupSearch.bind();
                    this.setGroupGrid.bind();
                    // 페이지 로딩 후 바로 검색 처리하기 (option)
                    //this.search.setItemGroupSelectOptions("");
                    //this.search.setSetGroupSelectOptions("");
                    this.search.firstOptionSelect();
                    //this.search.submit();


                },

                bindEvent: function(){
                    var _this = this;
                    /* $("#ax-page-btn-search").bind("click", function(){
                        _this.search.submit();
                    }); */

                    $("#ax-page-btn-excel").bind("click", function(){
                        app.modal.excel({
                            pars:"target=${className}"
                        });
                    });

                    $("#ax-form-btn-add").bind("click", function(){
                    	//_this.addItemToSet();
                    	_this.addItemToSetLocal();
                    });

                    $("#ax-form-btn-up").bind("click", function(){
                    	_this.setGroupGrid.moveUpItemLocal();
                    });

                    $("#ax-form-btn-down").bind("click", function(){
                    	_this.setGroupGrid.moveDownItemLocal();
                    });

                    $("#ax-form-btn-del").bind("click", function(){
                    	_this.setGroupGrid.removeItemLocal();
                    });

                    $("#ax-form-btn-save, #ax-page-btn-save").bind("click", function(){
                    	_this.setGroupGrid.save();
                    });


                    // 배열 위치변환시 필요한 메서드
                    Array.prototype.move = function (old_index, new_index) {
                        if (new_index >= this.length) {
                            var k = new_index - this.length;
                            while ((k--) + 1) {
                                this.push(undefined);
                            }
                        }
                        this.splice(new_index, 0, this.splice(old_index, 1)[0]);
                        return this; // for testing purposes
                    };
                },

                addItemToSetLocal: function(){

                	// 체크된 리스트를 가져온다.
		            var checkedList = fnObj.grid.target.getCheckedListWithIndex(0);// colSeq
		            if(checkedList.length == 0){
		                alert("선택된 목록이 없습니다. 추가하시려는 목록을 체크하세요");
		                return;
		            }

		           	// 리스트를 가져온다.
		           	var destList = fnObj.setGroupGrid.target.getList();
					if(destList == null || destList.length == 0){
						destList = [];
					}

					// set을 선언한다.
					var mySet = new Set();

					// set에 데이터를 담는다.
					for(var i=0; i<checkedList.length; i++){
						mySet.add(checkedList[i].item);
					}
					for(var i=0; i<destList.length; i++){
						mySet.add(destList[i]);
					}

					// set을 list로 변형한다.
					var resultList = Array.from(mySet);

		           	// 리스트를 그리드에 설정한다.
		           	fnObj.setGroupGrid.target.setList(resultList);

		         	// left-grid의 체크표시를 해제한다.
		         	fnObj.grid.target.checkedColSeq(0, false);

		           	// right-grid의 체크표시를 해제한다.
		           	fnObj.setGroupGrid.target.checkedColSeq(0, false);


		           	// 결과 메세지를 출력한다.
		           	var toastMsg = "추가되었습니다.";
		           	toastMsg += "\n데이터가 중복되는 요소들은 제외됩니다.";

		           	toast.push(toastMsg);
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
									{label:"파트", labelWidth:"", type:"selectBox", width:"150", key:"partCode", addClass:"", valueBoxStyle:"", value:"close", options:[],



										AXBind: {
									        type: "select", config: {

									            reserveKeys: {
									                  options: "list",
									                  optionValue: "partCode",
									                  optionText: "partName"
									               },

									          ajaxUrl: "/FUNE0060/part",
									          ajaxPars: null,
									          //isspace: true, isspaceTitle: "선택하세요",
									          setValue: "",
									          alwaysOnChange: false,
									          onChange: function() {
									        	 //trace(this);
									        	 _this.submit();
									        	 //fnObj.form.selectedPartCode = this.optionValue;

									        	 var partCode = this.optionValue;
									        	 _this.setItemGroupSelectOptions(partCode);
									        	 _this.setSetGroupSelectOptions(partCode);
									          }
									        }
									    }

									},
                                ]},

                                {display:true, addClass:"", style:"", list:[
	                               {label:"품목분류", labelWidth:"", type:"inputText", width:"150", key:"groupCode", addClass:"", valueBoxStyle:"", value:"", type:"selectBox",
										options:[],
                                       	AXBind:{
                                       		alwaysOnChange: true,
            								type:"select", config:{
            									onchange:function(){
            										//toast.push(Object.toJSON(this));
            										_this.submit();
            									}
            								}
            							}
	                               }
                           		]}
                            ]
                        });
                    },

                    firstOptionSelect : function(){
                    	app.ajax({
                    		url:"/FUNE0060/first-part",
                    		type:"get",
                    		data:null
                    	}, function(res){
                    		fnObj.search.setItemGroupSelectOptions(res.partCode);
                    		fnObj.search.setSetGroupSelectOptions(res.partCode);
                    	});
                    },

                    setItemGroupSelectOptions : function(partCode){
						/* 첫 번째 셀렉트박스 옵션 선택에 따른 두 번째 셀렉트박스 옵션 동적 변화 */

			        	// 선택된 아이템의 키를 통해 AJAX 요청을 한다.
			        	app.ajax({
			        		url:"/FUNE0060/itemGroup",
			        		type:"get",
			        		data:"partCode="+partCode
			        	}, function(res){

			        		// AJAX 요청으로 반환받은 리스트를 준비한다.
			        		var list = res.list;
			        		//var optionList = [];

			        		if(!list){
			        			return;
			        		}

				        	// 리스트 요소마다 optionValue와 optionText를 설정해준다.
				        	for(var i=0; i < list.length; i++ ){
				        		list[i].optionValue = list[i].groupCode;
				        		list[i].optionText = list[i].groupName;
				        		/* optionList.push({
				        			optionValue:list[i].groupCode,
				        			optionText:list[i].groupName
								}); */
		        			}
				        	//list.unshift({optionValue:null, optionText:"선택하세요"});

			        		//trace(optionList);

			        		// 배열을 AXSearch Select 박스에 설정해준다.

			        		fnObj.search.target.config.rows[1].list[0].options = list;

			        		// 추가로, 첫 번째 메뉴 설정이 초기화 되므로 다시 선택되도록 바꿔준다.
			        		fnObj.search.target.config.rows[0].list[0].AXBind.config.setValue = partCode;

		        			fnObj.search.target.setConfig(fnObj.search.target.config);

		        			setTimeout(function(){
		        				// AXSearch 폼을 전송한다.
			        			fnObj.search.target.submit();
		        			}, 500);
		        	 	});

                 	},

                 	setSetGroupSelectOptions : function(partCode){

    					/* 첫 번째 셀렉트박스 옵션 선택에 따른 두 번째 셀렉트박스 옵션 동적 변화 */

    		        	// 선택된 아이템의 키를 통해 AJAX 요청을 한다.
    		        	app.ajax({
    		        		url:"/FUNE0060/setGroup",
    		        		type:"get",
    		        		data:"partCode="+partCode
    		        	}, function(res){

    		        		// AJAX 요청으로 반환받은 리스트를 준비한다.
    		        		var list = res.list;
    		        		//var optionList = [];

    			        	// 리스트 요소마다 optionValue와 optionText를 설정해준다.
    			        	for(var i=0; i < list.length; i++ ){
    			        		list[i].optionValue = list[i].setCode;
    			        		list[i].optionText = list[i].setName;
    			        		/* optionList.push({
    			        			optionValue:list[i].groupCode,
    			        			optionText:list[i].groupName
    							}); */
    	        			}

    		        		// 배열을 AXSearch Select 박스에 설정해준다.
    		        		fnObj.setGroupSearch.target.config.rows[0].list[0].options = list;

    		        		// 추가로, 첫 번째 메뉴 설정이 초기화 되므로 다시 선택되도록 바꿔준다.
    		        		fnObj.search.target.config.rows[0].list[0].AXBind.config.setValue = partCode;
    		        		if(partCode == ""){
    		        			fnObj.search.target.config.rows[0].list[0].AXBind.config.setValue = "";
    	        			}

    		        		fnObj.setGroupSearch.target.setConfig(fnObj.setGroupSearch.target.config);
    		        	 	//fnObj.search.target.setItemValue("partCode", partCode);

    		        		fnObj.setGroupSearch.target.submit();

    	        	 	});

                	},

                    submit: function(){
                        var pars = this.target.getParam();
                        fnObj.grid.setPage(fnObj.grid.pageNo, pars);
                    }
                },



                grid: {
                    pageNo: 1,
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
                                {key:"itemCode", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"itemName", label:"품목명", width:"100", align:"center"},
                                {key:"unit", label:"단위", width:"150", align:"center"},
                                {key:"finalPrice", label:"최종단가", width:"150", align:"right", formatter:"money"},
                            ],
                            body : {
                                onclick: function(){
                                    //fnObj.form.setJSON(this.item);
                                }
                            }
                            /* page: {
                                display: true,
                                paging: true,
                                onchange: function(pageNo){
                                    _this.setPage(pageNo);
                                }
                            } */
                        });
                    },
                    add:function(){
                        this.target.pushList({});
                        this.target.setFocus(this.target.list.length-1);
                    },
                    del:function(){
                        var _target = this.target,
                                nextFn = function() {
                                    _target.removeListIndex(checkedList);
                                    toast.push("삭제 되었습니다.");
                                };

                        var checkedList = _target.getCheckedListWithIndex(0);// colSeq
                        if(checkedList.length == 0){
                            alert("선택된 목록이 없습니다. 삭제하시려는 목록을 체크하세요");
                            return;
                        }
                        var dto_list = [];
                        $.each(checkedList, function(){
                            if(this.item._CUD != "C"){
                                dto_list.push("key=" + this.item.key); // ajax delete 요청 목록 수집
                            }
                        });

                        if(dto_list.length == 0) {
                            nextFn(); // 스크립트로 목록 제거
                        }
                        else {
                            app.ajax({
                                        type: "DELETE",
                                        url: "/api/v1/samples/parent",
                                        data: dto_list.join("&")
                                    },
                                    function(res) {
                                        if (res.error) {
                                            alert(res.error.message);
                                        } else {
                                            nextFn(); // 스크립트로 목록 제거
                                        }
                                    });
                        }
                    },
                    setPage: function(pageNo, searchParams){
                        var _target = this.target;
                        this.pageNo = pageNo;

                        app.ajax({
                            type: "GET",
                            url: "/FUNE0060/item",
                            data: "dummy="+ axf.timekey() +"&pageNumber=" + (pageNo-1) + "&pageSize=50&" + (searchParams||fnObj.search.target.getParam())
                        }, function(res){
                            if(res.error){
                                alert(res.error.message);
                            }
                            else
                            {
                                var gridData = {
                                    list: res.list
                                    /* page:{
                                        pageNo: res.page.currentPage.number()+1,
                                        pageSize: res.page.pageSize,
                                        pageCount: res.page.totalPages,
                                        listCount: res.page.totalElements
                                    } */
                                };
                                _target.setData(gridData);
                            }
                        });
                    }
                },

                setGroupSearch:{
                	target: new AXSearch(),
                    bind: function(){
                        var _this = this;
                        this.target.setConfig({
                            targetID:"set-search-box",
                            theme : "AXSearch",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            onsubmit: function(){
                                // 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.
                               	// fnObj.search.submit();
                            	fnObj.setGroupSearch.submit();
                            },
                            rows:[
                                {display:true, addClass:"", style:"", list:[

									{label:"세트명", labelWidth:"", type:"inputText", width:"150", key:"setCode", addClass:"", valueBoxStyle:"", value:"", type:"selectBox",
        								options:[],
										AXBind:{
                                        alwaysOnChange: true,
                    					type:"select", config:{
                    						onchange:function(){
	                    						//toast.push(Object.toJSON(this));
	                    						_this.submit();
                    						}
                    					}
                    				}
        	                  	}

                           	]}

                            ]
                        });
                    },
                    submit: function(){
                        var pars = fnObj.setGroupSearch.target.getParam();
                        fnObj.setGroupGrid.setPage(fnObj.setGroupGrid.pageNo, pars);
                    }
                },

                setGroupGrid: {
                    pageNo: 1,
                    target: new AXGrid(),
                    selectedCell: null,
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "set-group-grid-box",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                {key:"itemCode", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"itemCode", label:"품목코드", width:"100", align:"center"},
                                {key:"itemName", label:"품목명", width:"100", align:"center"},
                                {key:"groupName", label:"품목분류", width:"100", align:"center"},

                                {key:"unit", label:"단위", width:"100", align:"center"},
                                {key:"finalPrice", label:"최종단가", width:"150", align:"right"},
                                {key:"qty", label:"수량", width:"150", align:"right", formatter:"money",
                                	 editor:{
                                         type:"text",
                                         maxLength: 50
                                }},
                            ],
                            body : {
                                onclick: function(){
                                    //fnObj.form.setJSON(this.item);
                                    fnObj.setGroupGrid.selectedCell = this.item;
                                }
                            }
                            /* page: {
                                display: true,
                                paging: true,
                                onchange: function(pageNo){
                                    _this.setPage(pageNo);
                                }
                            } */
                        });

                    },
                    add:function(){
                        this.target.pushList({});
                        this.target.setFocus(this.target.list.length-1);
                    },
                    del:function(){
                        var _target = this.target,
                                nextFn = function() {
                                    _target.removeListIndex(checkedList);
                                    toast.push("삭제 되었습니다.");
                                };

                        var checkedList = _target.getCheckedListWithIndex(0);// colSeq
                        if(checkedList.length == 0){
                            alert("선택된 목록이 없습니다. 삭제하시려는 목록을 체크하세요");
                            return;
                        }
                        var dto_list = [];
                        $.each(checkedList, function(){
                            if(this.item._CUD != "C"){
                                dto_list.push("key=" + this.item.key); // ajax delete 요청 목록 수집
                            }
                        });

                        if(dto_list.length == 0) {
                            nextFn(); // 스크립트로 목록 제거
                        }
                        else {
                            app.ajax({
                                        type: "DELETE",
                                        url: "/api/v1/samples/parent",
                                        data: dto_list.join("&")
                                    },
                                    function(res) {
                                        if (res.error) {
                                            alert(res.error.message);
                                        } else {
                                            nextFn(); // 스크립트로 목록 제거
                                        }
                                    });
                        }
                    },
                    setPage: function(pageNo, searchParams){
                        var _target = this.target;
                        this.pageNo = pageNo;

                        //trace(searchParams);

                        var partCode = Common.search.getValue(fnObj.search.target, "partCode")

                        app.ajax({
                            type: "GET",
                            url: "/FUNE0060/item-by-set-code",
                            data: "dummy="+ axf.timekey() +"&pageNumber=" + (pageNo-1) + "&pageSize=50&" + (searchParams||fnObj.search.target.getParam()) + "&partCode="+partCode
                        }, function(res){


                            if(res.error){
                                alert(res.error.message);
                            }
                            else
                            {
                                var gridData = {
                                    list: res.list
                                    /* page:{
                                        pageNo: res.page.currentPage.number()+1,
                                        pageSize: res.page.pageSize,
                                        pageCount: res.page.totalPages,
                                        listCount: res.page.totalElements
                                    } */
                                };
                                _target.setData(gridData);
                            }
                        });
                    },

                    moveUpItemLocal: function(){
                    	fnObj.setGroupGrid.move(true);
                    },

                    moveDownItemLocal: function(){
                    	fnObj.setGroupGrid.move(false);
                    },

                    move: function(toUp){
                    	// 선택된 요소를 가지고 온다.
                    	var selectedCell = fnObj.setGroupGrid.selectedCell;

                    	if(selectedCell == null){
                    		alert("선택된 열이 없습니다.");
                    		return;
                    	}

                    	// grid의 리스트를 가져온다.
                    	var list = fnObj.setGroupGrid.target.getList();
                    	if(list == null || list.length == 0){
                    		return;
                    	}

                    	// grid의 요소마다 partCode와 item코드들을 선택된 요소와 순차적으로 비교하면서 일치하는 곳의 i값을 가져온다.
                    	// setCode는 비교할 필요가 없는 것이 같은 세트에 포함된 물품들만 검색하는 것이므로 따로 비교할 필요가 없다.
                    	var idx = 0;
                    	for(var i=0; i<list.length; i++){

							if(selectedCell.partCode == list[i].partCode
									&&
								selectedCell.itemCode == list[i].itemCode
							){
								idx = i;
							}
                    	}

                    	// bindEvent에서 Array에 정의한 move 메서드를 사용하여 재정렬한다.
                    	var newIdx = (toUp)? idx-1 : idx + 1;

                    	if(toUp && idx > 0){
                    		list.move(idx, newIdx);
                    	}else if(!toUp && idx < list.length-1){
                    		list.move(idx, newIdx);
                    	}

                    	// 재정렬된 리스트를 grid에 설정한다.
                    	fnObj.setGroupGrid.target.setList(list);

                    	// 포커스를 이동한 곳으로 설정한다.
                    	fnObj.setGroupGrid.target.setFocus(newIdx);

                    	// 만약, 범위 밖으로 포커스가 이동하면 포커스를 해제한다.
                    	if((toUp && idx == 0)
                    		||
                    		(!toUp && idx == list.length-1)
                    	){
                    		//fnObj.setGroupGrid.target.selectClear();
                    		//$("body").click();
                    		fnObj.setGroupGrid.selectedCell = null;

                    	}

                    	// 결과 메세지를 출력한다.
                    	toast.push((toUp)? "한줄 위로 이동하였습니다." : "한 줄 아래로 이동하였습니다.");
                    },

                    removeItemLocal: function(){

                    	// 선택한 요소를 가지고 온다.
                    	var checkedList = fnObj.setGroupGrid.target.getCheckedListWithIndex(0);// colSeq
    		            if(checkedList.length == 0){
    		                alert("선택된 목록이 없습니다. 추가하시려는 목록을 체크하세요");
    		                return;
    		            }

                    	// 제거한다.
                    	fnObj.setGroupGrid.target.removeListIndex(checkedList);

                    	// 결과 메세지를 출력한다.
                    	toast.push("삭제한 내용은 저장버튼 클릭시 반영됩니다.");
                    },

                    save: function(){

                    	// 리스트를 가져온다.
                    	var list = fnObj.setGroupGrid.target.getList();

                    	// AXSearch에서 선택한 setCode로 리스트 각 요소마다 setCode를 추가한다.
                    	var setGroupSearchParams = fnObj.setGroupSearch.target.getParam();
                    	var setCode = setGroupSearchParams.substring( setGroupSearchParams.indexOf("=")+1 );
                    	for(var i=0; i<list.length; i++){
                    		list[i].setCode = setCode;
                    	}

                    	// ajax 요청으로 서버에 전달한다.
                    	app.ajax({
                    		url:"/FUNE0060/setItem?partCode="+Common.search.getValue(fnObj.search.target, "partCode")+"&setCode="+setCode,
                    		type:"put",
                    		data:Object.toJSON(list)
                    	}, function(res){
                    		// get 요청으로 폼을 업데이트 한다.
                        	fnObj.setGroupSearch.submit();
                    	});
                    }
                }
            };
        </script>
    </ax:div>
</ax:layout>