
/**
 * WC 웹소켓 컨트롤러
 */
var WC = function(url, pConnectedCallback){

	this.socket;

	this.connectedCallback = pConnectedCallback;

	this.init = function(){

		var _this = this;

		// 웹소켓 생성
		_this.socket = new WebSocket(url);

		// 메세지가 왔을때 호출할 메소드 지정
		_this.socket.onmessage = function(evt){
			/**
			 * data = {controller:*String*, data:*Json data*}
			 */
			var data = JSON.parse(evt.data);
			if(_this.controllers[data.controller]){
				_this.controllers[data.controller].apply(_this, [data.data]);
			}else{
				if(console.log){
					console.log(data.controller + "는 존재하지 않는 controller 입니다.");
				}
			}
		};

		_this.socket.onopen = function(){
			if(console.log){
				console.log("서버와 연결이 완료되었습니다.");
			}
			if(_this.connectedCallback){
				_this.connectedCallback();
			}
		};

		_this.socket.onclose = function(){
			if(console.log){
				console.log("서버와 연결이 종료되었습니다. 잠시후 재접속을 시도합니다.");
			}
			$("#main").html(
				'<div style="color:gray; width: 100px; height: 100%; margin-top: 25%; margin-left:50%;">'
					+'<i class="axi axi-data-usage animated bounceOutUp" style="font-size:100px;display:block;"></i>'
					+'<div style="font-family: consolas">서버와 연결이 종료되었습니다. 잠시후 재접속을 시도합니다.</div>'
				+'</div><input type="hidden" id="pageId" value="boardLoading" />'
			);
			_this.timeout = setTimeout(function(){
				_this.init();
			}, 30*1000)
		}
	};

	this.send = function(data){

		var _this = this;

		if(_this.socket){
			_this.socket.send(data);
		}else{
			if(console.log){
				console.log("웹소켓이 생성되지 않았습니다.");
			}
			alert("웹소켓이 생성되지 않았습니다.");
		}
	}

	this.controllers = {
		connected : function(data){
			if(console.log){
				console.log(data);
			}
		}
		, refresh : function(data){
			window.location.reload(true);
		}
		, monitering : function(data){
			var url = 'ws://' + location.host + '/wst/monitering';
			monitering = new WebSocket(url);
			function sendScreenshot(){
				html2canvas(document.body, {
				      onrendered: function (canvas) {
//				           canvas.toBlob(function(blob){
//							   	monitering.send(blob);
//							   	if(monitering.readyState === monitering.CLOSED){
//				        		   return;
//								}
//								setTimeout(sendScreenshot, 500);
//				           });
				    	  if(monitering.readyState === monitering.CLOSED){
				    		  return;
				    	  }
				    	  monitering.send(canvas.getImageData(0, 0, canvas.width, canvas.height).data.buffer);
				    	  setTimeout(sendScreenshot, 500);
				      }
				});

			}
			monitering.onopen = function(){
				sendScreenshot();
			}
		}
		, moniteringClose : function(){
			if(monitering){
				monitering.close();
			}
		}
	};

}