import Foundation

class APIService {

    static let shared = APIService()

    func searchSongs(query: String) async throws -> [Song] {

        let urlString = "http://127.0.0.1:8000/search?query=\(query)"

        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
            return []
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        struct Response: Codable {
            let results: [Song]
        }

        let decoded = try JSONDecoder().decode(Response.self, from: data)

        return decoded.results
    }
}