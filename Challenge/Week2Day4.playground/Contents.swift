//Palimdrone

import UIKit


func amIAPalimdrone(inputText: String) -> Bool{
  var testOfPalindrone: Bool = false
  var tempArray: [String]=[]
  
  for Character in inputText{
    tempArray.append("\(Character)")
  }
  
  if tempArray == tempArray.reverse(){
    testOfPalindrone = true
  } else {}
  
  return testOfPalindrone
}

amIAPalimdrone("assa")
amIAPalimdrone("")
amIAPalimdrone("hih")
amIAPalimdrone("IT ti")
