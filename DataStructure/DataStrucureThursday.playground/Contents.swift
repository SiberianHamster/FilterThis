//Lifo structure with 3 methods pop, push, peek

import UIKit



class LifoStructure{
  
 var dataStructure:[String] = []
  
  func pop(){
    dataStructure.removeLast()
  }
  
  func push(elementToAdd: String){
    dataStructure.append(elementToAdd)
  }
  
  func peek()->String{
    if let peekedItem = dataStructure.last
    {
    println(peekedItem)
    return peekedItem
    }else{
    println("no items")
    return "no items"}
  
  }
}

var DataOne = LifoStructure()

DataOne.peek()
DataOne.push("h")
DataOne.peek()
DataOne.push("i")
DataOne.peek()
DataOne.pop()
DataOne.peek()
DataOne.pop()
DataOne.peek()





