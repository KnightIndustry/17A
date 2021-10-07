#!/usr/bin/env python
# -*- coding: utf-8 -*-

import requests
import json
import sys
import os
import datetime

webhook="https://oapi.dingtalk.com/robot/send?access_token=527a2a9f035d5e027766c4e1cad47fe58189a3aa55d56539934a80bfbeecd343"
user=sys.argv[1]
text=sys.argv[3]
data={
    "msgtype": "text",
    "text": {
        "content": text
    },
    "at": {
        "atMobiles": [
            user
        ],
        "isAtAll": False
    }
}
headers = {'Content-Type': 'application/json'}
x=requests.post(url=webhook,data=json.dumps(data),headers=headers)
if os.path.exists("/var/log/dingtalk.log"):
    f=open("/var/log/dingtalk.log","a+")
else:
    f=open("/var/log/dingtalk.log","w+")
f.write("\n"+"--"*30)
if x.json()["errcode"] == 0:
    f.write("\n"+str(datetime.datetime.now())+"    "+str(user)+"    "+"发送成功"+"\n"+str(text))
    f.close()
else:
    f.write("\n"+str(datetime.datetime.now()) + "    " + str(user) + "    " + "发送失败" + "\n" + str(text))
    f.close()


