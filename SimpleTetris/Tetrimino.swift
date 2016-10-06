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
            let allBlocksSet = Set<TetrisBlock>(blocks)
            let rest = allBlocksSet.subtracting(touchingSides)
            
            for block in touchingSides {
                block.moveDown()
            }
            for block in rest {
                block.moveDown()
            }
            tetrisBoard.syncModel()
        } else {
            tetrisBoard.scene!.removeAllActions()
            onLanded?()
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
