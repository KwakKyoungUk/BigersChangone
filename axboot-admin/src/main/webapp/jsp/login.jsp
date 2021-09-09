<%@ page import="com.axisj.axboot.core.util.WebUtils" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>
<%
	request.setAttribute("redirect", WebUtils.pageForAfterLoggedIn(request));
%>
<ax:layout name="empty.jsp">
	<c:if test="${redirect!=null}">
		<c:redirect url="${redirect}"/>
	</c:if>
	<ax:div name="header">

	</ax:div>
	<ax:div name="css">

	</ax:div>
	<ax:div name="js">
		<script type="text/javascript" src="<c:url value='/static/js/data/words.js' />"></script>
	</ax:div>
	<ax:div name="contents">
		<ax:row>
			<ax:col size="12" wrap="false">

				<div class="login-visual"></div>
				<div class="login-vline"></div>
				<div class="login-form">
					<h1>로그인
						<small>로그인 해주세요.</small>
					</h1>
					<div class="H10"></div>
					<form name="login-form" method="post" action="/api/login" onsubmit="return fnObj.login();">
						<div class="ax-input">
							<input type="text" name="username" id="username" value="${loginUserName}"
								   class="AXInput ime-false"
								   placeholder="e-mail">
						</div>
						<div class="ax-input">
							<input type="password" name="password" id="password" value="${loginUserPassword}"
								   class="AXInput"
								   placeholder="password">
						</div>

						<div class="ax-clear"></div>
						<div class="H10"></div>
						<input type="hidden"
							   name="${_csrf.parameterName}" value="${_csrf.token}"/>

						<div class="ax-funcs">
							<!--
							<label>
								<span>&nbsp;아이디 기억하기</span>
								<input type="text" name="" value="NO" id="AXInputSwitch"
									   style="width:50px;height:23px;border:0px none;"/>

							</label>
							-->
							<button type="submit" class="AXButtonLarge Red">&nbsp;&nbsp;로그인&nbsp;&nbsp;</button>
						</div>
					</form>
				</div>
				<div class="ax-clear"></div>
				<div class="icn-stipe"></div>
			</ax:col>
		</ax:row>

		<div id="row-30" class="ax-layer " style="">
			<div id="col-30" class="ax-col-12">
				<div class="ax-unit">
					<div style="width:800px;margin:10px auto;font-size:13px;line-height: 1.8em;text-align: center;"
						 id="good_words">

					</div>
				</div>
			</div>
			<div class="ax-clear"></div>
		</div>

	</ax:div>
	<ax:div name="scripts">
		<script type="text/javascript">
			var fnObj = {
				pageStart: function () {

					var word = good_words[(Math.random() * good_words.length).floor()];//.replace("<", "&lt;");
					var sidx = -1;
					var si1 = word.indexOf("(");
					var si2 = word.indexOf("<");
					if (si1 > -1 && si2 > -1) {
						sidx = Math.min(word.indexOf("("), word.indexOf("<"));
					} else if (si1 > -1) {
						sidx = si1;
					} else if (si2 > -1) {
						sidx = si2;
					}

					if (sidx != -1) {
						word = word.substr(0, sidx) + "<br/><b>" + word.substr(sidx).replace("<", "&lt;") + "</b>";
					} else {
						word = word.replace("<", "&lt;");
					}
					/*
					 toast.push({
					 type:"Caution",
					 body: word
					 });
					 */
					$("#good_words").html(word);
				},
				login: function () {

					app.ajax({
						method: "POST",
						url: "/api/login",
						data: Object.toJSON({
							"username": $("#username").val(),
							"password": $("#password").val()
						})
					}, function (res) {
						if (res && res.error) {
							if (res.error.message == "Unauthorized") {
								alert("로그인에 실패 하였습니다. 계정정보를 확인하세요");
							} else {
								alert(res.error.message);
							}
							return;
						} else {
							location.reload();
						}
					}, false, "islogin");
					return false;
				}
			};
		</script>
	</ax:div>
</ax:layout>
