import UIKit

var str = "lengthOfLongestSubstring"

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
    func maxDistanceIn() -> Int {
        let biger = self.dropFirst()
        let smaller = self.dropLast()
        return zip(biger, smaller).map { (a, b) -> Int in
            a - b
        }.max() ?? 0
    }

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

extension Dictionary where Key == Int, Value == [Int] {
    func minCount() -> Int {
        return self.values.map { $0.count }.min() ?? 0
    }

    func maxValueInMinCount() -> Int {
        var temp: [Int] = []
        var chageCount = 1
        while temp.count == 0 {
            self.values.enumerated().forEach { _, arr in
                if arr.count == chageCount {
                    if arr.max() ?? 0 != 0 {
                        temp.append(arr.max() ?? 0)
                    }
                }
            }

            chageCount = chageCount + 1
        }
        return temp.max() ?? 0
    }

    func findIndexInValue(v: Int) -> Int? {
        return self.filter { d -> Bool in
            d.value.contains(v)
        }.first?.key
    }
}

func findMaxListCount(dic: inout [Int: [Int]], start: Int, result: inout [Int]) -> Int {
    if let r = dic.findIndexInValue(v: start) {
        print("key is \(r) value is \(start)")
        result.append(r)
        dic.removeValue(forKey: r)
        findMaxListCount(dic: &dic, start: start - 1, result: &result)
    }
    print("find max list count the result is \(result)")
    return result.count
}

func findMaxStart(compIndex: [Int: [Int]], maxLength: Int) {
    let compMax = compIndex.maxValueInMinCount()
}

func findInscriseList(source: [[Int]], start: Int) {
    var used: [[Int]] = []
    var maxT = source.flatMap { $0 }.max() ?? 0
    var minT = source.flatMap { $0 }.min() ?? 0
    var resultLeft: [Int] = []
    var resultRight: [Int] = []

    var startLeft = start
    var startRight = start

    repeat {
        findInLeft(start: startLeft, source: source, userdItem: &used)
        let tempLength = used.count
        resultLeft.append(tempLength)
        startLeft = startLeft - tempLength
        print("MAX TEMP LENGTH IN LEFT IS \(used.count)")
        used.removeAll()
    } while startLeft > 0

    repeat {
        findInRight(start: startRight, source: source, userdItem: &used)
        let tempLength = used.count
        resultRight.append(tempLength)
        startRight = startRight + tempLength
        print("MAX TEMP LENGTH IN RIGHT IS \(used.count)")
        used.removeAll()
    } while startRight < maxT
}

func findMaxLength(source: [[Int]]) -> Int {
    var used: [[Int]] = []
    var maxT = source.flatMap { $0 }.max() ?? 0
    var minT = source.flatMap { $0 }.min() ?? 0
    var resultLeft: [Int] = []
    var resultRight: [Int] = []
    repeat {
        findInLeft(start: maxT, source: source, userdItem: &used)
        let tempLength = used.count
        resultLeft.append(tempLength)
        maxT = maxT - tempLength
        print("MAX TEMP LENGTH IN LEFT IS \(used.count)")
        used.removeAll()
    } while maxT > 0

    if resultLeft.max()! == source.count {
        return resultLeft.max()!
    }
    repeat {
        findInRight(start: minT, source: source, userdItem: &used)
        let tempLength = used.count
        resultRight.append(tempLength)
        minT = minT + tempLength
        print("MAX TEMP LENGTH IN RIGHT IS \(used.count)")
        used.removeAll()
    } while minT < maxT

    let result = max(resultLeft.max() ?? 0, resultRight.max() ?? 0)
    return result
}

func findStartSigal() {
}

func lengthOfLongestSubstring(_ s: String) -> Int {
    if s.count <= 1 {
        return s.count
    }
    // 将字符串转为无重复值串
    let setInput = Array(Set(s))
    var dic: [Character: [Int]] = [:]
    var arrCompIndex: [Int: [Int]] = [:]
    // 将字符串转为数组
    let arrInput = Array(s)

    setInput.forEach { c in
        dic[c] = arrInput.indexs(of: c)
    }

    let tt = Array(dic.values).sorted { (a, b) -> Bool in
        return a.min()! < b.min()!
    }
    print(tt)
    let r = arrCompIndex.maxValueInMinCount()
    print(r)
    return 2
}

func findInLeft(start: Int, source: [[Int]], userdItem: inout [[Int]]) {
    if (!userdItem.flatMap { $0.map { $0 } }.contains(start) && start > 0) {
        print("start \(start) source \(source) userdItem \(userdItem)")
        let newSource = source.filter { (arr) -> Bool in
            return !arr.contains(start)
        }
        let item = source.filter { $0.contains(start) }.first!
        userdItem.append(item)
        findInLeft(start: start - 1, source: newSource, userdItem: &userdItem)
    }
}

func findInRight(start: Int, source: [[Int]], userdItem: inout [[Int]]) {
    if (!userdItem.flatMap { $0.map { $0 } }.contains(start)) {
        print("start \(start) source \(source) userdItem \(userdItem)")
        let newSource = source.filter { (arr) -> Bool in
            return !arr.contains(start)
        }
        let result = source.filter { $0.contains(start) }.first
        if let item = result {
            userdItem.append(item)
            findInRight(start: start + 1, source: newSource, userdItem: &userdItem)
        }
    }
}

lengthOfLongestSubstring("asjrgapa")

// max(1, 3)
