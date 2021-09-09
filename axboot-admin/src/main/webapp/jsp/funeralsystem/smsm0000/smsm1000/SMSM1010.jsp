<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%@ taglib prefix="b" tagdir="/WEB-INF/tags" %>
<ax:layout name="base.jsp">
    <ax:set name="title" value="${PAGE_NAME}" />
    <ax:set name="page_desc" value="${PAGE_REMARK}" />

    <ax:div name="css">
        <style type="text/css">
		.div {
		background-image:url('/static/smsm/iphone_bg_w_16.png');
		background-repeat: no-repeat;
		background-size: 100% 100%;
		overflow:hidden;
		min-height: 300px;
		}

        </style>
    </ax:div>

    <ax:div name="contents">
        <ax:row>
            <ax:col size="12">
                <ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}" function2Auth="${FUNCTION_2_AUTH}" function3Auth="${FUNCTION_3_AUTH}" function4Auth="${FUNCTION_4_AUTH}" function5Auth="${FUNCTION_5_AUTH}"></ax:custom>

                <!-- <div class="ax-search" id="page-search-box"></div> -->
                <ax:form id="page-search-box" name="form-info">
                <input type="hidden" id="info-tblGbNm" name="tblGbNm" value=""/>
                <ax:fields>
                      <ax:field label="업무구분">
                      	 <select id="info-jobGubun" name="jobGubun" class="AXSelect W100" ></select>
                      </ax:field>
                      	<ax:field label="조회구분" style="width:450px;">
                    	  	<select id="info-gubun" name="gubun" class="AXSelect W100" ></select>
<%-- 		                       	  <b:inputTwinDate toId="info-from" fromId="info-to" clazz="W80" fromValue="" toValue="" ></b:inputTwinDate> --%>
							<div id="period" style="display: inline-block;">
								<input type="text" id="info-from" name="from" title="" placeholder="" maxlength="15" class="AXInput W100 av-required" value=""/>
								<input type="text" id="info-to" name="to" title="" placeholder="" maxlength="15" class="AXInput W100 av-required" value=""/>
							</div>
							<div id="room" style="display: inline-block;">
								<select id="locCode" name="locCode" class="AXSelect W100"></select>
								<select id="floorCode" name="floorCode" class="AXSelect W100"></select>
								<select id="roomCode" name="roomCode" class="AXSelect W100"></select>
							</div>
							<div id="glocCode" style="display: inline-block;">
								<select id="grassLocCode" name="grassLocCode" class="AXSelect W100"></select>
							</div>
                   		</ax:field>
                       <ax:field label="내용구분" style="width:150px;">
                	       <select id="info-tplgGb" name="tplGb" class="AXSelect W100"></select>
                	       <%-- <b:select basicCd="TPL_GB" id="info-tplgGb" name="tplGb" clazz="W100"  isspace="true" isspaceTitle="전체"></b:select> --%>
                       </ax:field>
                  		  <ax:field label="전송시간" style="width:200px;">
              	   			  <%-- <b:inputDate id="info-trnsenddate" name="trnsenddate" clazz="W120"></b:inputDate> --%>
              	   			  <input type="text" id="info-trnsenddate" name="trnsenddate" title="전송날짜" placeholder="전송날짜" maxlength="10" class="AXInput W100 av-required" />
              	   			  <input type="text" id="info-trnsendtime" name="trnsendtime" title="전송시간" placeholder="전송시간" maxlength="5" class="AXInput W80 av-required" />
                     	</ax:field>
                     	</ax:fields>
                 </ax:form>
                <ax:form id="form-info" name="form-info" method="get">
            	<ax:custom customid="table" >
                    <ax:custom customid="tr">
                        <ax:custom customid="td">

                      	 	<div class="ax-grid" id="page-grid-box" style="min-height: 300px;"></div>
                        </ax:custom>
                        <ax:custom customid="td">
                        	<div class="ax-grid" id="page-grid-box2" style="min-height: 300px;"></div>
                        </ax:custom>
                        <ax:custom customid="td">
                        	<div id="container" class="div">
                        		<div style="width:100%; height: 16%; position:relative; float: left;"></div>
                        		<div style="margin-left: 13%; margin-right: 10%;  width: 77%; height: 70%; position: relative; float: left;">
                        			<div style="height:10%; min-height:60px; width: 100%; float: left; position: relative;">
                        				<label id="subjectLabel" for="subject">제목 </label><br>
                        				<input type="text" id="info-subject" name="phone" title=""  maxlength="100" class="AXInput W100" value="수원시연화장" style="width: 98%; margin-top: 10px;"/>
                        			</div>
                        			<div style="height:65%; min-height:250px; width: 100%; float: left; position: relative;">
                        				<label id="messageLabel" for="message">Message </label>
                        				<textarea  id="info-content" name="content" title="내용" maxlength="500" class="av-required"  style="width: 98%;  height:1em; min-height: 92%; margin-top: 10px;"></textarea>
                        			</div>
                        			<div style="min-height: 20px; height:10%;  width:100%; position:relative; float: left; margin-top: 13px;" align="right">
                        					<table style="min-width: 100%;">
                        						<tr>
                        							<td align="left" width="90%">
                        								<label id="senderLable">발신자 번호 : </label><input type="text" id="info-sender" name="sender" title="" placeholder="031-1234-1234" maxlength="13" class="AXInput W100 av-required" value=""/>
                        								<label id="phoneLable">수신자 번호 : </label><input type="text" id="info-phone" name="phone" title="" placeholder="010-1234-1234" maxlength="13" class="AXInput W100" value=""/>
                        							</td>
                        							<td align="right" width="10%">	<span id="info-counter" style="margin-left:10%; width: 20%;">###</span></td>
                        						</tr>
                        					</table>



                        			</div>
                        			<div  style="min-height:30px; height:10%; width: 100%; position:relative; float: left;">
                        			        <button type="button" class="AXButton" id="ax-form-btn-new"><i class="axi axi-plus-circle"></i>다시쓰기</button>
               								<button type="button" class="AXButton" id="ax-form-btn-save"><i class="axi axi-message"></i>문자전송</button>
                        			</div>
                        		</div>
                        		<div style="width:100%; height: 24%; position:relative; float: left;"></div>

                        </ax:custom>
                    </ax:custom>
                </ax:custom>
                </ax:form>
            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
        <script type="text/javascript">
            var resize_elements = [
                {id:"page-grid-box", adjust:-97},
                {id:"page-grid-box2", adjust:-97},
                {id:"container", adjust:-97}
            ];
            var fnObj = {
                CODES: {
                	tplGb: Common.getCode("TPL_GB"),
                	jobGubun: Common.getCode("JOB_GUBUN"),
                	gubun : {
                		"C" :  [{optionValue:"/SMSM1010/hwaBooking/bookDate", optionText:"예약일"} ]
           				,"E" :  [
	                        {optionValue:"/SMSM1010/enshrine/room", optionText:"호실"}
           					,{optionValue:"/SMSM1010/enshrine/ensDate", optionText:"접수일"}
	                        ,{optionValue:"/SMSM1010/enshrine/endDate", optionText:"만료일"}
	                    ]
			           ,"N": [
			        	   	{optionValue:"/SMSM1010/nature/grass/locCode", optionText:"구역"}
			        	   	,{optionValue:"/SMSM1010/nature/natDate", optionText:"접수일"}
		        	   	]
		          	   ,"T":  [
// 			        	   	{optionValue:"/SMSM1010/nature/tree/locCode", optionText:"구역"},
		          		    {optionValue:"/SMSM1010/nature/natDate", optionText:"접수일자"}
	          		   ]
                	},
           			tplGb: Common.getCode("TPL_GB"),


                },
                pageStart: function(){
                    this.search.bind();
                    this.grid.bind();
                    this.grid2.bind();
                    this.form.bind();
                    this.bindEvent();
                    // 페이지 로딩 후 바로 검색 처리하기 (option)
                    this.search.submit();
                },
                bindEvent: function(){
                    var _this = this;
                    fnObj.CODES.jobGubun.splice(4, 5);
                    $("#ax-page-btn-search").bind("click", function(){
                        _this.search.submit();
                    });

                    $("#ax-form-btn-save").bind("click", function(){
                        setTimeout(function() {
                            _this.save();
                        }, 500);
                    });

                    $("#ax-page-btn-excel").bind("click", function(){
                    	fnObj.grid.target.setConfig({colGroup : [
                            {key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox", display : false},
                            {key:"anchNo", label:"안치호수", width:"150", align:"left" },
                            {key:"deadName", label:"사망자", width:"100"},
                            {key:"applName", label:"신고자", width:"100"},
                            {key:"phone", label:"휴대전화번호", width:"100"},
                        ]});
                    	Common.report.gridToExcel("SMSM1010", fnObj.grid.target);
                    	fnObj.grid.target.setConfig({colGroup : [
                            {key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox", display : true},
                            {key:"anchNo", label:"안치호수", width:"150", align:"left" },
                            {key:"deadName", label:"사망자", width:"100"},
                            {key:"applName", label:"신고자", width:"100"},
                            {key:"phone", label:"휴대전화번호", width:"100"},
                        ]});
                    });

                    $("#info-jobGubun").bindSelect({
                    	options:fnObj.CODES.jobGubun,
                    	setValue:this.optionValue,
                    	alwaysOnChange: true,
                        onChange: function(){
                        	var job = this.optionValue
                            $("#info-gubun").bindSelect({
                                options:fnObj.CODES.gubun[this.optionValue],
                                //isspace: true, isspaceTitle: "선택하세요",
                                setValue:this.optionValue,
                                alwaysOnChange: true,
                                onChange: function(){
									var value = this.optionValue
									if(job == "E"){
										$("#glocCode").hide()
										$("#period").hide()
										if(value == "/SMSM1010/enshrine/room"){
											$("#room").show()
											$("#period").hide()
										}else{
											$("#room").hide()
											$("#period").show()
										}
									}else if(job == "N"){
										$("#room").hide()
										$("#period").hide()
										if(value == "/SMSM1010/nature/grass/locCode"){
											$("#glocCode").show()
											$("#period").hide()
										}else{
											$("#period").show()
											$("#glocCode").hide()
										}
									}
                                }
                            });
                        }
                    });

                    $("#info-to").bindTwinDate({
                        startTargetID: "info-from",
                        handleLeft: 25,
                        align: "right",
                        valign: "bottom",
                        separator: "-",
                        buttonText: "선택",
                        onChange: function () {
                            //toast.push(Object.toJSON(this));
                        },
                        onBeforeShowDay: function (date) {
//                             if (date.getDay() == 3) {
//                                 return { isEnable: false, title: "수요일 선택불가", className: "", style: "" };
//                             }
                        }
                    });

                    $('#info-content').keyup(function (e){
                        var content = $(this).val();
                        $(this).height(((content.split('\n').length + 1) * 1.5) + 'em');
                        $('#info-counter').html(content.length + '/500');
                    });
                    $('#info-content').keyup();

                    $("#info-from").val(new Date().print());
                    $("#info-to").val(new Date().print());


                    $("#info-tplgGb").bindSelect({
						options:fnObj.CODES.tplGb
						,isspace: true
						,isspaceTitle: "전체",
        			});
                    $("#info-tplgGb").bind("change",function(){
                    	fnObj.grid2.setPage(fnObj.grid2.pageNo, "");
                    });

                    $('#info-trnsenddate').bindDate().val( (new Date()).print() );
                    $("#info-trnsendtime").bindPattern({pattern: "time"});

                    $("#info-sender").bindPattern({
                        pattern: "phone"
                    });

                    $("#info-phone").bindPattern({
                        pattern: "phone"
                    });



                	$("#ax-form-btn-new").on("click", function(){
                		fnObj.form.clear();
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
                            $("#floorCode").bindSelect({
                                ajaxUrl: "/ENSH3020/findEnsfloor", ajaxPars: "locCode="+locCode, method:"GET", ajaxAsync:false,
                                //isspace: true, isspaceTitle: "선택하세요",
                                alwaysOnChange: true,
                                reserveKeys: {
                     				options: "list",
                     				optionValue: "floorCode",
                     				optionText: "charnClassName"
                     			},
                                onChange: function(){
                                	var floorCode = this.optionValue;

                                    $("#roomCode").bindSelect({
			                             ajaxUrl: "/ENSH3030/findEnsroom", ajaxPars: "locCode="+locCode+"&floorCode="+floorCode,  method:"GET", ajaxAsync:false,
			                             //isspace: true, isspaceTitle: "선택하세요",
			                             reserveKeys: {
			                   				options: "list",
			                   				optionValue: "roomCode",
			                   				optionText: "roomName"
			                   			},
										alwaysOnChange: true,
										onChange: function(){

			                             }
			                         });
                                }
                            });
                        }
                    });
                	$("#grassLocCode").bindSelect({
                        ajaxUrl: "/NATU3010/findNatloc", ajaxPars: "natGubun=TFM1600003", method:"GET", ajaxAsync:false,
                        //isspace: true, isspaceTitle: "선택하세요",
                        alwaysOnChange: true,
                        reserveKeys: {
            				options: "list",
            				optionValue: "locCode",
            				optionText: "locName"
            			},
                	})

					$("#glocCode").hide()
					$("#room").hide()
                },
                replaceMsg : function(){

                },
                getTextLength : function(str) {
                    var len = 0;
                    for (var i = 0; i < str.length; i++) {
                        if (escape(str.charAt(i)).length == 6) {
                            len++;
                        }
                        len++;
                    }
                    return len;
                },
                save: function(){

                    var validateResult = fnObj.form.validate_target.validate();
                    if (!validateResult) {
                        var msg = fnObj.form.validate_target.getErrorMessage();
                        axf.alert(msg);
                        fnObj.form.validate_target.getErrorElement().focus();
                        return false;
                    }

                    var info = fnObj.form.getJSON();
                    var checkedList = fnObj.grid.target.getCheckedListWithIndex(0);// colSeq
                    var trSenddate = $("#info-trnsenddate").val();
                    var trSendtime = $("#info-trnsendtime").val();
                    var dto_list = [];
                    var textLength = fnObj.getTextLength( info.content);
                    var url = "";


                    if($("#info-phone").val().length > 0){
                    	if(textLength  > 80){
                        	url = "/SMSM1010/saveMMS";
                        		dto_list.push({
                        			"phone" : $("#info-phone").val()
                        			,"msg" : $("#info-content").val()
                        			,"subject" : $("#info-subject").val()
                        			,"reqdate" : $("#info-trnsenddate").val()  +" "+ $("#info-trnsendtime").val()+":59"
                        			,"callback" : $("#info-sender").val()
                        			,"etc1" : $("#info-tblGbNm").val()
                        		});
                        }else{
                        	url = "/SMSM1010/saveScTran";
                            	dto_list.push({
                            						"trSenddate" : $("#info-trnsenddate").val() +" "+ $("#info-trnsendtime").val()+":59"
                            						,"trSendstat" : "0"
                            						,"trMsgtype": "0"
                            						,"trPhone": $("#info-phone").val()
                            						,"trMsg" : $("#info-content").val()
                            						,"trCallback" : $("#info-sender").val()
                            						,"trEtc1" : $("#info-tblGbNm").val()
                            					});

                        }
                    }else if(checkedList.length == 0){
                        alert("선택된 대상이 없습니다. 전송대상을 목록에서 체크하세요");
                        return;
                    }else if(checkedList.length > 0){
                    	if(textLength  > 80){
                        	url = "/SMSM1010/saveMMS";
                        	$.each(checkedList, function(){
                        		dto_list.push({
                        			"phone" : this.item.phone
                        			,"msg" : info.content
                        			,"subject" : $("#info-subject").val()
                        			,"reqdate" : trSenddate +" "+ trSendtime+":59"
                        			,"callback" : info.sender
                        			,"etc1" : $("#info-tblGbNm").val()
                        		});
                        	});
                        }else{
                        	url = "/SMSM1010/saveScTran";
                        	$.each(checkedList, function(){
                            	dto_list.push({
                            						"trSenddate" : trSenddate +" "+ trSendtime+":59"
                            						,"trSendstat" : "0"
                            						,"trMsgtype": "0"
                            						,"trPhone": this.item.phone
                            						,"trMsg" : info.content.replace("[name]",this.item.deadName).replace("[no]",this.item.anchNo)
                            						,"trCallback" : info.sender
                            						,"trEtc1" : $("#info-tblGbNm").val()
                            					});
                       		});

                        }
                    }



                    //info.partCode = partCode;

                     app.ajax({
                        type: "PUT",
                        url: url,
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
                            fnObj.form.clear();
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
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            onsubmit: function(){
                                // 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.
                                fnObj.search.submit();
                            },

                        });
                    },
                    submit: function(){
                        var pars = this.target.getParam();
                       	fnObj.grid.setPage(fnObj.grid.pageNo, pars);
                        fnObj.grid2.setPage(fnObj.grid2.pageNo, "");
                    }
                },
                grid : {
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
                                {key:"anchNo", label:"안치호수", width:"150", align:"left" },
                                {key:"deadName", label:"사망자", width:"100"},
                                {key:"applName", label:"신고자", width:"100"},
                                {key:"phone", label:"휴대전화번호", width:"100"},
                            ],
                            body : {
                                onclick: function(){

                                }
                            },
                             page: {
                                display: true,
                                //paging: true,
                                onchange: function(pageNo){
                                  //  _this.setPage(pageNo);
                                }
                            }
                        });
                    },
                    setPage: function(pageNo, searchParams){
                        var _target = this.target;
                        this.pageNo = pageNo;

                        app.ajax({
                            type: "GET",
                            url: $("#info-gubun :selected").val() ,
                            data: (searchParams||fnObj.search.target.getParam())
                        }, function(res){

                            if(res.error){
                                alert(res.error.message);
                            }
                            else
                            {
                                var gridData = {
                                    list: res.list,
                                     page:{
                                        //pageNo: res.page.currentPage.number()+1,
                                       // pageSize: res.page.pageSize,
                                       // pageCount: res.page.totalPages,
                                        listCount: res.list.length
                                    }
                                };
                                _target.setData(gridData);
                            }
                        });
                    }
                },

                grid2: {
                    pageNo: 1,
                    target: new AXGrid(),
                    bind: function(){
                        var target = this.target, _this = this;
                        target.setConfig({
                            targetID : "page-grid-box2",
                            theme : "AXGrid",
                            colHeadAlign:"center",
                            /*
                             mediaQuery: {
                             mx:{min:"N", max:767}, dx:{min:767}
                             },
                             */
                            colGroup : [
                                {key:"tplGb", label:"내용구분", width:"100", align:"left" , formatter:function(){
                                    return Common.grid.codeFormatter("tplGb",this.value);
                            		}
                                },
                                {key:"content", label:"내용", width:"300"},
                            ],
                            body : {
                                onclick: function(){
									var subject = $("#info-subject").val();
                                	console.log(this.item);
                                	$("#info-tblGbNm").val(this.item.tplGb);
                                    fnObj.form.setJSON(this.item);
                                    $("#info-subject").val(subject);
                                }
                            }
                           /*  page: {
                                display: true,
                                paging: true,
                                onchange: function(pageNo){
                                    _this.setPage(pageNo);
                                }
                            } */
                        });
                    },
                    setPage: function(pageNo, searchParams){
                        var _target = this.target;
                        this.pageNo = pageNo;

                        app.ajax({
                            type: "GET",
                            url: "/SMSM1040/getSmstpl",
                            data: "dummy="+ axf.timekey() +"&pageNumber=" + (pageNo-1) + "&pageSize=50&tplGb=" +searchParams
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
                },

                /*******************************************************
                 * 상세 폼
                 */
                 form: {
                     target: $('#form-info'),
                     validate_target: new AXValidator(),
                     bind: function() {
                         var _this = this;

                         this.validate_target.setConfig({
                             targetFormName : "form-info"
                         });

                         // form clear 처리 시
                         $('#ax-form-btn-new').click(function() {
                             fnObj.form.clear()
                         });
                     },
                     setJSON: function(item) {
                         var _this = this;
                         // 수정시 입력 방지 처리 필드 처리
                         var info = $.extend({}, item);
                         app.form.fillForm(_this.target, info, 'info-');
                         // 추가적인 값 수정이 필요한 경우 처리
                         // $('#info-useYn').bindSelectSetValue( info.useYn );
                     },
                     getJSON: function() {
                         return app.form.serializeObjectWithIds(this.target, 'info-');
                     },
                     clear: function() {
                    	 var subject = $("#info-subject").val();
                         app.form.clearForm(this.target);
                         $("#info-subject").val(subject);
                     }
                 } // form
            };
        </script>
    </ax:div>
</ax:layout>