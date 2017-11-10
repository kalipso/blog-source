---
title: ［Scala 기초］ Scala로 구구단 만들기
categories:
  - Application
  - Scala
tags:
  - scala 기초
  - 함수형 프로그래밍
  - 구구단
date: 2017-11-10 14:18:44
thumbnail: https://farm5.staticflickr.com/4528/37586906734_a6a87636f3_m.jpg
---

프로젝트에서 사용할 수 있다는 이유 때문에 최근 Scala를 공부하고 있습니다. 

지금까지 써본 개발 언어는 ASP, PHP 같은 스크립트 언어(~~나이가 탄로나나요.. 쿨럭~~), 비교적 최근에 썼던 언어로는 Java, Python과 Javascript 등이 있습니다만, 객체지향의 특징과 함수 지향의 특징을 가지고 있는 Scala는 또 매우 새롭더군요. 

간단한 예제를 통해서 Scala의 특징을 짚어보고자 합니다. Scala를 창시한 마틴 오더스키가 직접 쓴 "Programming in Scala 3/e"로 공부하는 중인데, 아래 내용은 대략 1~7장까지의 내용을 나름대로 정리한 것으로 보면 되겠습니다



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

![함수의 형태](https://farm5.staticflickr.com/4564/38297482051_b2b9c07b18_z.jpg)

- 기본적인 구조는 위와 같이 구구단 소스 1 line과 같이 def + 함수명 + 파라미터 목록 + 함수 결과 타입 + 등호(=) + 중괄호({})안에 본문입니다.
- Result type은 생략할 수 있으나, 함수가 재귀적으로 정의되어 있을 경우에는 반드시 명시해야 합니다. 값의 반환이 없는 함수는 Result Type이 Unit이며, 이는 Java의 void와 같습니다. 
- 함수 본문에 return이 없는데, scala는 return을 사용하지 않아도 맨 나중에 계산한 값을 반환합니다.
- scala에서 **함수는 1급 계층(first class) 값**입니다. 즉, 함수는 문자열과 동일한 자격을 갖는 값으로 함수를 다른 함수에 인자로 넘길 수 있고, 함수 안에서 결과로 함수를 반환할 수도 있고, 함수를 변수에 저장할 수도 있습니다. 
- 다음과 같이 함수 리터럴을 사용하기도 합니다.

```scala
/* String 배열을 출력 */
//#1. 함수 리터럴을 사용하는 경우
args.foreach(arg => println(arg))

//#2. 함수 리터럴에서 인자의 타입을 명시적으로 표현
args.foreach((arg: String) => println(arg))

//#3. 함수 리터럴이 인자를 하나만 받는 경우 해당 인자를 생략 가능
args.foreach(println)

```



#### 2. 변수의 정의

- 2번째 라인 `val result = "~"` 구문은 변수에 값을 할당하는 부분입니다.
- 스칼라에는 val, var의 두 종류 변수가 있습니다. 
- val은 Java의 final 변수와 비슷하고 일단 초기화하고 나면 값을 다시 할당할 수 없습니다.
- 위와 같이 String은 + 연산자로 이어붙일 수 있습니다.
- var 대신 val을 사용하는 것이 코드를 더 가독성 높고 리팩토링 하기 쉽게 해준다(by 마틴 오더스키)




#### 3. 문자열 인터폴레이션

- 3번째 라인 `s"$dan ..."`구문은 문자열 인터폴레이션입니다.

-  문자열을 시작하는 따옴표 직전에 **s**라는 문자가 오는 경우 scala는 해당 리터럴을 처리하기 위해 **s 문자열 인터폴레이션**을 사용합니다.

- s 인터폴레이터는 내장된 각 표현식을 평가하고, 각 결과에 대해 toString을 호출한 다음 내장된 표현식을 toString의 결과로 대치해줍니다.

- `${6 * 7}`과 같이 `$` 뒤에 원하는 표현식을 사용할 수 있습니다.

- scala는 s 인터폴레이터 외에 raw 인터폴레이터, f 인터폴레이터를 제공합니다.

  ```scala
  println(raw"No\\\\escape")
  //--> 출력 : No\\\\escape!

  val pi = "Pi"
  println(f"$pi is approximately ${math.Pi}%.8f")
  //--> 출력 : Pi is approximately 3.14159265.
  ```

  ​

#### 4. if 구문

- 12라인은 if 구문과 문자열을 +로 이어붙이는 구문입니다.
- scala의 제어 구문은 대부분 어떤 값을 내놓으며, if 문도 마찬가지입니다.
- C, C++, Java의 삼항연산자(?:)와 같이 삼항 연산자 모델을 채용하되, 삼항 연산자와 if를 합쳐서 if 구문으로만 사용합니다.




#### 5. for 표현식

- 7~13 라인의 `for {} yield {}`는 for 표현식입니다.

- scala에서는 <u>제너레이터</u>라고 부르는 문법(`file <- fileCollection`와 같은 형태)을 이용해 컬렉션을 이터레이션합니다. 

- for 표현식에서는 이터레이션 구문 뒤에 if절을 넣어서 filter를 추가(다중 if도 가능)할 수 있습니다. 

  ```scala
  for(
    file <- fileCollection
    if file.isFile
    if file.getName.endsWith(".scala")
  ) println(file)
  ```

- 여러 개의 제너레이터를 사용하면 for문은 중첩 이터레이션을 수행 합니다.

- 괄호 대신 중괄호를 사용해 제너레이터와 필터를 감싸도 동일하게 사용 가능합니다.

- `for (이터레이션) yield {본문}` 표현식을 사용하여 본문의 값을 배열로 반환할 수 있습니다.




#### 6. toString, mkString

- 2라인의 `toString` 연산자는 해당 객체에 대한 표준 문자열 표현을 반환합니다.
- 다른 표현을 원한다면 `mkString` 메소드를 사용할 수 있습니다. 15라인의 `배열.mkString("\n")`은 배열의 각 원소를 개행문자로 연결하여 반환합니다.




### 참고문헌

Programming in Scala 3/e Updated for Scala 2.12 (2017, 에이콘 출판사)