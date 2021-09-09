var page_menu_id = "dashboard";

var fnObj = {
	pageStart: function(){
		setTimeout((function(){
			this.grid.bind();
			this.grid_02.bind();
		}).bind(this), 500);
	},
	pageResize: function(){

	},
	grid: {
		target: new AXGrid(),
		pageNo: 0,
		bind: function(){
			this.target.setConfig({
				targetID : "grid-notice",
				theme : "AXGrid",
				colHeadAlign:"center",
				//fitToWidth: true,
				colGroup : [
					{key:"title", label:"제목", width:"*", align:"left"},
					{key:"insDate", label:"등록일", width:"100", formatter:function(){
						if (this.value!=""){
							return this.value.date().print();
						}
						else
							return "";
					}}
				],
				body : {
					onclick: function(){
						app.modal.open({
							url:"/jsp/system/system-operation-notice-modal-view.jsp",
							pars:"id=" + this.item.id
						});
					}
				},
				page: {
					display:true,
					paging:false,
					onchange: function(pageNo){
						_this.setPage(pageNo);
					}
				}
			});

			fnObj.grid.setPage(fnObj.grid.pageNo);
		},
		setPage: function(pageNo, searchParams) {
			var _this = this;
			_this.pageNo = pageNo;
			app.ajax({
				type: "GET",
				url: "/api/v1/notices",
				data: "pageNumber=" + (pageNo) + "&pageSize=50"
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
					_this.target.setData(gridData);
				}
			});
		},
		reload: function(){
			fnObj.grid.setPage(fnObj.grid.pageNo);
		}
	},

	grid_02: {
		target: new AXGrid(),
		get: function(){ return this.target },
		bind: function(){
			var _this = this, target = this.target;
			this.target.setConfig({
				targetID : "grid-sales-anal",
				theme : "AXGrid",
				sort: false,
				fixedColSeq: 2,
				colHeadAlign:"center",
				colGroup: (function(){
					var row = [
						{key:"index", label:"NO", width:"40", align:"center", formatter:function(){
							//this.target.index;
							//this.target.index;
							return this.index + 1;
						}},
						{key:"compNm", label:"업체명", width:"100", align:"center"},
						{key:"storNm", label:"매장명", width:"150"},
						{key:"cashAmt", label:"현금매출", width:"100", align:"right", formatter: function(){
							return this.value.money();
						}},
						{key:"cardAmt", label:"카드매출", width:"100", align:"right", formatter: function(){
							return this.value.money();
						}},
						{key:"totalAmt", label:"총판매액", width:"100", align:"right", formatter: function(){
							return this.value.money();
						}},
						{key:"dcAmt", label:"할인액", width:"100", align:"right", formatter: function(){
							return this.value.money();
						}},
						{key:"saleAmt", label:"공급가액", width:"100", align:"right", formatter: function(){
							return this.value.money();
						}},
						{key:"vatAmt", label:"부가세", width:"100", align:"right", formatter: function(){
							return this.value.money();
						}},
						{key:"saleTot", label:"매출액", width:"100", align:"right", formatter: function(){
							return this.value.money();
						}},
						{key:"cnt", label:"영수건수", width:"60", align:"right", formatter: function(){
							return this.value.money();
						}},
						{key:"price", label:"영수단가", width:"100", align:"right", formatter: function(){
							return this.value.money();
						}},

						{key:"monSaleTot", label:"매출액", width:"100", align:"right", formatter: function(){
							return this.value.money();
						}},
						{key:"monCnt", label:"영수건수", width:"60", align:"right", formatter: function(){
							return this.value.money();
						}},
						{key:"monPrice", label:"영수단가", width:"100", align:"right", formatter: function(){
							return this.value.money();
						}}
					];
					return row;
				})(),

				colHead : {
					rows: (function(){
						var rows = [
							[
								{ key: 'index', rowspan: 2, valign: "middle" },
								{ key: 'compNm', rowspan: 2, valign: "middle" },
								{ key: 'storNm', rowspan: 2, valign: "middle" },
								{ colspan: 9, label: "조회일", valign: "middle" },
								{ colspan: 3, label: "조회월", valign: "middle" }
							],
							[
								{ key: 'cashAmt' },
								{ key: 'cardAmt' },

								{ key: 'totalAmt' },
								{ key: 'dcAmt' },
								{ key: 'saleAmt' },
								{ key: 'vatAmt' },
								{ key: 'saleTot' },
								{ key: 'cnt' },
								{ key: 'price' },

								{ key: 'monSaleTot' },
								{ key: 'monCnt' },
								{ key: 'monPrice' }
							]
						];
						return rows;
					})()
				},
				body: {
					onclick: function() {
						//toast.push(Object.toJSON({index:this.index, item:this.item}));
						//fnObj.modal.open("gridView", this.item);
					}
				},
				page: {
					display: true,
					paging: false,
					pageNo:1,
					pageSize:100,
					status:{formatter: null}
				}
			});

		}
	},

};
jQuery(window).resize(function() {
	fnObj.pageResize()
});