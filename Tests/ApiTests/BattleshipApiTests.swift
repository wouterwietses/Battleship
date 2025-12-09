@testable import Api
import VaporTesting
import Testing

@Suite("App Tests")
struct BattleshipApiTests {
    @Test("Test health check Route")
    func healthCheck() async throws {
        try await withApp(configure: configure) { app in
            try await app.testing().test(.GET, "health", afterResponse: { res async throws in
                #expect(res.status == .ok)
                let status: String = try res.content.get(at: "status")
                #expect(status == "ACTIVE")
            })
        }
    }
}
