// Based on John Sundell's [Review: Swift Playgrounds 3.0 for iPad][1]
//
// [1]: https://www.swiftbysundell.com/articles/review-swift-playgrounds-30-for-ipad/

import Foundation

final class PlaylistTests: XCTestCase {
    public static var allTests: [(String, (PlaylistTests) -> () throws -> Void)] {
        return [
            ("testAddingSongs", testAddingSongs),
            ("testSerialization", testSerialization)
        ]
    }

    private var playlist: Playlist!

    public func setUp() {
        playlist = Playlist(name: "John's coding mix")
    }

    public func testAddingSongs() {
        XCTAssertEqual(playlist.songs, [])

        let songs = (a: Song(name: "A"), b: Song(name: "B"))
        playlist.add(songs.a)
        playlist.add(songs.b)

        XCTAssertEqual(playlist.songs, [songs.a, songs.b])
    }

    public func testSerialization() throws {
        playlist.add(Song(name: "A"))
        playlist.add(Song(name: "B"))

        let data = try JSONEncoder().encode(playlist)
        let decoded = try JSONDecoder().decode(Playlist.self, from: data)
        XCTAssertEqual(playlist, decoded)
    }
}

try PlaylistTests.run()
