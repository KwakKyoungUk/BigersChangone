<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>

<ax:layout name="base.jsp">
    <ax:set name="title" value="${PAGE_NAME}" />
    <ax:set name="page_desc" value="${PAGE_REMARK}" />
    <ax:div name="contents">
        <ax:row>
            <ax:col size="12">
                <ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}" function2Auth="${FUNCTION_2_AUTH}" function3Auth="${FUNCTION_3_AUTH}" function4Auth="${FUNCTION_4_AUTH}" function5Auth="${FUNCTION_5_AUTH}"></ax:custom>


                <div class="ax-button-group">
                    <div class="left">
                        <h2><i class="axi axi-list-alt"></i> 우편번호 검색</h2>
                    </div>
                    <div class="ax-clear"></div>
                </div>

				<div class="ax-button-group">
				http://postcode.map.daum.net/guide
			        <input type="text" id="sample6_postcode" placeholder="우편번호">
			        <input class="AXButton" type="button" onclick="fnObj.popPostcode()" value="우편번호 찾기" class=""><br>
			        <input type="text" id="sample6_address" placeholder="주소">
			        <input type="text" id="sample6_address2" placeholder="상세주소">
			        <textarea id="data" style="width: 100%; height: 100px;"></textarea>
				</div>

            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
    <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
        <script>
            var fnObj = {
                popPostcode : function(){

                	new daum.Postcode({
	                    oncomplete: function(data) {

	                        // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                        // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                        // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                        var fullAddr = ''; // 최종 주소 변수
	                        var extraAddr = ''; // 조합형 주소 변수

	                        // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                        if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                            fullAddr = data.roadAddress;

	                        } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                            fullAddr = data.jibunAddress;
	                        }

	                        // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
	                        if(data.userSelectedType === 'R'){
	                            //법정동명이 있을 경우 추가한다.
	                            if(data.bname !== ''){
	                                extraAddr += data.bname;
	                            }
	                            // 건물명이 있을 경우 추가한다.
	                            if(data.buildingName !== ''){
	                                extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                            }
	                            // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	                            fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	                        }

	                        // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                        $('#sample6_postcode').val(data.zonecode); //5자리 새우편번호 사용
	                        $('#sample6_address').val(fullAddr);

	                        // 커서를 상세주소 필드로 이동한다.
	                        $('#sample6_address2').focus();

	                        $('#data').val(Object.toJSON(data));
	                    }
//                 		, theme: {
//                 	        searchBgColor: "#0B65C8", //검색창 배경색
//                 	        queryTextColor: "#FFFFFF" //검색창 글자색
//                 	    }

	                }).open();
                }
            }
        </script>
    </ax:div>
</ax:layout>