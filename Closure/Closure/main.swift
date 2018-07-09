//
//  main.swift
//  Closure
//
//  Created by DongJin Lee on 2018. 7. 9..
//  Copyright © 2018년 NBT. All rights reserved.
//

import Foundation


let closure: (Int, Int) -> Int = { (number1, number2) in
    return number1 + number2
}

print(closure(4,3))

let callStringWithClosure: () -> String = {
    return "Hello"
}

print(callStringWithClosure())

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


var addClosure: (Int, Int) -> Int = { $0 + $1 }

func returnClosure() -> (Int, Int) -> Int {
    return addClosure
}

let returnedClosure = returnClosure()


let aString: () = { print("hello, I'm a closure too.") }()
let aString2 = { print("hello. I'm a closure but not a call.")}

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

