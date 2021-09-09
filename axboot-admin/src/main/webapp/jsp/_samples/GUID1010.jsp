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
                             <div class="ax-search" id="page-search-box"></div>
								<div class="ax-button-group">
				                   	 <div class="left">
				                		     	<h2><i class="axi axi-list-alt"></i> 고인 목록</h2>
				              			 </div>
				                 	
				                	 <div class="ax-clear"></div>
				               	 </div>
                            <%-- %%%%%%%%%% 그리드 (업체정보) %%%%%%%%%% --%>
                            <div class="ax-grid" id="page-grid-box" style="min-height: 300px;"></div>
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
            
            function strReplace(str){
              	 regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%\\\\(\'\"]/gi
                   //	return  _this.target.stdate.replace(regExp, "").replace(/\s/g,''); 
              	  var val = "";
              	  if(str != "" && str != null && typeof str !== "undefined" ){
              		
              	   val =str.replace(regExp, "").replace(/\s/gi,''); 
              	  }
               
                  return  val;
            }

            var fnObj = {
                
                pageStart: function(){
                    this.search.bind();
                    this.grid.bind();                  
                    this.bindEvent();
                    // 페이지 로딩 후 바로 검색 처리하기 (option)
                    //this.search.submit();
                },
                bindEvent: function(){
                	
                    var _this = this;
                    $("#ax-page-btn-search").bind("click", function(){
                       _this.search.submit();
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
                                      {label:"매장구분", labelWidth:"", type:"selectBox", width:"150", key:"kind", addClass:"", valueBoxStyle:"", value:"",
                                          options:[],
                                          AXBind:{
                                              type:"select", config:{
                                                  reserveKeys: {
                                                      options: "list",
                                                      optionValue: "code",
                                                      optionText: "name"
                                                  },
      				                            method:"GET", ajaxUrl: "/api/v1/basicCodes/group", ajaxPars: "basicCd=00001",
                                                  isspace: true, isspaceTitle: "전체",
                                                  setValue:"ALL",
                                                  alwaysOnChange: true,
                                                  onchange:function(){
                                                     // console.log(this);
                                                     // fnObj.code = this.value;
                                                     // fnObj.name = this.text.dec();
                                                      //toast.push(Object.toJSON(this));
                                                    ///fnObj.search.submit();
                                                  }
                                              }
                                          }
                                      },
                                      {label:"고인명", labelWidth:"", type:"inputText", width:"150", key:"deadName",  addClass:"deadName", valueBoxStyle:"", value:"" ,
                                    	  config:{min:2, maxLength:10},
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
    	            	var deadName =  this.target.getItemId("deadName");
    	            	var dd = $(deadName);
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
                                
                                {key:"deadName", label:"고인명", width:"100", align:"center"},
                                {key:"deadSex", label:"성별", width:"100", align:"center"},
                                {key:"applName", label:"신청자", width:"100", align:"center"},
                                {key:"deadDate", label:"사망일자", width:"100", align:"center"},
                                {key:"tombDate", label:"안치일자", width:"100", align:"center"},
                                {key:"kindName", label:"구분", width:"100", align:"center"},
                                {key:"loc", label:"안장위치", width:"250", align:"center"},
                              /*   {key:"etc3", label:"ㅇㅇ", width:"150", align:"center",
                                    formatter: function(val){
                                        return fnObj.CODES._etc3[ ( (Object.isObject(this.value)) ? this.value.NM : this.value ) ];
                                    }
                                } */
                            ],
                          
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
                            url: "/GUID1010/findDeadList",
                          //  data: "dummy="+ axf.timekey() +"&pageNumber=" + (pageNo-1) + "&pageSize=50&" + (searchParams||"")
                        	data: "pageNumber=" + (pageNo-1) + "&pageSize=50&" + (searchParams||fnObj.search.target.getParam())
                            
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