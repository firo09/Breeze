import Foundation

public enum SpacingToken: Double, Sendable {
    case xs = 4
    case sm = 8
    case md = 12
    case lg = 16
    case xl = 24
}

public enum RadiusToken: Double, Sendable {
    case sm = 6
    case md = 10
    case lg = 16
}

public struct TypographyToken: Sendable {
    public let size: Double
    public let weight: Int

    public init(size: Double, weight: Int) {
        self.size = size
        self.weight = weight
    }

    public static let title = TypographyToken(size: 22, weight: 700)
    public static let body = TypographyToken(size: 16, weight: 400)
    public static let caption = TypographyToken(size: 13, weight: 400)
}
