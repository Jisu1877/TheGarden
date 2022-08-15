<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<style>
	#siteMap > a {
		color: gray;
	}
</style>
<!-- Footer -->
<hr>
<footer class="w3-row-padding w3-padding-16">
    <div class="w3-third">
      <ul class="w3-ul">
        <li>
          <p>사업자등록번호 : 305-94-15275<br>
		통신판매업신고 : 2019-충북청주-0049호</p>
          <p>Copyright © 2022 The Garden. All Right Reserved.</p>
        </li>
      </ul>
    </div>
    <div class="w3-third text-center">
      <h3>THE GARDEN</h3>
      <p>식물의 모든 것, 더 가든 입니다.</p>
    </div>
    <div class="w3-third text-center">
      <p>고객센터 운영시간 09:00 - 18:00(월-금)</p>
      <p>대표번호 : 043) 255 - 2111</p>
       <p><span id="kakao-talk-channel-chat-button"></span>&nbsp;<span id="kakao-talk-channel-add-button"></span></p>
       <script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
       <script type="text/javascript">
	      // 사용할 앱의 JavaScript 키를 설정해 주세요.
	      Kakao.init('519384171cff5916d36308792f665979');
	      // 채널 추가하기 버튼을 생성합니다.
	      Kakao.Channel.createAddChannelButton({
	        container: '#kakao-talk-channel-add-button',
	        channelPublicId: '_WgLIxj',
	        size: 'large',
	        supportMultipleDensities: true,
	      });
	  	
	      
	      // 채널 1:1 채팅 버튼을 생성합니다.
	      Kakao.Channel.createChatButton({
	        container: '#kakao-talk-channel-chat-button',
	        channelPublicId: '_WgLIxj',
	        title: 'question',
	        size: 'small',
	        color: 'yellow',
	        shape: 'pc',
	        supportMultipleDensities: true,
	      });
	    </script>
    </div>
  </footer>