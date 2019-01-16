import UIKit

var str = "Hello, playground"
func longestPalindrome(_ s: String) -> String {
    if s.count < 2 {return s}
    if s.count == 2 && s.first! == s.last! {return s}
    if s.count == 2  {return String(s.first!)}
    let result = getSameChatater(s)
    let tt = Array(result.values).sorted { (a, b) -> Bool in
        return a.min()! < b.min()!
    }
    let tryFirst = tt.filter{$0.count > 1}.first!
    var pp : [[Int]] = []
    getNext(L: tryFirst.first ?? 0, R: tryFirst.last ?? 0, pairs: tt, result: &pp)
    
    let arr = pp.flatMap{$0.map{$0}}.sorted()
    let startIndex = s.index(s.startIndex, offsetBy: (arr.first ?? 0))
    let endIndex = s.index(s.startIndex, offsetBy: (arr.last ?? 0) + 1)
    if arr.count == 2 {
        let l = arr.first ?? 0
        if  (l + 1) != arr.last ?? 0 {
            return String(s[startIndex])
        }
    }

    let sub = s[startIndex..<endIndex]
    return String(sub)
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
    func maxArrayDistanceIn() -> [Int] {
        let biger = self.dropFirst()
        let smaller = self.dropLast()
        return zip(biger, smaller).map { (a, b) -> Int in
            a - b
        }
    }
    
    // 是否为自增序列
    func isInscriseList() -> Bool {
        let rs = self.maxArrayDistanceIn()
        return rs.max() ?? 0 == (rs.min() ?? 0)
    }
}

func getNext(L:Int,R:Int,pairs:[[Int]],result:inout [[Int]]){
       print("\(pairs) + Left is \(L) + right is \(R)")
    let subPairs = pairs.filter { (arr) -> Bool in
        print("  arr is \(arr)")
         return  arr.contains(L) && arr.contains(R)
      }
    print("subpairs \(subPairs)")
    if subPairs.count != 0 {
        result.append([L,R])
    }
    print("subPairs \(subPairs)")
    if subPairs.count != 0 && L + 1 <= R - 1{
        getNext(L: L + 1, R: R - 1, pairs: pairs, result: &result)
    }
}

let tts = "abacab" 
let result = longestPalindrome(tts)
result
