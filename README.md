# JsutGram.Docker

### Git First Push.

Use the package manager [Docker](https://www.docker.com) to install foobar.

```bash
echo "# justgram.docker" >> README.md
git init
git add README.md
git commit -m "first commit"
git remote add origin https://github.com/psmever/justgram.docker.git
git push -u origin master
```

## Git Clone.

```bash
git clone https://github.com/psmever/justgram.docker.git
```

## config
```bash
.env
.laravel_env
```

## Docker Build
```bash
docker-compose build --force-rm
docker-compose up -d
```

## Docker Command
```bash
// 빌드
docker-compose build --force-rm

// 이미지 초기화
docker system prune -a

// 컨테이너 접속
docker-compose exec api /bin/bash

docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
docker kill $(docker ps -q)
docker rm $(docker ps -a -q)
docker rm $(docker ps -a -q)

```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
