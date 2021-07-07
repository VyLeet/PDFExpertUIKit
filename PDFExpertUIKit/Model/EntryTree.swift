//
//  EntryTree.swift
//  PDFExpertUIKit
//
//  Created by Nazariy Vysokinskyi on 02.07.2021.
//

import Foundation

class EntryNode: Identifiable {
    var value: Entry
    
    weak var parent: EntryNode?
    var children = [EntryNode]()
    
    var id: UUID {
        value.id
    }
    
    init(value: Entry) {
        self.value = value
    }
    
    func addChild(_ node: EntryNode) {
        children.append(node)
        print("Child \(node.value.itemName) added to \(self.value.itemName)")
        node.parent = self
    }
}

extension EntryNode {
    
    func findParent(withID id: UUID) -> EntryNode? {
        if self.value.id == id {
            return self
        }
        for child in children {
          if let found = child.findParent(withID: id) {
            return found
          }
        }
        return nil
    }
}

extension EntryNode: CustomStringConvertible {
    var description: String {
        let children = self.children.map { $0.value.itemName }.joined(separator: ", ")
        let text = "Current node's children are \(children)"
        return text
    }
}
