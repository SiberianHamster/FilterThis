//Code Challenge: Write a function that returns all the odd elements of an array

import UIKit

func giveMeTheOddElements(originalArray:[String])->[String]{
  var oddElements:[String] = []
  
  for (index, element) in enumerate(originalArray){
    if index % 2 == 0 {oddElements.append(element)}
  }
  
  return oddElements
}

giveMeTheOddElements(["1","23","as","33","gs","be","sffs"])
