import SpriteKit

class TShapedTetrimino : Tetrimino, Rotatable {
    override var touchingSides: [TetrisBlock] {
        switch rotationIndex {
        case 0: return [blocks[0], blocks[2], blocks[3]]
        case 1: return [blocks[3], blocks[2]]
        case 2: return [blocks[0], blocks[2], blocks[1]]
        case 3: return [blocks[0], blocks[3]]
        default: fatalError("Rotation index invalid")
        }
    }
    
    init(tetrisBoard: TetrisBoard, rotationIndex: Int) {
        self.rotationIndex = 0
        super.init(tetrisBoard: tetrisBoard)
        let texture = SKTexture(imageNamed: "ttetrimino")
        blocks = [
            TetrisBlock(x: 3, y: 0, texture: texture, tetrisBoard: tetrisBoard),
            TetrisBlock(x: 4, y: 0, texture: texture, tetrisBoard: tetrisBoard),
            TetrisBlock(x: 5, y: 0, texture: texture, tetrisBoard: tetrisBoard),
            TetrisBlock(x: 4, y: 1, texture: texture, tetrisBoard: tetrisBoard)
        ]
        
        for _ in 0..<rotationIndex {
            rotate()
        }
        
        tetrisBoard.syncModel()
    }
    
    func rotate() {
        if TetrisUtility.tryRotate(self, clockwiseAbout: 0) {
            rotationIndex += 1
        } else if TetrisUtility.tryRotate(self, clockwiseAbout: 1) {
            rotationIndex += 1
        } else if TetrisUtility.tryRotate(self, clockwiseAbout: 2) {
            rotationIndex += 1
        } else if TetrisUtility.tryRotate(self, clockwiseAbout: 3) {
            rotationIndex += 1
        }
        tetrisBoard.syncModel()
    }
    
    var rotationIndex: Int {
        didSet {
            if rotationIndex < 0 || rotationIndex >= numberOfRotations {
                rotationIndex = 0
            }
        }
    }
    
    let numberOfRotations: Int = 4
}
