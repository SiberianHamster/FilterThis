//: Write a function that computes the list of the first 100 Fibonacci numbers.

import UIKit

class FibMeSomeMath{

class func fibMeSomeMath(x1 : Double, x2: Double, numberOfReturnedElements: Int) -> [Double]{
  
  
  var fibArrayOfAwesomeness: [Double] = []
  fibArrayOfAwesomeness.append(x1)
  fibArrayOfAwesomeness.append(x2)
  
  var numberleft = numberOfReturnedElements - fibArrayOfAwesomeness.count
  
  while (numberleft > 0){
    var lastInIndex = fibArrayOfAwesomeness.count-1
    var secondToLastInIndex = fibArrayOfAwesomeness.count-2
    
    fibArrayOfAwesomeness.append(fibArrayOfAwesomeness[lastInIndex]+fibArrayOfAwesomeness[secondToLastInIndex])
    
    numberleft--
  }
  println(fibArrayOfAwesomeness)
  return fibArrayOfAwesomeness
}
}

FibMeSomeMath.fibMeSomeMath(0, x2: 1, numberOfReturnedElements: 100)