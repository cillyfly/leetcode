public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        next = nil
    }
}

public class LinkedList {
    fileprivate var head: ListNode?
    private var tail: ListNode?
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var first: ListNode? {
        return head
    }
    
    public var last: ListNode? {
        return tail
    }
    
    public func append(value: Int) {
        let newNode = ListNode(value)
        if let tailNode = tail {
            tailNode.next = newNode
        }
        else {
            head = newNode
        }
        tail = newNode
    }
}
// 1
extension LinkedList: CustomStringConvertible {
    // 2
    public var description: String {
        // 3
        var text = "["
        var node = head
        // 4
        while node != nil {
            text += "\(String(describing: node?.val))"
            node = node!.next
            if node != nil { text += ", " }
        }
        // 5
        return text + "]"
    }
}


func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    //进位数
    var carry:Int = 0
    let relist = LinkedList()
    var p = l1
    var q = l2
    while p != nil || q != nil {
        let sum = (p?.val ?? 0) + (q?.val ?? 0) + carry
        relist.append(value: sum % 10)
        carry = sum / 10
        p = p?.next
        q = q?.next
        
    }
    if carry > 0 {
        relist.append(value: carry)
    }
    print(relist.description)
    return relist.first
}

var l1 = LinkedList()
[1,8].forEach { (value) in
    l1.append(value: value)
}
var l2 = LinkedList()
[0].forEach { (value) in
    l2.append(value: value)
}

addTwoNumbers(l1.first, l2.first)

