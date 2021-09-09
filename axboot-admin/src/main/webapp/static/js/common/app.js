AXConfig.AXGrid.emptyListMSG = "검색된 목록이 없습니다.";

var app = {
	page_size: 50,

	modal: {
		target: new AXModal(),
		bind: function(){
			window.myModal = this.target;
			this.target.setConfig({
				windowID: "app-modal-container",
				mediaQuery: {
					mx:{min:0, max:767}, dx:{min:767}
				},
				displayLoading:true
			});
		},
		open: function(http, opts){
			this.target.open({
				url: http.url,
				pars: (typeof http.pars == "string") ? http.pars.queryToObject() : http.pars,
				top: ( (typeof http.top == "undefined") ? axdom(window).scrollTop() + 30 : http.top ),
				width: ( (typeof http.width == "undefined") ? 900 : http.width ),
				closeByEscKey: false,
				scrollLock: true
			});
		},
		save: function(callBackName){
			var _window = parent||opener||window;
			var fn = eval("_window." + callBackName);
			var args = $.makeArray(arguments);
			args.shift();
			fn.apply(null, args);
		},
		cancel: function(){
			parent.myModal.close();
		},
		close: function(){
			myModal.close();
		},
		excel: function(http){
			app.modal.open({
				url:'/jsp/common/excel-modal.jsp',
				pars: "callBack=app.excel_uploaded" + ((http.pars) ? "&" + http.pars : ""),
		        width:500
			});
		}
	},

	ajax_queue: [],
	ajax: function(http, callBack, nomask, typ){
		if(!nomask) loading_mask.open();
		app.ajax_queue.push("1");
		var jqxhr, opts = {
			contentType: 'application/json'
		};
		$.extend(http, opts);
		jqxhr = $.ajax( http );
		jqxhr
			.done(function(data, textStatus, jqXHR) {
				if(typeof data == "string") arguments[0] = (data == "") ? {} : (data).object();
				if(data.redirect && typ != "islogin") {
					location.href = data.redirect;
					return;
				}
				/*
				if(arguments[0].result == "syntaxerr" && typ != "islogin"){
					location.href = "/jsp/login.jsp";
					return;
				}
				*/

				//console.log("success");
				//전체에 대한 중앙 제어가 필요할 때
				var args = [].concat($.makeArray(arguments));
				if(callBack) callBack.apply(this, args); // callBack
			})
			.fail(function(data, textStatus, msg) {
				//console.log(arguments);
				/*
				if(textStatus == "error" && typ != "islogin"){
					location.href = "/jsp/login.jsp";
					return;
				}
				*/

				//if(data.readyState == 0 || data.status == 0){
				if(msg == ""){

				}else{
					if(callBack) callBack.apply(this, [{
						error: {message:msg}
					}]); // callBack
				}
			})
			.always(function(data, textStatus, jqXHR) {
				app.ajax_queue.pop();
				if(!nomask) if(app.ajax_queue.length == 0) loading_mask.close(300);
			});
	},

	form: {
		clearForm: function($form, includeDisabled) {
			includeDisabled = (includeDisabled || false);
			var o = this.serializeObjWithIds($form, includeDisabled);
			for ( var key in o ) {
				this.axisjVal($form.find('#' + key), '');
			}
		},
		clearFormWithPrefix: function($form, prefix, includeDisabled) {
			includeDisabled = (includeDisabled || false);
			var o = this.serializeObjWithIds($form, includeDisabled, prefix);
			for ( var key in o ) {
				this.axisjVal($form.find('#' + prefix + key), '');
			}
		},

		fillForm: function($form, data, prefix, noClear) {
			prefix = (prefix || '');
			if(!noClear){
				this.clearForm($form);
			}
			for ( var key in data ) {
				var value = data[key],
					field = $form.find('#' + prefix + key);

				this.axisjVal(field, value);
			}
		},

		serializeFormJSON: function ($form) {
			var o = {};
			var a = $form.serializeArray();
			$.each(a, function () {
				if (o[this.name]) {
					if (!o[this.name].push) {
						o[this.name] = [o[this.name]];
					}
					o[this.name].push(this.value || '');
				} else {
					o[this.name] = this.value || '';
				}
			});
			return o;
		},

		serializeObjectWithIds: function($form, prefix, includeDisabled) {
			return this.serializeObjWithIds($form, includeDisabled, prefix);
		},

		serializeObjWithIds: function($form, includeDisabled, prefix) {
			var rCRLF = /\r?\n/g,
				rsubmitterTypes = /^(?:submit|button|image|reset|file)$/i,
				rsubmittable = /^(?:input|select|textarea|keygen)/i,
				manipulation_rcheckableType = /^(?:checkbox|radio)$/i;
				prefix = (prefix || '');

			var arr = $form.map(function(){
				// Can add propHook for "elements" to filter or add form elements
				var elements = jQuery.prop( this, "elements" );
				return elements ? jQuery.makeArray( elements ) : this;
			})
			.filter(function(){
				var type = this.type;
				var use = (includeDisabled) ? true : (jQuery( this ).is( ":disabled" ) ? false : true);
				return jQuery(this).attr('id') && use &&
					rsubmittable.test( this.nodeName ) && !rsubmitterTypes.test( type ) &&
					( this.checked || !manipulation_rcheckableType.test( type ) );
			})
			.map(function( i, elem ){
				var val = jQuery( this ).val();

				return val == null ?
					null :
					jQuery.isArray( val ) ?
						jQuery.map( val, function( val ){
							return { key: jQuery(elem).attr('id'), value: val.replace( rCRLF, "\r\n" ) };
						}) :
					{ key: jQuery(elem).attr('id'), value: val.replace( rCRLF, "\r\n" ) };
			}).get();

			var	i = arr.length,
				result = {};
			while (i--) {
				var e = arr[i],
					key = e.key,
					val = e.value;

				if(prefix == ''){
					result[key] = val;
				}else
				if (prefix && key.indexOf(prefix) == 0) {
					key = key.substring(prefix.length);
					result[key] = val;
				}
			}

			return result;
		},
		axisjVal: function($field, value) {
			$field.val(value);
			if ($field.data('axbind') == "pattern") {
				// axisj pattern이 적용된 input의 경우 pattern이 적용되도록 set val 한다
				$field.bindPatternSetText(value);
			}
			else
			if ($field.attr("data-axbind") == "select") {
				if ( this._hasValueInOptions($field, value) ) {
					$field.bindSelectSetValue(value);
				} else {
					var defaultValue = $field.data('default-value');
					var foundDefaultValueInOption = this._hasValueInOptions($field, defaultValue);
					var hasOption = this._hasOption($field);
					if ( defaultValue && foundDefaultValueInOption ) {
						$field.bindSelectSetValue(defaultValue);
					} else if ( defaultValue && !foundDefaultValueInOption && hasOption ) {
						$field.bindSelectSetValue($field[0].options[0].value);
					} else if ( hasOption ) {
						$field.bindSelectSetValue($field[0].options[0].value);
					}
				}

				if ( $field.data('be-disabled') == 'Y' ) {
					$field.bindSelectDisabled(true);
				}
			}
			else
			if ($field.attr("data-axbind") == "switch") {
				$field.setValueInput(value);
			}
			else
			if ($field.attr("data-axbind") == "money") {
				$field.val(value.money());
			}
			else
			if ($field.attr("data-axbind") == "date") {
				$field.val(value.date().print("yyyy-mm-dd hh:mi"));
				$field.blur();
			}
		},
		_hasOption: function($field) {
			var sel = $field[0];
			return ( sel.options && sel.options.length > 0 );
		},
		_hasValueInOptions: function($field, value) {
			if ( ! this._hasOption($field) ) {
				return false;
			}

			var options = $field[0].options;
			for ( var i = 0 ; i < options.length ; i++ ) {
				if ( options[i].value == value ) {
					return true;
				}
			}
			return false;
		}
	},

	net: {
		ajax: function(callData, successHandler) {
			app.ajax(callData, function(res) {
				if (res && res.error) {
					alert(res.error.message);
				} else {
					successHandler(res);
				}
			})
		}
	},

	gridutil: {
		marker: function(row, args) {
			var currIdx = row.index;
			var prevIdx = currIdx - 1;
			var nextIdx = currIdx + 1;

			var currKey = args.initKey(row.list[currIdx]);
			var prevKey = ( prevIdx >= 0 ? args.initKey(row.list[prevIdx]) : null );
			var nextKey = ( nextIdx < row.list.length ? args.initKey(row.list[nextIdx]) : null );

			var needInit = prevKey != currKey;
			args.row(row, currIdx, needInit);
			return currKey != nextKey;
		}
	},

	arrayutil: {
		mergeArray: function(arr1, arr2, prefix) {
			prefix = (prefix || '_');
			var result = [];
			for ( var i = 0 ; i < arr1.length ; i++ ) {
				var o = {};
				for ( var key in arr1[i] ) {
					if ( arr1[i].hasOwnProperty(key) ) {
						o[key] = arr1[i][key];
					}
				}
				result.push(o);
			}
			for ( var i = 0 ; i < result.length ; i++ ) {
				var currArr1Row = result[i];
				for ( var key in arr2[i] ) {
					if ( arr2[i].hasOwnProperty(key) ) {
						currArr1Row[prefix + key] = arr2[i][key];
					}
				}
			}
			return result;
		}
	},

	dateutil: {
		// pad 함수. 예) 4를 04로 5를 05로 13은 그대로 13으로 만들어준다
		pad: function(n, width, z) {
			z = z || '0';
			n = n + '';
			return n.length >= width ? n : new Array(width - n.length + 1).join(z) + n;
		},
		// 주어진 date를 1982-08-24 형식의 dateString을 만들어준다
		getICNStyleDateString: function(date) {
			var yyyy = date.getFullYear().toString();
			var mm = (date.getMonth()+1).toString();
			var dd  = date.getDate().toString();
			return yyyy + "-" + this.pad(mm, 2) + "-" + this.pad(dd, 2);
		},
		// 특정월의 첫 날을 구한다
		getFirstDateOfDate: function(date) {
			return new Date(date.getFullYear(), date.getMonth(), 1);
		},
		getFirstDateStringOfDate: function(date) {
			return this.getICNStyleDateString(this.getFirstDateOfDate(date));
		},
		// 특정월의 마지막 날을 구한다
		getLastDateOfDate: function(date) {
			return new Date(date.getFullYear(), date.getMonth() + 1, 0)
		},
		getLastDateStringOfDate: function(date) {
			return this.getICNStyleDateString(this.getLastDateOfDate(date));
		},
		// 특정일이 속한 week의 첫날(일요일)을 얻는다
		getFirstDateOfWeek: function(d) {
			d = new Date(d);
			var day = d.getDay();
			var diff = d.getDate() - day; // adjust when day is sunday
			return new Date(d.setDate(diff));
		},
		// 특정일이 속한 week의 마지막날(토요일)을 얻는다
		getLastDateOfWeek: function(d) {
			d = new Date(d);
			var day = d.getDay();
			var diff = d.getDate() - day + 6; // adjust when day is sunday
			return new Date(d.setDate(diff));
		}
	},

	dateObj: {
		dummy: (function() {
			var d = new Date();
			return ("U" + d.getUTCHours() + d.getUTCMinutes() + d.getUTCSeconds() + d.getUTCMilliseconds());
		})(),
		today: new Date(),
		returnDate: function(position, separ) {
			if (position == "YY") {
			}
		},
		numberToString: function(n, digits) {
			var zero = "";
			var tmDate = n.toString();

			if (tmDate.length < digits) {
				for (var i = 1; i < digits; i++)
					zero += "0";
			}
			return zero + tmDate;
		},
		getDateY: function(moveTo, num) {
			if (moveTo == "next")
				return this.numberToString(this.today.getFullYear() + num, 4);
			else if (moveTo == "prev")
				return this.numberToString(this.today.getFullYear() - num, 4);
			else
				return this.numberToString(this.today.getFullYear(), 4);
		},
		getDateM: function(moveTo, num) {
			if (moveTo == "next")
				return this.numberToString(this.today.getMonth() + num + 1, 2);
			else if (moveTo == "prev")
				return this.numberToString(this.today.getMonth() - num + 1, 2);
			else
				return this.numberToString(this.today.getMonth() + 1, 2);
		},
		getDateD: function(moveTo, num) {
			if (moveTo == "next")
				return this.numberToString(this.today.getDate() + num, 2);
			else if (moveTo == "prev")
				return this.numberToString(this.today.getDate() - num, 2);
			else
				return this.numberToString(this.today.getDate(), 2);
		},
		nowDate: function(reType, separ) {
			var bsepar = "-"
			if (separ != undefined) bsepar = separ;

			if (reType != undefined) {
				if (reType == "Y") return this.getDateY();
				else if (reType == "M") return this.getDateY() + bsepar + this.getDateM();
				else return this.getDateY() + bsepar + this.getDateM() + bsepar + this.getDateD();
			}
			else {
				return this.getDateY() + bsepar + this.getDateM() + bsepar + this.getDateD();
			}
		},
		stDate: function(separ) {
			var bsepar = "-"
			if (separ != undefined) bsepar = separ;

			return this.getDateY() + bsepar + this.getDateM() + bsepar + "01";
		},
		edDate: function(separ) {
			var bsepar = "-"
			if (separ != undefined) bsepar = separ;

			var endDay = new Date(new Date(this.getDateY(), this.getDateM(), 1) - 86400000).getDate();

			return this.getDateY() + bsepar + this.getDateM() + bsepar + endDay;
		},
		nextDate: function(reType, setObj, separ) {
			var sType = "D";
			var iNum = 0;
			var sdata = "";
			var dataTm = "";
			var sSepar = "-";

			if (setObj != undefined && setObj.type != undefined) {
				sType = setObj.type;
			}

			if (setObj != undefined && setObj.num != undefined) {
				iNum = setObj.num;
			}

			if (separ != undefined) {
				sSepar = separ;
			}

			if (sType == "Y") {
				dataTm = this.getDateY("next", iNum) + sSepar + this.getDateM() + sSepar + this.getDateD();
			} else if (sType == "M") {
				dataTm = this.getDateY() + sSepar + this.getDateM("next", iNum) + sSepar + this.getDateD();
			} else if (sType == "D") {
				dataTm = this.getDateY() + sSepar + this.getDateM() + sSepar + this.getDateD("next", iNum);
			}

			if (reType == "Y")
				sdata = dataTm.substr(0, 4);
			else if (reType == "M") {
				sdata = dataTm.substr(0, 7);
			}
			else
				sdata = dataTm;
			return sdata;
		},
		prevDate: function(reType, setObj, separ) {
			var sType = "D";
			var iNum = 0;
			var sdata = "";
			var dataTm = "";
			var sSepar = "-";

			if (setObj.type != undefined) {
				sType = setObj.type;
			}
			if (setObj.num != undefined) {
				iNum = setObj.num;
			}

			if (separ != undefined) {
				sSepar = separ;
			}

			if (sType == "Y") {
				dataTm = this.getDateY("prev", iNum) + sSepar + this.getDateM() + sSepar + this.getDateD();
			} else if (sType == "M") {
				dataTm = this.getDateY() + sSepar + this.getDateM("prev", iNum) + sSepar + this.getDateD();
			} else if (sType == "D") {
				dataTm = this.getDateY() + sSepar + this.getDateM() + sSepar + this.getDateD("prev", iNum);
			}

			if (reType == "Y")
				sdata = dataTm.substr(0, 4);
			else if (reType == "M") {
				sdata = dataTm.substr(0, 7);
			}
			else
				sdata = dataTm;

			return sdata;
		},
		//2011.07.27 라천호 moveDate추가 prevDate와 nextDate를 숫자로 판단해서 분기 시켜줌
		moveDate: function(reType, setObj, separ) {
			var iNum = 0;
			if (setObj.num != undefined) {
				iNum = setObj.num;
			}

			if (iNum < 0) {
				iNum = Math.abs(iNum)
				setObj.num = iNum;
				return this.prevDate(reType, setObj, separ);
			}
			else {
				return this.nextDate(reType, setObj, separ);
			}
		}
	},

	excel_uploaded: function(){
		window.location.reload();
	},

	link_to: function(url){
		location.href = url;
	},

	grid: {
		foot_sum: function(list, key, sum){
			sum = 0;
			for(var i=0, l=list.length;i<l;i++){
				sum += Number(list[i][key]||0);
			}
			return sum.money();
		}
	}
};

String.prototype.dec = function() {
	return decodeURIComponent(this);
};