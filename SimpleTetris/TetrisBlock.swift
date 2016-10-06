import SpriteKit

public class TetrisBlock: Hashable {
    let node: SKSpriteNode
    var texture: SKTexture {
        didSet {
            node.texture = texture
        }
    }
    
    weak var tetrisBoard: TetrisBoard?
    
    var x: Int {
        didSet {
            self.tetrisBoard!.tetrisBlocks[oldValue][y] = nil
            self.tetrisBoard!.tetrisBlocks[x][y] = self
        }
    }
    
    var y: Int {
        didSet {
            self.tetrisBoard!.tetrisBlocks[x][oldValue] = nil
            self.tetrisBoard!.tetrisBlocks[x][y] = self
        }
    }
    
    func moveDown() {
        y += 1
    }
    
    init(x: Int, y: Int, texture: SKTexture, tetrisBoard: TetrisBoard, id: Int) {
        self.x = x
        self.y = y
        self.texture = texture
        self.tetrisBoard = tetrisBoard
        self.node = SKSpriteNode(texture: texture)
        self.node.size = CGSize(width: 50, height: 50)
        self.hashValue = id
        self.tetrisBoard!.tetrisBlocks[x][y] = self
    }
    
    public var hashValue: Int
    
    public static func ==(lhs: TetrisBlock, rhs: TetrisBlock) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
