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


<form id="myform" name="myform" method="post" action="http://127.0.0.1:90/jasperserver/flow.html" target="popup_window">
  <input name="_flowId" value="viewReportFlow" />
  <input name="reportUnit" value="%2Freports%2FLay_StsLoc_Pre" />
  <input name="output" value="pdf" />

</form>

---------------------------------------------------------------------------
장사시스템의 CREM1020.jsp 참조
Common.report.go 로 검색하면 레포트 창 띄우는 예제 확인 가능.
---------------------------------------------------------------------------

                <div class="ax-search" id="page-search-box"></div>
                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-list-alt"></i> 정보리스트</h2>
                        	<a href="http://127.0.0.1:90/jasperserver/flow.html/flowFile/TableReport.pdf">asdsad</a>
                        	<a href="http://127.0.0.1:90/jasperserver/flow.html?_flowId=viewReportFlow&reportUnit=%2Freports%2FRitMngRgit_excel&output=pdf">asdsad</a>

                    </div>
                    <div class="right">
                        <button type="button" class="AXButton" id="ax-grid-btn-add"><i class="axi axi-plus-circle"></i> 추가</button>
                        <button type="button" class="AXButton" id="ax-grid-btn-del"><i class="axi axi-minus-circle"></i> 삭제</button>
                        <button type="button" class="AXButton" id=btn_submit><i class="axi axi-minus-circle"></i> 서브밋</button>
                    </div>
                    <div class="ax-clear"></div>
                </div>
                <div class="ax-grid" id="page-grid-box" style="min-height:300px;"></div>

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
                    "etc3": [
                        {CD:'1', NM:"코드"},
                        {CD:'2', NM:"CODE"},
                        {CD:'4', NM:"VA"}
                    ],
                    "_etc3": {"1":"코드", "2":"CODE", "4":"VA"}
                },
                pageStart: function(){

                    this.grid.bind();
                    this.bindEvent();
                    // 페이지 로딩 후 바로 검색 처리하기 (option)
                    this.search.submit();
                },
                bindEvent: function(){
                    var _this = this;

                    $("#ax-page-btn-excel").bind("click", function(){
                        app.modal.excel({
                            pars:"target=${className}"
                        });
                    });

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
                                {key:"key", label:"코드", width:"100", align:"left",
                                    editor:{
                                        type:"text",
                                        maxLength: 8,
                                        disabled: function(){
                                            return this.item._CUD != "C";
                                        },
                                        beforeUpdate: function(val){
                                            var hasCd = false, index = this.index;
                                            target.list.forEach(function(item, i){
                                                if(item.key == val && i != index) {
                                                    hasCd = true;
                                                    return false;
                                                }
                                            });
                                            if(hasCd) target.list[index].__edting__ = true;
                                            return (hasCd) ? "" : val;
                                        },
                                        afterUpdate: function(){
                                            if(this.item.key == "" && this.item.__edting__) toast.push("코드값이 중복됩니다. 입력이 취소 되었습니다.");
                                            delete target.list[this.index].__edting__;
                                        }
                                    }
                                },
                                {key:"value", label:"이름", width:"150",
                                    editor:{
                                        type:"text",
                                        maxLength: 50
                                    }
                                },
                                {key:"etc1", label:"컬럼1", width:"150",
                                    editor:{
                                        type:"text",
                                        maxLength: 50
                                    }
                                },
                                {key:"etc2", label:"날짜", width:"150",
                                    editor:{
                                        type: "calendar",
                                        config: {
                                            separator: "-"
                                        },
                                        updateWith: ["_CUD"] // 셀에디팅이 일어나면 함께 컬럼 업데이트 해야할 컬럼 키
                                    }
                                },


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
                                paging: true,
                                onchange: function(pageNo){
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
                             url: "/api/v1/samples/parent",
                             data: "dummy="+ axf.timekey() +"&pageNumber=" + (pageNo-1) + "&pageSize=50&" + (searchParams||fnObj.search.target.getParam())
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
                                 _target.setData(gridData);
                             }
                         });
                    }
                }
            };
        </script>
    </ax:div>
</ax:layout>