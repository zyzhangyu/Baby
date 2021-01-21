import Foundation

public struct UnionFindWeightedQuickUnionPathCompression<T: Hashable> {
    
    /// 没一个元素都放到数组了
    private var index = [T: Int]()
    private var parent = [Int]()
    private var size = [Int]()
    
    public init() {}
    
    public mutating func addSetWith(_ element: T) {
        index[element] = parent.count
        parent.append(parent.count)
        size.append(1)
    }
    
    ///Path Compression
    ///路径压缩 如果当前的结点的父节点不是自己 表示自己和别人是联通的 那么找到这颗联通树的根结点 用递归的方式
    private mutating func setByIndex(_ index: Int) -> Int {
        if index != parent[index] {
            parent[index] = setByIndex(parent[index])
        }
        return parent[index]
    }
    
    
    ///先找到这个结点在数组中的位置 然后找到这个位置所在联通树的根结点
    public mutating func setOf(_ element: T) -> Int? {
        if let indexOfElement = index[element] {
            return setByIndex(indexOfElement)
        } else {
            return nil
        }
    }
    
    
    /// 小树 添加到 大树底下
    public mutating func unionSetsContaining(_ firstElement: T, an secondElement: T) {
        if let firstSet = setOf(firstElement) , let secondSet = setOf(secondElement) {
            if firstSet != secondSet {
                if size[firstSet] < size[secondSet] {
                    parent[firstSet] = parent[secondSet]
                    size[secondSet] += size[firstSet]
                } else {
                    parent[secondSet] = parent[firstSet]
                    size[firstSet] += size[secondSet]
                }
            }
        }
    }
    
    /// 是否联通
    public mutating func inSameSet(_ firstElement: T, and secondElement: T) -> Bool {
        if let firstSet = setOf(firstElement), let secondSet = setOf(secondElement) {
            return firstSet == secondSet
        } else {
            return false
        }
    }
    
}


/// 解题思路:
/// 创建一个新的结构体


struct VP {
    public init() {}
    /// 没一个元素都放到数组了
    var start = [Int]()
    var end = [Int]()
    var size:Int {
        get {
            var width = start[0] - end[0]
            var height = start[1] - end[1]
            if width < 0 {width = 0 - width}
            if height < 0 {height = 0 - height}
            return width + height
        }
    }
}

class Solution {
    func minCostConnectPoints(_ points: [[Int]]) -> Int {
        
        return 0
    }
}

/// 我的解题基本思路
///

///疑问1 关键字 mutating
