# voctocore-docker
## (re)build
```bash
docker tag bjoernr/voctocore:latest bjoernr/voctocore:old
docker build -t bjoernr/voctocore ./voctocore-docker \
&& docker rmi bjoernr/voctocore:old
```

## run
```shell
docker run -it --rm -v /some/dir:/video \
	-p 9999:9999 -p 10000:10000 -p 10001:10001 -p 10002:10002 -p 11000:11000 -p 12000:12000 \
	-p 13000:13000 -p 13001:13001 -p 13002:13002 -p 14000:14000 -p 15000:15000 -p 16000:16000 \
	-p 17000:17000 -p 17001:17001 -p 17002:17002 -p 18000:18000 --name=voctocore bjoernr/voctocore
```
