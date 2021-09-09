<%----------------------------------------------------------------------------------------
 - 파일이름	: FUNE7020.jsp
 - 설      명	: 입관 정보 관리 화면
 - 작 성 자		: KYM
 - 추가내용 	:
 - 버전관리	: 1.0
 ----------------------------------------------------------
 - Date        Version   Auther   Description
 ----------------------------------------------------------
 - 2017.11.20  1.0        KYM      신규작성
------------------------------------------------------------------------------------------%>
<%@page import="com.axisj.axboot.core.domain.user.AdminLoginUser"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%@ taglib prefix="b" tagdir="/WEB-INF/tags" %>
<ax:layout name="base.jsp">
    <ax:set name="title" value="${PAGE_NAME}" />
    <ax:set name="page_desc" value="${PAGE_REMARK}" />
    <ax:div name="css">
        <style type="text/css">
             .button_group.vertical button{
            	width:130px;
            	height: 50px;
            	margin: 5px;
            	margin-bottom: 15px;
            	font-size: 18px;
            }
            .button_group.vertical.fixed{
            	right: 30px;
            	width: 150px;
            	text-align: center;
            }
            .fixed{
            	position: fixed;
            }
            .AXGrid .AXgridScrollBody .AXGridBody .gridBodyTable tbody tr td .bodyTdText,
	.AXGrid .AXgridScrollBody .AXGridBody .gridBodyTable tfoot tr td .bodyTdText,
	.AXGrid .AXgridScrollBody .AXGridBody .gridBodyTable thead tr td .bodyTdText
	{
		line-height: 9px;
	}
        </style>
    </ax:div>
    <ax:div name="contents">
        <ax:row>
            <ax:col>
                <ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}" function2Auth="${FUNCTION_2_AUTH}" function3Auth="${FUNCTION_3_AUTH}" function4Auth="${FUNCTION_4_AUTH}" function5Auth="${FUNCTION_5_AUTH}"></ax:custom>
				
				<div class="ax-search" id="page-search-box"></div>
				
				<ax:custom customid="table">
                    <ax:custom customid="tr">
                        <ax:custom customid="td">
                          
                            <div class="ax-grid" id="page-grid-box" style="min-height: 300px;"></div>

                        </ax:custom>
                        
                        <ax:custom customid="td" style="width:150px;" >
                        	<div class="button_group vertical fixed">
	                        	<b:button  text="고객조회" id="btn-srch-customer"></b:button>
	                        	<b:button  text="입관정보수정" id="btn-modify-ibkwan"></b:button>
	                        	<b:button  text="입관완료/취소" id="btn-ibkwan"></b:button>	                        	
                        	</div>
						</ax:custom>
                        
                        
                    </ax:custom>
                </ax:custom>
				
								
            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
    	<script type="text/javascript">
            var resize_elements = [
                {id:"page-grid-box", adjust:-85}
            ];
            var pb_data={            		
                	//그리드 선택 값
            		selectedCustomerNo		: "",
            		selectedInkwanGubun	: "",
            }
            var fnObj = {
           		CODES: {
           			deadSex			: Common.getCode("TCM05"),
           			person			: Common.getCode("117"),
           			funeral_gubun 	: Common.getCode("107"),
           			ibkwan_gubun 	: Common.getCode("108"),
           			ibkwan_code	: Common.getCodeByUrl("/FUNE7020/code/gubunCd?ibkwanGubun=03")
               	},
                pageStart: function(){
                	this.search.bind();
                    this.grid.bind();
                    this.bindEvent();
                    // 페이지 로딩 후 바로 검색 처리하기 (option)
                    this.search.submit();
                },
                bindEvent: function(){
                    var _this = this;
                    $("#ax-page-btn-search").bind("click", function(){
                        _this.search.submit();
                    });
                    $("#btn-srch-customer").bind("click", fnObj.eventFunc.srchCustomer);
                    $("#btn-modify-ibkwan").bind("click", fnObj.eventFunc.modifyIbkwan);
                    $("#btn-ibkwan").bind("click", fnObj.eventFunc.ibkwan);
                },
                eventFunc: {
                	//고객조회 화면이동
                	srchCustomer: function(){
                		if($.trim(pb_data.selectedCustomerNo)  === ""){
                			alert("선택한 고객이 없습니다.");
							return;
                		}
                		var str_url = "/jsp/funeralsystem/fune/fune1000/FUNE1030.jsp?m=searchFuneral&customerNo=" + pb_data.selectedCustomerNo;
                		window.location.href = str_url;
                	},
                	//입관 정보 수정
                	modifyIbkwan: function(){
                		if($.trim(pb_data.selectedCustomerNo)  === ""){
                			alert("선택한 고객이 없습니다.");
							return;
                		}
                		//재조회 할때 검색한 날짜로 해야 하므로 입관날짜까지 보냄.
                		app.modal.open({
	                        url:"/jsp/funeralsystem/fune/fune7000/FUNE7021.jsp?customerNo=" + pb_data.selectedCustomerNo + "&ibkwanDate=" + $("#"+fnObj.search.target.getItemId("ibkwanDate")).val(),
	                        pars:"callBack=fnObj.grid.setPage",
	                        width:600,
	                        top:100
	                    });
                	},
                	//입관 완료 / 취소
                	ibkwan: function(){
                		if($.trim(pb_data.selectedCustomerNo)  === ""){
                			alert("선택한 고객이 없습니다.");
							return;
                		}
                		//구분값만 변경
                		var flagGubun="";
                		if(pb_data.selectedInkwanGubun === "0"){
                			flagGubun = "1";
                		}else{
                			flagGubun = "0";
                		}
                		
                		var funeral = {
								customerNo		: pb_data.selectedCustomerNo,
								ibkwanGubun 	: flagGubun
						}
                		app.ajax({
                            type: "POST",
                            url: "/FUNE7020/funeral/ibkwanGubun",
                            data: Object.toJSON(funeral)
                        },
                        function(res){
                        	if(res.error){
                        		alert(res.error.message);
                        	}else{
                        		//완료 후 기 선택값 초기화 
                        		pb_data.selectedCustomerNo 		= "";
                            	pb_data.selectedInkwanGubun 	= "";
                            	//선택된것처럼 그리드 유지되는것 제거
                        		fnObj.grid.target.reloadList();
                        		fnObj.search.submit();
                            }
                        });
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
									{label:"입관일자", labelWidth:"", type:"inputText", width:"100", key:"ibkwanDate", addClass:"secondItem", valueBoxStyle:"", value:new Date().print(),
               							onChange: function(){}
	               						, AXBind:{
	        								type:"date", config:{
	        									align:"right", valign:"top", defaultDate:new Date().print(),
	        									onChange:function(){
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
                        var pars = this.target.getParam();
                        console.log(pars);
                        fnObj.grid.setPage(pars);
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
                            colGroup : [
                                {key:"customerNo"		, label:"코드"				, display :false},                                                                                                
                                {key:"photoImage"		, label:"고인이미지"		, width:"110"	, align:"center",
                                	formatter : function(){
	                                	if(this.item.photo){
	                                		return "<img width='90' height='85' src='"+this.item.photo.photoImage+"'/>";		                               		
	                                	}else{
	                                		return "<img width='90' height='85' src='/static/ui/bigers/images/profile.png'/>";
	                                		return "";
	                                	}	
                                	}
                                },
                                {key:"deadName"			, label:"고인명"			, width:"100"	, align:"center",
                                	formatter : function(){
	                                	if(this.item.thedead){
		                               		return this.item.thedead.deadName;
	                                	}else{
	                                		return "";
	                                	}	
                                	}
                                },
                                {key:"applName"			, label:"상주명"			, width:"100" 	, align:"center",
                                	formatter : function(){
	                                	if(this.item.binso){
		                               		return this.item.applicant.applName;
	                                	}else{
	                                		return "";
	                                	}	
                                	}	
                                },
                                {key:"binsoCode"			, label:"빈소/안치"		, width:"100" 	, align:"center",
                                	formatter : function(){
	                                	if(this.item.binso){
		                               		return this.item.binso.binsoName + " ("  + this.item.anchiRoom + "호)";
	                                	}else{
	                                		return "";
	                                	}
                                	}
                                },
                                {key:"deadSex"			, label:"성별/나이"		, width:"100" 	, align:"center"
                                	,formatter : function(){
	                                	if(this.item.thedead){
	                                		var dead_sex="";
	                           				for(var i=0; i<fnObj.CODES.deadSex.length; i++){
	                                   			if(this.item.thedead.deadSex == fnObj.CODES.deadSex[i].optionValue){
	                                   				dead_sex = fnObj.CODES.deadSex[i].optionText;                                   				
	                                   			}
	                                   		}
	                           				var birthday = new Date(this.item.thedead.deadBirth);
	                           				var today = new Date();
	                           				
	                           				var years = today.getFullYear() - birthday.getFullYear();
	                           				birthday.setFullYear(today.getFullYear());
	                           				if (today < birthday) years--;
	                           				return dead_sex + " / " + years;	                           				
	                                	}else{
	                                		return "";
	                                	}
                           			}	
                                },
                                {key:"anchiDate"		, label:"안치/입관일시"		, width:"300" 	, align:"center",
                                	formatter : function(){
                            			if(this.value){
	                                		return this.value.date().print("yyyy-mm-dd hh:mi") + " , " + this.item.ibkwanDate.date().print("yyyy-mm-dd hh:mi");
                                		}else{
                                			return "";
                                		}
                            		}	
                                },
                                {key:"person"					, label:"상례사"		, width:"100" 	, align:"center",
                                	formatter : function(){
                                		if(this.item.photo){
                                			var person01= "";
                                			var person02= "";
                                			if(this.item.photo.person01){
                                				for(var i=0; i<fnObj.CODES.person.length; i++){
                                           			if(this.item.photo.person01 == fnObj.CODES.person[i].optionValue){
                                           				person01 =  fnObj.CODES.person[i].optionText;
                                           			}
                                           		}	
                                			}
                                			if(this.item.photo.person02){
                                				for(var i=0; i<fnObj.CODES.person.length; i++){
                                           			if(this.item.photo.person02 == fnObj.CODES.person[i].optionValue){
                                           				person02 =  fnObj.CODES.person[i].optionText;
                                           			}
                                           		}	
                                			}
                                    		if(person01 && person02){
                                    			return person01 + " , " + person02;
                                    		}else if(this.item.photo.person01){
                                    			return person01
                                    		}else if(this.item.photo.person02){
                                    			return person02
                                    		}                                    		
                                    	}	
                                	}
                                	
                                },
                                {key:"ibkwanCode"			, label:"입관실"		, width:"100" 	, align:"center",
                                	formatter : function(){
                                		if(this.item.photo){
                                			if(this.item.photo.ibkwanCode){
                                				for(var i=0; i<fnObj.CODES.ibkwan_code.length; i++){
                                           			if(this.item.photo.ibkwanCode == fnObj.CODES.ibkwan_code[i].optionValue){
                                           				return fnObj.CODES.ibkwan_code[i].optionText;
                                           			}
                                           		}	
                                			}                                			
                                		}                           				
                           			}                                		
                                },
                                {key:"funeralGubun"			, label:"장례방법"	, width:"80" 	, align:"center",                                	
                                	formatter : function(){
                           				for(var i=0; i<fnObj.CODES.funeral_gubun.length; i++){
                                   			if(this.value == fnObj.CODES.funeral_gubun[i].optionValue){
                                   				return fnObj.CODES.funeral_gubun[i].optionText;
                                   			}
                                   		}
                           			}
                                },
                                {key:"ibkwanGubun"			, label:"완료"			, width:"50" 	, align:"center",
                                	formatter : function(){
                           				for(var i=0; i<fnObj.CODES.ibkwan_gubun.length; i++){
                                   			if(this.value == fnObj.CODES.ibkwan_gubun[i].optionValue){
                                   				return fnObj.CODES.ibkwan_gubun[i].optionText;
                                   			}
                                   		}
                           			}	
                                },
                            ],
                            body : {
                                onclick: function(){
                                	//선택값 저장
                                	pb_data.selectedCustomerNo 		= this.item.customerNo;
                                	pb_data.selectedInkwanGubun 	= this.item.ibkwanGubun;                                	
                                }
                            },
                            page: {
                                display: true,
                                paging: false,
                                onchange: function(pageNo){
                                    _this.setPage(pageNo);
                                }
                            }
                        });
                    },                  
                    clear: function(){
                        this.target.setList([]);
                    },
                    setPage: function(searchParams){
                        var _target = this.target;
                        
                        app.ajax({
                            type: "GET",
                            url: "/FUNE7020/ibkwan",
                            async: false,
                            data: "dummy="+ axf.timekey() +"&" + (searchParams||"")
                        }, function(res){
                            if(res.error){
                                alert(res.error.message);
                            }
                            else
                            {                            	
                            	//console.log("<<<", res);
                            	fnObj.grid.target.setData({list:res.list});
                            }
                        });
                    }
                }
            };
        </script>
    </ax:div>
</ax:layout>