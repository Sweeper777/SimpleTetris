import SpriteKit

class JShapedTetrimino : Tetrimino, Rotatable {
    override var touchingSides: [TetrisBlock] {
        switch rotationIndex {
        case 0: return [blocks[2], blocks[3]]
        case 1: return [blocks[1], blocks[2], blocks[0]]
        case 2: return [blocks[0], blocks[3]]
        case 3: return [blocks[3], blocks[0], blocks[1]]
        default: fatalError("Rotation index invalid")
        }
    }
    
    init(tetrisBoard: TetrisBoard, rotationIndex: Int) {
        self.rotationIndex = rotationIndex
        super.init(tetrisBoard: tetrisBoard)
        let texture = SKTexture(imageNamed: "jtetrimino")
        blocks = [
            TetrisBlock(x: 5, y: 0, texture: texture, tetrisBoard: tetrisBoard),
            TetrisBlock(x: 5, y: 1, texture: texture, tetrisBoard: tetrisBoard),
            TetrisBlock(x: 5, y: 2, texture: texture, tetrisBoard: tetrisBoard),
            TetrisBlock(x: 4, y: 2, texture: texture, tetrisBoard: tetrisBoard)
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