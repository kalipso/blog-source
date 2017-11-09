---
title: Scala로 구구단 만들기
categories:
 - Application
 - Scala
tags:
 - scala
 - 함수형 프로그래밍
 - 구구단
---

최근 프로젝트에서 사용할 수 있다는 이유 때문에 Scala를 공부하고 있습니다. 지금까지 써본 개발 언어는 ASP, PHP 같은 스크립트 언어(~~나이가 추측되실지도 쿨럭~~), 비교적 최근에 썼던 언어로는 Java, Python과 Javascript 등이 있습니다만, 객체지향의 특징과 함수 지향의 특징을 가지고 있는 Scala는 또 매우 새롭더군요. 

간단한 예제를 통해서 Scala의 특징을 짚어보고자 합니다.

### 구구단 프로그램

아래는 IntelliJ의 Scala WorkSheet에서 작성해본 구구단 출력 프로그램 소스입니다.

```scala
def makeRow(dan: Int, num: Int) : String = {
  val result = " "* (2 - (dan * num).toString.length) + (dan * num).toString
  s"$dan × $num = $result"
}

def makeMultiTable() = {
  val rowTable = for {
    i <- 1 to 9
    if (i != 1);
    j <- 1 to 9
  } yield {
    (if(j == 1) s"\n[$i 단]\n" else "") + makeRow(i, j)
  }

  rowTable.mkString("\n")
}

println(makeMultiTable)
```

#### 1. 함수의 정의

