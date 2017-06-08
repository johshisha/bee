#!/bin/sh

if [ $# = 0 ]; then
  echo "need argument 'COMMAND'" 1>&2
  exit 0   
else
  COMMAND=$*
fi
start="`date '+%y/%m/%d %H:%M:%S'`"

${COMMAND}
status=$?
end="`date '+%y/%m/%d %H:%M:%S'`"

if [ $status = 0 ]; then
  MESSAGE="Success!!!!";
  COLOR="#00ff00";
else
  MESSAGE="Failed....";
  COLOR="#ff0000";
fi

WEBHOOKURL="WebhockのURL入れてね"
#slack 送信チャンネル
CHANNEL=${CHANNEL:-"#general"}
#slack 送信名
BOTNAME=${BOTNAME:-"Bee"}
#slack アイコン
FACEICON=${FACEICON:-":bee:"}
#メッセージ
WEBMESSAGE="Command: ${COMMAND}\nStart time: ${start}\nEnd time: ${end}"
#メンションするユーザ
MENTION_USER="@channel"

curl -s -S -X POST --data-urlencode "payload={\"channel\": \"${CHANNEL}\", \"username\": \"${BOTNAME}\", \"text\": \"${MENTION_USER}\", \"icon_emoji\": \"${FACEICON}\", \"attachments\": [ {\"title\": \"${MESSAGE}\", \"text\": \"${WEBMESSAGE}\", \"color\": \"${COLOR}\"}] }" ${WEBHOOKURL} >/dev/null

exit 0
