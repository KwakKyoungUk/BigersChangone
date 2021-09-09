<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%
	request.setAttribute("callBack", request.getParameter("callBack"));
%>
<ax:layout name="modal.jsp">
	<ax:set name="title" value="정보등록" />
	<ax:set name="page_desc" value="" />

	<ax:div name="contents">
		<ax:row>
			<ax:col size="12" wrap="true">


                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-table"></i> 화장예약변경</h2>
                    </div>
                    <div class="right">
                    	<button id="btn-search" type="button" class="AXButton" ><i class="axi axi-ion-android-search"></i> 조회</button>
                    	<button id="btn-save" type="button" class="AXButton" ><i class="axi axi-save"></i> 저장</button>
                    </div>
                    <div class="ax-clear"></div>
                </div>

				<div class="ax-search" id="page-search-box"></div>
				<div class="ax-grid" id="page-grid-box" style="min-height: 200px;"></div>

				<ax:form id="form-info" name="form-info" method="post">
					<table class="AXGridTable">
						<thead>
							<tr>
								<th>
	                                <div class="tdRel">
	                                    &nbsp;
	                                </div>
								</th>
								<th><div class="tdRel">예약일자</div>
								</th>
								<th><div class="tdRel">예약차수</div>
								</th>
								<th><div class="tdRel">우선순위</div>
								</th>
								<th class="last"><div class="tdRel">예약시간</div>
								</th>
							</tr>
						</thead>
						<tbody>
							<tr class="mytr">
								<th>변경전
								</th>
								<td><input type="text" id="info-beforeBookDate" name="beforeBookDate" title="예약일자" placeholder="예약일자" readonly="readonly" class="AXInput W100" value="${param.bookDate}"/>
								</td>
								<td><input type="text" id="info-beforeBookChasu" name="beforeBookChasu" readonly="readonly" class="AXInput W40" value="${param.bookChasu }"/>
								</td>
								<td><input type="text" id="info-beforeBookChasuSeq" name="beforeBookChasuSeq" readonly="readonly" class="AXInput W40" value="${param.bookChasuSeq}"/>
								</td>
								<td><span id="sp-before-bookDateTime">${param.time }</span>
								</td>
							</tr>
							<tr>
								<th>변경후
								</th>
								<td><input type="text" id="info-bookDate" name="bookDate" title="예약일자" placeholder="예약일자" readonly="readonly" class="AXInput W100 av-required" value=""/>
								</td>
								<td><input type="text" id="info-bookChasu" name="bookChasu" title="차수" placeholder="차수" readonly="readonly" class="AXInput W40 av-required" value=""/>
								</td>
								<td><input type="text" id="info-bookChasuSeq" name="bookChasuSeq" title="순번" placeholder="순번" readonly="readonly" class="AXInput W40 av-required" value=""/>
								</td>
								<td><span id="sp-bookDateTime"></span>
								</td>
							</tr>
						</tbody>
					</table>
				</ax:form>

			</ax:col>
		</ax:row>

	</ax:div>
	<ax:div name="buttons">
		<button type="button" class="AXButton" onclick="fnObj.control.save();">저장</button>
		<button type="button" class="AXButton" onclick="fnObj.control.cancel();">취소</button>
	</ax:div>

	<ax:div name="scripts">
		<script type="text/javascript">

			var fnObj = {
                CODES: {
                	"chasu": (function(){
                    	var result;
                    	app.ajax({
                    			async: false,
	                            type: "GET",
	                            url: "/CREM1010/chasuSelectOption",
	                            data: ""
	                        },
	                        function(res){
	                        	result = res;
                        	}
                        );
                    	return result;
                    }()),
                    "chasuSeq": (function(){
                    	var result;
                    	app.ajax({
                    			async: false,
	                            type: "GET",
	                            url: "/CREM1010/roSelectOption",
	                            data: ""
	                        },
	                        function(res){
	                        	result = res;
                        	}
                        );
                    	return result;
                    }()),
                },

				pageStart: function(){
					this.search.bind();
					this.grid.bind();
					this.bindEvent();
				},
				pageResize: function(){
					parent.myModal.resize();
				},
				bindEvent: function(){
					$("#btn-search").bind("click", function(){
						fnObj.search.submit();
					});
					$("#btn-search").click();
					$("#info-beforeBookDate").bindPattern({pattern: "custom", max_length: 14, patternString:"9999-99-99"});
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
                                    {label:"예약 일자", labelWidth:"", type:"inputText", width:"150", key:"searchParams", addClass:"", valueBoxStyle:"", value:new Date().print(),
                                    	AXBind:{
            								type:"date", config:{
            									align:"right", valign:"top", defaultDate:new Date(),
            									onChange:function(){
            										toast.push(Object.toJSON(this));
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
                        fnObj.grid.setPage(fnObj.grid.pageNo, pars);
                    }
                },
				grid: {
                	roFormatter:function(val){

                		if(isNaN(+(this.value))){
                			return this.value;
                		}

                		if(this.value.toString() == "000"){
                			return "불가";
                		}

                		var res = [];

                		for(var i=0; i<this.value.toString().length; i++){
                			if(this.value.toString()[i]=="1"){
                				res.push("<i class='axi axi-circle' style='color:green; font-size:25px;'></i>");
                			}else{
                				res.push("<i class='axi axi-circle' style='color:darkgray; font-size:25px;'></i>");
                			}
                		}

                		return res.join("");
                	},
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
                                //{key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"chasuSeq", label:"차수", width:"100", align:"center"},
                                {key:"strtimeString", label:"시작시간", width:"100", align:"center"},
                                {key:"endtimeString", label:"종료시간", width:"100", align:"center"},
                                {key:"ro01", label:"1", width:"100", align:"center"
                                	, formatter:fnObj.grid.roFormatter
                               	},
                                {key:"ro02", label:"2", width:"100", align:"center"
                                	, formatter:fnObj.grid.roFormatter
                              	},
                                {key:"ro03", label:"3", width:"100", align:"center"
                                	, formatter:fnObj.grid.roFormatter
                                },
                                {key:"ro04", label:"4", width:"100", align:"center"
                                	, formatter:fnObj.grid.roFormatter
                                },
                                {key:"ro05", label:"5", width:"100", align:"center"
                                	, formatter:fnObj.grid.roFormatter
                                },
                                {key:"ro06", label:"6", width:"100", align:"center"
                                	, formatter:fnObj.grid.roFormatter
                                },
                                {key:"ro07", label:"7", width:"100", align:"center"
                                	, formatter:fnObj.grid.roFormatter
                                },
                                {key:"ro08", label:"8", width:"100", align:"center"
                                	, formatter:fnObj.grid.roFormatter
                                }
//                                 ,{key:"etc3", label:"선택타입", width:"150", align:"center",
//                                     formatter: function(val){
//                                         return fnObj.CODES._etc3[ ( (Object.isObject(this.value)) ? this.value.NM : this.value ) ];
//                                     }
//                                 }
                            ],
                            body : {
                                onclick: function(){
									console.log(this);
									if(this.c < 3){
										toast.push("우선순위를 선택해 주세요.");
										return;
									}
									if(isNaN(+this.item[fnObj.grid.target.config.colGroup[this.c].key])){
										toast.push("이미 예약된 순번에는 예약할 수 없습니다.");
										return;
									}
									var bookChasuSeq = this.c-2 < 10 ? "0"+(this.c-2) : this.c-2;
									$("#info-bookDate").val($("#"+fnObj.search.target.getItemId("searchParams")).val());
									$("#info-bookChasu").val(this.item.chasuSeq);
									$("#info-bookChasuSeq").val(bookChasuSeq);
									$("#sp-bookDateTime").html(this.item.strtimeString+"-"+this.item.endtimeString);
                                }
                            },
                            page: {
                                display: false,
                                paging: false
//                                 , onchange: function(pageNo){
//                                     _this.setPage(pageNo);
//                                 }
                            }
                        });
                    },
                    setPage: function(pageNo, searchParams){
                        var _target = this.target;
                        this.pageNo = pageNo;

                        app.ajax({
                            type: "GET",
                            url: "/CREM1010/findRogrpchasu/"+$("#"+fnObj.search.target.getItemId("searchParams")).val(),
                            data: ""
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

                    },
                    setJSON: function(item) {
                        var _this = this;

                        // 수정시 입력 방지 처리 필드 처리
//                         $('#info-key').attr("readonly", "readonly");

                        var info = $.extend({}, item);
                        app.form.fillForm(_this.target, info, 'info-');
                        // 추가적인 값 수정이 필요한 경우 처리
                        // $('#info-useYn').bindSelectSetValue( info.useYn );
                    },
                    getJSON: function() {
                        return app.form.serializeObjectWithIds(this.target, 'info-');
                    },
                    clear: function() {
                        app.form.clearForm(this.target);
                    }
                }, // form
				control: {
					save: function(){

                        var info = fnObj.form.getJSON();
						app.modal.save("${callBack}", info);

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