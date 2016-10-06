import HLSpriteKit

class OShapedTetrimino : Tetrimino {
    override var touchingSides: [TetrisBlock] {
        return [blocks[1], blocks[2]]
    }
    
    override init(tetrisBoard: TetrisBoard) {
        super.init(tetrisBoard: tetrisBoard)
        let texture = SKTexture(imageNamed: "otetrimino")
        blocks = [
            TetrisBlock(x: 4, y: 0, texture: texture, tetrisBoard: tetrisBoard),
            TetrisBlock(x: 4, y: 1, texture: texture, tetrisBoard: tetrisBoard),
            TetrisBlock(x: 5, y: 0, texture: texture, tetrisBoard: tetrisBoard),
            TetrisBlock(x: 5, y: 1, texture: texture, tetrisBoard: tetrisBoard)
        ]
        tetrisBoard.syncModel()
    }
}
