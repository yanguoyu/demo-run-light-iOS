import Foundation
import Moya

enum MyService {
    case rpc(methodName: String, params: Any)
}

// MARK: - TargetType Protocol Implementation
extension MyService: TargetType {
    var baseURL: URL { return URL(string: "http://127.0.0.1:9000")! }
    var path: String {
        switch self {
        case .rpc:
            return ""
        }
    }
    var method: Moya.Method {
        switch self {
        case .rpc:
            return .post
        }
    }
    var task: Task {
        switch self {
        case let .rpc(methodName, params):
            var body = ["jsonrpc": "2.0", "method": methodName, "params": params, "id": 1] as [String : Any]
            return .requestParameters(parameters: body, encoding: JSONEncoding.default)
        }
    }
    var sampleData: Data {
        switch self {
        case .rpc(let method_name, let params):
            return "{\"jsonrpc\": \"2.0\", \"method_name\": \"\(method_name)\", \"params\": [], \"id\": 1 }".utf8Encoded
        }
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data {
        Data(self.utf8)
    }
}
