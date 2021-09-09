<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>

<ax:layout name="base.jsp">
    <ax:set name="title" value="${PAGE_NAME}" />
    <ax:set name="page_desc" value="${PAGE_REMARK}" />
    <ax:div name="contents">
        <ax:row>
            <ax:col size="12">
                <ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION1_AUTH}" function2Auth="${FUNCTION2_AUTH}" function3Auth="${FUNCTION3_AUTH}" function4Auth="${FUNCTION4_AUTH}" function5Auth="${FUNCTION5_AUTH}">

                </ax:custom>

                <div class="ax-search" id="page-search-box"></div>
                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-storage"></i> 화장 진행</h2>
                    </div>
                    <div class="right">
                        <button type="button" class="AXButton" id="btn-receipt"><i class="axi axi-exchange"></i> 접수</button>
                        <button type="button" class="AXButton" id="btn-body-carrying"><i class="axi axi-exchange"></i> 운구중</button>
                        <button type="button" class="AXButton" id="btn-cremation"><i class="axi axi-exchange"></i> 화장중</button>
                        <button type="button" class="AXButton" id="btn-sugol"><i class="axi axi-exchange"></i> 수골중</button>
                        <button type="button" class="AXButton" id="btn-end"><i class="axi axi-exchange"></i> 종료</button>
                    </div>
                    <div class="ax-clear"></div>
                </div>
                <div class="ax-grid" id="page-grid-box-hwa" style="min-height:300px;"></div>
                <div class="tag-result" id="ax-input-checkbox" align="right">
					<label>
						<input type="radio" name="msgType" value="0" />
						전체
					</label>
					<label>
						<input type="radio" name="msgType" value="1" />
						방송
					</label>

					<label>
						<input type="radio" name="msgType" value="2" />
						방송/표출
					</label>
					<label>
						<input type="radio" name="msgType" value="3" />
						표출
					</label>
				</div>
                <div class="ax-grid" id="page-grid-box-msg" style="min-height:300px;"></div>
				<textarea id="ta-msg" style="height: 100px; width: 100%;"></textarea>
				<div class="ax-button-group">
                    <div class="right">
                        <button type="button" class="AXButton" id="btn-broadcast"><i class="axi axi-exchange"></i> 방송</button>
                    </div>
                    <div class="ax-clear"></div>
                </div>
            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
        <script type="text/javascript">
            var resize_elements = [
                {id:"page-grid-box", adjust:function(){
                    return -92;
                }}
            ];
            var fnObj = {
                CODES: {
                    "burnStatus": (function(){
                    	var result;
                    	app.ajax({
                    			async: false,
	                            type: "GET",
	                            url: "/CREM3010/findBurnStatus",
	                            data: ""
	                        },
	                        function(res){
	                        	result = res.list;
                        	}
                        );
                    	return result;
                    }())
                    , "msgType": (function(){
                    	var result;
                    	app.ajax({
                    			async: false,
	                            type: "GET",
	                            url: "/CREM3010/findMsgType",
	                            data: ""
	                        },
	                        function(res){
	                        	result = res.list;
                        	}
                        );
                    	return result;
                    }())
                },
                pageStart: function(){
                    this.grid.bind();
                    this.bindEvent();
                    this.grid.setPageHwaBrazier();
                    this.grid.setPageMsgSet();
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
                    $("#ax-grid-btn-add").bind("click", function(){
                        _this.grid.add();
                    });
                    $("#ax-grid-btn-del").bind("click", function(){
                        _this.grid.del();
                    });
                    $('#ax-input-checkbox').find('input[type=radio]').bindChecked();
                    $('#ax-input-checkbox').find('input[type=radio]').bind("change", function(){
                    	fnObj.grid.setPageMsgSet(this.value);
                    });
                    $("input:radio[name='msgType']:radio[value='0']").click();
                    $('#btn-receipt').bind("click", function(){
                    	if(!confirm("선택하신 화장 데이터를 접수 상태로 변경하시겠습니까?")){
                    		return;
                    	}
						fnObj.updateBurnStatus(1);
                    });
                    $('#btn-body-carrying').bind("click", function(){
                    	if(!confirm("선택하신 화장 데이터를 접수 상태로 변경하시겠습니까?")){
                    		return;
                    	}
                    	fnObj.updateBurnStatus(2);
                    });
                    $('#btn-cremation').bind("click", function(){
                    	if(!confirm("선택하신 화장 데이터를 화장 상태로 변경하시겠습니까?")){
                    		return;
                    	}
                    	fnObj.updateBurnStatus(3);
                    });
                    $('#btn-sugol').bind("click", function(){
                    	if(!confirm("선택하신 화장 데이터를 수골 상태로 변경하시겠습니까?")){
                    		return;
                    	}
                    	fnObj.updateBurnStatus(4);
                    });
                    $('#btn-end').bind("click", function(){
                    	if(!confirm("선택하신 화장 데이터를 종료 상태로 변경하시겠습니까?")){
                    		return;
                    	}
                    	fnObj.updateBurnStatus(9);
                    });
                    $('#btn-broadcast').bind("click", function(){
                    	app.ajax({
                            type: "POST",
                            url: "/CREM3010/saveTTS",
                            data: "{'msgContent' : '"+$('#ta-msg').val()+"'}"
                        }, function(res){
                            if(res.error){
                               alert(res.error.message);
                            }
                            else
                            {
                            	toast.push("방송 완료");
                            }
                        });
                    });
                },
                updateBurnStatus : function(burnStatus){
                	var item = fnObj.grid.target.hwaBrazier.getSelectedItem().item
					if(item.error){
						toast.push(item.description);
						return;
					}
					item.burnStatus = burnStatus;
                	app.ajax({
                        type: "POST",
                        url: "/CREM3010/updateHwaStatus",
                        data: Object.toJSON(item)
                    }, function(res){
                        if(res.error){
                           alert(res.error.message);
                        }
                        else
                        {
                        	toast.push("화장 진행 상태를 변경하였습니다.");
                        	var _target = fnObj.grid.target.hwaBrazier;

                            $.ajax({
                                url:'/CREM3010/findHwaBrazier',
                                dataType:'json',
                                success:function(data){
                                	var gridData = {
                                            list: data.list
                                        };
                                    _target.setData(gridData);
                                }
                            });
                        }
                    });
                },
                grid: {
                    target: {hwaBrazier : new AXGrid(), msgSet : new AXGrid()},
                    bind: function(){
                        var targetHwaBrazier = this.target.hwaBrazier, _this = this;
                        var targetMsgSet = this.target.msgSet;
                        targetHwaBrazier.setConfig({
                            targetID : "page-grid-box-hwa",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                {key:"burnChasu", label:"회차", width:"100", align:"center"
                                },
                                {key:"burnNo", label:"화로번호", width:"150", align:"center"
                                },
                                {key:"deadName", label:"고인명", width:"150", align:"center"
                                },
                                {key:"applyName", label:"신청자명", width:"150", align:"center"
                                },
                                {key:"burnStatus", label:"상태", width:"150", align:"center"
                                	, formatter : function(val){
                                		for(var i=0; i<fnObj.CODES.burnStatus.length; i++){
                                			if(this.item.burnStatus == fnObj.CODES.burnStatus[i].code){
                                				return fnObj.CODES.burnStatus[i].name;
                                			}
                                		}
                                	}
                                },
                                {key:"burnStrTimeString", label:"시작시간", width:"150", align:"center"
                                },
                                {key:"burnEndTimeString", label:"종료시간", width:"150", align:"center"
                                },
                                {key:"waitRoomName", label:"유족대기실", width:"150", align:"center"
                                },
                                {key:"byeRoomName", label:"고별실", width:"150", align:"center"
                                }
                            ],
                            body : {
                                onclick: function(){
                                    //toast.push(Object.toJSON({index:this.index, item:this.item}));
                                    //alert(this.list);
                                    //alert(this.page);
                                }
                            },
                            page: {
                                display: true,
                                paging: false
//                                 , onchange: function(pageNo){
//                                     _this.setPage(pageNo);
//                                 }
                            }
                        });
                        targetMsgSet.setConfig({
                            targetID : "page-grid-box-msg",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
//                                 {key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"msgId", label:"코드", width:"100", align:"center"},
                                {key:"msgContent", label:"내용", width:"600", align:"center"},
                                {key:"repeatCnt", label:"횟수", width:"150", align:"center"},
                                {key:"msgType", label:"형식", width:"150", align:"center"
	                               	, formatter : function(val){
	                            		for(var i=0; i<fnObj.CODES.msgType.length; i++){
	                            			if(this.item.msgType == fnObj.CODES.msgType[i].code){
	                            				return fnObj.CODES.msgType[i].name;
	                            			}
	                            		}
	                            	}
                                },
                                {key:"msgUse", label:"용도", width:"150", align:"center"}
                            ],
                            body : {
                                onclick: function(){
                                    //toast.push(Object.toJSON({index:this.index, item:this.item}));
                                    //alert(this.list);
                                    //alert(this.page);
                                    $('#ta-msg').val(this.item.msgContent);
                                }
                            },
                            page: {
                                display: true,
                                paging: false
//                                 , onchange: function(pageNo){
//                                     _this.setPage(pageNo);
//                                 }
                            }
                        });
                    },
                    setPageHwaBrazier: function(){
                        var _target = fnObj.grid.target.hwaBrazier;

                        $.ajax({
                            url:'/CREM3010/findHwaBrazier',
                            dataType:'json',
                            success:function(data){
                            	var gridData = {
                                        list: data.list
                                    };
                                _target.setData(gridData);
                            },
                            complete:function(){
                            	setTimeout(fnObj.grid.setPageHwaBrazier, 10*1000);
                            }
                        });

                    },
                    setPageMsgSet: function(value){
                        var _target = this.target.msgSet;

                         app.ajax({
                             type: "GET",
                             url: "/CREM3010/findMsgsetByMsgType",
                             data: "dummy="+ axf.timekey() + "&msgType=" + value
                         }, function(res){
                             if(res.error){
                                alert(res.error.message);
                             }
                             else
                             {
                                 var gridData = {
                                     list: res.list
                                 };
                                 _target.setData(gridData);
                             }
                         });
                    }
                }
            };
        </script>
    </ax:div>
</ax:layout>