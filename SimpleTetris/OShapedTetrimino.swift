import HLSpriteKit

class OShapedTetrimino : Tetrimino {
    override var touchingSides: [TetrisBlock] {
        return [blocks[1], blocks[3]]
    }
    
    override init(tetrisBoard: TetrisBoard) {
        super.init(tetrisBoard: tetrisBoard)
        let texture = SKTexture(imageNamed: "otetrimino")
        blocks = [
            TetrisBlock(x: 4, y: 0, texture: texture, tetrisBoard: tetrisBoard, id: 0),
            TetrisBlock(x: 4, y: 1, texture: texture, tetrisBoard: tetrisBoard, id: 1),
            TetrisBlock(x: 5, y: 0, texture: texture, tetrisBoard: tetrisBoard, id: 2),
            TetrisBlock(x: 5, y: 1, texture: texture, tetrisBoard: tetrisBoard, id: 3)
        ]
        tetrisBoard.syncModel()
    }
}
