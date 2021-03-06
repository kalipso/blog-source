---
title: Github Page에 Hexo 블로그 만들기
date: 2017-11-08 17:02:10
categories:
 - Application
 - Hexo
tags:
 - hexo
 - 블로그 만들기
 - github
thumbnail:
---

## 프롤로그

올해 여름, 11개월 프로젝트를 마치고 나와서 오랜만에 티스토리 블로그를 접속했더니 접속이 되지 않았습니다.

다음 고객센터를 페이지를 통해서 티스토리 담당자랑 한참 실갱이를 했는데, 누군가 해킹을 해서 내 블로그와 글을 모두 삭제하였고, 해당 블로그는 결국 살릴 수 없다고 합니다. 쿠궁 ㅠㅠ

가끔씩 써오기는 했지만 나름 10년을 써왔던 블로그인데 한순간에 날아가버린 거죠.. 이렇게 허무할 수가..

눈물을 머금고 블로그 선택에 대한 포스팅([내 글을 오래 남기기 위한 블로그 선택](http://blog.kalkin7.com/2015/07/07/maintain-a-blog-for-a-long-time/))들을 찾아보다가 GitHub Page에서 Hexo를 이용해 블로그를 구축하는 방법을 선택하였는데, 선택의 주된 이유를 정리해보면 이렇습니다.
+ 변경 자유도가 높다.
+ 보안 및 컨텐츠 유실로부터 비교적 안전하다. 
  + web환경에서 로그인 및 권한획득 과정이 없음. 
  + 기본적으로 PC에서 소스를 관리함. 
  + GitHub를 통해 버전 관리가 가능함. 
+ 모든 기능을 제한없이 무료로 사용할 수 있다. 
+ Jekyll과 Hexo를 비교한 결과, Hexo가 더 예쁘다.


![](https://farm5.staticflickr.com/4573/38204775206_4a6d29f021_m.jpg)
 > A fast, simple & powerful blog framework

약간의 삽질을 통해 Hexo 블로그를 만들게 되었는데, 그 과정을 아래에 기록합니다.

## # GitHub으로 정적 페이지 생성하기

GitHub에서는 Repository를 생성하여 정적 페이지를 서비스할 수 있는 기능을 제공합니다.

#### 1. Repository 생성 

GitHub에서 "New Repository" 선택 후 Repository Name, Description 등 입력하고 Repository을 생성합니다.

![](http://farm5.staticflickr.com/4562/24387340028_fc8d18364f_b.jpg) 

※ Add License 등 옵션은 선택하지 않음

#### 2. Clone then Repository

```bash
#1. Repository를 "pub"저장소로 clone
d:\blog> git clone https://github.com/username/username.github.io.git pub
Cloning into 'pub'...
warning: You appear to have cloned an empty repository.
```

#### 3. Hello world 서비스 테스트

```bash
#2. index.html 생성
d:\blog> cd pub
d:\blog\pub> echo "Hello World" > index.html

#. Remote 저장소에 변경내역 Push
d:\blog\pub> git add --all
d:\blog\pub> git commit -m "Initial commit"
d:\blog\pub> git push -u origin maser
```

#### 4. 접속확인

페이지 접속 확인 브라우저에서 Repository name으로 접속하여 접속 확인
※ 위에서 pub 폴더는 서비스용이 아니고 테스트 용도입니다.

## # Hexo 설치

#### 1. 사전설치
설치 전 준비 Hexo를 이용하기 위해서는 다음 구성요소들이 사전에 설치되어 있어야 합니다.
 - [Node.js](https://nodejs.org/en/) 
 - [Git](https://git-scm.com/)

#### 2. Hexo Client 및 저장소 설정
npm을 이용하여 Hexo Client를 설치하고 저장소를 설정합니다.

```bash
#1. hexo client 설치
D:\blog> npm install hexo-cli-g

#2. hexo 저장소 생성 및 설치
D:\blog> hexo init src
D:\blog> cd src
D:\blog\src> npm install
```

#### 3. _config.yml 파일 설정

hexo의 기본정보를 셋팅합니다. "Plugins"의 첫번째 문자가 대문자임에 유의하세요. (~~저처럼 3일 동안 삽질할 수 있습니다~~)

```yml
# Site
# language를 ko로 만들면 Home > 홈으로 나오는 등의 부작용
title: 낭만디비술사
subtitle:
description:
author: kalipso
language: en
timezone: Asia/Seoul

... 중략 ...

## Plugins: https://hexo.io/plugins/
Plugins:
- hexo-deployer-git

... 중략 ...

# Deployment
## Docs: https://hexo.io/docs/deployment.html
deploy:
  type: git
  repo: https://github.com/username/username.github.io.git
```

#### 4. Hexo 로컬 서버에서 확인
로컬 서버를 만들고 확인할 수 있습니다. 기본적으로 로컬 페이지는 포트 4000입니다.
```bash
# server 설치
D:\blog\src>npm install hexo-server --save

# 서버 구동
D:\blog\src>hexo server

```
   http://localhost:4000 에서 확인 가능

#### 5. GitHub에 Deploy
아래에서 hexo-deployer-git은 _config.yml에 정의되어 있기 때문에, server를 구동하기 전에 먼저 설치되어야 합니다. 
아래 명령을 통해 간단하게 Github에 Deploy할 수 있습니다.
```
# deployer 설치
D:\blog\src>npm install hexo-deployer-git --save

# generate 및 github-deploy
D:\blog\src>hexo deploy --generate
```
   http://username.github.io 에 deploy 완료. 


## # Theme 적용하기
https://hexo.io/themes/ 에 접속해서 Hexo에서 사용할 수 있는 여러가지 Theme를 확인하고 선택할 수 있습니다. 
저는 많은 블로그들이 사용하고 있는 hueman(https://github.com/ppoffice/hexo-theme-hueman/wiki/Installation) 을 사용했습니다. (중국어로 된 테마도 많은데, 언어 문제로 포기..)

대부분의 Theme가 sample 페이지와 Installation 문서를 포함한 Github 페이지를 제공하고 있기 때문에 설치가 어렵지 않습니다. 
다만, 로컬에서 Server 재시작에도 변경사항이 제대로 반영되지 않을때, clean 명령을 통해 저장소를 초기화할 수 있습니다.

```bash
D:\blog\src> hexo clean
D:\blog\src> hexo server

```

## # 백업 설정
Jekyll과 달리 Hexo는 각 변경사항이 모두 Git으로 버전관리가 되지 않기 때문에, 유실에 대비하여 GitHub에 Repository(https://github.com/username/blog-source.git) 를 만들고 관리하는 것으로 설정하였다.

## 1. Hexo 저장소 git에 관리
```bash
# git 저장소로 만들고 커밋
D:\blog\src> git init
D:\blog\src> git add --all
D:\blog\src> git commit -m "initial commit"
D:\blog\src> git remote add origin https://github.com/username/blog-source.git
D:\blog\src> git push origin master

```

## 2. 배치파일 생성
반영시마다 Hexo 저장소를 commit하고 반영하는 배치파일 생성
```bash
# hexoCommit.bat 파일 생성

D:\blog\src> copy con hexoCommit.bat
cd D:\blog\src
git add --all
git commit -m "블로그 소스 반영(%date%)"
git push -u origin master
hexo deploy --generate

# Ctrl + Z (저장)
```

## 참고
----
- Github Pages와 Hexo를 통해 30분만에 기술 블로그 만들기(https://www.holaxprogramming.com/2017/04/16/github-page-and-hexo/)
- 워드프레스보다 쉬운 Hexo 블로그 시작하기(http://futurecreator.github.io/2016/06/14/get-started-with-hexo/)
