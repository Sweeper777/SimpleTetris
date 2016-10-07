

class TetrisUtility {
    private init() {}
    
    static func rotateClockwise(x: inout Int, y: inout Int) {
        let temp = y
        y = x
        x = -temp
    }
    
    static func rotateAnticlockwise(x: inout Int, y: inout Int) {
        let temp = x
        x = y
        y = -temp
    }
    
    static func tryRotate(_ tetrimino: Tetrimino, clockwiseAbout rotationPointBlockIndex: Int) -> Bool {
        var finalPositionsValid = [Bool]()
        let rotationBlock = tetrimino.blocks[rotationPointBlockIndex]
        
        // relative coordinates
        var x1 = tetrimino.blocks[0].x - rotationBlock.x
        var y1 = tetrimino.blocks[0].y - rotationBlock.y
        var x2 = tetrimino.blocks[1].x - rotationBlock.x
        var y2 = tetrimino.blocks[1].y - rotationBlock.y
        var x3 = tetrimino.blocks[2].x - rotationBlock.x
        var y3 = tetrimino.blocks[2].y - rotationBlock.y
        var x4 = tetrimino.blocks[3].x - rotationBlock.x
        var y4 = tetrimino.blocks[3].y - rotationBlock.y
        
        rotateClockwise(x: &x1, y: &y1)
        rotateClockwise(x: &x2, y: &y2)
        rotateClockwise(x: &x3, y: &y3)
        rotateClockwise(x: &x4, y: &y4)
        
        let absoluteCoordinates = [
            (rotationBlock.x + x1, rotationBlock.y + y1),
            (rotationBlock.x + x2, rotationBlock.y + y2),
            (rotationBlock.x + x3, rotationBlock.y + y3),
            (rotationBlock.x + x4, rotationBlock.y + y4)
        ]
        
        for i in 0..<4 {
            if i != rotationPointBlockIndex {
                finalPositionsValid.append(tetrimino.isPositionValid(x: absoluteCoordinates[i].0, y: absoluteCoordinates[i].1))
            }
        }
        
        if !finalPositionsValid.contains(false) {
            for i in 0..<4 {
                tetrimino.blocks[i].x = absoluteCoordinates[i].0
                tetrimino.blocks[i].y = absoluteCoordinates[i].1
                tetrimino.blocks[i].node.removeFromParent()
            }
            tetrimino.updatePosition()
            return true
        }
        return false
    }
    
    static func tryRotate(_ tetrimino: Tetrimino, anticlockwiseAbout rotationPointBlockIndex: Int) -> Bool {
        var finalPositionsValid = [Bool]()
        let rotationBlock = tetrimino.blocks[rotationPointBlockIndex]
        
        // relative coordinates
        var x1 = tetrimino.blocks[0].x - rotationBlock.x
        var y1 = tetrimino.blocks[0].y - rotationBlock.y
        var x2 = tetrimino.blocks[1].x - rotationBlock.x
        var y2 = tetrimino.blocks[1].y - rotationBlock.y
        var x3 = tetrimino.blocks[2].x - rotationBlock.x
        var y3 = tetrimino.blocks[2].y - rotationBlock.y
        var x4 = tetrimino.blocks[3].x - rotationBlock.x
        var y4 = tetrimino.blocks[3].y - rotationBlock.y
        
        rotateAnticlockwise(x: &x1, y: &y1)
        rotateAnticlockwise(x: &x2, y: &y2)
        rotateAnticlockwise(x: &x3, y: &y3)
        rotateAnticlockwise(x: &x4, y: &y4)
        
        let absoluteCoordinates = [
            (rotationBlock.x + x1, rotationBlock.y + y1),
            (rotationBlock.x + x2, rotationBlock.y + y2),
            (rotationBlock.x + x3, rotationBlock.y + y3),
            (rotationBlock.x + x4, rotationBlock.y + y4)
        ]
        
        for i in 0..<4 {
            if i != rotationPointBlockIndex {
                finalPositionsValid.append(tetrimino.isPositionValid(x: absoluteCoordinates[i].0, y: absoluteCoordinates[i].1))
            }
        }
        
        if !finalPositionsValid.contains(false) {
            for i in 0..<4 {
                tetrimino.blocks[i].x = absoluteCoordinates[i].0
                tetrimino.blocks[i].y = absoluteCoordinates[i].1
                tetrimino.blocks[i].node.removeFromParent()
            }
            tetrimino.updatePosition()
            return true
        }
        return false
    }
}
