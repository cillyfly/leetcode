import UIKit

var str = "Hello, playground"



func lengthOfLongestSubstring(_ s: String) -> Int {
    var result:[Int] = []
    let sArr = s.map { (temp) -> Character in
        return temp
    }
    let maxChatacter = maxCharactersCount(s: sArr)
    var sArrCopy = sArr
    var tempResult:[Character] = []
    var maxLength = 0
    while sArrCopy.count != 0 {
        if !getNext(a: sArrCopy, tempResult: &tempResult){
            sArrCopy = Array(sArrCopy.dropFirst())
            maxLength = max(maxLength, tempResult.count)
            if tempResult.count == maxChatacter {
                break
            }
            tempResult = []
        }
    }
 
    return maxLength
}


func getNext(a:[Character],tempResult:inout [Character]) -> Bool{
    let aTemp = a
    guard let temp = aTemp.first else { return false }
    if !tempResult.contains(temp){
        tempResult.append(temp)
        return getNext(a:Array(aTemp.dropFirst()), tempResult: &tempResult)
        
    }else{
        return false
    }
}

//计算不同元素个数
func maxCharactersCount(s:[Character]) -> Int{
    return Set(s).count
}

var testStr = "abcabcabc"

lengthOfLongestSubstring(testStr)
