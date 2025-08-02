# Spin component in MoonBit

This example is based on this blog post: https://www.moonbitlang.com/blog/component-model
and this GitHub example: https://github.com/moonbitlang/moonbit-docs/tree/464356567270284446244cccecd101c04e9806f8/examples/wasi-http

In one terminal window, start up the app:

```shell
$ spin build --up
```

Then in another terminal window, get the results:

```shell
$ curl -i localhost:3000/outbound-http
HTTP/1.1 200 OK
content-type: application/json
transfer-encoding: chunked
date: Fri, 16 Aug 2024 21:42:38 GMT

{"timestamp":1723844558854,"fact":"Water slows down light"}
```

To test the `consume` and `stream` endpoints, start up a python server in
another terminal window in the root directory of this repo:

```shell
$ cd .. && python3 -m http.server 8080
```

Then use `curl` to test the endpoint:

```shell
$ curl -X POST http://localhost:3000/consume -d 'http://localhost:8080/LICENSE'
OK

$ curl -X POST http://localhost:3000/consume?md5sum -d 'http://localhost:8080/LICENSE'
f18f58e5cd844650215c76d1071a5b09

$ curl -X POST http://localhost:3000/consume?sha256sum -d 'http://localhost:8080/LICENSE'
fea26e329e7dd773fbee25b903a6fcdd6a38d689f7983b62592cbd470a004450

$ curl -X POST http://localhost:3000/stream -d 'http://localhost:8080/LICENSE' | wc
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 11384  100 11355  100    29  2620k   6852 --:--:-- --:--:-- --:--:-- 2779k
     201    1581   11355

$ curl -X POST http://localhost:3000/stream?md5sum -d 'http://localhost:8080/LICENSE' | wc
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 11384  100 11355  100    29  2082k   5444 --:--:-- --:--:-- --:--:-- 2223k
     201    1581   11355

$ curl -X POST http://localhost:3000/stream?sha256sum -d 'http://localhost:8080/LICENSE' | wc
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 11384  100 11355  100    29  1922k   5028 --:--:-- --:--:-- --:--:-- 2223k
     201    1581   11355
```

View the `spin` stderr output:

```shell
Serving http://127.0.0.1:3000
Available Routes:
  outbound-http: http://127.0.0.1:3000 (wildcard)
...
INFO: Performing GET 'http://localhost:8080/LICENSE'
INFO: Status code = 200
INFO: Header['server'] = 'SimpleHTTP/0.6 Python/3.13.5'
INFO: Header['date'] = 'Sat, 02 Aug 2025 17:00:46 GMT'
INFO: Header['content-type'] = 'application/octet-stream'
INFO: Header['content-length'] = '11355'
INFO: Header['last-modified'] = 'Fri, 24 Jan 2025 02:55:57 GMT'
INFO: Streamed 11355 bytes from 'GET http://localhost:8080/LICENSE', sha256sum = fea26e329e7dd773fbee25b903a6fcdd6a38d689f7983b62592cbd470a004450
```
