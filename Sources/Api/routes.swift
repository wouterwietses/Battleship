import OpenAPIRuntime
import OpenAPIVapor
import Vapor

func routes(_ app: Application) throws {
    let transport = VaporTransport(routesBuilder: app)
    let handler = Handler()
    try handler.registerHandlers(on: transport, serverURL: URL(string: "/")!)
}
