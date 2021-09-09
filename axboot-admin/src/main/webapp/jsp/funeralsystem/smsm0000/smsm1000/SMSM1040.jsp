<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%@ taglib prefix="b" tagdir="/WEB-INF/tags" %>
<ax:layout name="base.jsp">
    <ax:set name="title" value="${PAGE_NAME}" />
    <ax:set name="page_desc" value="${PAGE_REMARK}" />

    <ax:div name="css">
        <style type="text/css">
             .border_none { border: none;
	            border:none;
	            border-right:0px;
	            border-top:0px;
	            boder-left:0px;
	            boder-bottom:0px;
	            box-shadow :0;
	            text-shadow : none;
             }
			#info-content {
			  	 width: 100%;
			    resize: none;
			    min-height: 10em;
			    line-height:1.6em;
			    max-height: 10em;
			}
			#info-counter {
			  text-align:right
			  background:rgba(255,0,0,0.5);
			  border-radius: 0.5em;
			  padding: 0 .5em 0 .5em;
			  font-size: 0.75em;
			}

        </style>
    </ax:div>

    <ax:div name="contents">
        <ax:row>
            <ax:col size="12">
                <ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}" function2Auth="${FUNCTION_2_AUTH}" function3Auth="${FUNCTION_3_AUTH}" function4Auth="${FUNCTION_4_AUTH}" function5Auth="${FUNCTION_5_AUTH}"></ax:custom>


                <ax:custom customid="table">
                    <ax:custom customid="tr">
                        <ax:custom customid="td">
                            <div class="ax-button-group">
                                <div class="right">
                                </div>
                                <div class="ax-clear"></div>
                            </div>
                            <div class="ax-search" id="page-search-box"></div>
                            <div class="ax-grid" id="page-grid-box" style="min-height: 300px;"></div>
                        </ax:custom>

                        <ax:custom customid="td">
                        	<div class="ax-button-group">

                                <div class="right">
                                    <button type="button" class="AXButton" id="ax-form-btn-new"><i class="axi axi-plus-circle"></i> 신규</button>
                                </div>
                                <div class="ax-clear"></div>
                            </div>
                            <ax:form id="form-info" name="form-info" method="get">
                           <input id="info-seq" name="seq" type="hidden" value="">
                            <table class='AXFormTable'  cellpadding="0" cellspacing="0" style="width: 100%" >
                   				<tbody>
	                            	<tr class="tdRel">
	                            		<th>사용여부</th>
	                            		<td width="550"><div class='tdRel'>
	                        					<label><input name="useGb" type="radio" value="Y" checked="checked"> 사용</label>
												<label><input name="useGb" type="radio" value="N" > 미사용</label>
	                       						</div>
	                       				</td>
	                            	</tr>
	          					   	<tr class="tdRel">
	                            		<th>내용구분</th>
	                            		<td><div class='tdRel'>
	                            				 <select id="info-tplGb" name="tplGb" class="AXSelect W100"></select>
	                       						</div>
	                       				</td>
	                            	</tr>
	                            	<tr>
	                            		<th>내용</th>
	                            		<td >
	                        				 <textarea type="text" id="info-content" name="content" title="내용" maxlength="" class="AXTextarea W400 av-required" value="" style="width:98%; min-height: 200px;" ></textarea>
	                          					<div align="right">
	                       						 <span id="info-counter">###</span>
	                       						</div>
	                       				</td>
	                            	</tr>
	                            	<tr height="50">
	                            		<th >비고</th>
	                            		<td>[name] 은 고인명, [n]은  안치번호로 바뀌어 발송 됩니다.</td>
	                            	</tr>
                            	</tbody>
                            </table>
                            </ax:form>
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
            var fnObj = {
                CODES: {
                	tplGb: Common.getCode("TPL_GB"),
                },
                pageStart: function(){
                    this.search.bind();
                    this.grid.bind();
                    this.form.bind();
                    this.bindEvent();
                    // 페이지 로딩 후 바로 검색 처리하기 (option)
                    this.search.submit();
                },
                bindEvent: function(){
                    var _this = this;

                    $("#ax-page-btn-fn1").html("<i class=\"axi axi-minus-circle\"></i> 삭제");

                    $("#ax-page-btn-search").bind("click", function(){
                        _this.search.submit();
                    });

                    $("#ax-page-btn-save").bind("click", function(){
                        setTimeout(function() {
                            _this.save();
                        }, 500);
                    });

                    $("#ax-page-btn-fn1").bind("click", function(){
                        setTimeout(function() {
                            _this.grid.del();
                        }, 500);
                    });

                    $("#ax-page-btn-excel").bind("click", function(){
                        app.modal.excel({
                            pars:"target=${className}"
                        });
                    });

                    $('#ax-form-btn-new').click(function() {
                        fnObj.form.clear()
                    });


                    $('#info-content').keyup(function (e){
                        var content = $(this).val();
                        $(this).height(((content.split('\n').length + 1) * 1.5) + 'em');
                        $('#info-counter').html(content.length + '/500');
                    });
                    $('#info-content').keyup();

                    $("input:radio[name='useGb']:radio[value='Y']").click();

                    var config = {
                  	    //min: 1,   // {Number} [min=Number.MIN_VALUE] - 최소값 (optional)
                  	    //max: 100, // {Number} [max=Number.MAX_VALUE] - 최대값 (optional)
                  	    onchange: function(){ // {Function} - 값이 변경되었을 때 이벤트 콜백함수 (optional)
                  	        //trace(this);
                  	    }
                  	};
                  	 axdom("#AXInputNumber").bindNumber(config);


                	$("#ax-form-btn-new").on("click", function(){
                		fnObj.form.clear();
                	});


                	 $("#info-tplGb").bindSelect({
         				options:fnObj.CODES.tplGb
         				, alwaysOnChange: true
         				, onchange:function(){
         				}
         			});

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
                    info.useGb = $("[name=useGb]:checked").val()
                    //info.partCode = partCode;

                    app.ajax({
                        type: "PUT",
                        url: "/SMSM1040/saveSmstpl",
                        data: Object.toJSON(info)
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
                            rows:[
                                {display:true, addClass:"", style:"", list:[
									{label:"내용구분", labelWidth:"100", type:"selectBox", width:"150", key:"tplGb", addClass:"", valueBoxStyle:"", value:"",
										options:[{optionValue:"", optionText:"전체"}].concat(fnObj.CODES.tplGb),
											onChange:function(){
												   fnObj.search.submit();
											}
										},
                                ]},


                            ]
                        });
                    },
                    submit: function(){
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
                                {key:"index", label:"선택", width:"35", align:"center", formatter:"checkbox"},
                                {key:"seq", label:"", width:"100", align:"left" , display:false },
                                {key:"tplGb", label:"내용구분", width:"100", align:"left" , formatter:function(){
                                    return Common.grid.codeFormatter("tplGb",this.value);
                            		}
                                },
                                {key:"content", label:"내용", width:"300"},
                                {key:"useGb", label:"사용구분", width:"150"},
                            ],
                            body : {
                                onclick: function(){
                                    fnObj.form.setJSON(this.item);
                                    $("input:radio[name='useGb']:radio[value='"+this.item.useGb+"']").click();

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
                    del:function(){
                    	if(!confirm("삭제하시겠습니까?")){
                    		return false;
                    	}
                        var _target = this.target,
                                nextFn = function() {
                                    _target.removeListIndex(checkedList);
                                    toast.push("삭제 되었습니다.");
                                };

                        var checkedList = _target.getCheckedListWithIndex(0);// colSeq
                        if(checkedList.length == 0){
                            alert("선택된 목록이 없습니다. 삭제하시려는 목록을 체크하세요");
                            return;
                        }
                        var dto_list = [];
                        $.each(checkedList, function(){
                            if(this.item._CUD != "C"){
                                dto_list.push("seq=" + parseInt(this.item.seq)); // ajax delete 요청 목록 수집
                            }
                        });

                        if(dto_list.length == 0) {
                            nextFn(); // 스크립트로 목록 제거
                        }
                        else {
                            app.ajax({
                                        type: "DELETE",
                                        url: "/SMSM1040/deleteSmstpl?" + dto_list.join("&"),
                                    },
                                    function(res) {
                                        if (res.error) {
                                            alert(res.error.message);
                                        } else {
                                            nextFn(); // 스크립트로 목록 제거
                                        }
                                    });
                        }
                    },
                    setPage: function(pageNo, searchParams){
                        var _target = this.target;
                        this.pageNo = pageNo;

                        app.ajax({
                            type: "GET",
                            url: "/SMSM1040/getSmstpl",
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
                         app.form.clearForm(this.target);
                     }
                 } // form
            };
        </script>
    </ax:div>
</ax:layout>