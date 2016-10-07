import HLSpriteKit

class Tetrimino {
    var blocks: [TetrisBlock]
    let tetrisBoard: TetrisBoard
    
    var onLanded: (() -> Void)?
    
    var tetrisBlockMatrix: [[TetrisBlock?]] {
        get { return tetrisBoard.tetrisBlocks }
        set { tetrisBoard.tetrisBlocks = newValue }
    }
    
    var touchingSides: [TetrisBlock] {
        fatalError("Please implement touchingSides")
    }
    
    func landed() -> Bool {
        for block in touchingSides {
            if block.y >= 19 {
                return true
            }
            
            if tetrisBlockMatrix[block.x][block.y + 1] != nil {
                return true
            }
        }
        return false
    }
    
    func isPositionValid(x: Int, y: Int) -> Bool {
        if !(x >= 0 && y >= 0 && x <= 9 && y <= 19) {
            return false
        }
        if (tetrisBlockMatrix[x][y] == nil) {
            return true
        }
        return false
    }
    
    func changeSpeed(time: TimeInterval) {
        tetrisBoard.scene!.removeAllActions()
        
    }
    
    func moveDown() {
        if !landed() {
            for block in blocks {
                block.moveDown()
            }
            updatePosition()
            tetrisBoard.syncModel()
        } else {
            tetrisBoard.scene!.removeAllActions()
            onLanded?()
        }
    }
    
    func move(_ direction: Direction) {
        let finalPositions = blocks.map { ($0.x + direction.rawValue, $0.y) }
        for (index, position) in finalPositions.enumerated() {
            if !isPositionValid(x: position.0, y: position.1) {
                return
            }
            blocks[index].node.removeFromParent()
            blocks[index].x = position.0
        }
        updatePosition()
        tetrisBoard.syncModel()
    }
    
    func updatePosition() {
        for tetrisBlock in blocks {
            tetrisBlock.updatePosition()
        }
    }
    
    init(tetrisBoard: TetrisBoard) {
        self.tetrisBoard = tetrisBoard
        self.blocks = []
        let wait = SKAction.wait(forDuration: tetrisBoard.tetriminoSpeed)
        let moveDown = SKAction.run {[weak self] in self?.moveDown() }
        self.tetrisBoard.scene!.run(SKAction.repeatForever(SKAction.sequence([wait, moveDown])))
    }
}

enum Direction: Int {
    case left = -1
    case right = 1
}
