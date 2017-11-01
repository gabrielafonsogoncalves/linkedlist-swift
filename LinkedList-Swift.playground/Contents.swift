// Singly Linked List - Swift
// this is just one way to implement this kind of list.
// We are going to implement:
// Node:
//  With a value and its next Node (if it exists)
//
// LinkedList:
//  head: the head of the list
//  tail: the tail of the list
//  isEmpty: retuns if the list is empty or not
//  append(_ value: T): Create a new node and append it at the end of the list
//  removeAll(): Remove all nodes
//  remove(at: Int): Remove a node in a specific index

// This is still in progress and it is used to practice.

import Foundation

public class Node<T: Equatable>: Equatable {
    var value: T
    var next: Node?
    
    init(value: T) {
        self.value = value
    }
    
    public static func ==(lhs: Node, rhs: Node) -> Bool {
        return lhs.value == rhs.value
    }
}

public class LinkedList<T: Equatable> {
    var head: Node<T>?
    var tail: Node<T>?
    var isEmpty: Bool { return head == nil }
    
    /// Append new node in the list
    /// - parameter value: the value of the new node
    func append(_ value: T) {
        let node = Node(value: value)
        if isEmpty {
            head = node
        } else {
            tail?.next = node
            tail = node
        }
        
        tail = node
    }
    
    /// Remove all nodes in the List
    func removeAll() {
        head = nil
        tail = nil
    }
    
    /// Remove a node given a index
    /// - parameter at: specific index of the node to be removed.
    /// - returns: the node that was removed.
    func remove(at index: Int) -> Node<T>? {
        guard index >= 0 else {
            return nil
        }
        
        var i = 0
        var node = head
        var nodeRemoved: Node<T>?
        
        while node != nil {
            // case when removing the head
            if i == index && node == head {
                nodeRemoved = head
                head = node?.next
                break
            
            // case when removing the tale (the next one after the tail is always nil in this kind of LinkedList)
            } else if (i + 1) == index && node?.next?.next == nil {
                nodeRemoved = node?.next
                node?.next = nil
                tail = node
                break
            
            // case when removing any other node
            } else if (i + 1) == index {
                nodeRemoved = node?.next
                node?.next = node?.next?.next
                break
            } else {
                node = node?.next
            }
            
            i += 1
        }
        
        return nodeRemoved
    }
    
    func description() -> String {
        var description = "["
        var node = head
        
        while node != nil {
            description += "\(String(describing: node!.value))"
            node = node?.next
            if node != nil {
                description += ","
            }
        }
        
        description += "]"
        
        return description
    }
}

// ------ Some process to test the list ------

// let's create a list
let list = LinkedList<String>()

// let's add some values
list.append("Gabriel")
list.append("Angelica")
list.append("Jose")
list.append("Petra")
// now we have:
// [Gabriel, Angelica, Jose, Petra]

// let's remove Angelica
list.remove(at: 1)
// now we have:
// [Gabriel, Jose, Petra]
print(list.description())

// let's add other people
list.append("Zidane")
list.append("Cafu")

// now we have:
// [Gabriel, Jose, Petra, Zidane, Cafu]
print(list.description())

// let's try to remove an index that doesn't exist
list.remove(at: 10) // we get nil

// let's remove Jose and Petra
list.remove(at: 1)
list.remove(at: 1)

// now we have:
// [Gabriel, Zidane, Cafu]
print(list.description())

// Let's remove the tail (Cafu)
list.remove(at: 2)
print(list.description())
list.tail?.value // returns Zidane
list.head?.value // returns Gabriel

// let's clean the list
list.removeAll()
print(list.description()) //retuns []
list.isEmpty // returns true

