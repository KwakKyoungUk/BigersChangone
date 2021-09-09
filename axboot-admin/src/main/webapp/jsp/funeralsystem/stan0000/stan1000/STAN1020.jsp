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

                            <div class="ax-button-group">
                                <div class="left">
                                    <h2><i class="axi axi-list-alt"></i>기본요금 리스트</h2>
                                </div>
                                <div class="right">
                                    <button type="button" class="AXButton" id="ax-price-btn-add"><i class="axi axi-plus-circle"></i> 추가</button>
									<button type="button" class="AXButton" id="ax-price-btn-del"><i class="axi axi-minus-circle"></i> 삭제</button>
                                </div>
                                <div class="ax-clear"></div>
                            </div>

                            <div class="ax-grid" id="page-grid-price" style="min-height: 300px;"></div>

                        </ax:custom>

                        <ax:custom customid="td" style="width:610px;">

                            <div class="ax-button-group">
                                <div class="left">
                                    <h2><i class="axi axi-list-alt"></i> 감면율 리스트</h2>
                                </div>
                                <div class="right">
                                    <button type="button" class="AXButton" id="ax-dcRate-btn-add"><i class="axi axi-plus-circle"></i> 추가</button>
                                    <button type="button" class="AXButton" id="ax-dcRate-btn-del"><i class="axi axi-minus-circle"></i> 삭제</button>
                                </div>
                                <div class="ax-clear"></div>
                            </div>

                            <div class="ax-grid" id="page-grid-dcRate" style="min-height: 300px;"></div>

                        </ax:custom>
                    </ax:custom>
                </ax:custom>

            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
        <script type="text/javascript">
/*
        	function getFeetypedivcd (value){
        		var code= [];
        		for(var i=0; i<Common.getCode("FEETYPEDIVCD").length; i++){
    				if( Common.getCode("FEETYPEDIVCD")[i].optionValue.right(4).left(1)  == value){
    					code.push(Common.getCode("FEETYPEDIVCD")[i]);
    				}
    			}
        		console.log(code);
        		return code;
        	}  */

        	 var resize_elements = [
        	                        {id:"page-grid-price", adjust:-45},
        	                        {id:"page-grid-dcRate", adjust:-45}
        	                    ];

            var jobGubun;
            var priceGubun;
            var objt;
            var fnObj = {

                CODES: {
                	"jobGubun": Common.getCode("JOB_GUBUN")
/*                  	,"priceGubun": {
                		"C" : [Common.getCode("PRICE_GUBUN")[0]] //화장
                		,"E" : Common.getCode("PRICE_GUBUN")       // 봉안
                		,"N" : Common.getCode("PRICE_GUBUN")     // 자연장
                		,"T" : Common.getCode("PRICE_GUBUN")    // 수목장
                		,"F" : Common.getCode("PRICE_GUBUN")   // 장례식장
                		,"S" : [Common.getCode("PRICE_GUBUN")[0]]   // 유택동산
                	}  */
                	,"priceGubun":  Common.getCode("PRICE_GUBUN")
                	,"objt": {
                		"C":Common.getCode("TMC03")
                		,"E":Common.getCode("TFM10")
                		,"N":Common.getCode("TFM10")
                		,"T":Common.getCode("TFM10")
                		,"F":Common.getCode("TFM10")
                		,"S":Common.getCode("TFM27")
                	},
                	"addrPart": Common.getCode("TCM10")
/*                  	 ,"feetypedivcd" : {
                		"ETFM1000001" : getFeetypedivcd("A")  // 봉안개인
                		,"ETFM1000003" : getFeetypedivcd("B") // 봉안부부
                		,"ETFM1000004" : getFeetypedivcd("C") // 봉안무연
                		,"TTFM1000001" :  getFeetypedivcd("E") // 수목개인

                		,"NTFM1000001" :  getFeetypedivcd("F") // 잔디개인
                		,"NTFM1000003" :  getFeetypedivcd("F") // 잔디부부
                		,"STFM2700001" :  getFeetypedivcd("D") // 산골
                		,"" : Common.getCode("feetypedivcd") // 전체
                	}
                	  ,"feetypedivcd" : {
                		"A" : getFeetypedivcd("A")  // 개인
                		,"B" : getFeetypedivcd("B") // 부부
                		,"C" : getFeetypedivcd("C") // 무연
                		,"E" :  getFeetypedivcd("E") // 수목
                		,"F" :  getFeetypedivcd("F") // 잔디
                		,"D" :  getFeetypedivcd("D") // 산골
                	}   */

                },
                pageStart: function(){
                	 this.price.bind();
                     this.dcRate.bind();
                     this.bindEvent();

                     this.search.submit();

                },
                bindEvent: function(){
                    var _this = this;

                    $("#ax-page-btn-search").bind("click", function(){
                        _this.search.submit();
                    });
                    $("#ax-page-btn-save").bind("click", function(){
                        setTimeout(function() {
                            _this.price.save();
                        }, 500);
                        setTimeout(function() {
                       	  _this.dcRate.save();
                        }, 500);
                    });

                    /*   $("#ax-page-btn-fn1").html("<i class=\"axi axi-minus-circle\"></i> 삭제");
                    $("#ax-page-btn-fn1").bind("click", function(){
                        setTimeout(function() {
                        	_this.price.del();
                        }, 500);
                        setTimeout(function() {
                       	   _this.dcRate.del();
                        }, 500);
                    });
                    */

                    $("#ax-page-btn-excel").bind("click", function(){
                        app.modal.excel({
                            pars:"target=${className}"
                        });
                    });

                    $("#ax-price-btn-add").bind("click", function(){
                        _this.price.add();
                    });
                    $("#ax-price-btn-del").bind("click", function(){
                        _this.price.del();
                    });
                    $("#ax-dcRate-btn-add").bind("click", function(){
                        _this.dcRate.add();
                    });
                    $("#ax-dcRate-btn-del").bind("click", function(){
                        _this.dcRate.del();
                    });




                },
                search: {
                    submit: function(){
                        fnObj.price.setPage(fnObj.price.pageNo);
                        fnObj.dcRate.setPage(fnObj.dcRate.pageNo);
                    }
                },
                price: {
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "page-grid-price",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
								//{key:"_CUD", label:"", width:"35", align:"center", display:false},
								{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"jobGubun", label:"업무구분", width:"80", align:"center",
                             	    formatter: function(){
                             	    	jobGubun = this.value;
                             	    	return Common.grid.codeFormatter("jobGubun", this.value);
                                    },
                                    editor: {
                                        type: "select",
                                        optionValue: "optionValue",
                                        optionText: "optionText",
                                        options: fnObj.CODES.jobGubun,
                                        disabled: function(){
                                            return this.item._CUD != "C";
                                        },
                                        beforeUpdate: function(val){ // 수정이 되기전 value를 처리 할 수 있음.
                                            // console.log(val);
                                            return val.optionValue; // return 이 반드시 있어야 함.
                                        },
                                        afterUpdate: function(val){ // 수정이 처리된 후
                                            // 수정이 된 후 액션.
                                            // console.log(this);
                                        },
                                        updateWith: ["_CUD"]
                                    }
                                },
                                {key:"priceGubun", label:"요금구분", width:"100", align:"center",
                               	    formatter: function(val){
                               	    	return Common.grid.codeFormatter("priceGubun", this.value);
                               	    	/* for(var i=0; i<fnObj.CODES.priceGubun[this.item.jobGubun].length; i++){
                                			if(this.value == fnObj.CODES.priceGubun[this.item.jobGubun][i].optionValue){
                                				return fnObj.CODES.priceGubun[this.item.jobGubun][i].optionText;
                                			}
                                		} */
                              	    },
	                              	  editor: {
	                                      type: "select",
	                                      optionValue: "optionValue",
	                                      optionText: "optionText",
	                                      options: fnObj.CODES.priceGubun,
	                                      disabled: function(){
	                                            return this.item._CUD != "C";
	                                      },
	                                      beforeUpdate: function(val){ // 수정이 되기전 value를 처리 할 수 있음.
	                                          // console.log(val);
	                                         return val.optionValue;
	                                      },
	                                      afterUpdate: function(val){ // 수정이 처리된 후
	                                          // 수정이 된 후 액션.
	                                          // console.log(this);

	                                      },
	                                      updateWith: ["_CUD"]
	                                  }
                                },
                                {key:"objt", label:"", width:"150", align:"center", display :false},
                                {key:"objtNm", label:"대상구분", width:"120", align:"center",

	                                formatter: function(val){
										return ((this.value||"") == "") ? "<span style='color:#ff3300;'>선택</span>" : this.value;
									},
									editor: {
										type: "finder",
										 disabled: function(){
	                                            return this.item._CUD != "C";
	                                    },
										finder: {
											onclick: function(){

												if(fnObj.price.target.list[this.index].jobGubun == null){
													alert("업무구분을 선택해주세요.");
													return false;
												}

												app.modal.open({
													url:"/jsp/funeralsystem/stan0000/stan1000/STAN1021.jsp",
													pars:"callBack=fnObj.price.setObjt&itemIndex=" + this.index+"&jobGubun="+fnObj.price.target.list[this.index].jobGubun, // callBack 말고
													width:500 // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
													//top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
												});
											}
										}
									}
	                             },

                                {key:"addrPart", label:"관내외구분", width:"100", align:"center",
                                	formatter: function(val){

                                	//	trace(this.value);
                                	//	trace(this);
                                		return Common.grid.codeFormatter("addrPart", this.value);
                              	    },
                              	  editor: {
                                      type: "select",
                                      optionValue: "optionValue",
                                      optionText: "optionText",
                                      options: fnObj.CODES.addrPart,
                                      disabled: function(){
                                          return this.item._CUD != "C";
                                      },
                                      beforeUpdate: function(val){ // 수정이 되기전 value를 처리 할 수 있음.
                                          // console.log(val);
                                         console.log("//   " +this);
                                         return val.optionValue;
                                      },
                                      afterUpdate: function(val){ // 수정이 처리된 후
                                          // 수정이 된 후 액션.
                                          // console.log(this);
                                    	  console.log("////   " +this);
                                      },
                                      updateWith: ["_CUD"]
                                  }


                                },
                                {key:"useDate", label:"적용일자", width:"120", align:"center",
									formatter: function(val){
                                	    //trace(typeof this.value);
                                		return  typeof this.value  == "number" ?  new Date(this.value).print() : this.value ;
                              	    },
                              	  	editor:{
                                      type: "calendar",
                                      config: {
                                          separator: "-"
                                      },
                                      updateWith: ["_CUD"] // 셀에디팅이 일어나면 함께 컬럼 업데이트 해야할 컬럼 키
                                  }
                                },
                               /*  {key:"feetypedivcd", label:"이용요금코드", width:"150", align:"center",
                                	formatter: function(val){
                                	//console.log(this.value);
	                                	for(var i=0; i<fnObj.CODES.feetypedivcd[""].length; i++){
	                            			if(this.value == fnObj.CODES.feetypedivcd[""][i].optionValue){
	                            				return fnObj.CODES.feetypedivcd[""][i].optionText;
	                            			}
	                            		}
                              	    },
                                }, */
                                {key:"charge", label:"요금", width:"150", align:"right",
                                	formatter : "money",
                                	 editor:{
                                         type:"number",
                                         maxLength: 20
                                     }
                                },
                                {key:"useTerm", label:"사용년수", width:"100",
                                	 editor:{
                                         type:"number",
                                         maxLength: 20
                                     }
                                },
                                {key:"remark", label:"비고", width:"160",
                                	 editor:{
                                         type:"text",
                                         maxLength: 200
                                     }
                                },
                            ],
                            colHeadAlign:"center",
                            colHead : {
                                rows: [
                                    [
                                        {colSeq:0, rowspan:1},
                                        {colSeq:1, rowspan:1},
                                        {colSeq:2, rowspan:1},
                                        {colSeq:3, rowspan:1},
                                        {colSeq:4, rowspan:1},
                                        {colSeq:5, rowspan:1},
                                        {colSeq:6, rowspan:1},
                                        {colSeq:7, rowspan:1},
                                        {colSeq:8, rowspan:1},
                                        {colSeq:9, rowspan:1},
                                        {colSeq:10, rowspan:1},

                                    ]
                                ]
                            },
                            body : {
                            	 onclick: function(){
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
                    setObjt: function(item, itemIndex){
                    	fnObj.price.target.updateItem(0, 3, itemIndex, item.optionValue);
						fnObj.price.target.updateItem(0, 4, itemIndex, item.optionText);

						app.modal.close();
					},
                    add:function(){
                        this.target.pushList({},this.target.list.length+1);
                        this.target.setFocus(this.target.list.length-1);
                    },
                    save: function(){

                    	  var items = fnObj.price.target.list;
                          if (items.length == 0) {
                              alert("기본요금에 저장할 내용이 없습니다.");
                              return;
                          }

                          var dto_list = [];
                          $.each(items, function (i, d) {
                              if (d.jobGubun && d.priceGubun && d.objt && d.addrPart) {
                            	  var item = {
                                          jobGubun: (d.jobGubun),
                                          priceGubun: (d.priceGubun),
                                          objt: (d.objt),
                                          addrPart: (d.addrPart),
                                          useDateString: (new Date(d.useDate).print("yyyy-mm-dd") || ""),
                                          charge: (d.charge || 0),
                                          useTerm: (d.useTerm || ""),
                                          remark: (d.remark || ""),
                                      };
                                      dto_list.push(item);
                              }
                          });
                          if(dto_list.length == 0){
                        	  alert("업무구분, 요금구분, 대상, 관내외구분은 필수 입력값 입니다.");
                        	  return false;
                          }

                         app.ajax({
                             type: "PUT",
                             url: "/STAN1020/savePriceList",
                             data: Object.toJSON(dto_list)
                         },
                         function(res){
                             if(res.error){
                                 console.log(res.error.message);
                                 alert(res.error.message);
                             }
                             else
                             {
                                //toast.push("저장되었습니다.");
                                fnObj.search.submit();
                             }
                         });
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
                        if(!confirm("선택한 요금정보를 삭제하시겠습니까?")){
                    		return;
                    	}
                        var dto_list = [];

                        $.each(checkedList, function(){

                        		if(this.item._CUD != "C" ){

                        			 var item = {
                                             jobGubun: (this.item.jobGubun),
                                             priceGubun: (this.item.priceGubun),
                                             objt: (this.item.objt),
                                             addrPart: (this.item.addrPart),
                                             useDateString: (new Date(this.item.useDate).print("yyyy-mm-dd") || ""),
                                             charge: (this.item.charge || 0),
                                             useTerm: (this.item.useTerm || ""),
                                         };
                                         dto_list.push(item);
                        		}



                        });

                        if(dto_list.length == 0) {
                            nextFn(); // 스크립트로 목록 제거
                        }
                        else {
                            app.ajax({
                                type: "DELETE",
                                url: "/STAN1020/deletePriceList",
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
                             url: "/STAN1020/findPriceList",
                             data: "dummy="+ axf.timekey() +"&pageNumber=" + (pageNo-1) + "&pageSize=50"
                         }, function(res){
                             if(res.error){
                                alert(res.error.message);
                             }
                             else
                             {
                            	 var gridData = {
                                 		 list: (function(){
                                        	 for(var i=0; i<res.list.length; i++){
                                        		 for(var key in res.list[i]){

                                        			 if(key == 'objt'){
                                         				var jobGubun =res.list[i]['jobGubun']+"";
                                         				var objt =res.list[i][key];
                                  				    	for(var j=0; j<fnObj.CODES.objt[jobGubun].length; j++){
                    	                                	if(objt == fnObj.CODES.objt[jobGubun][j].optionValue){
                    	                                	 res.list[i].objtNm= fnObj.CODES.objt[jobGubun][j].optionText;
                    	                               		}
                    	                               	}
                                         			 }
                                        			 res.list[i][key]=res.list[i][key];
                                        		 }
                                        	 }
                                        	 return res.list;
                                         }())
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
                },

                dcRate: {
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "page-grid-dcRate",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [

								{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"jobGubun", label:"업무구분", width:"80", align:"center",
									formatter: function(){
                             	    	jobGubun = this.value;
                             	    	return Common.grid.codeFormatter("jobGubun", this.value);
                                    },
                                    editor: {
                                        type: "select",
                                        optionValue: "optionValue",
                                        optionText: "optionText",
                                        options: fnObj.CODES.jobGubun,
                                        disabled: function(){
                                            return this.item._CUD != "C";
                                        },
                                        beforeUpdate: function(val){ // 수정이 되기전 value를 처리 할 수 있음.
                                            // console.log(val);
                                            return val.optionValue; // return 이 반드시 있어야 함.
                                        },
                                        afterUpdate: function(val){ // 수정이 처리된 후
                                            // 수정이 된 후 액션.
                                            // console.log(this);
                                        },
                                        updateWith: ["_CUD"]
                                    }
                                },
                                {key:"dcCode", label:"감면코드", width:"100",
                                	editor:{
                                        type:"text",
                                        maxLength: 10,
                                        disabled: function(){
                                            return this.item._CUD != "C";
                                        },
                                    }
                                },
                                {key:"dcName", label:"감면명", width:"150",
                                	editor:{
                                        type:"text",
                                        maxLength: 30
                                    }
                                },
                                {key:"dcPercent", label:"감면율(%)", width:"100",
                                	editor:{
                                        type:"number",
                                        maxLength: 20
                                    }
                                },
                                {key:"dcAddrPart", label:"감면적용관내구분", width:"100",
                                	editor: {
                                        type: "select",
                                        optionValue: "optionValue",
                                        optionText: "optionText",
                                        options: fnObj.CODES.addrPart,

                                        beforeUpdate: function(val){ // 수정이 되기전 value를 처리 할 수 있음.
                                            // console.log(val);
                                            return val.optionValue; // return 이 반드시 있어야 함.
                                        },
                                        afterUpdate: function(val){ // 수정이 처리된 후
                                            // 수정이 된 후 액션.
                                            // console.log(this);
                                        },
                                        updateWith: ["_CUD"]
                                    },formatter : function(){
                                    	return Common.grid.codeFormatter("addrPart", this.value);
                                    }

                                },
                                {key:"sort", label:"정렬순서", width:"80",
                                	editor:{
                                        type:"text",
                                        maxLength: 10
                                    }
                                },
                                {key:"remark", label:"비고", width:"150",
                                	editor:{
                                        type:"text",
                                        maxLength: 30
                                    }
                                },
                            ],
                            body : {
                            	 onclick: function(){
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
                        this.target.pushList({},this.target.list.length+1);
                        this.target.setFocus(this.target.list.length-1);
                    },
                    save: function(){

                  	  var items = fnObj.dcRate.target.list;
                        if (items.length == 0) {
                            alert("감면율에 저장할 내용이 없습니다.");
                            return;
                        }

                        var dto_list = [];
                        $.each(items, function (i, d) {
                            if (d.jobGubun && d.dcCode) {
                          	  var item = {
                          			   jobGubun: (d.jobGubun),
                                       dcCode: (d.dcCode),
                                       dcName: (d.dcName ||""),
                                       dcPercent: (d.dcPercent || 0),
                                       dcAddrPart: (d.dcAddrPart || ""),
                                       sort: (d.sort || ""),
                                       remark: (d.remark || ""),
                                    };
                                    dto_list.push(item);
                            }
                        });
                        if(dto_list.length == 0){
                      	  alert("업무구분과 감면코드는 필수 입력값 입니다.");
                      	  return false;
                        }

                       app.ajax({
                           type: "PUT",
                           url: "/STAN1020/saveDcRateList",
                           data: Object.toJSON(dto_list)
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
                      if(!confirm("선택한 반환율 정보를 삭제하시겠습니까?")){
                    		return;
                    	}
                      var dto_list = [];

                      $.each(checkedList, function(){

                      		if(this.item._CUD != "C" ){

                      			 var item = {
                                           jobGubun: (this.item.jobGubun),
                                           dcCode: (this.item.dcCode),
                                           dcName: (this.item.dcName || ""),
                                           dcPercent: (this.item.dcPercent || 0),
                                           remark: (this.item.remark || ""),
                                       };
                                       dto_list.push(item);
                      		}
                      });

                      if(dto_list.length == 0) {
                          nextFn(); // 스크립트로 목록 제거
                      }
                      else {
                          app.ajax({
                              type: "DELETE",
                              url: "/STAN1020/deleteDcRateList",
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
                           url: "/STAN1020/findDcRateList",
                           data: "dummy="+ axf.timekey() +"&pageNumber=" + (pageNo-1) + "&pageSize=50&sort=jobGubun&sort"
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
                           }
                       });
                  }
                },
            };
        </script>
    </ax:div>
</ax:layout>