import Foundation

struct Song: Identifiable, Codable {
    let id: Int
    let title: String
    let artist: String
    let artwork: String
}