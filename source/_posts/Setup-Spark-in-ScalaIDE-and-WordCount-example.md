---
title: Scala-IDE에서 Spark 셋팅과 WordCount
categories:
  - Application
  - Spark
tags:
  - Spark 개발환경 구성
  - Scala IDE
  - WordCount
  - Scala
thumbnail: 'https://farm5.staticflickr.com/4582/37805855144_391f390b07_o.png'
date: 2018-01-04 23:45:05
---




 ## # Spark 개발환경 셋팅

의외로 친절하게 정리된 글이 없어서 Window 10 환경에서 Spark의 개발환경을 잡는 일이 쉽지 않았는데, [한 외국 블로거의 글](http://www.devinline.com/2016/01/apache-spark-setup-in-eclipse-scala-ide.html)을 따라하고 성공했습니다. Scala-IDE로 개발환경을 잡고 Spark의 "Hello World"이라 할 수 있는 WordCount를 실행해보도록 하겠습니다.

> Apache Spark는 하둡 기반의 데이터 처리 프레임워크인 Map-Reduce가 가진 단점들을 보완하기 위하여 2009년 UC Berkeley 대학의 연구로 시작되어 2012년 미국 NSDI 학회에서 RDD(Resilient Distributed Dataset) 논문이 발표되면서 알려진 기술입니다. 
>
> 스파크는 하둡과 달리 <u>메모리를 이용한 데이터 저장 방식</u>을 제공함으로써 머신러닝 등 반복적인 데이터 처리가 필요한 분야에서 높은 성능을 보여줍니다. 또한 강력한 데이터 처리 함수를 제공하여 프로그램의 복잡도를 크게 낮춰줍니다. 
>
> 2016년 11월 Spark 2.0 버전이 출시되었는데, 이는 Spark 1.x 보다 10배 정도 향상된 처리 속도를 보여준다고 합니다. 또한 Java, Scala, Python 뿐 아니라 분석 환경에서 많이 사용되고 있는 R스크립트를 이용해서도 Application을 작성할 수 있게 되었습니다.

#### 1. Scala IDE 다운로드

 Scala IDE는 Scala, 혹은 Scala-Java 혼합 Application의 개발환경을 제공하는 eclipse project입니다. http://scala-ide.org 를 방문하여 IDE를 Download하고 install합니다. 2017년 11월 현재 최신 Release는 4.7.0(이 글을 마무리하게 된 시기는 2018년 1월입니다만 버전은 동일합니다)네요.

![Scala IDE for eclipse](https://farm5.staticflickr.com/4537/37710863985_e2588309b4.jpg)



압축을 풀고 설치를 마무리한 후, eclipse를 엽니다. 



> 이유는 알 수 없으나 eclipse가 간혹 An error has occurred. See the log file
> C:\dev\workspace\scala\.metadata\.log. 라는 에러 메시지를 뱉습니다. 로그를 확인해보면 <u>java.lang.AssertionError: assertion failed</u>라는 에러가 보이는데, workspace의 \.metadata\.plugins\org.eclipse.e4.workbench\workbench.xmi 파일을 삭제하면 해결됩니다.



#### 2. maven project 생성

Maven은 가장 인기있는 Library 관리 및 빌드 툴 중 하나입니다. 이 예제에서는 Maven을 통해 프로젝트를 생성합니다. 

1. **File -> New -> Project -> Maven Project**를 선택하여 프로젝트를 생성합니다.  예제에서는 Group Id는 io.github.kalipso.spark로, Artifact Id는 Spark Sample로 지정하였습니다. 

   ​

   ![](https://farm5.staticflickr.com/4551/37710863595_00d6c6dbb0_z.jpg)

   ​

   ![](https://farm5.staticflickr.com/4547/38599065561_c278aa5350_z.jpg)

   ​

2. [pom.xml Sample](https://drive.google.com/file/d/15_QoyH0YIG5UKzSpbPqsWQzC-3LGDPIf/view?usp=sharing) 을 다운로드하고 SparkSample 프로젝트 Root에 위치한 pom.xml을 수정합니다. 

3. Project에서 오른쪽 마우스 버튼을 클릭, **Configure -> Add Scala Nature** 을 선택하여 Scala Nature를 추가합니다. 

4. Spark를 위한 Scala Compiler를 선택합니다. Scala IDE는 기본적으로  `Lastest 2.12 bundle (dynamic)`을 사용하고 있으나 Spark는 2.10을 사용하기 때문에,  Compiler를 변경해주어야 합니다. 
   Project에서 오른쪽 마우스 버튼을 클릭, **Properties -> Scala compiler**에서 `Fixed Scala Installation: 2.10.6 (built-in) ` 을 선택합니다. 

   ​

   ![](https://farm5.staticflickr.com/4635/24629943397_4586f00db1_z.jpg)

   ​

5. Source 폴더를 **src/main/java**에서 **src/main/scala**로 변경합니다.  해당 폴더에서 오른쪽 마우스 버튼 클릭 -> Refactor -> Rename을 선택하여  scaca로 변경합니다.

   > project에 에러표시가 있다면 Project 오른쪽 마우스버튼 클릭 -> Maven -> Update Project를 선택하여 해당 프로젝트의 Maven Update를 수행하면 필요한 라이브러리 다운로드 및 빌드를 통해 에러가 없어집니다. 



#### 3. WordCount 프로그램

1. src/main/scala 밑에 패키지를 생성하고, scala Object를 생성합니다. 

   ​

   ![](https://farm5.staticflickr.com/4638/39497161721_e7df408a36.jpg)

   ​

   ![](https://farm5.staticflickr.com/4684/39497161701_0a380ec2bf.jpg)

   ​

2. WordCount.scala를 아래와 같이 구성합니다.

   ```scala
   package io.github.kalipso.spark

   import org.apache.spark.SparkConf
   import org.apache.spark.SparkContext
   import org.apache.spark.rdd.RDD.rddToPairRDDFunctions

   object WordCount {
     def main(args: Array[String]) = {

       //Start the Spark context
       val conf = new SparkConf()
         .setAppName("WordCount")
         .setMaster("local")
       val sc = new SparkContext(conf)

       //Read some example file to a test RDD
       val test = sc.textFile("src/main/shakespeare.txt")

       test.flatMap { line => //for each line
         line.split(" ") //split the line in word by word.
       }
         .map { word => //for each word
           (word, 1) //Return a key/value tuple, with the word as key and 1 as value
         }
         .reduceByKey(_ + _) //Sum all of the value with same key
         .saveAsTextFile("output.txt") //Save to a text file

       //Stop the Spark context
       sc.stop
     }
   }
   ```

   ​

3. [Text Sample](https://drive.google.com/file/d/1Mfxp1R3TtJzAnjIb3Ix_Corl0YSeOaI_/view?usp=sharing)을 다운받아서 위에서 지정한 것처럼 src/main 하단에 복사합니다.  

4. WordCount 프로그램을 동작합니다. WordCount.scala 오른쪽 마우스 버튼 클릭 -> Run as -> Scala Application을 선택하여 동작시킬 수 있습니다. 



위 소스의 대략적인 로직을 그림으로 표현해보면 아래와 같습니다.

![](https://farm5.staticflickr.com/4688/24630076017_15143cd250_o.png)



정상적인 상황이라면, 프로그램은 output.txt라는 Directory 안에 아래와 같은 2개의 파일을 만들겁니다.

- SUCCESS
- part-00000

part-00000 안에는 다음과 같은 결과들이 저장됩니다. 

(fartuous,1)
(hem,1)
(meets,,1)
(toll,,1)
(melody?,1)
(it!-,3)
(tough,6)
(briefly,,7)



이상 Window 10 환경에서의 Spark 개발환경 구성 및 WordCount 예제를 살펴보았습니다~



## 참고

- [Setup Apache Spark in eclipse(Scala IDE) : Word count example using Apache spark in Scala IDE](http://www.devinline.com/2016/01/apache-spark-setup-in-eclipse-scala-ide.html)





