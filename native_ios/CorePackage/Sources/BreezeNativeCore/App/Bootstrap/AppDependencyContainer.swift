import Foundation
import FoundationNetworking

public struct AppDependencyContainer {
    public let runtime: AppRuntimeEnvironment
    public let logger: AppLogger
    public let keyValueStore: KeyValueStore
    public let requestBuilder: APIRequestBuilder
    public let httpClient: HTTPClient

    public init(
        runtime: AppRuntimeEnvironment,
        logger: AppLogger,
        keyValueStore: KeyValueStore,
        requestBuilder: APIRequestBuilder,
        httpClient: HTTPClient
    ) {
        self.runtime = runtime
        self.logger = logger
        self.keyValueStore = keyValueStore
        self.requestBuilder = requestBuilder
        self.httpClient = httpClient
    }

    public static func makeDefault(runtime: AppRuntimeEnvironment) -> AppDependencyContainer {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForRequest = runtime.requestTimeout
        let session = URLSession(configuration: sessionConfiguration)

        return AppDependencyContainer(
            runtime: runtime,
            logger: ConsoleLogger(),
            keyValueStore: UserDefaultsStore(),
            requestBuilder: APIRequestBuilder(baseURL: runtime.environment.baseURL),
            httpClient: URLSessionHTTPClient(session: session)
        )
    }
}
