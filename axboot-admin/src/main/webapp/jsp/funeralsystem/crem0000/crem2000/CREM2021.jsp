<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%
	request.setAttribute("callBack", request.getParameter("callBack"));
%>
<ax:layout name="modal.jsp">
	<ax:set name="title" value="고인 검색" />
	<ax:set name="page_desc" value="" />

	<ax:div name="contents">
		<ax:row>
			<ax:col size="12" wrap="true">


                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-table"></i> 고인 검색</h2>
                    </div>
                    <div class="right">
                   	<button id="btn-search" type="button" class="AXButton" ><i class="axi axi-ion-android-search"></i> 조회</button>

                       </div>
                    <div class="ax-clear"></div>
                </div>

				<div class="ax-search" id="page-search-box"></div>
				<div class="ax-grid" id="page-grid-box" style="min-height: 400px;"></div>



			</ax:col>
		</ax:row>

	</ax:div>
	<ax:div name="buttons">
		<button type="button" class="AXButton" onclick="fnObj.control.select();">선택</button>
		<button type="button" class="AXButton" onclick="fnObj.control.cancel();">취소</button>
	</ax:div>

	<ax:div name="scripts">
		<script type="text/javascript">
			vapplId = "";
			var fnObj = {
                CODES: {
                	"deadSex": Common.getCode("TCM05"),
   					"applNationGb": Common.getCode("TCM11"),
                    "addrGubun": Common.getCode("TCM07"),
                },

				pageStart: function(){
					this.search.bind();
					this.grid.bind();
					this.bindEvent();
					this.search.defaultSeach();

				},
				pageResize: function(){
					parent.myModal.resize();
				},
				bindEvent: function(){
					// click----------------------------------------------------------------
					$("#btn-search").bind("click", function(){
						fnObj.search.submit();
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
                                      {label:"사망자", labelWidth:"", type:"inputText", width:"150", key:"deadName", addClass:"", valueBoxStyle:"", value:""},
                                      {label:"신청자", labelWidth:"", type:"inputText", width:"150", key:"applName", addClass:"", valueBoxStyle:"", value:""},
                                      {label:"화장일자", labelWidth:"", type:"inputText", width:"90", key:"from", addClass:"secondItem", valueBoxStyle:"", value:new Date().print()},
									  {label:"", labelWidth:"", type:"inputText", width:"90", key:"to", addClass:"secondItem", valueBoxStyle:"padding-left:0px;", value:new Date().print(),
  	               							AXBind:{
  	               								type:"twinDate", config:{
  	               									align:"right", valign:"top", startTargetID:"from",
  	               									onChange:function(){

  	               									}
  	               								}
  	               							}
  	               						},
                                  ]}
                              ]
                        });
                    },
                    defaultSeach:function(){
                    	vapplId = "${param.cremDate}";
                    	this.submit();
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
                                {key:"id", label:"화장번호", width:"100", align:"center", formatter: function(){
                                	return this.item.cremDate.date().print("yyyymmdd")+"-"+this.item.cremSeq;
                                }},
                                {key:"cremDate", label:"화장일자", width:"100", align:"center"},
                                {key:"deadName", label:"이름", width:"100", align:"center", formatter: function(){
                                	return this.item.thedead.deadName;
                                }},
                                {key:"deadJumin", label:"주민등록번호", width:"100", align:"center", formatter: function(){
                                	return this.item.thedead.deadJumin;
                                }},
                                {key:"deadDate", label:"사망일자", width:"100", align:"center", formatter: function(){
                                	return this.item.thedead.deadDate;
                                }},
                                {key:"applName", label:"이름", width:"100", align:"center", formatter: function(){
                                	return this.item.applicant.applName;
                                }},
                               // {key:"phone", label:"전화번호", width:"130", align:"center"},
                               // {key:"fullAddr", label:"주소", width:"500", align:"center"},
                            ],
                            colHead: {
                                rows: [
                                    [
                                        {colSeq: 0, rowspan: 2},
                                        {colSeq: 1, rowspan: 2},
                                        {colSeq: null, colspan: 3, label: "사망자", align: "center"},
                                        {colSeq: null, colspan: 1, label: "신청자", align: "center"}
                                    ],
                                    [
                                        {colSeq: 2},
                                        {colSeq: 3},
                                        {colSeq: 4},
                                        {colSeq: 5},

                                    ]
                                ]
                            },
                            body : {
                                onclick: function(event){
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
                             url: "/CREM2021/hwaCremation",
                             data: "dummy="+ axf.timekey() +"&pageNumber=" + (pageNo-1) + "&pageSize=50&"
                             			+"sort=cremDate&cremDate.dir=desc&"
                             			+ (searchParams||fnObj.search.target.getParam())
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

				control: {
					select: function(){

                        var item = fnObj.grid.target.getSelectedItem();
                        if(item.error){
                        	toast.push("고인을 선택해주세요.");
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