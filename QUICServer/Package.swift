// swift-tools-version: 5.9
import PackageDescription
let package = Package(
    name: "QUICServer",
    platforms: [.macOS(.v13)],
    dependencies: [
        // Vulnerable commit: parent of 66ce86d (fix)
        // = 0.2.2 without the undersized datagram guard
        .package(
            url: "https://github.com/apple/swift-nio-quic.git",
            revision: "c615d0d6c3306a32615805344809445f5948e5f0"
        ),
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.0.0"),
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
