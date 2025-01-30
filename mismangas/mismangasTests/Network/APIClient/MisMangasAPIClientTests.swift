import Testing
@testable import mismangas

@Suite 
struct MisMangasAPIClientTests {
    private let session: URLSession = {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: config)
    }()
    
    private lazy var client = MisMangasAPIClient(session: session)
}