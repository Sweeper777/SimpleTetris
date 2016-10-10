import SpriteKit

class SShapedTetrimino : Tetrimino, Rotatable {
    override var touchingSides: [TetrisBlock] {
        if rotationIndex == 0 {
            return [blocks[0], blocks[1], blocks[3]]
        } else {
            return [blocks[3], blocks[1]]
        }
    }
    
    init(tetrisBoard: TetrisBoard, rotationIndex: Int) {
        self.rotationIndex = rotationIndex
        super.init(tetrisBoard: tetrisBoard)
        let texture = SKTexture(imageNamed: "stetrimino")
        blocks = [
            TetrisBlock(x: 3, y: 1, texture: texture, tetrisBoard: tetrisBoard),
            TetrisBlock(x: 4, y: 1, texture: texture, tetrisBoard: tetrisBoard),
            TetrisBlock(x: 4, y: 0, texture: texture, tetrisBoard: tetrisBoard),
            TetrisBlock(x: 5, y: 0, texture: texture, tetrisBoard: tetrisBoard)
        ]
        
        if rotationIndex == 1 {
            rotate()
        }
        
        tetrisBoard.syncModel()
    }
    
    func rotate() {
        if rotationIndex == 0 {
            if TetrisUtility.tryRotate(self, clockwiseAbout: 0) {
                rotationIndex = 1
            } else if TetrisUtility.tryRotate(self, clockwiseAbout: 1) {
                rotationIndex = 1
            } else if TetrisUtility.tryRotate(self, clockwiseAbout: 2) {
                rotationIndex = 1
            } else if TetrisUtility.tryRotate(self, clockwiseAbout: 3) {
                rotationIndex = 1
            }
        } else {
            if TetrisUtility.tryRotate(self, anticlockwiseAbout: 0) {
                rotationIndex = 0
            } else if TetrisUtility.tryRotate(self, anticlockwiseAbout: 1) {
                rotationIndex = 0
            } else if TetrisUtility.tryRotate(self, anticlockwiseAbout: 2) {
                rotationIndex = 0
            } else if TetrisUtility.tryRotate(self, anticlockwiseAbout: 3) {
                rotationIndex = 0
            }
        }
        tetrisBoard.syncModel()
    }
    
    var rotationIndex: Int {
        didSet {
            if rotationIndex < 0 || rotationIndex > 1 {
                rotationIndex = 0
            }
        }
    }
    
    let numberOfRotations: Int = 2
}
