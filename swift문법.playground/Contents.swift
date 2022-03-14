import UIKit


/*번수와 상수 선언*/
//1.1 상수
let name: String = "uni"
let swift = "swift"

//1.2 변수
var year : Int = 2022
var y = 2022

year = 2023
//print(year) //var은 변수라 값 변경가능

/*2. 함수만들기*/
func sum(a: Int, b: Int) -> Int{
    return a+b
}

//print(sum(a: 1, b: 2))

func multiply(a: Int, b: Int) -> Int {
    a * b  //리턴 생략 가능
}

//print(multiply(a: 1, b: 2))

/* 3. 이름짓는 규칙*/
// 3.1 Lower Canel Case - 인스턴스 / 매소드 / 함수
// - 시작은 소무자 나머지 단어의 시작은 대문자
let viewContriller = UIViewController() //인스턴스를 생성

// 3.2 Upper Canel Case - 구조 / 클래스 / 프로토콜
// - 시작과 나머지 단어도 모두 대문자
struct Person{
    let a:Int
    let b:Int
} //구조체(스트럭쳐의 축약 struct사용) 'P'erson 시작을 대문자로 시작

class Operator {
    let a:Int //내부에 있는 a, b에 할당
    let b:Int
    
    init(a: Int, b:Int) {  //초기화 함수는 클래스, 인스턴스가 생성될 때 제일 최소에 호출되는 함수
        self.a = a
        self.b = b  //파라미터로 두 개의 값을 받음, 외부에서 호출
    }
} //클래스는 오류 (초기화 함수를 자동으로 생성해주지 않는다/구조체는 생성해줌)

protocol Flyable {
    func fly()
}










