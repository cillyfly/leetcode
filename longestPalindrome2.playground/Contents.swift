import UIKit
extension Array where Element == Character {
    func indexs(of s: Character) -> [Int] {
        return self.enumerated().map { (arg1) -> Int in
            let (index, value) = arg1
            if value == s {
                return index
            }
            return NSNotFound
            }.filter { $0 != NSNotFound }
    }
}
extension Array where Element == Int{
    func distances() -> [Int]{
        let after = self.dropFirst()
        let before = self.dropLast()
        return zip(after, before).map { (a,b) -> Int in
            return a - b
        }
    }
}
var str = "aaaaa22"
func longestPalindrome(_ s: String) -> String {
    let sArr = Array(s)
    let setSarr = Set(sArr)
    if setSarr.count == 1{
        return s
    }
    let result = getSameChatater(s)
    let tt = Array(result.values).sorted { (a, b) -> Bool in
        return a.min()! < b.min()!
    }
    let distance = tt.map{$0.distances()}.filter{$0.contains(1)}
    print(distance)
    var resultArrS: [[Character]] = []
    var resultArrT: [[Character]] = []
    sArr.enumerated().forEach { index, _ in
        var rsult: [Character] = []
        judgePairs(index: index, arr: sArr, length: 0, result: &rsult)
        resultArrS.append(rsult)

        var rssultT: [Character] = []
        findLengthTwo(arr: sArr, index: index, pairsIndex: index + 1, result: &rssultT)
        resultArrT.append(rssultT)
    }
    let r = resultArrS.sorted { (a, b) -> Bool in
        return a.count > b.count
    }
    let t = resultArrT.sorted { (a, b) -> Bool in
        return a.count > b.count
    }
    return (r.first ?? []).count > (t.first ?? []).count ? String(r.first ?? []) : String(t.first ?? [])
}

func getSameChatater(_ s:String) -> [Character: [Int]]{
    let arrS = Array(s)
    let sType = Array(Set(arrS))
    var dic: [Character: [Int]] = [:]
    sType.forEach { c in
        dic[c] = arrS.indexs(of: c)
    }
    return dic
}

func judgePairs(index: Int, arr: [Character], length: Int, result: inout [Character]) {
//    print(" this is index \(index) in count \(length)")
    let left = index - length
    let right = index + length
    if left >= 0 && right < arr.count {
        if arr[left] == arr[right] {
            result = Array(arr[left..<(right + 1)])
            judgePairs(index: index, arr: arr, length: length + 1, result: &result)
        }
    }
}

func findLengthTwo(arr: [Character], index: Int, pairsIndex: Int, result: inout [Character]) {
 
    if index >= 0 && pairsIndex < arr.count {
        if arr[index] == arr[pairsIndex] {
            result = Array(arr[index..<(pairsIndex + 1)])
            findLengthTwo(arr: arr, index: index - 1, pairsIndex: pairsIndex + 1, result: &result)
        }
    }
}

longestPalindrome(str)
