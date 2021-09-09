<%----------------------------------------------------------------------------------------
 - 파일이름	: FUNE4020.jsp
 - 설      명	: 생산 관리 > 식단 관리 화면
 - 작 성 자		: KYM
 - 추가내용 	:
 - 버전관리	: 1.0
 ----------------------------------------------------------
 - Date        Version   Auther   Description
 ----------------------------------------------------------
 - 2017.11.08  1.0        KYM      신규작성
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
             #calendar {
				margin: 0 auto;
			}
			/*토요일 일요일 색 조정*/
		    .fc-sat {
		        color: #0082BE;
		    }
		    .fc-sun {
		        color: #E51C23;
		    }

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
                            <div id='calendar'></div>

                        	<div class="ax-clear"></div>

                        <div class="spacer" style="width: 100px; height: 10px;"></div>
                        	<div id='select-date' style="font-size: 16px;font-weight: bold;">&nbsp;</div>
                        </ax:custom>

                        <ax:custom customid="td" style="width:150px;" >
                        	<div class="button_group vertical fixed">
	                        	<b:button  text="식단작업등록" id="btn-new-menu"></b:button>
	                        	<b:button  text="조리작업지시서" id="btn-cooking-work-order"></b:button>
                        	</div>

						</ax:custom>

                    </ax:custom>
                </ax:custom>


            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
    	<link href='/static/plugins/fullcalendar/fullcalendar.css' rel='stylesheet' />
		<link href='/static/plugins/fullcalendar/fullcalendar.print.css' rel='stylesheet' media='print' />
		<script src='/static/plugins/fullcalendar/lib/moment.min.js'></script>
		<script src='/static/plugins/fullcalendar/fullcalendar.js'></script>
		<script src='/static/plugins/fullcalendar/locale-all.js'></script>
    	<script type="text/javascript">
    	    var calData={
            		selDate : "",
            		selPartCode:""
            }
    		var fnObj = {
                pageStart: function(){
                	this.search.bind();
                    this.bindEvent();
                    // 페이지 로딩 후 바로 검색 처리하기 (option)
                    this.search.submit();
                  	//년월 달력 세팅
                	$("[name='menuDate']").bindDate({separator: "-", selectType: "m"});
                },
                bindEvent: function(){
                    var _this = this;
                    $("#ax-page-btn-search").bind("click", function(){
                        _this.search.submit();
                    });
                    $("#btn-new-menu").bind("click", fnObj.eventFunc.newMenu);
                    $("#btn-cooking-work-order").bind("click", fnObj.eventFunc.cookingWorkOrder);
                },
                eventFunc: {
                	//식단 작업 등록
                	newMenu: function(){
                		if(calData.selDate  === ""){
							alert("날짜를 선택 하세요");
							return;
						}
						var part_code 	= encodeURI($("#"+fnObj.search.target.getItemId("partCode")).val());
						var recipe_date	= calData.selDate.replace(/-/g, '');
						app.modal.open({
                            url:"/jsp/funeralsystem/fune/fune4000/FUNE4021.jsp",
                            pars:"callBack=&m=searchMenuInfo&execute=new"
								+ "&partCode="+part_code+ "&itemCode=90-9998&recipeCode=" + recipe_date, // callBack 말고
							width: (window.innerWidth||1400)*0.9, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
                            //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
                        })
                	},
                	cookingWorkOrder : function(){
                		if(calData.selDate  === ""){
							alert("날짜를 선택 하세요");
							return;
						}
                		var part_code 	= encodeURI($("#"+fnObj.search.target.getItemId("partCode")).val());
						var recipe_date	= calData.selDate.replace(/-/g, '');
						app.modal.open({
                            url:"/jsp/funeralsystem/fune/fune4000/FUNE4023.jsp",
                            pars:"callBack="
								+ "&partCode="+part_code+ "&itemCode=90-9998&recipeCode=" + recipe_date+"&printName="+"${LOGIN_USER_NAME}", // callBack 말고
								width: (window.innerWidth||1400)*0.9, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
                            //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
                        })
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
									{label:"파트", labelWidth:"", type:"selectBox", width:"100", key:"partCode", addClass:"", valueBoxStyle:"", value:"",
										options:[],
										AXBind:{
										   type: "select", config: {
                                                reserveKeys: {
                                                      options: "list",
                                                      optionValue: "partCode",
                                                      optionText: "partName"
                                                   },
                                              ajaxUrl: "/FUNE4020/part",
                                              ajaxPars:"partGroupCode=2",
                                              //setValue: "",
                                              alwaysOnChange: true,
                                              onChange: function() {
                                            	  /* 처음 로딩시 하단 submit 으로 getParam() 하면 현재 콤보 값을 못가져감. 해결방법 찾으면 수정요. 상단 alwaysOnChange true값 주고 여기 검색을 한번더 실행하면 파라미터  이동하여 검색 됨 */
                                            	  _this.submit();
                                              }
                                            }
										}
									},
									{label:"식단년월", labelWidth:"", type:"inputText", width:"100", key:"menuDate", addClass:"secondItem", valueBoxStyle:"", value:new Date().print("yyyy-mm"),
               							onChange: function(){
               								_this.submit();
               							}
               						}
                                ]}
                            ]
                        });
                    },
                    submit: function(){
                    	calData.selDate 	= "";
                        var pars 			= this.target.getParam();
                        var pars_arr 		= pars.split('&')
		                var obj 				= {};
                        //파라미터 객체화
	                   	for(var c=0; c < pars_arr.length; c++) {
	                    	var split 		= pars_arr[c].split('=', 2);
	                     	obj[split[0]] 	= split[1];
	                   	}
		                //조회 하여 달력 변경 시
		                $('#calendar').fullCalendar('destroy');
		                // 달력 로딩
                        fnObj.renderCalendar(obj);
                        fnObj.bottomDateTxt("today");
                    }
                },
                renderCalendar:function(srchParam){
                	// 처음에 파트코드 콤보 값을 취득 못함 partCode 들어올때만 검색
                	if(srchParam.partCode != undefined){
                		// 받아온 값 기본 날짜 지정
                		var srch_dt 	= srchParam.menuDate;
                		var part_code = srchParam.partCode;

                		//달력 세팅
                		// https://fullcalendar.io/docs/
                		$('#calendar').fullCalendar({
                			  defaultDate: srch_dt+ "-01",				// 기본 날짜 지정
                				header:{
	            					 left: '',
	            	                 center: 'title',
	            	                 right: ''
                				},
                	        	locale: 'ko',							// 언어셋 세팅
                				editable: false,					// 이벤트들 수정 가능여부
                				allDaySlot:false,  				// 최상단 종일 보여주기
                				eventLimit: false, 				// allow "more" link when too many events
                			    lazyFetching: false,
                				//공간 선택 이벤트
                				selectable: true,
                				//해당월만 선택 가능케
                				selectConstraint: {
                			        start:$.fullCalendar.moment(srch_dt+ "-01"),
                			        end: $.fullCalendar.moment(srch_dt+ "-01").startOf('month').add(1, 'month')
                			    },
                				select: function(start, end) {
                					//전역 변수에 선택 날짜 삽입
                					calData.selDate = start.format("YYYY-MM-DD");
            						//하단 날짜 표시
                					fnObj.bottomDateTxt(start);
                				}
                				//타이틀 클릭시 이벤트
                				,eventClick: function(calEvent, jsEvent, view) {
                			        //console.log(calEvent.id);
                					var param = calEvent.id.split("|");
                					app.modal.open({
                                        url:"/jsp/funeralsystem/fune/fune4000/FUNE4021.jsp",
                                        pars:"callBack=&m=searchMenuInfo&execute=mod"
            								+ "&partCode="+param[0]+"&itemCode=" + param[1]+"&recipeCode=" + param[2], // callBack 말고
            								width: (window.innerWidth||1400)*0.9, // 모달창의 너비 - 필수값이 아닙니다. 없으면 900
                                        //top:100 // 모달창의 top 포지션 - 필수값이 아닙니다. 없으면 axdom(window).scrollTop() + 30
                                    })
                			    },
                			    //이벤트 정렬 값
                			    eventOrder : "id",
                			    events: function(start, end, timezone, callback) {
                			       	   $.ajax({
                			       			type: "GET",
                                        	url: "/FUNE4020/recipeCal?partCode="+ part_code + "&recipeYm="+srch_dt,
                			                  success: function(res) {
                			                      var calendars = [];
                			                      //console.log("calendar Ajax~~~~",res)
                			                      if(res.length>0){
                			                    	  $.each (res, function (i, v){
														var partCode 		= v[0];
                    			                    	var itemCode 		= v[1];
                    			                    	var recipeCode 	= v[2];
                    			                    	var recipeName 	= v[3];
                    			                    	var menuPlanQty = v[4];
                    			                    	var basicCdNm	= v[5];

                    			                    	var view_title 		= basicCdNm;
                    			                    	if(menuPlanQty !== null){
                    			                    		view_title= view_title + "(" + menuPlanQty + ")";
                    			                    	}
                    			                    	var st_dt = recipeCode.substring(0,4) + "-" + recipeCode.substring(4,6) + "-" +recipeCode.substring(6,8);
                    			                    	//var recipe_gubun = recipeCode.substring(8,10);
														// 이벤트 클릭시 id에 전달할 값을 모두 포함하여 전달.
                    			                    	calendars.push({
                   			                    		  	id:partCode +"|"+ itemCode + "|"+recipeCode,
                   			                    		  	title: view_title,
   	                			                            start: st_dt,
   	                			                            color:"#c7bcf0",//이벤트 색
   	                			                            allDay : true
														});
                     			      				});
                			                      }
                			                      callback(calendars);
                			                  }
                			              });
                			       }
                			});
                		}

                	$('#calendar').fullCalendar('option', 'height', 650);
                }//renderCalendar END
                ,bottomDateTxt:function(start){
                	var date;
                	var yyyymmdd;
                	if(start === "today"){
                		date = new Date();
                		var m = moment();
                		yyyymmdd = m.format("YYYY년 MM월 DD일");
                		//선택하지않은 처음 로딩시 오늘날짜로 선택
                		$('#calendar').fullCalendar('select', m);
                	}else{
                		date = new Date(calData.selDate);
                		yyyymmdd = start.format("YYYY년 MM월 DD일");
                	}
					var week = new Array('일', '월', '화', '수', '목', '금', '토');
					if (week[date.getDay()] != undefined){
						var html_text = yyyymmdd + " (" + week[date.getDay()] + "요일)";
						$("#select-date").html(html_text);
					}
                }
            };
        </script>
    </ax:div>
</ax:layout>