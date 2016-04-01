//
//  Shape.swift
//  tetris
//
//  Created by Suli Huang on 3/31/16.
//  Copyright © 2016 Suli Huang. All rights reserved.
//

import SpriteKit


let SwapOptions: UInt32 = 4

enum Swap: Int, CustomStringConvertible{
    
    case zero = 0, ninety, oneeighty, twoseventy
    
    var description: String {
        switch self {
        case .zero:
            return "0"
        case .ninety:
            return "90"
        case .oneeighty:
            return "180"
        case .twoseventy:
            return "270"
        }
    }
    
    static func random() -> Swap{
        return Swap(rawValue:Int(arc4random_uniform(SwapOptions)))!
    }
    
    static func rotate(swap: Swap, clockwise: Bool) -> Swap {
        var rotated = swap.rawValue + (clockwise ? 1 : -1)
        if rotated > Swap.twoseventy.rawValue{
            rotated = Swap.zero.rawValue
        }
        else if rotated < 0{
            rotated = Swap.twoseventy.rawValue
        }
        return Swap(rawValue: rotated)!
    }
}

let NumShapesTypes: UInt = 7

let FirstBlockIdx: Int = 0
let SecondBlockIdx: Int = 1
let ThirdBlockIdx: Int = 2
let FourthBlockIdx: Int = 3

class Shape: Hashable, CustomStringConvertible{
    
    let color: BlockColor
    
    var blocks = Array<Block>()
    
    var swap:Swap
    
    var column, row: Int
    
    var blockRowColumnPositions: [Swap: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [:]
    }
    
    var bottomBlocksForOrientations: [Swap: Array<Block>] {
        return [:]
    }
    var bottomBlocks:Array<Block> {
        guard let bottomBlocks = bottomBlocksForOrientations[swap] else {
            return []
        }
        return bottomBlocks
    }
    
    var hashValue:Int {
        return blocks.reduce(0) { $0.hashValue ^ $1.hashValue }
    }
    
    var description:String {
        return "\(color) block facing \(swap): \(blocks[FirstBlockIdx]), \(blocks[SecondBlockIdx]), \(blocks[ThirdBlockIdx]), \(blocks[FourthBlockIdx])"
    }
    
    init(column:Int, row:Int, color: BlockColor, swap:Swap) {
        self.color = color
        self.column = column
        self.row = row
        self.swap = swap
        initializeBlocks()
    }
    
    convenience init(column:Int, row:Int) {
        self.init(column:column, row:row, color:BlockColor.random(), swap:Swap.random())
    }
    
    final func initializeBlocks() {
        guard let blockRowColumnTranslations = blockRowColumnPositions[swap] else {
            return
        }

        blocks = blockRowColumnTranslations.map { (diff) -> Block in
            return Block(column: column + diff.columnDiff, row: row + diff.rowDiff, color: color)
        }
    }
    
}

func ==(lhs: Shape, rhs: Shape) -> Bool {
    return lhs.row == rhs.row && lhs.column == rhs.column
}


