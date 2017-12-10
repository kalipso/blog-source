---
title: Scala-IDE에서 Spark 셋팅과 WordCount
categories:
  - Application
  - Spark
tags:
  - Spark
  - Scala IDE
  - WordCount
  - Scala
thumbnail: https://farm5.staticflickr.com/4582/37805855144_391f390b07_o.png
---



Apache Spark는 하둡 기반의 데이터 처리 프레임워크인 Map-Reduce가 가진 단점들을 보완하기 위하여 2009년 UC Berkeley 대학의 연구로 시작되어 2012년 미국 NSDI 학회에서 RDD(Resilient Distributed Dataset) 논문이 발표되면서 알려진 기술입니다. 

스파크는 하둡과 달리 <u>메모리를 이용한 데이터 저장 방식</u>을 제공함으로써 머신러닝 등 반복적인 데이터 처리가 필요한 분야에서 높은 성능을 보여줍니다. 또한 강력한 데이터 처리 함수를 제공하여 프로그램의 복잡도를 크게 낮춰줍니다. 

2016년 11월 Spark 2.0 버전이 출시되었는데, 이는 Spark 1.x 보다 10배 정도 향상된 처리 속도를 보여준다고 합니다. 또한 Java, Scala, Python 뿐 아니라 분석 환경에서 많이 사용되고 있는 R스크립트를 이용해서도 Application을 작성할 수 있게 되었습니다.

조대협 님의 블로그에 《[Apache Spark이 왜 인기가 있을까?](http://bcho.tistory.com/1023?category=563141)》라는 포스팅이 있는데, Spark를 이해하는데 도움이 될 것 같네요. 



 ## # Spark 개발환경 셋팅

의외로 친절하게 정리된 글이 없어서 Spark의 개발환경을 잡는 일이 쉽지 않았는데, [한 외국 블로거의 글](http://www.devinline.com/2016/01/apache-spark-setup-in-eclipse-scala-ide.html)을 따라하고 성공했습니다. Scala-IDE에서 개발환경을 잡고 Spark의 "Hello World"이라 할 수 있는 WordCount를 실행해보도록 하겠습니다.

#### 1. Scala IDE 다운로드

 Scala IDE는 Scala, 혹은 Scala-Java 혼합 Application의 개발환경을 제공하는 eclipse project입니다. http://scala-ide.org 를 방문하여 IDE를 Download하고 install합니다. 2017년 11월 현재 최신 Release는 4.7.0네요.

![Scala IDE for eclipse](https://farm5.staticflickr.com/4537/37710863985_e2588309b4.jpg)

압축을 풀고 설치를 마무리한 후, eclipse를 엽니다.



> 이유는 알 수 없으나 eclipse가 간혹 An error has occurred. See the log file
> C:\dev\workspace\scala\.metadata\.log. 라는 에러 메시지를 뱉습니다. 로그를 확인해보면 <u>java.lang.AssertionError: assertion failed</u>라는 에러가 보이는데, workspace의 \.metadata\.plugins\org.eclipse.e4.workbench\workbench.xmi 파일을 삭제하면 해결됩니다.



#### 2. maven project 생성

