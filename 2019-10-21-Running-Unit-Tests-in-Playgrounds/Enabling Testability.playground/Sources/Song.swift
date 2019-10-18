import Foundation

public struct Song: Equatable {
    public let name: String

    private enum CodingKeys: String, CodingKey {
        case name
    }

    public init(name: String) {
        self.name = name
    }
}

extension Song: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
    }
}

extension Song: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
    }
}
