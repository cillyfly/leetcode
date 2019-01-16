import UIKit

var str = "Hello, playground"

func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
    let leftCount = nums1.count
    let rightCount = nums2.count
    let index = (leftCount + rightCount) / 2
    if index < 1 {
        return nums1.count == 0 ? Double(nums2.first ?? 0)  : Double(nums1.first  ?? 0)
    }
    var result:[Int] = []
//    getNewElement(left: nums1, right: nums2, result: &result, stopAt: index + 1)
    getNextIndex(leftIndex: 0, rightIndex: 0, left: nums1, right: nums2, result: &result, stopAt: index + 1)
    print(result , "  ss  " , index)
   
    if (leftCount + rightCount) % 2 == 0 {
        return Double(result[index] + result[index - 1])/2.0
    }else{
        return Double(result[index])
    }
}

//114ms
func getNextIndex(leftIndex:Int,rightIndex:Int,left:[Int],right:[Int],result:inout [Int],stopAt:Int){
    print("result is \(result) stopat is \(stopAt)")
    if result.count <= stopAt{
        if leftIndex < left.count && rightIndex < right.count  {
            print(left,"----- \(leftIndex) ---- \(left[leftIndex])")
            print(right,"----- \(rightIndex)---- \(right[rightIndex])")
            if left[leftIndex] < right[rightIndex] {
                print("leftIndex \(leftIndex)")
                result.append(left[leftIndex])
                let newLI = leftIndex + 1
                getNextIndex(leftIndex: newLI, rightIndex: rightIndex, left: left, right: right, result: &result, stopAt: stopAt)
            }else{
                 print("RightIndex \(rightIndex)")
                result.append(right[rightIndex])
                let newRI = rightIndex + 1
                getNextIndex(leftIndex: leftIndex, rightIndex: newRI, left: left, right: right, result: &result, stopAt: stopAt)
            }
        }else if leftIndex >= left.count && rightIndex < right.count {
            print("rightIndex")
            let subArr = right.suffix(from: rightIndex)
            result.append(contentsOf: subArr)
        }else if leftIndex < left.count && rightIndex >= right.count {
            print("left")
            let subArr = left.suffix(from: leftIndex)
            result.append(contentsOf: subArr)
        }
    }
}

//204ms
func getNewElement(left:[Int],right:[Int],result:inout [Int],stopAt:Int){
    let tempL = left
    let tempR = right
    
    if result.count != stopAt{
        if let firstL = tempL.first,let firstR = tempR.first {
            print("first")
            if firstL < firstR {
                result.append(firstL)
               getNewElement(left: Array(tempL.dropFirst()), right: tempR, result: &result,stopAt:stopAt)
            }else{
                 result.append(firstR)
                getNewElement(left: tempL, right: Array(tempR.dropFirst()), result: &result,stopAt:stopAt)
            }
        }else if tempL.count == 0 {
            print("second")
            result.append(contentsOf: tempR)
        }else if tempR.count == 0 {
            print("another second")
            result.append(contentsOf: tempL)
        }
    }
}

var rr = findMedianSortedArrays([1,2], [3,4])
print(rr)
