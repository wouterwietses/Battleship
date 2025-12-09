import Vapor

struct Handler: APIProtocol {
    func getHealth(_ input: Operations.GetHealth.Input) async throws -> Operations.GetHealth.Output {
        return .ok(.init(body: .json(.init(status: .active))))
    }
}
