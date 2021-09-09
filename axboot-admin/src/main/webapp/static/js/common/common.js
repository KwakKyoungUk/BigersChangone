jQuery(function($) { $.extend({
    form: function(url, data, method, target) {
        if (method == null) method = 'POST';
        if (data == null) data = {};

        var attr = {
                method: method,
                action: url
             };
        if(target){
        	attr.target = target;
        }

        var form = $('<form>').attr(attr).css({
            display: 'none'
         });

        var addData = function(name, data) {
            if ($.isArray(data)) {
                for (var i = 0; i < data.length; i++) {
                    var value = data[i];
                    addData(name + '[]', value);
                }
            } else if (typeof data === 'object') {
                for (var key in data) {
                    if (data.hasOwnProperty(key)) {
                        addData(name + '[' + key + ']', data[key]);
                    }
                }
            } else if (data != null) {
                form.append($('<input>').attr({
                  type: 'hidden',
                  name: String(name),
                  value: String(data)
                }));
            }
        };

        for (var key in data) {
            if (data.hasOwnProperty(key)) {
                addData(key, data[key]);
            }
        }

        return form.appendTo('body');
    }
}); });

jQuery.fn.extend({

	/**
	 *
		$("#info-thedead-deadSex").selectBox({
			url: "/FUNE1030/binso/assignable/code/option/ajax"
			, method: "post"
			, isspace: true
			, isspaceTitle: "-"
			, index: 5
			, reserveKey: {
				optionRoot: "options"
				, optionValue: "optionValue"
				, optionText: "optionText"
			}
			, filter: function(i, o){
				return // boolean 타입 리턴
			}
		});
	 */
	selectBox: function(config){

		var method = config.method;
		var basicCd = config.basicCd;
		var url = config.url || "/api/v1/basicCodes/groupSelect?basicCd="+basicCd;
		var isspace = config.isspace;
		var isspaceTitle = config.isspaceTitle;
		var reserveKey = config.reserveKey;
		var optionRootKey = reserveKey ? reserveKey.optionRoot : "";
		var optionValueKey = reserveKey ? reserveKey.optionValue : "optionValue";
		var optionTextKey = reserveKey ? reserveKey.optionText : "optionText";
		var value = config.value;
		var index = config.index;
		var async = (config.async == undefined || config.async == false) ? false : true;
		var _this = this;

		$.ajax({
			url: url
			, dataType: "json"
			, method: method || "GET"
			, async : async
			, success: function(res){
				if(res.error){

				}else{
					if(reserveKey && reserveKey.optionRoot){
						res = res[optionRootKey];
					}
					var options = [];
					var str = [];

					if(isspace === true){
						options.push({optionValue: "", optionText: isspaceTitle || ""});
					}

					$.each(res, function(i, o){
						options.push({optionValue: o[optionValueKey], optionText: o[optionTextKey]});
					});

					$.each(options, function(i, o){
						if(config.filter){
							if(!config.filter(i, o)){
								return;
							}
						}
						var selected = "";
						if(value && o.optionValue == value){
							selected = "selected='selected'";
						}else if(index && i == index){
							selected = "selected='selected'";
						}
						str.push("<option value='"+o.optionValue+"' "+selected+">"+o.optionText+"</option>");
					});
					$(_this).html("");
					$(_this).append(str.join(""));
				}
			}
			, error: function(){

			}
		});
	}

});

var Common = {
    	getCode: function(basicCd){
    		var result;
        	app.ajax({
        			async: false,
                    type: "GET",
                    url: "/api/v1/basicCodes/groupSelect?basicCd="+basicCd,
                    data: ""
                },
                function(res){
                	result = res;
            	}
            );
        	return result;
    	},
    	getCodeByUrl: function(url){
    		var result;
        	app.ajax({
        			async: false,
                    type: "GET",
                    url: url,
                    data: ""
                },
                function(res){
                	result = res;
            	}
            );
        	return result;
    	},
    	json: {
    		getJsonWithId: function(prefix){
    			var result = {};
    			$.each($("[id^='"+prefix+"']"), function(index, item){
    				result[item.name] = $(item).val();
				});
    			return result;
    		}
    	},
    	grid: {
    		codeFormatter: function(code, value){
    			for(var i=0; i<fnObj.CODES[code].length; i++){
    				if(fnObj.CODES[code][i].optionValue == value){
    					return fnObj.CODES[code][i].optionText;
    				}
    			}
    			return "";
    		}
    		, containsNewItem: function(grid){
    			for(var i=0; i<grid.list.length; i++){
    				if(grid.list[i]._CUD == "C"){
    					return true;
    				}
    			}
    			return false;
    		}
    		, changeValueToGrid: function(startId, grid, property){
                $("[id^='"+startId+"']").bind("change",function(){
                	var item = grid.getSelectedItem();
                	if(item.error){
                		return;
                	}
                	var name = this.id.substring(startId.length);
                	if(property){
                		if(!item.item[property]){
                			item.item[property] = {};
                		}
                		item.item[property][name] = $(this).val();
                	}else{
                		item.item[name] = $(this).val();
                	}
                	grid.updateList(item.index, item.item);
                });
    		}
    		, dateFormatter: function(value, separator){
    			if(!value){
    				return "";
    			}
    			if(value.indexOf("-") != -1){
    				return value;
    			}
    			var result = [];
    			for(var i=0; i<value.length; i++){
    				if(i==4 || i==6){
    					result.push(separator);
    				}
    				result.push(value[i]);
    			}
    			return result.join("");
    		}
    		, clickSelectedRow: function(gridId){
    			setTimeout(function(){$("#"+gridId+" .gridBodyTr.selected td").click()}, 500);
    		}
    		, setFocus: function(grid, index){
    			setTimeout(function(){
    				grid.setFocus(index);
    				$("#"+grid.config.targetID+" .gridBodyTr.selected td").click()
				}, 500);
    		}
    		, getDivRow: function(list, key, formatter){
    			var result = [];
    			for(var i=0; i<list.length; i++){
    				var keys = key.split(".");
    				var value=undefined;
    				for(var j=0; j<keys.length; j++){
    					if(value){
    						value = value[keys[j]];
    					}else{
    						value = list[i][keys[j]];
    					}
    				}
    				if(formatter){
    					value = formatter(value);
    				}
    				if(i == list.length-1){
    					result.push("<div>" + value + "</div>");
    				}else{
    					result.push("<div style='border-bottom: 1px solid gray;'>" + value + "</div>");
    				}
    			}
    			return result.join("");
    		}
    		, getDivRowValues: function(list, formatter){
    			var result = [];
    			for(var i=0; i<list.length; i++){
					var value = list[i];
    				if(formatter){
    					value = formatter(value);
    				}
    				if(i == list.length-1){
    					result.push("<div>" + value + "</div>");
    				}else{
    					result.push("<div style='border-bottom: 1px solid gray;'>" + value + "</div>");
    				}
    			}
    			return result.join("");
    		}
    		, getSaveList: function(grid){
    			var result = [];
    			for(var i=0; i<grid.list.length; i++){
    				if(grid.list[i]._CUD && (grid.list[i]._CUD == 'C' || grid.list[i]._CUD == 'U')){
    					result.push(grid.list[i]);
    				}
    			}
    			return result;
    		}
    		, getColLabel: function(grid, c){
    			var rows = grid.config.colHead.rows[0];
    			if(!rows){
    				return "";
    			}
    			for(var i=0; i<rows.length; i++){
    				if(rows[i].colSeq == c){
    					return rows[i].label
    				}
    			}
    			return "";
    		}
    		, revitalizeInlineEditor: function(target, rowIndex, colIndex){
    			target.editCell("0", colIndex, rowIndex);
    		}
    		, selectedItemToArray: function(selectedItem){
    			if($.isArray(selectedItem.index)){
    				var res = [];
    				$.each(selectedItem.index, function(i, o){
    					res.push({index: selectedItem.index[i], item: selectedItem.item[i]});
    				});
    				return res;
    			}else{
    				return [selectedItem];
    			}
    		}
    		, removeSelectedItem: function(grid){
    			grid.removeListIndex(Common.grid.selectedItemToArray(grid.getSelectedItem()));
    		}
    	}
    	, search: {
    		change: function(key, target){
    			$("#"+target.getItemId(key)).change();
    		}
    		, getValue: function(target, key){
    			return $("#"+target.getItemId(key)).val();
    		}
    		, setValue: function(target, key, value){
    			$("#"+target.getItemId(key)).val(value);
    		}
    		, isChecked: function(target, key){
    			return $("#"+target.getItemId(key)).is(":checked");
    		}
    		, focus: function(target, key){
    			$("#"+target.getItemId(key)).focus();
    		}
    	}
    	,strReplace : function(str){

     	  	var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%\\\\(\'\"]/gi
     	 	var val = "";

     	  	if(str != "" && str != null && typeof str !== "undefined" ){
     	 		val =str.replace(regExp, "").replace(/\s/gi,'');
     	 	}
         	return  val;
  		 }
    	, str: {
    		replaceAll: function(str, regex, replaceStr){
    			return str.replace(eval("/"+regex+"/gi"), replaceStr);
    		}
    		,getAge : function(jumin, now) {
    				if(jumin == null){
    					return "";
    				}

    				var jumin1 = jumin.substring(0,6);
    				var jumin2 = jumin.replace("-","").substring(6,7);
    				var curDateObj = now || new Date(); // 날짜 Object 생성
    				var curDate = ""; // 현재일자
    				var tmpAge = 0; // 임시나이
    				var tmpYear = "";
    				var curYear = curDateObj.getFullYear(); // 현재년도
    				var curMonth = curDateObj.getMonth() + 1; // 현재월
    				if(curMonth < 10) curMonth = "0" + curMonth; // 현재 월이 10보다 작을경우 '0' 문자 합한다
    				var curDay = curDateObj.getDate(); // 현재일
    				if(curDay < 10) curDay = "0" + curDay; // 현재 일이 10보다 작을경우 '0' 문자 합한다
    				curDate = curYear + curMonth + curDay;
    					var genType = jumin2.substring(0, 1); // 주민번호 뒷자리 성별구분 문자 추출
    					curDate = curYear+"" + curMonth+"" + curDay+"";

    				var genType = jumin2.substring(0, 1); // 주민번호 뒷자리 성별구분 문자 추출
    				if(genType == 9 || genType == 0) {
    					tmpYear = (1800 + parseInt(jumin1.substring(0, 2)));
    					tmpAge = parseInt(curYear) - (1800 + parseInt(jumin1.substring(0, 2))); // 1, 2 일경우
    				}else if(genType == 1 || genType == 2 || genType == 5 || genType ==6) {
    					tmpYear = (1900 + parseInt(jumin1.substring(0, 2)));
    					tmpAge = parseInt(curYear) - (1900 + parseInt(jumin1.substring(0, 2))); // 1, 2 일경우
    				} else {
    					tmpYear = (2000 + parseInt(jumin1.substring(0, 2)));
    					tmpAge = parseInt(curYear) - (2000 + parseInt(jumin1.substring(0, 2))); // 그 외의 경우
    				}

					var tmpBirthday = jumin1.substring(2, 6); // 주민번호 4자리 생일문자 추출
					if(curDate < (curYear + tmpBirthday)) {
						tmpAge -=1;
					}

    				return tmpAge<= 0 ? 0 : tmpAge;

    		}
    		, toBirth: function(jumin){
    			var _jumin = jumin.replace("-", "");
    			var year = _jumin.substring(0,2);
    			var month = _jumin.substring(2,4);
				var date = _jumin.substring(4,6);
				var th = _jumin.substring(6,7);

				var yearPrefix;
				switch (+th) {
				case 1: case 2:
					yearPrefix = "19";
					break;
				case 3: case 4:
					yearPrefix = "20";
					break;
				case 9: case 0:
					yearPrefix = "18";
					break;
				default:
					break;
				}

				if (month < 1 || month > 12) {
			          //alert("달은 1월부터 12월까지 입력 가능합니다.");
			          return "";
			     }
			    if (date < 1 || date > 31) {
			          //alert("일은 1일부터 31일까지 입력가능합니다.");
			          return "";
			     }
			     if ((month==4 || month==6 || month==9 || month==11) && date==31) {
			          //alert(month+"월은 31일이 존재하지 않습니다.");
			          return "";
			     }
			     if (month == 2) {
			          var isleap = ((yearPrefix+year) % 4 == 0 && ((yearPrefix+year) % 100 != 0 || (yearPrefix+year) % 400 == 0));
			          if (date>29 || (date==29 && !isleap)) {
			              // alert(year + "년 2월은  " + day + "일이 없습니다.");
			               return "";
			          }
			     }

				return (yearPrefix+year+month+date);
    		}
    		, ifNull: function(str, defaultStr){
    			if(typeof str == "undefined" || str == null){
    				return defaultStr;
    			}else{
    				return str;
    			}
    		}
    		,lpad : function(originalstr, strToPad , length) {
    		    while (originalstr.length < length)
    		        originalstr = strToPad + originalstr;
    		    return originalstr;
    		},getBirthFromJuminNoAndSex: function(juminNo){
     			var j1, j2;
     			if(juminNo == null){
     				return {birth:"", sex:""};
     			}else if(juminNo.length == 14){
     				j1 = juminNo.split('-')[0];
     				j2 = juminNo.split('-')[1];
     			}else if(juminNo.length == 13){
     				j1 = juminNo.substring(0,6);
     				j2 = juminNo.substring(6,13);
     			}else{
     				return {birth:"", sex:""};
     			}
 				var checkNum = j2.substring(0, 1);
 				var sex;
 				if (j2.charAt(0) == 2 || j2.charAt(0) == 4 || j2.charAt(0) == 6 || j2.charAt(0) == 8) {
 					sex = "TCM0500002";
 				} else if (j2.charAt(0) == 1 || j2.charAt(0) == 3 || j2.charAt(0) == 5 || j2.charAt(0) == 7) {
 					sex = "TCM0500001";
 				} else {
 					sex = "TCM0500003";
 				}

 				var birth = '';

 				if ((checkNum) == 3 || (checkNum) == 4) {
 					birth = "20" + j1.substring(0, 2);
 				} else {
 					birth = "19" + j1.substring(0, 2);
 				}

 				birth += "-" + j1.substring(2, 4);
 				birth += "-" + j1.substring(4);
 				return {birth:birth, sex:sex};
    		}
    		, getGender: function(juminNo){
    			if(juminNo.length >= 8 ){

        			var female = "0,2,4,6,8";
        			var male = "1,3,5,7,9";

    				if(female.indexOf(juminNo.substring(7,8)) != -1){
    					  return "TCM0500002";
    				}else if(male.indexOf(this.value.substring(7,8)) != -1){
    					return "TCM0500001";
    				}

                }else{
                	 return "TCM0500003";
                }
    		}
    		,juminChk : function (juminNo) {
    			 var strJumin = juminNo.replace("-", "");
    			 var checkBit = new Array(2,3,4,5,6,7,8,9,2,3,4,5);
    			 var num7  = strJumin.charAt(6);
    			 var num13 = strJumin.charAt(12);
    			 var total = 0;
    			 if (strJumin.length == 13 ) {
    			  for (i=0; i<checkBit.length; i++) { // 주민번호 12자리를 키값을 곱하여 합산한다.
    			    total += strJumin.charAt(i)*checkBit[i];
    			  }
    			  // 외국인 구분 체크
    			  if (num7 == 0 || num7 == 9) { // 내국인 ( 1800년대 9: 남자, 0:여자)
    			   total = (11-(total%11)) % 10;
    			  }
    			  else if (num7 > 4) {  // 외국인 ( 1900년대 5:남자 6:여자  2000년대 7:남자, 8:여자)
    			   total = (13-(total%11)) % 10;
    			  }
    			  else { // 내국인 ( 1900년대 1:남자 2:여자  2000년대 3:남자, 4:여자)
    			   total = (11-(total%11)) % 10;
    			  }

    			  if(total != num13) {
    			   return false;
    			  }
    			  return true;
    			 } else{
    			  return false;
    			 }
    		}
    		, bolderAndSize: function(str, size){
    			return "<span style='font-weight: bolder; font-size: "+size+"px;'>"+str+"</span>";
    		}

	    }
    	, obj: {
    		moveParent: function(obj, field){
    			for(var key in obj[field]){
    				obj[key] = obj[field][key];
    			}
    			return obj;
    		}
    	}
    	, message: {
    		validError: function(error){
    			var errorLog = error.log;
                var message = [];
                for(var i=0; i<errorLog.length; i++){
                    $('[name="'+errorLog[i].field+'"]').css("background-color", "#FF0000");
                    $('[name="'+errorLog[i].field+'"]').bind("blur", function(){
                    	$(this).css("background-color", "#FFFFFF");
                    });
                    $('[name="'+errorLog[i].field+'String"]').css("background-color", "#FF0000");
                    $('[name="'+errorLog[i].field+'String"]').bind("blur", function(){
                    	$(this).css("background-color", "#FFFFFF");
                    });
                    message.push(errorLog[i].message);
                }
                alert(message.join("\n"));
    		}
    	}
    	, pattern: {
    		custom: function(value, pattern){
    			var input = document.createElement("input");
    			var id = new Date().getTime();
    			$(input).attr("id", id);
    			$(input).css("display", "none");
    			$(document.body).append(input);
                $(input).bindPattern({pattern: "custom", patternString: pattern});
                $(input).val(value);
                $(input).blur();
                var res = $(input).val();
                $(input).remove();
                return res;
    		}
    	}
    	, addr: {
    		getAddrPart: function(addr, addrCodeId, addrPartId, isEtc,gridIndex){
              	var addrName = addr.split(" ");
            	var result = [];
            	result.push(addrName.shift());
            	result.push(addrName.shift());
            	app.ajax({
                    type: "GET",
                    url: "/CREM2010/addrCode/"+encodeURI(result.join(" ").trim()),
                    data: ""
                },
                function(res){
                	if(res.error){
                		alert(res.massage);
                	}else{
                		if(!res.map || res.map.addrPartVTO == null){
                			return;
                		}
                		$("#"+addrCodeId).val(res.map.addrPartVTO.addrCode);
                		$("#"+addrCodeId).change();
	                		if(isEtc){
	                			$("#"+addrPartId).val(res.map.addrPartVTO.addrPartEtc);
	                			$("#"+addrPartId).change();
	                		}else if(!isEtc){
	                			$("#"+addrPartId).val(res.map.addrPartVTO.addrPart);
	                			$("#"+addrPartId).change();
	                		}
                	}
            	});
    		},
	    	getAddrCode: function(){
	    		var result;
	    		app.ajax({
	    			async:false,
	    			type: "GET",
	    			url: "/CREM2010/addrCode",
	    			data: ""
	    		},
	    		function(res){
	    			if(res.error){
	    				alert(res.massage);
	    			}else{
	    				result = res.list;
	    			}
	    		});
	    		return result;
	    	}
    	}
    	, report: {
    		getRealReportUrl: function(path, output, params){
    			var result;
	    		app.ajax({
	    			async:false,
	    			type: "GET",
	    			url: "/report/url",
	    			data: "reportUnit="+path+"&output="+output+"&"+params
	    		},
	    		function(res){
	    			if(res.error){
	    				alert(res.massage);
	    			}else{
	    				result = res.map.url;
	    			}
	    		});
	    		return result;
    		},
    		getReportUrl: function(path, output, params){
    			return "/report?reportUnit="+path+"&output="+output+"&"+params;
    		}
    		, open: function(path, output, params){
    			var windowFeatures = 'toolbar=0, status=0, menubar=0, scrollbars=no, height=700, width=800';
//    			var url = Common.report.getReportUrl(path, output, params);
    			var url = "/report?reportUnit="+path+"&output="+output+"&"+params;
	    		window.open(url, "reportPop", windowFeatures);
    		}
    		, go: function(path, output, params){
    			var windowFeatures = 'toolbar=0, status=0, menubar=0, scrollbars=no, height=700, width=800';
    			var url = "/report?reportUnit="+path+"&output="+output+"&"+params;
	    		location.href = url;
    		}
    		, embedded: function(path, output, params, frameId){
    			var url = "/report?reportUnit="+path+"&output="+output+"&"+params;
				$("#"+frameId).attr("src", url);
    		}
    		/**
    		 * [{path:[reportUnit], parameter:{parameter}]
    		 */
    		, mergePdfReport: function(parameters){
    			var windowFeatures = 'toolbar=0, status=0, menubar=0, scrollbars=no, height=700, width=800';
	    		window.open("", "reportPop", windowFeatures);
	    		$.form("/report/merge/pdf", this.getMergedPdfData(parameters), "POST", "reportPop").submit();
    		}
    		/**
    		 * [{path:[reportUnit], parameter:{parameter}]
    		 */
    		, printMergePdfReport: function(parameters){
    			var windowFeatures = 'toolbar=0, status=0, menubar=0, scrollbars=no, height=700, width=800';
    			var iframe = this._printIframe;
				if (!this._printIframe) {
					iframe = this._printIframe = document.createElement('iframe');
					iframe.name = "reportIf";
					document.body.appendChild(iframe);

					iframe.style.display = 'none';
					iframe.onload = function() {
						setTimeout(function() {
							iframe.focus();
							iframe.contentWindow.print();
						}, 1);
					};
				}

    			$.form("/report/merge/pdf", this.getMergedPdfData(parameters), "POST", "reportIf").submit();
    		}
    		/**
    		 * [{path:[reportUnit], parameter:{parameter}]
    		 */
    		, getMergedPdfUrl: function(parameters){
    			var paramsArr = [];
    			for(var i=0; i<parameters.length; i++){
    				paramsArr.push(("reportUnit="+parameters[i].path+"&output=pdf&"+parameters[i].parameter).split("&").join("__"));
    			}
    			var url = "/report/merge/pdf?reportQuery="+paramsArr.join("&reportQuery=");
    			return url;
    		}
    		, getMergedPdfData: function(parameters){
    			var paramsArr = [];
    			for(var i=0; i<parameters.length; i++){
    				paramsArr.push("reportUnit="+parameters[i].path+"&output=pdf&"+parameters[i].parameter);
    			}
    			return {url: paramsArr};
    		}
    		, printMergePdf: function(parameters){
    			var url = this.getMergedPdfUrl(parameters);
    			this.printByUrl(url);
    		}
    		, print : function(path, output, params) {
    			var url = "/report?reportUnit="+path+"&output="+output+"&"+params;
				this.printByUrl(url);
			}
    		, printByUrl: function(url){
    			var iframe = this._printIframe;
				if (!this._printIframe) {
					iframe = this._printIframe = document.createElement('iframe');
					document.body.appendChild(iframe);

					iframe.style.display = 'none';
					iframe.onload = function() {
						setTimeout(function() {
							iframe.focus();
							iframe.contentWindow.print();
						}, 1);
					};
				}

				iframe.src = url;
    		}
    		, addPrintListener: function(win) {

    			if(!win){
    				win = window
    			}

    		    var beforePrint = function() {
    		        console.log('Functionality to run before printing.');
    		    };

    		    var afterPrint = function() {
    		        console.log('Functionality to run after printing');
    		    };

    		    if (win.matchMedia) {
    		        var mediaQueryList = win.matchMedia('print');
    		        mediaQueryList.addListener(function(mql) {
    		            if (mql.matches) {
    		                beforePrint();
    		            } else {
    		                afterPrint();
    		            }
    		        });
    		    }

    		    window.onbeforeprint = beforePrint;
    		    window.onafterprint = afterPrint;

    		}
    		, excelTemplate: '<html>'+
				'<head>'+
				'	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />'+
				'	<style type="text/css">'+
				'		table {'+
				'		    border-spacing: 0;'+
				'		    border-collapse: collapse;'+
				'		}'+
				'		thead td {'+
				'			background-color: #F2F2F2;'+
				'			font-weight: bolder;'+
				'		}'+
				'		td, th {'+
				'			text-align: center;'+
				'			border-style: solid;'+
				'			border-color: black;'+
				'/* 			border-right-width: 1px; */'+
				'			border-bottom-width: 1px;'+
				'		}'+
				'/* 		tr:eq(0) td{ */'+
				'/* 			border-top-width: 1px; */'+
				'/* 		} */'+
				'/* 		td:eq(0) { */'+
				'/* 			border-left-width: 1px; */'+
				'/* 		} */'+
				'	</style>'+
				'</head>'+
				'<body>'+
				'${excelFormat }'+
				'</body>'+
				'</html>'
    		, gridToExcel: function(fileName, grid){
//    			$.form('/report/excel', {filename: fileName, excelFormat: grid.getExcelFormat("html")}, 'POST').submit();
    			// Function to download data to a file
    			function download(data, filename, type) {
    			    var file = new Blob([data], {type: type});
    			    if (window.navigator.msSaveOrOpenBlob) // IE10+
    			        window.navigator.msSaveOrOpenBlob(file, filename);
    			    else { // Others
    			        var a = document.createElement("a"),
    			                url = URL.createObjectURL(file);
    			        a.href = url;
    			        a.download = filename;
    			        document.body.appendChild(a);
    			        a.click();
    			        setTimeout(function() {
    			            document.body.removeChild(a);
    			            window.URL.revokeObjectURL(url);
    			        }, 0);
    			    }
    			}
    			var data = this.excelTemplate.replace("${excelFormat }", grid.getExcelFormat("html"));
    			download(data, fileName+".xls", 'text');
    		}
    	}
    	, page: {
    		host: function(){
    			return location.protocol + "//" + location.host;
    		}
    	}
    	, form : {
    		fillForm : function(startId,data){
    				for(var key in data){


    					$("#"+startId+key).val(data[key]);
    					$("#"+startId+key).bindSelectSetValue(data[key]);
    					$("#"+startId+key).change();

    					if ($("#"+startId+key).attr("data-axbind") == "date" &&  data[key].length  >=8) {
    						$("#"+startId+key).val(data[key].date().print());
    					}

    				}
    		}
    	}
    	, input :{
    		keydown : function(id,fn){
    			$(id).keydown(function (key) {
                    if(key.keyCode == 13){
                    	evel(fn);
                    }
                });
    		}
    	},
    	 calc: {
         	sum: function(targetEl, elArray){
         		var sum = 0;
         		elArray.forEach(function(o, i){
         			console.log(o.val());
         			if(!isNaN(Common.str.replaceAll(o.val(), ",", "")))
         				sum+=(+Common.str.replaceAll(o.val(), ",", ""));
        			});
         		targetEl.val(sum);
         	},
         	listSum: function(target, list, keyList){
         		var sum = 0;
         		list.forEach(function(o, i){
         			var value = 0;
         			keyList.forEach(function(o1, i){
         				if(isNaN(o[o1])) return;
         				value+=(+o[o1]);
         			})
         			sum += value;
         		});
         		target.val(sum);
         	}
         },
         cond: {
        	 run: function(item, returnValue, func){
        		 if(item){
        			 return func(item);
        		 }else{
        			 return returnValue;
        		 }
        	 }
         },
         security: {
        	 chkPw: function(userCd, userPs, userPs_chk){
        		 if(userPs != userPs_chk)
        		    {
        		        alert("입력하신 비밀번호와 비밀번호확인이 일치하지 않습니다");
        		        return false;
        		    }

        		    if(userPs.length < 10)
        		    {
        		        alert("비밀번호는 문자, 숫자, 특수문자의 조합으로 10~16자리로 입력해주세요!.");
        		        return false;
        		    }

        		    if(!userPs.match(/[a-zA-Z0-9]*[^a-zA-Z0-9\n]+[a-zA-Z0-9]*$/ ))
        		    {
        		        alert("비밀번호는 문자, 숫자, 특수문자의 조합으로 10~16자리로 입력해주세요!!.");
        		        return false;
        		    }

        		    if(userPs.indexOf(userCd.value) > -1)
        		    {
        		        alert("비밀번호에 아이디를 사용할 수 없습니다.");
        		        return false;
        		    }

        		    var SamePass_0 = 0; //동일문자 카운트
        		    var SamePass_1 = 0; //연속성(+) 카운드
        		    var SamePass_2 = 0; //연속성(-) 카운드

        		    var chr_pass_0;
        		    var chr_pass_1;

        		    var chr_pass_2;

        		    for(var i=0; i < userPs.length; i++)
        		    {
        		        chr_pass_0 = userPs.charAt(i);
        		        chr_pass_1 = userPs.charAt(i+1);

        		        //동일문자 카운트
        		        if(chr_pass_0 == chr_pass_1)
        		        {
        		            SamePass_0 = SamePass_0 + 1
        		        }


        		        chr_pass_2 = userPs.charAt(i+2);
        		        //연속성(+) 카운드

        		        if(chr_pass_0.charCodeAt(0) - chr_pass_1.charCodeAt(0) == 1 && chr_pass_1.charCodeAt(0) - chr_pass_2.charCodeAt(0) == 1)
        		        {
        		            SamePass_1 = SamePass_1 + 1
        		        }

        		        //연속성(-) 카운드
        		        if(chr_pass_0.charCodeAt(0) - chr_pass_1.charCodeAt(0) == -1 && chr_pass_1.charCodeAt(0) - chr_pass_2.charCodeAt(0) == -1)
        		        {
        		            SamePass_2 = SamePass_2 + 1
        		        }
        		    }
        		    if(SamePass_0 > 1)
        		    {
        		        alert("동일문자를 3번 이상 사용할 수 없습니다.");
        		        return false;
        		    }

        		    if(SamePass_1 > 1 || SamePass_2 > 1 )
        		    {
        		        alert("연속된 문자열(123 또는 321, abc, cba 등)을\n 3자 이상 사용 할 수 없습니다.");
        		        return false;
        		    }
        		 return true;
        	 }
         }

};