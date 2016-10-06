import SpriteKit

public class TetrisBlock {
    let node: SKSpriteNode
    var texture: SKTexture {
        didSet {
            node.texture = texture
        }
    }
    
    weak var tetrisBoard: TetrisBoard?
    
    var x: Int
    var y: Int
    
    func moveDown() {
        y += 1
    }
    
    init(x: Int, y: Int, texture: SKTexture, tetrisBoard: TetrisBoard) {
        self.x = x
        self.y = y
        self.texture = texture
        self.tetrisBoard = tetrisBoard
        self.node = SKSpriteNode(texture: texture)
        self.node.size = CGSize(width: 50, height: 50)
        self.tetrisBoard!.tetrisBlocks[x][y] = self
    }
}
