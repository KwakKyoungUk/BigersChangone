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
				<form id="page-search-box">

                      <div class="sbar">
                      <div id="hide">
                      <span class="sitem">
                             <span class="slabel">봉안당구분</span>
                              <select id="locCode" name="locCode" class="AXSelect W100" ></select>
                         </span>
                      <span class="sitem">
                             <span class="slabel">층</span>
                             <select id="floorCode" name="floorCode" class="AXSelect W100" ></select>
                         </span>
                	  </div>
                         <span class="sitem">
                             <span class="slabel">호실</span>
                             <select id="roomCode" name="roomCode" class="AXSelect W100" ></select>
                         </span>
                     </div>
                 </form>


                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-list-alt"></i> 봉안실행열관리</h2>
                    </div>

                    <div class="ax-clear"></div>
                </div>
                <div class="ax-grid" id="page-grid-box" style="max-height:400px;"></div>

            </ax:col>
        </ax:row>
        <ax:row>
        	<ax:col size="12">
        						<div class="ax-button-group">
                                <div class="left">
                                    <h2><i class="axi axi-table"></i> 정보등록</h2>
                                </div>
                                <div class="right">
                                    <button type="button" class="AXButton" id="ax-form-btn-new"><i class="axi axi-plus-circle"></i> 신규</button>
                                </div>
                                <div class="ax-clear"></div>
                            </div>
        		<ax:form id="form-info" name="form-info" method="get">
        			<input type="hidden" id="info-locCode" name="locCode" value=""/>
        			<input type="hidden" id="info-floorCode" name="floorCode" value=""/>
        			<input type="hidden" id="info-roomCode" name="roomCode" value=""/>        						
        					   <ax:fields>                                    
                                    <ax:field label="블럭">
                                    	   <input type="number" id="info-blockNum" name="blockNum" title="단" maxlength="3" class="AXSelect W100 av-required"  min="1" >
                                    </ax:field>
                                    <ax:field label="최대행수">
                                         <input type="number" id="info-maxRow" name="maxRow" title="행크기" maxlength="3" class="AXInput W100 av-required" min="1"  />
                                    </ax:field>
                                     <ax:field label="최대열수">
                                         <input type="number" id="info-maxCol" name="maxCol" title="열크기" maxlength="3" class="AXInput W100 av-required"  min="1" />
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                	<ax:field label="증가치">
                                        <input type="number" id="info-incValue" name="incValue" title="증가치" maxlength="1" class="AXInput W100 av-required"  min="1"/>
                                    </ax:field>
                                    <ax:field label="자릿수">
                                        <input type="number" id="info-numSize" name="numSize" title="자릿수" maxlength="1" class="AXInput W100 av-required" min="1" />
                                    </ax:field>
                                    <ax:field label="시작번호">
                                        <input type="number" id="info-strNo" name="strNo" title="시작번호" maxlength="3" class="AXInput W100 av-required"  min="1" />
                                    </ax:field>
                                    <ax:field label="종료번호">
                                        <input type="number" id="info-endNo" name="endNo" title="종료번호" maxlength="3" class="AXInput W100 av-required"  min="1" />
                                    </ax:field>
                                </ax:fields>
                                <ax:fields>
                                 <ax:field label="안치유형">
                                         <select id="info-ensKind" name="ensKind" class="AXSelect W100" ></select>
                                    </ax:field>
                                     <ax:field label="정렬구분">
                                         <select id="info-direction" name="direction" class="AXSelect W100" ></select>
                                    </ax:field>
                                   <ax:field label="비고">
                                         <input type="text" id="info-remark" name="remark" class="AXInput W300"  width="500" maxlength="200">
                                    </ax:field>
                                </ax:fields>
                            </ax:form>

        	</ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
        <script type="text/javascript">

            var resize_elements = [
                {id:"page-grid-box", adjust:-97}
            ];
            var fnObj = {
       			locCode : "",
       			floorCode : "",
                CODES: {
                	"locCode": (function(){
                    	var result;
                    	app.ajax({
                    			async: false,
	                            type: "GET",
	                            url: "/ENSH3010/enslocSelectOption",
	                            data: ""
	                        },
	                        function(res){
	                        	result = res;
                        	}
                        );
                    	return result;
                    }()),
            		"floorCode": (function(){
                    	var result;
                    	app.ajax({
                    			async: false,
	                            type: "GET",
	                            url: "/ENSH3030/ensfloorSelectOption",
	                            data: ""
	                        },
	                        function(res){
	                        	result = res;
                        	}
                        );
                    	return result;
                    }()),
                                        
                    "ensKind" : Common.getCode("TFM10"),
                    "direction" : Common.getCode("DIRECTION"),


                },
                pageStart: function(){


                    this.search.bind();
                    this.form.bind();
                    this.bindEvent();
                    this.grid.bind();

                    this.search.submit();

                },
                bindEvent: function(){
                    var _this = this;
                     $("#ax-page-btn-search").bind("click", function(){
                        _this.search.submit();
                    });

                     $("#locCode").bindSelect({
	                        ajaxUrl: "/ENSH3010/findEnsloc", ajaxPars: "", method:"GET", ajaxAsync:false,
	                       // isspace: true, isspaceTitle: "선택하세요",
	                        setValue:this.optionValue,
	                        alwaysOnChange: true,
	                        reserveKeys: {
	            				options: "list",
	            				optionValue: "locCode",
	            				optionText: "locName"
	            			},
	                        onChange: function(){
	                        	var locCode = this.optionValue;
	                        	$("#info-locCode").val(locCode);
	                            $("#floorCode").bindSelect({
	                                ajaxUrl: "/ENSH3020/findEnsfloor", ajaxPars: "locCode="+this.optionValue, method:"GET", ajaxAsync:false,
	                                //ajaxUrl: "/ENSH3010/findEnsloc", ajaxPars: "", method:"GET", ajaxAsync:false,
	                                //isspace: true, isspaceTitle: "선택하세요",
	                                setValue:this.optionValue,
	                                alwaysOnChange: true,
	                                reserveKeys: {
	                     				options: "list",
	                     				optionValue: "floorCode",
	                     				optionText: "charnClassName"
	                     			},
	                                onChange: function(){
	                                	var floorCode = this.optionValue;
	                                	$("#info-floorCode").val(floorCode);
	                                     $("#roomCode").bindSelect({
	                                        ajaxUrl: "/ENSH3030/findEnsroom", ajaxPars: "locCode="+locCode+"&floorCode="+this.optionValue,  method:"GET", ajaxAsync:false,
	                                        //isspace: true, isspaceTitle: "전체",
	                                        reserveKeys: {
			                      				options: "list",
			                      				optionValue: "roomCode",
			                      				optionText: "roomName"
			                      			},
	                                        setValue:this.optionValue,
	                                        alwaysOnChange: true,
	                                        onChange: function(){

	                                        	 fnObj.search.submit();
	                                            //toast.push(Object.toJSON(this));

	                                        }
	                                    });

	                                }
	                            });
	                        }
	                    });
//                      $("#hide").hide();

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


                    $("#ax-page-btn-fn1").html("<i class=\"axi axi-minus-circle\"></i> 삭제");
                    $("#ax-page-btn-fn1").bind("click", function(){
                        setTimeout(function() {
                        	_this.grid.del();
                        }, 500);
                    });


                },
                save: function(){

                	 var validateResult = fnObj.form.validate_target.validate();
                     if (!validateResult) {
                         var msg = fnObj.form.validate_target.getErrorMessage();
                         axf.alert(msg);
                         fnObj.form.validate_target.getErrorElement().focus();
                         return false;
                     }

                     if(!confirm("입력된 정보로 봉안함을 생성합니다. 수정 시 봉안함을 삭제 후 재생성 합니다. 계속 하시겠습니까?")){
                    	 return;
                     }

                     var items = fnObj.grid.target.list;
                     var newItem =  fnObj.grid.target.getList("C");

                     var info = fnObj.form.getJSON();

                    var maxNum = Number(info.incValue*info.maxRow*info.maxCol)-Number(info.incValue)+Number(info.strNo);
                      if(maxNum < info.endNo){
                    	 alert(maxNum + " 보다 종료번호가 클 수 없습니다.");
                    	 $("#info-endNo").focus();
                    	 return;
                     }

                      if((info.endNo+"").length > info.numSize){
                    	 alert("종료번호 보다 자릿수가 작습니다.");
                    	 $("#info-numSize").focus();
                    	 return;
                     }


                     app.ajax({
                         type: "PUT",
                         url: "/ENSH3040/saveEnsMatrix",
                         data: Object.toJSON(info)
                     },
                     function(res){
                         if(res.error){
                             console.log(res.error.message);
                             alert(res.error.message);
                         }
                         else
                         {
                            toast.push("저장되었습니다.");
                             fnObj.search.submit();
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

                             //mediaQuery: {
                            // mx:{min:"N", max:767}, dx:{min:767}
                             //},

                            onsubmit: function(){
                                // 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.

                                fnObj.search.submit();
                            },

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
								{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},

								{key:"blockNum", label:"블럭", width:"100", align:"center",

                                },
								{key:"maxRow", label:"행크기", width:"150", align:"center",

                                },
                                {key:"maxCol", label:"열크기", width:"150", align:"center",

                                },

								{key:"incValue", label:"증가치", width:"150", align:"center",

                                },
								{key:"numSize", label:"자릿수", width:"150", align:"center",

                                },
								{key:"strNo", label:"시작번호", width:"150", align:"center",

                                },
                                {key:"endNo", label:"종료번호", width:"150", align:"center",

                                },
								{key:"ensKind", label:"안치구분", width:"150", align:"center",
										formatter: function(val){

											return Common.grid.codeFormatter("ensKind", this.value);
	                              	    },
                                },
                                {key:"direction", label:"정렬방법", width:"150",
                                	formatter: function(val){

										return Common.grid.codeFormatter("direction", this.value);
                              	    },
                                },
                                {key:"remark", label:"비고", width:"150",

                                },
                            ],
                            body : {
                                onclick: function(){
                                    fnObj.form.setJSON(this.item);
                                }
                            },
                            page: {
                                display: true,
                                paging: true,
                                onchange: function(pageNo){
                                    _this.setPage(pageNo);
                                }
                            }
                        });
                    },
                    add:function(){
                    	
                    	var locCode = $( "#info-locCode option:selected" ).val()
                    	var ensKind = $( "#info-ensKind option:selected" ).val()
                    	var floorCode = $( "#info-floorCode option:selected" ).val();
                    	var roomCode =  $( "#info-roomCode option:selected" ).val();
                    	//alert(fnObj.roomCode);                    	
                        this.target.pushList({
                        	locCode :locCode
                        	,floorCode : floorCode
                        	,ensKind : ensKind
                        	,roomCode : roomCode 
                        	,fullYn : "Y"
                        });
                        this.target.setFocus(this.target.list.length-1);

                        //this.target.pushList({},this.target.list.length+1);
                        //this.target.setFocus(this.target.list.length-1);
                    },
                    del:function(){
                    	if(!confirm("선택한 행열 정보를 삭제하시겠습니까?")){
                    		return;
                    	}
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


                            	 var item = {
                            			 locCode: (this.item.locCode),
                            			 floorCode: (this.item.floorCode),                            	 
                                         roomCode: (this.item.roomCode),
                                         blockNum: (this.item.blockNum)
                                     };
                                     dto_list.push(item);

                        });

                        if(dto_list.length == 0) {
                            nextFn(); // 스크립트로 목록 제거
                        }
                        else {
                            app.ajax({
                                type: "DELETE",
                                url: "/ENSH3040/deleteEnsMatrix",
                                data: Object.toJSON(dto_list)
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
                             url: "/ENSH3040/findMatrix",
                             data: (searchParams||"")
                         }, function(res){
                             if(res.error){
                                alert(res.error.message);
                             }
                             else
                             {
                            	 var dd = res;
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
                             }
                         });
                    }
                }
                ,form: {
                    target: $('#form-info'),
                    validate_target: new AXValidator(),
                    bind: function() {
                        var _this = this;

                        this.validate_target.setConfig({
                            targetFormName : "form-info"
                        });




                        $('#info-ensKind').bindSelect({
                            options: fnObj.CODES.ensKind
                        });
                        $('#info-direction').bindSelect({
                            options: fnObj.CODES.direction
                        });                        

                        // form clear 처리 시
                        $('#ax-form-btn-new').click(function() {
                        	//$("#locCode").change();
                        	//fnObj.grid.target.pushList({});
                        	//Common.grid.setFocus(fnObj.grid.target, fnObj.grid.target.list.length-1);
                            fnObj.form.clear()
                        });

                    },
                    setJSON: function(item) {
                        var _this = this;
                        var info = $.extend({}, item);
                        app.form.fillForm(_this.target, info, 'info-');
                        // 추가적인 값 수정이 필요한 경우 처리
                       // $('#info-useYn').bindSelectSetValue( info.useYn );
                       // $("#info-locCode").val($("#locCode option:selected" ).val());
               // $("#info-floorCode").val($("#floorCode option:selected" ).val());
                      // $("input[id*='info']").attr('readonly',true);
                    },
                    getJSON: function() {
                        return app.form.serializeObjectWithIds(this.target, 'info-');
                    },
                    clear: function() {
                        app.form.clearForm(this.target);
                        $("input[id*='info']").attr('readonly',false);
                        $("#info-locCode").val($("#locCode option:selected" ).val());
                        $("#info-floorCode").val($("#floorCode option:selected" ).val());
                        $("#info-roomCode").val($("#roomCode option:selected" ).val());                        
                    }
                },
            };
        </script>
    </ax:div>
</ax:layout>