# 클로저
[공부 출처 Medium](https://medium.com/@abhimuralidharan/functional-swift-all-about-closures-310bc8af31dd)

1. 클로저란?<br>

- 클로저란 self-contained functionality한 블록단위이며, 나의 코드에 전반적으로 사용될 수 있다.<br>
그렇다면, self-contained functionality한 블록 단위가 무엇인가? 우선적으로 알고 가야할 것이 함수는 타입으로 사용될 수 있다는 것이다. 함수가 타입처럼 사용이된다는 것은 클로저또한 타입으로 사용가능하다는 것.

```swift
let functionTypeEx: (Int) -> () 
```
위의 함수는 (Int) -> () 타입인것이다!!!

```swift
{ (params) -> returnType in
 //someting ...do it!
}
```
위와같이 실행가능하고 포함가능한 블록, 클로저의 형태를 기본 단위라고 하는건가?
- 클로져는 Context를 둘러싸고있는 범위안에서 값을 Capture! 할 수 있다. 값을 캡쳐!
- 클로져의 Arguments를 줄이는 방법은 생략한다.
여기서는 중점적으로 왜 Closure를 쓰는지와 적절하게 사용하는 예를 알아보고 익숙하게 될 때까지 무한 반복을 한다.

- 클로저와 함수는 first class types 이다. Normal value처럼 사용할 수 있다.라는점!!이 가장중요하다.

2. 적절한 사용예<br>
핸들러로써의 클로저의 사용!

```swift
var shoppingList = ["key": "value"]

func callSomeMethodWithParams(_ params: [AnyHashable: Any], onSuccess success: @escaping (_ JSON: Any) -> (), onFailure failure: @escaping (_ error: Error?, _ params: [AnyHashable: Any]) -> ()){
    
    print("\n" + String(describing: params))
    
    let error: Error? = NSError(domain:"", code:1, userInfo:nil)
    
    var responseArray: [Any]?
    responseArray = [1,2,3,4,5]
    
    if let responseArr = responseArray {
        success(responseArray)
    }
    
    if let error = error {
        failure(error, params)
    }
}


callSomeMethodWithParams(shoppingList, onSuccess: { JSON in
    print(String(describing: JSON))
}) { (error, params) in
    if let err = error {
        print(err.localizedDescription)
    }
    print(params)
}
```

Return타입으로써의 클로져
```swift
// () -> UIView Type Closure.
let setupViewUsingClosure = { () -> UIView in
    let view = UIView()
    view.backgroundColor = .green
    return view
}

// closure call.
let setupViewUsingClosureCall = {
    let view = UIView()
    view.backgroundColor = .red
    return view
}()
```
맨뒤에 () 를 붙혀주지 않는다면 closure는 그저 closure 타입일 뿐이다. 즉 아직 실행을 하지 않는 상태인것, 그래서 setupViewUsingClosure()를 해야 클로져타입이 실행된다. 하지만 아래에있는 예제는
setupViewUsingClosureCall가 바로 실행되어 보여진다.

Trailing Closures

```swift
// Trailing Closures

func doSomething(number: Int, onSuccess closure: (Int) -> ()) {
    closure(number * number * number)
}

doSomething(number: 3) { numberCube in
    print(numberCube)
}

func testSuccess(number: Int) -> () {
    print(number)
}

doSomething(number: 2, onSuccess: testSuccess)
````
doSomething 함수에서 클로져를 바로 사용할 수 있다. 저기에는 매개변수의 이름조차 없지만 Swift가 알아서 넣어준다. 대단해..
3. Advanced한 사용예<br>