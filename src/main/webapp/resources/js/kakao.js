/* 카카오톡 채널 API */

function kakaoInit() {
   const jsKey = '519384171cff5916d36308792f665979';
   const chId = '_WgLlxj';
   
   if (!Kakao.isInitialized()) {
      Kakao.init(jsKey);
   }
   
   return chId;
}

function chatChannel() {
   const chId = kakaoInit();

   Kakao.Channel.chat({
      channelPublicId: chId // 카카오톡 채널 홈 URL에 명시된 id로 설정합니다.
   });
}

function addChannel() {
   const chId = kakaoInit();
   
   Kakao.Channel.addChannel({
      channelPublicId: chId
   });
}

