import NIOQUIC
import NIOCore
import NIOPosix
import Foundation

// Phase B: real swift-nio-quic 0.2.2 server
// QUICHandler processes incoming UDP datagrams via channelRead()
// Pre-fix: readSlice(dcidLength)! crashes on short datagrams

let port = 4433
let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)

print("=== swift-nio-quic 0.2.2 server ===")
print("PID: \(ProcessInfo.processInfo.processIdentifier)")

do {
    let channel = try DatagramBootstrap(group: group)
        .channelOption(ChannelOptions.socketOption(.so_reuseaddr), value: 1)
        .channelInitializer { channel in
            let quicHandler = QUICHandler(
                role: .server,
                quicConfiguration: .init(role: .server)
            )
            return channel.pipeline.addHandler(quicHandler)
        }
        .bind(host: "0.0.0.0", port: port)
        .wait()

    print("Listening on UDP :\(port)")
    print("READY")
    fflush(stdout)

    try channel.closeFuture.wait()
} catch {
    print("ERROR: \(error)")
    exit(1)
}
