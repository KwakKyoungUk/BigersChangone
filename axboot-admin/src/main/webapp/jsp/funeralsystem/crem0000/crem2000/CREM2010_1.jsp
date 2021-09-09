<%@page import="com.axisj.axboot.core.domain.user.AdminLoginUser"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<ax:layout name="modal.jsp">
	<ax:set name="title" value="개장유골 입력" />
	<ax:set name="page_desc" value="" />
    <ax:div name="contents">
        <ax:row>
            <ax:col size="12">
                <ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}" function2Auth="${FUNCTION_2_AUTH}" function3Auth="${FUNCTION_3_AUTH}" function4Auth="${FUNCTION_4_AUTH}" function5Auth="${FUNCTION_5_AUTH}"></ax:custom>

                <ax:custom customid="table">
                    <ax:custom customid="tr">
                        <ax:custom customid="td" colspan="3">
                        	<div class="ax-button-group">
			                    <div class="left">
			                        <h2><i class="axi axi-storage"></i> 고인입력</h2>
			                    </div>
			                    <div class="right">
			                    	<button class="AXButton" onclick="fnObj.gridHwaOpenGrave.add()">추가</button>
			                    	<button class="AXButton" onclick="fnObj.gridHwaOpenGrave.del()">삭제</button>
			                    	<button class="AXButton" onclick="fnObj.save()">저장</button>
			                    </div>
			                    <div class="ax-clear"></div>
			                </div>
			                <div class="ax-grid" id="page-grid-box-hwaOpenGrave" style="min-height: 400px;"></div>
                        </ax:custom>
                    </ax:custom>
                </ax:custom>

            </ax:col>
        </ax:row>
       	<ax:div name="buttons">
			<button type="button" class="AXButton" onclick="fnObj.control.cancel();">닫기</button>
		</ax:div>
    </ax:div>
    <ax:div name="scripts">
        <jsp:include page="/jsp/funeralsystem/common/postcode.jsp"></jsp:include>
        <script type="text/javascript">

            var resize_elements = [
//                 {id:"page-grid-box-rogrpchasu", adjust:function(){
//                     	return -axf.clientHeight()/2;
//                 	}
//                 }
//                 , {id:"page-grid-box-hwaBooking", adjust:function(){
//     	                return -axf.clientHeight()/2;
// 	                }
//                 }
            ];
            var fnObj = {

                CODES: {
                	"objt": Common.getCode("TMC02"),
                },
                pageStart: function(){
                	this.gridHwaOpenGrave.bind();
                	this.gridHwaOpenGrave.setPage(1);
                    this.bindEvent();
                    // 페이지 로딩 후 바로 검색 처리하기 (option)
//                     this.search.submit();
                },
				pageResize: function(){
					parent.myModal.resize();
				},
                bindEvent: function(){
                },
                gridHwaOpenGrave: {
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "page-grid-box-hwaOpenGrave",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                            	{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"deadName", label:"고인명", width:"150", align:"center",
	                               	editor:{
		                                type:"text",
		                                maxLength: 50
	                                }
                                },
                                {key:"ugolNum", label:"일련번호", width:"180", align:"center",
	                               	editor:{
		                                type:"text",
		                                maxLength: 50
	                                }
                                },
                            ],
                            body : {
                                onclick: function(){
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
                    add:function(){
                        this.target.pushList({});
                        this.target.setFocus(this.target.list.length-1);
                    },
                    del: function(){
		                var checkedList = this.target.getCheckedListWithIndex(0);// colSeq
                    	this.target.removeListIndex(checkedList);
                        toast.push("삭제 되었습니다. 변경사항은 저장시 반영됩니다.");
                    },
                    setPage: function(pageNo, searchParams){
                        var _target = this.target;
                        this.pageNo = pageNo;

                        app.ajax({
                            type: "GET",
                            url: "/CREM1010_1/hwa_open_grave?cremDate=${param.cremDate}&cremSeq=${param.cremSeq}",
                            data: ""
                        }, function(res){
                            if(res.error){
                                alert(res.error.message);
                            }
                            else
                            {
                                var gridData = {
                                    list: res.list,
                                };
                                _target.setData(gridData);
                            }
                        });
                    }
                },
                save: function(){

                	app.ajax({
                        type: "PUT",
                        url: "/CREM1010_1/hwa_open_grave?cremDate=${param.cremDate}&cremSeq=${param.cremSeq}",
                        data: Object.toJSON(fnObj.gridHwaOpenGrave.target.list)
                    },
                    function(res){
                        if(res.error){
                            console.log(res.error.message);
                            alert(res.error.message);
                        }
                        else
                        {
                           toast.push("저장되었습니다.");
                           fnObj.control.cancel()
                        }
                    });
                },
				control: {
					cancel: function(){
						app.modal.cancel();
					}
				},

            };
			axdom(document.body).ready(function() {
				fnObj.pageStart();
			});
			axdom(window).resize(fnObj.pageResize);
        </script>

    </ax:div>
</ax:layout>