<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%
	request.setAttribute("callBack", request.getParameter("callBack"));
%>
<ax:layout name="modal.jsp">
	<ax:set name="title" value="사용료" />
	<ax:set name="page_desc" value="" />

	<ax:div name="contents">
		<ax:row>
			<ax:col size="12" wrap="true">


                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-table"></i> 사용료</h2>
                    </div>
                    <div class="right">
                    </div>
                    <div class="ax-clear"></div>
                </div>

				<div class="ax-grid" id="page-grid-box" style="min-height: 400px;"></div>

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
			var fnObj = {
                CODES: {
                	"jobGubun": Common.getCode("JOB_GUBUN")
                	,"priceGubun": {
                		"C" : [Common.getCode("PRICE_GUBUN")[0]]
                		,"E" : Common.getCode("PRICE_GUBUN")
                		,"N" : Common.getCode("PRICE_GUBUN")
                		,"T" : Common.getCode("PRICE_GUBUN")
                		,"F" : Common.getCode("PRICE_GUBUN")
                		,"S" : [Common.getCode("PRICE_GUBUN")[0]]
                	}
                	,"objt": {
                		"C":Common.getCode("TMC03")
                		,"E":Common.getCode("TFM10")
                		,"N":Common.getCode("TFM10")
                		,"T":Common.getCode("TFM10")
                		,"F":Common.getCode("TFM10")
                		,"S":Common.getCode("TFM27")
                	},
                	"addrPart": Common.getCode("TCM10")
                	,"dcGubun": Common.getCode("TCM12")


                },
				pageStart: function(){
					this.grid.bind();
					this.bindEvent();
					this.grid.setPage();
				},
				pageResize: function(){
					parent.myModal.resize();
				},
				bindEvent: function(){
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
                                {key:"jobGubun", label:"업무구분", width:"80", align:"center",
                             	    formatter: function(){
                             	    	jobGubun = this.value;
                             	    	return Common.grid.codeFormatter("jobGubun", this.value);
                                    },
                                },
                                {key:"priceGubun", label:"요금구분", width:"100", align:"center",
                               	    formatter: function(val){

                               	    	for(var i=0; i<fnObj.CODES.priceGubun[jobGubun].length; i++){
                                			if(this.value == fnObj.CODES.priceGubun[jobGubun][i].optionValue){
                                				return fnObj.CODES.priceGubun[jobGubun][i].optionText;
                                			}
                                		}
                              	    },
                                },
                                {key:"objt", label:"대상구분", width:"150", align:"center",

                                	formatter: function(val){
                                		for(var i=0; i<fnObj.CODES.objt[jobGubun].length; i++){
                                			if(this.value == fnObj.CODES.objt[jobGubun][i].optionValue){
                                				return fnObj.CODES.objt[jobGubun][i].optionText;
                                			}
                                		}
                            	    }
                                },
                                {key:"addrPart", label:"관내외구분", width:"150", align:"center",
                                	formatter: function(val){

                                	//	trace(this.value);
                                	//	trace(this);
                                		return Common.grid.codeFormatter("addrPart", this.value);
                              	    },


                                },
                                {key:"dcGubun", label:"감면구분", width:"150", align:"center",
									formatter: function(val){

                                		return Common.grid.codeFormatter("dcGubun", this.value);
                              	    },
                              	  	updateWith: ["_CUD"]
                                },
                                {key:"useDate", label:"적용일자", width:"150", align:"center",
									formatter: function(val){
                                	    trace(typeof this.value);
                                		return  typeof this.value  == "number" ?  new Date(this.value).print() : this.value ;
                              	    },
                                },
                                {key:"charge", label:"요금", width:"150", align:"center",
                                	formatter : "money",

                                },
                                {key:"useTerm", label:"사용년수", width:"150",

                                },
                                {key:"remark", label:"비고", width:"150",

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
                    setPage: function(){
                        var _target = this.target;

                         app.ajax({
                             type: "GET",
                             url: "/STAN1020/findPriceList",
                             data: "jobGubun=${param.jobGubun}&priceGubun=${param.priceGubun}&objt=${param.objt}"
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
                },
				control: {
					select: function(){

                        var item = fnObj.grid.target.getSelectedItem();
                        if(item.error){
                        	toast.push("사용료를 선택해주세요.");
                        	return;
                        }
						app.modal.save("${callBack}", item.item);

					},
					cancel: function(){
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