import Foundation

public struct Playlist: Equatable {
    public var name: String
    public var songs: [Song]

    private enum CodingKeys: String, CodingKey {
        case name
        case songs
    }

    public init(name: String) {
        self.name = name
        self.songs = []
    }

    public mutating func add(_ song: Song) {
        songs.append(song)
    }
}

extension Playlist: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.songs, forKey: .songs)
    }
}

extension Playlist: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.songs = try container.decode(Array.self, forKey: .songs)
    }
}
