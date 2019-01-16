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

extension Array where Element == Int {
    func distances() -> [Int] {
        let after = self.dropFirst()
        let before = self.dropLast()
        return zip(after, before).map { (a, b) -> Int in
            a - b
        }
    }
}

func getSameChatater(_ s: String) -> [Character: [Int]] {
    let arrS = Array(s)
    let sType = Array(Set(arrS))
    var dic: [Character: [Int]] = [:]
    sType.forEach { c in
        dic[c] = arrS.indexs(of: c)
    }
    return dic
}

var str = "babaddtattarrattatddetartrateedredividerb"
func longestPalindrome(_ s: String) -> String {
    let sarr = Array(s)
    if sarr.count <= 1 {
        return s
    }
    if sarr.count == 2 {
        if sarr.first == sarr.last {
            return s
        } else {
            return String(sarr.first!)
        }
    }
//    将一致的字符串归类
    let result = getSameChatater(s)
    if result.count == sarr.count {
        return String(sarr.first!)
    }
//    将字符串按照index来进行归类 数量多的放最前边
    let tt = Array(result.values).sorted { (a, b) -> Bool in
        return a.distances().reduce(0, + ) > b.distances().reduce(0, + )
    }
//    若是均为单数串则返回任意一个
    if tt.first?.count == 1 {
        return String(sarr.first!)
    }
    var finalResult: [[Character]] = []
    var interrupt: [[Int]] = []
    var max = 0
    tt.forEach { arr in
        print("-------- arr is \(arr)")
        var rr: [Character] = []
        dealWithArr(sarr: sarr, pairs: arr, result: &rr, maxLength: &max, interrupt: &interrupt)
        finalResult.append(rr)
    }
//    print(finalResult)
    let r = finalResult.max { (a1, a2) -> Bool in
        return a1.count < a2.count
    }
    let tempresult = String(r!)
    return tempresult == "" ? String(sarr.first!) : tempresult
}

func dealWithArr(sarr: [Character], pairs: [Int], result: inout [Character], maxLength: inout Int, interrupt: inout [[Int]]) {
//    当出现[1,2,3,4]这样的情况时

    guard result.count != pairs.count - 1 else { return }
    guard let first = pairs.first, let last = pairs.last else { return }
    guard last - first > maxLength else { return }

    guard pairs.count - 1 != last - first else {
        result = Array(sarr[first..<(last + 1)])
        maxLength = max(maxLength, result.count)
        print("✅ ❗️ result is \(result)")
        return
    }

    doCheck(sarr: sarr, result: &result, first: first, last: last, maxLength: &maxLength, interrupt: &interrupt)
    if result.count == 0 {
        var leftResult: [Character] = []
        let leftPairs = pairs
        dealWithLeft(sarr: sarr, pairs: leftPairs, result: &leftResult, maxLength: &maxLength, interrupt: &interrupt)
        //            result = leftResult
//        print("LEFT RESULT IS \(leftResult)")

        var rightResult: [Character] = []
        dealWithRight(sarr: sarr, pairs: leftPairs, result: &rightResult, maxLength: &maxLength, interrupt: &interrupt)
//        print("RIGHT RESULT IS \(rightResult)")
        result = [leftResult, rightResult].max(by: { (a, b) -> Bool in
            a!.count < b!.count
        })!
//        let newPair = Array(pairs.dropLast())
//        if newPair.count > 1{
//            var rightResult : [Character] = []
//            if let f = newPair.first, let l = newPair.last {
//                 print(" ▶️ BEGIN ANASISY [\(f, l)]")
//                doCheck(sarr: sarr, result: &rightResult, first: f, last: l,maxLength: &maxLength, interrupt: &interrupt)
//            }
//            result = [leftResult, rightResult].max(by: { (a, b) -> Bool in
//                a!.count < b!.count
//            })!
//        }
    }
}

func dealWithLeft(sarr: [Character], pairs: [Int], result: inout [Character], maxLength: inout Int, interrupt: inout [[Int]]) {
    guard pairs.count != 0 else { return }
    let leftPairs = Array(pairs.dropFirst())
    guard let first = leftPairs.first, let last = leftPairs.last else { return }
//    guard last - first > maxLength else { return }
    interrupt.map { (temp) -> [Int] in
        if temp.last ?? 0 == last {
            return [max(first, temp.first ?? 0), last]
        }
        return temp
    }
//    print("DO LEFT WITH pairs \(leftPairs)")
    dealWithArr(sarr: sarr, pairs: leftPairs, result: &result, maxLength: &maxLength, interrupt: &interrupt)
//    print("      ✅ LEFT- [RESULT] \(result)")
}

func dealWithRight(sarr: [Character], pairs: [Int], result: inout [Character], maxLength: inout Int, interrupt: inout [[Int]]) {
    guard pairs.count != 0 else { return }
    let rightPairs = Array(pairs.dropLast())
    guard let first = rightPairs.first, let last = rightPairs.last else { return }
    guard last - first > maxLength else { return }

    interrupt.map { (temp) -> [Int] in
        if temp.first ?? 0 == first {
            return [first, min(last, temp.last ?? 0)]
        }
        return temp
    }
//    print("DO RIGHT WITH pairs \(rightPairs)")
    doCheck(sarr: sarr, result: &result, first: first, last: last, maxLength: &maxLength, interrupt: &interrupt)
    dealWithRight(sarr: sarr, pairs: rightPairs, result: &result, maxLength: &maxLength, interrupt: &interrupt)
//    dealWithArr(sarr: sarr, pairs: rightPairs, result: &result, maxLength: &maxLength, interrupt: &interrupt)
//    print("      ✅ RIGHT- [RESULT] \(result)")
}

func doCheck(sarr: [Character], result: inout [Character], first: Int, last: Int, maxLength: inout Int, interrupt: inout [[Int]]) {
    let isInInterrupt = checkIsInInterrupt(first: first, last: last, interrupt: interrupt)
    print(" ▶️ BEGIN ANASISY [\(first, last)] AND is in INTERRUPT IS \(isInInterrupt)")
    if !isInInterrupt {
        var notOKCount = 0
        checkNextIsOk(left: first, right: last, sarr: sarr, notOkCount: &notOKCount, maxLength: maxLength, interrupt: &interrupt)
        if notOKCount == 0 {
            let newresult = Array(sarr[first..<(last + 1)])
            if newresult.count > result.count {
                result = newresult
                maxLength = max(maxLength, result.count)
                print("✅ result is \(result) pair is [\(first,last)]")
                return
            }
        }
    }
}

func checkNextIsOk(left: Int, right: Int, sarr: [Character], notOkCount: inout Int, maxLength: Int, interrupt: inout [[Int]]) {
//    print("    --- maxLength is \(maxLength) distance is \(right - left - 2)")
    if left + 1 <= right - 1 {
        if sarr[left + 1] == sarr[right - 1] {
            checkNextIsOk(left: left + 1, right: right - 1, sarr: sarr, notOkCount: &notOkCount, maxLength: maxLength, interrupt: &interrupt)
        } else {
            notOkCount = notOkCount + 1
            interrupt.append([(left + 1), (right - 1)])
//            print("     APPEND INTERRUPT \([(left + 1), (right - 1)])")
        }
    }
}

func checkIsInInterrupt(first: Int, last: Int, interrupt: [[Int]]) -> Bool {
    let r = interrupt.first { (temparr) -> Bool in
        guard let f = temparr.first, let l = temparr.last else {
            return false
        } 
        if first < f && l < last {
//            print("             first f l last \(first ,f ,l ,last)  is mod \((last - first) % (f - l) == 0)")
            if (first + last) == 2 * l || (first + last) == 2 * f || (last - first) % (f - l) == 0 || f - first != last - l{
                return false
            }
            return true
        }
        return false
    }
    print("👱👱 interrupt is \(interrupt)  result is \(r != nil)")
    return r != nil
}

let result = longestPalindrome(str)
print("---------RESULT-------- \(result)")
