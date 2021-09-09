<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>

<ax:layout name="base.jsp">
    <ax:set name="title" value="${PAGE_NAME}" />
    <ax:set name="page_desc" value="${PAGE_REMARK}" />
    <ax:div name="css">
    	<style>
    		.tase{
    			background-color: red;
    		}
    	</style>
    </ax:div>
    <ax:div name="contents">
        <ax:row>
            <ax:col size="12">
                <ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}" function2Auth="${FUNCTION_2_AUTH}" function3Auth="${FUNCTION_3_AUTH}" function4Auth="${FUNCTION_4_AUTH}" function5Auth="${FUNCTION_5_AUTH}"></ax:custom>
				<div class="ax-search" id="page-search-box"></div>
				<iframe id="if-pdf" width="100%" height="700" style="border: 0.5px solid lightgray;"></iframe>
			</ax:col>
		</ax:row>
    </ax:div>
    <ax:div name="scripts">
        <script type="text/javascript">
            var resize_elements = [
            ];
            var fnObj = {
                CODES: {
                	empGubun: Common.getCode("EMP_GUBUN"),
                	opyn: Common.getCode("OPYN")
                },
                pageStart: function(){
                    this.bindEvent();
					this.search.bind();
					this.gridEmployee.bind();
					this.gridDaywork.bind();
					this.gridDaydoc.bind();
                    this.search.submit();
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
               						{label:"운영일자", labelWidth:"", type:"inputText", width:"100", key:"workDate", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
               							onChange: function(){}
	               						, AXBind:{
	        								type:"date", config:{
	        									align:"right", valign:"top", defaultDate:new Date().print(),
	        									onChange:function(){
// 	        										toast.push(Object.toJSON(this));
	        									}
	        								}
	        							},
               						}
                                ]}
                            ]
                        });
                    },
                    submit: function(){
						var workDate = Common.search.getValue(fnObj.search.target, "workDate");
						Common.report.embedded("/reports/changwon/dail/DAIL1021", "pdf", "WORK_DATE="+workDate, "if-pdf");
                    }
                },

            };
        </script>
    </ax:div>
</ax:layout>