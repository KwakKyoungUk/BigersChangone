/**
 *
 */
var Board = function(){

	this.time = 8000;
	this.target = document.body;

	this.setTime = function(second){
		board.time = second*1000;
	};

	this.setTarget = function(target){
		if(typeof target == 'string'){
			board.target = document.querySelector(target);
		}else{
			board.target = target;
		}
		$(board.target).css("width","100%");
		$(board.target).css("height","100%");
		$(board.target).css("display","inline-block");
//		$(board.target).css("background-color","blue");

		$("<div id='left-tempBody'><div>").insertBefore(board.target);
		$("<div id='right-tempBody'><div>").insertAfter(board.target);

		$("#right-tempBody").css("width","100%");
		$("#right-tempBody").css("height","100%");
		$("#right-tempBody").css("display","inline-block");

		$("#left-tempBody").css("width","0%");
		$("#left-tempBody").css("height","100%");
		$("#left-tempBody").css("display","inline-block");
		$("#left-tempBody").css("position","absolute");
	}


	this.pageURLList = {};
	this.pageCount = 0;

	this.addPage = function(key, url, order){
		var page = {url:url, order:order};
		board.pageURLList[key] = page;
		var i=0;
		for(var k in this.pageURLList){
			i++;
		}
		board.pageCount = i;
	};

	this.removePage = function(key){
		delete board.pageURLList[key];
		return board.pageURLList;
	};

	this.documents = {};

	this.getDocuments = function(){
		return board.documents;
	};

	this.loadDocument = function(){

		this.documents = {};

		for(var k in this.pageURLList){

			var fullUrl = this.pageURLList[k].url;
			var urlArr = fullUrl.split('?');
			var url = urlArr[0];
			var params = urlArr.length == 2 ? urlArr[1] : '';
			var divDoc = document.createElement('div');
			$.ajax({
	            url:url,
	            async:false,
	            success:function(data){
	            	divDoc.innerHTML = data;
	            }
	        });
//			var req = new HttpRequest();
//			req.sendRequest(url, params, function(){
//				if (req.httpRequest.readyState == 4) {
//					if (req.httpRequest.status == 200) {
//						divDoc.innerHTML = req.httpRequest.responseText;
//					}
//				}
//			}, 'GET');
			board.documents[k] = {divDoc : divDoc, before : null, after : null};
		}
		board.setFontSize();
		return board.documents;
	};

//	this.sleep = function(){
//		var currentTime = new Date().getTime();
//		var endTime = currentTime + this.time;
//		while(endTime > new Date().getTime()){
//
//		}
//	};

	this.setFontSize = function(){

		var fontheight = document.body.clientHeight*0.15/2;

		var labels = [];

		for(var k in board.documents){
			var lbs = board.getDocuments()[k].divDoc.getElementsByTagName('label');
			for(var i=0; i<lbs.length;i ++){
				labels.push(lbs[i]);
			}
		}

		for(var i=0; i<labels.length; i++){
 			if(labels[i].getAttribute('size')){
 				labels[i].style.fontSize = (fontheight*labels[i].getAttribute('size'))+'px';
 			}else{
 				labels[i].style.fontSize = fontheight+'px';
 			}
		}
	}

	this.setRelativeFontSize = function(el){

		var fontheight = document.body.clientHeight*0.15/2;
		var canChangeFontSize;
		do {
			canChangeFontSize = false;
			var labels = el.querySelectorAll('label');
			for(var i=0; i<labels.length; i++){
				if(labels[i].style.fontSize == ''){
		 			if(labels[i].getAttribute('size')){
		 				labels[i].style.fontSize = (fontheight*labels[i].getAttribute('size'))+'px';
		 			}else{
		 				labels[i].style.fontSize = fontheight+'px';
		 			}
				}
				var parNodeWidth = labels[i].parentNode.clientWidth-10;
				var childNodeWidth = labels[i].clientWidth;
				if(parNodeWidth <= childNodeWidth){
					labels[i].style.fontSize = (+labels[i].style.fontSize.replace('px', '') - 3) + 'px';
					canChangeFontSize = true;
				}
			}
		}while(canChangeFontSize);
	}

	this.showCount = 0;
	this.show = function(){
		if(board.pageCount == 0) return;
		board.showInterval();
		setInterval(board.showInterval, board.time);
	};

	this.showDoc = function(key, data, effect){

		board.docId = key;

		var preShow = board.documents.before;
		var postShow = board.documents.after;

		var clone = board.documents[key].divDoc.cloneNode(true);
		var before = board.documents[key].before;
		var after = board.documents[key].after;

		if(preShow || preShow != null){
			preShow(clone, data);
		}

		if(before != null){
			if(before(clone, data)==false){
				return;
			}
		}


		switch (effect) {
		case "left":
			$("#left-tempBody").html(clone.innerHTML);
			$("#left-tempBody").animate({width: "100%"},{duration:1500, done:function(){
				$(board.target).html(clone.innerHTML);
				$("#left-tempBody").css("width", "0%");
				$(board.target).css("opacity", "1");
				$("#left-tempBody").html("");
			}
			, start: function(){
				$(board.target).animate({opacity:"0"},{duration:1500});
			}
			});
			break;
		case "modal":
			$("#left-tempBody").html(clone.innerHTML);
			$("#left-tempBody").css("opacity", "0");
			$("#left-tempBody").css("width", "100%");
			$("#left-tempBody").animate({opacity: "1"},{duration:1500});
			break;

		case "right":
			$("#right-tempBody").html(clone.innerHTML);
			$(board.target).animate({width: "0%", opacity:"0", left:"100%"},{duration:1500, done:function(){
				$(board.target).html(clone.innerHTML);
				$(board.target).css("width", "100%");
				$(board.target).css("opacity", "1");
				$("#right-tempBody").html("");
			}});
			break;
		default:
			board.target.innerHTML = clone.innerHTML;
		}



//		$(board.target).fadeOut(500, function() {
//		$(board.target).animate({width: "0%"}, {done :function(){
//			$(this).html(clone.innerHTML).ani({width: "100%"});
//		}
//		});
//		$(board.target).animate({width: "0px"});

		if(after != null){
			if(after(clone, data)==false){
				return;
			}
		}

		if(postShow || postShow != null){
			postShow(clone, data);
		}

		board.setRelativeFontSize(board.target);
	}

	this.showInterval = function(){
		for(var k in board.pageURLList){
			if(board.pageURLList[k].order == board.showCount%board.pageCount){
				var before = board.documents[k].before;
				var after = board.documents[k].after;
				var clone = board.documents[k].divDoc.cloneNode(true);
				if(before != null){
					if(before(clone)==false){
						board.showCount++;
//						board.showInterval();
						return;
					}
				}

				board.target.innerHTML = clone.innerHTML;

				if(after != null){
					if(after(clone)==false){
						board.showCount++;
//						board.showInterval();
						return;
					}
				}

				board.setRelativeFontSize(board.target);

				break;
			}
		}
		board.showCount++;
	}


//	this.addFlowListener = function(element, type, fn) {
//		var flow = type == 'over';
//		element
//				.addEventListener(
//						'OverflowEvent' in window ? 'overflowchanged' : type + 'flow'
//						, function(e) {
//							if (e.type == (type + 'flow')
//									|| ((e.orient == 0 && e.horizontalOverflow == flow)
//									|| (e.orient == 1 && e.verticalOverflow == flow)
//									|| (e.orient == 2 && e.horizontalOverflow == flow && e.verticalOverflow == flow))) {
//								return fn.call(this, e);
//							}
//						}, false);
//	}
};



window.board = new Board();