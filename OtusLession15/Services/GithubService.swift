import Foundation

public class GithubService {
    let locator = ServiceLocator.shared

    public init() {
        locator.addService(service: NetworkResponseParser())
        if let parser: NetworkResponseParser = locator.getService() {
            locator.addService(service: NetworkProvider(parser: parser))
        }
    }

    public func searchRepositories(with query: String, completion: @escaping ([Repository]) -> ()) {
        guard let provider: NetworkProvider = locator.getService() else { return }

        let url = GithubEndpoint.search(query).buildUrl()
        provider.send(with: url) { [unowned self] response in
            guard let items = response["items"] as? [[String: Any]] else { return }
            let repositories = items.compactMap { self.parse(dictionary: $0) }
            
            DispatchQueue.main.async {
                completion(repositories)
            }
        }
    }

    private func parse(dictionary: [String: Any]) -> Repository? {
        guard let name = dictionary["name"] as? String else {
            return nil
        }

        return Repository(name: name)
    }

}

enum GithubEndpoint {
    static let baseUrl = "https://api.github.com"

    case search(_ q: String)


    var path: String {
        switch self {
        case .search(_):
            return "/search/repositories"
        }
    }

    var parameters: String? {
        switch self {
        case .search(let query):
            return "?q=\(query)"
        }
    }

    func buildUrl() -> URL {
        var absolutePath = "\(GithubEndpoint.baseUrl)\(path)"
        if let parameters = parameters {
            absolutePath += parameters
        }
        return URL(string: absolutePath)!
    }
}
