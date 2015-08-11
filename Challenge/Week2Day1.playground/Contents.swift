//counting words in a sentence
//a word is broken up by spaces
//numbers are considered words
//Acronyms are considered a word

import UIKit

var wordCounted = 0
var tempArray :[String] = []
var i = 0


func countWordsInSentence(Sentence: String) -> Int {
  tempArray=[]
  i = 0
  wordCounted = 0
  for Character in Sentence{
    switch Character {
      case " ":
        if i == 0 {
        }else{ if tempArray[i-1]==" "{}
        else{tempArray.append("\(Character)")
        i++}}
      case "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","1","2","3","4","5","6","7","8","9","0":
        tempArray.append("\(Character)")
        i++
        //bet there is a better way to identifying letters and numbers.  Somethig to do with utc8
      
        
      default:
        println("not entered into array")
    }
  }
  
  i = 0
  if tempArray.count != 0 {
  for elements in tempArray{
    switch elements {
    case " ":
      if i == 0{
        i++
      }else if i == tempArray.count-1{
      }
      else{
        wordCounted++
        i++}
      
    default:
      i++
    }
  }
  wordCounted++
  }

  println(tempArray)
  return wordCounted
}


countWordsInSentence("   hi   this is a sentence, e.g. who 321 123 22 times ")
countWordsInSentence("")
countWordsInSentence(" ")
countWordsInSentence("a ")
countWordsInSentence("C.I.A.")


