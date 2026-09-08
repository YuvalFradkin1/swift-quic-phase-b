// swift-tools-version: 5.9
import PackageDescription
let package = Package(
    name: "QUICServer",
    platforms: [.macOS(.v13)],
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio-quic.git", exact: "0.2.2"),
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.0.0"),
        .package(url: "https://github.com/apple/swift-crypto.git", exact: "5.0.0-beta.2"),
        .package(url: "https://github.com/apple/swift-certificates.git", exact: "1.19.3"),
    ],
    targets: [
        .executableTarget(
            name: "QUICServer",
            dependencies: [
                .product(name: "NIOQUIC", package: "swift-nio-quic"),
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio"),
            ]
        )
    ]
)
