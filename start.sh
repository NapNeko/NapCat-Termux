#!/bin/bash
# Create a temporary file to store the JSON data
function main(){

temp_file=$(mktemp)

# Initialize the JSON structure with default values
cat > $temp_file << EOL
{
  "http": {
    "enable": false,
    "host": "",
    "port": 3000,
    "secret": "",
    "enableHeart": false,
    "enablePost": false,
    "postUrls": []
  },
  "ws": {
    "enable": false,
    "host": "",
    "port": 3001
  },
  "reverseWs": {
    "enable": false,
    "urls": []
  },
  "GroupLocalTime": {
    "Record": false,
    "RecordList": []
  },
  "debug": false,
  "heartInterval": 30000,
  "messagePostFormat": "array",
  "enableLocalFile2Url": true,
  "musicSignUrl": "",
  "reportSelfMessage": false,
  "token": ""
}
EOL

# Function to update JSON value
update_json() {
  jq "$1" $temp_file > $temp_file.tmp && mv $temp_file.tmp $temp_file
}

ACCOUNT=$(whiptail --inputbox "请输入机器人QQ号:" 8 39 --title "基础设置" 3>&1 1>&2 2>&3)
if [ -z "$account" ]; then
    echo "机器人QQ号不能为空"
    rm $temp_file
    main
else
  # Reverse WebSocket 设置
  reverse_ws_enable=$(whiptail --title "反向 ws 设置" --radiolist "启用反向 WS?" 15 60 2 \
  "true" "" ON \
  "false" "" OFF 3>&1 1>&2 2>&3)
  update_json '.reverseWs.enable = '"$reverse_ws_enable"''

  if [ "$reverse_ws_enable" = "true" ]; then
      reverse_ws_urls=$(whiptail --inputbox "请输入反向 ws URLs (comma separated):" 8 78 --title "反向 ws 设置" 3>&1 1>&2 2>&3)
      IFS=',' read -r -a reverse_ws_urls_array <<< "$reverse_ws_urls"
      reverse_ws_urls_json=$(printf '%s\n' "${reverse_ws_urls_array[@]}" | jq -R . | jq -s .)
      update_json '.reverseWs.urls = '"$reverse_ws_urls_json"''
  fi


  # WebSocket 设置
  ws_enable=$(whiptail --title "WebSocket 设置" --radiolist "启用 WebSocket?" 15 60 2 \
  "true" "" OFF \
  "false" "" ON 3>&1 1>&2 2>&3)
  update_json '.ws.enable = '"$ws_enable"''

  if [ "$ws_enable" = "true" ]; then
      ws_host=$(whiptail --inputbox "请输入 WebSocket host:" 8 39 --title "WebSocket 设置" 3>&1 1>&2 2>&3)
      update_json '.ws.host = "'"$ws_host"'"'

      ws_port=$(whiptail --inputbox "请输入 WebSocket 端口:" 8 39 --title "WebSocket 设置" 3>&1 1>&2 2>&3)
      update_json '.ws.port = '"$ws_port"''
  fi

  # HTTP 设置
  http_enable=$(whiptail --title "HTTP 设置" --radiolist "启用 HTTP?" 15 60 2 \
  "true" "" OFF \
  "false" "" ON 3>&1 1>&2 2>&3)
  update_json '.http.enable = '"$http_enable"''

  if [ "$http_enable" = "true" ]; then
      http_host=$(whiptail --inputbox "请输入 HTTP host:" 8 39 --title "HTTP 设置" 3>&1 1>&2 2>&3)
      update_json '.http.host = "'"$http_host"'"'

      http_port=$(whiptail --inputbox "请输入 HTTP 端口:" 8 39 --title "HTTP 设置" 3>&1 1>&2 2>&3)
      update_json '.http.port = '"$http_port"''

      http_secret=$(whiptail --inputbox "请输入 HTTP secret:" 8 39 --title "HTTP 设置" 3>&1 1>&2 2>&3)
      update_json '.http.secret = "'"$http_secret"'"'

      http_enable_heart=$(whiptail --title "HTTP 设置" --radiolist "启用 HTTP 心跳?" 15 60 2 \
      "true" "" ON \
      "false" "" OFF 3>&1 1>&2 2>&3)
      update_json '.http.enableHeart = '"$http_enable_heart"''

      http_enable_post=$(whiptail --title "HTTP 设置" --radiolist "启用 HTTP 消息上报?" 15 60 2 \
      "true" "" ON \
      "false" "" OFF 3>&1 1>&2 2>&3)
      update_json '.http.enablePost = '"$http_enable_post"''

      http_post_urls=$(whiptail --inputbox "请输入 HTTP post URLs (comma separated):" 8 78 --title "HTTP 设置" 3>&1 1>&2 2>&3)
      IFS=',' read -r -a http_post_urls_array <<< "$http_post_urls"
      http_post_urls_json=$(printf '%s\n' "${http_post_urls_array[@]}" | jq -R . | jq -s .)
      update_json '.http.postUrls = '"$http_post_urls_json"''
  fi

  advanced_setting=$(whiptail --title "高级设置" --radiolist "高级设置" 15 60 2 \
  "true" "" OFF \
  "false" "" ON 3>&1 1>&2 2>&3)

  if [ "$advanced_setting" = "true" ]; then
      # GroupLocalTime 设置
      group_local_time_record=$(whiptail --title "Group Local Time 设置" --radiolist "Record Group Local Time?" 15 60 2 \
      "true" "" ON \
      "false" "" OFF 3>&1 1>&2 2>&3)
      update_json '.GroupLocalTime.Record = '"$group_local_time_record"''

      # Other 设置
      debug=$(whiptail --title "Debug 设置" --radiolist "Enable Debug?" 15 60 2 \
      "true" "" ON \
      "false" "" OFF 3>&1 1>&2 2>&3)
      update_json '.debug = '"$debug"''

      heart_interval=$(whiptail --inputbox "请输入心跳间隔 (ms):" 8 39 --title "其他设置" 3>&1 1>&2 2>&3)
      update_json '.heartInterval = '"$heart_interval"''

      message_post_format=$(whiptail --title "消息上报格式" --radiolist "消息上报格式" 15 60 2 \
      "array" "" ON \
      "object" "" OFF 3>&1 1>&2 2>&3)
      update_json '.messagePostFormat = "'"$message_post_format"'"'

      enable_local_file2url=$(whiptail --title "本地文件转Url" --radiolist "启用本地文件转Url?" 15 60 2 \
      "true" "" ON \
      "false" "" OFF 3>&1 1>&2 2>&3)
      update_json '.enableLocalFile2Url = '"$enable_local_file2url"''

      music_sign_url=$(whiptail --inputbox "音乐签名url:" 8 39 --title "其他设置" 3>&1 1>&2 2>&3)
      update_json '.musicSignUrl = "'"$music_sign_url"'"'

      report_self_message=$(whiptail --title "上报自身消息" --radiolist "上报自身消息?" 15 60 2 \
      "true" "" ON \
      "false" "" OFF 3>&1 1>&2 2>&3)
      update_json '.reportSelfMessage = '"$report_self_message"''

      token=$(whiptail --inputbox "请输入Token:" 8 39 --title "其他设置" 3>&1 1>&2 2>&3)
      update_json '.token = "'"$token"'"'
  fi

  # Output the final JSON to the user
  cat $temp_file | echo > /root/NapCat.linux.arm64/config/onebot11_$ACCOUNT.json
  rm $temp_file
  cd /root/NapCat.linux.arm64 && ./napcat.sh -q $ACCOUNT
fi


}
main