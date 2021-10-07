

proxy_set_header Host $host;
proxy_set_header X-Real-IP $remote_addr;
#proxy_set_header X-Forwarded-For$proxy_add_x_forwarded_for;
set $realip "";
        if (sproxy_add_x_forwarded_for ~ "^([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)") { set $realip $1; }
        if (sproxy_add_x_forwarded_for = '^([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)") { set $realip $http_x_forwarded_for; }
proxy_set_header   X-Forwarded-For   $realip;
proxy_set_header   Connection "";
proxy_http_version. 1.1;
proxy_next_upstream error timeout invalid_header http_500 http_503 http"502 http_504;
proxy_ignore_headers X-Accel-Expires Expires Cache-Control Set-Cookie;
add_header X-Frame-Options SAMEORIGIN;
add_header Access-Control-Allow-Origin*;
add header Access-Control-Allow-Headers×-Requested-With,authToken;
add header Access-Control-Allow-Methods GET, PUT, DELETE, POST, OPTIONS;
**&**#R#
#add header X-Content-Type-Options nosniff； # 葵止噢探文件类型
#ia trace ID
set straceld"";
if (shttp_eagleeye_traceid~"^([a-zA-Z0-9]+)")(set $traceld $1;)
if (shttp_eagleeye_traceid='"'") ( set $traceld $request_id;)
proxy_set_header X-Request-Id straceld;
[root@AUJMNGINX010187 conf]#
ssh://kyyang@10.66.11.188-22
uppo-con
sCei
mime.types.default proxy-apptest.conf. proxy-k8s-noFrase.conf-upstr
nginx.conf
proxy.conf
nginx.conf.default proxyfile.comf
proxy-nofrane.conf
× forwarded for;)