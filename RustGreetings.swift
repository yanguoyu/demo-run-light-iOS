import Foundation
import Moya
import Bagel

struct RPCParams: Codable {
    var jsonrpc: String
    var method: String
    var params: Array<Int>
    var id: Int
}

var testnetConfig = """
# chain = "mainnet"
# chain = "testnet"
# chain = "your_path_to/dev.toml"
chain = "testnet"

[store]
path = "/data/store"

[network]
path = "/data/network"

listen_addresses = ["/ip4/0.0.0.0/tcp/8118"]
### Specify the public and routable network addresses
# public_addresses = []

# Node connects to nodes listed here to discovery other peers when there's no local stored peers.
# When chain.spec is changed, this usually should also be changed to the bootnodes in the new chain.
bootnodes = [
  # Ohio, North America
  "/ip4/18.217.146.65/tcp/8111/p2p/QmT6DFfm18wtbJz3y4aPNn3ac86N4d4p4xtfQRRPf73frC",
  # Singapore, Asia
  "/ip4/18.136.60.221/tcp/8111/p2p/QmTt6HeNakL8Fpmevrhdna7J4NzEMf9pLchf1CXtmtSrwb",
  # London, Europe
  "/ip4/35.176.207.239/tcp/8111/p2p/QmSJTsMsMGBjzv1oBNwQU36VhQRxc2WQpFoRu1ZifYKrjZ",
  # Singapore, Asia
  "/ip4/13.228.149.113/tcp/8111/p2p/QmQoTR39rBkpZVgLApDGDoFnJ2YDBS9hYeiib1Z6aoAdEf",
  # Bahrain, Asia
  "/ip4/157.241.73.87/tcp/8111/p2p/QmSPkAyXqsWpRiS7HpHLTProVdhQWLKFHCXbRjaLpJj7ZL",
  # Japan, Asia
  "/ip4/4.241.132.26/tcp/8111/p2p/QmX5D6aJiAQ5Fxn4BfVqSn6zrgyuQM1oXVC9yvmzLuHXnx",
  # Korea, Asia
  "/ip4/52.147.120.180/tcp/8111/p2p/QmPcJY2gZLUm66szYA9QaG1P3rzwseWCMgbj6AyNCyW4G2",
  # Hong Kong, Asia
  "/ip4/18.167.196.121/tcp/8111/p2p/QmQMjFrNGaphzfHin3mbYybbJcFMDUihKAcknquYvm9J3W",
  # Oregon, North America
  "/ip4/34.216.103.183/tcp/8111/p2p/Qmd41MaByDprkC5gP1XBKgamZ9DTLNk37zbPgwtiWCzRV6",
  # Canada, North America
  "/ip4/3.98.152.180/tcp/8111/p2p/QmWVuW5KquiWDSqgMJRFW1xRtVqkYJrWz6S9NNk6fFn3wh",
  # Frankfurt, Europe
  "/ip4/18.192.147.65/tcp/8111/p2p/QmWcEhsMNRcfJit62EbKgzpgtAJZX1G3Ur4shXjcvLsYDb",
  # Sydney, Oceania
  "/ip4/13.236.13.195/tcp/8111/p2p/QmfUTZxsse7rFJTJfoUv8bbStoDLETxst5nJEpJozNuAnH"
]

### Whitelist-only mode
# whitelist_only = false
### Whitelist peers connecting from the given IP addresses
# whitelist_peers = []

### Enable `SO_REUSEPORT` feature to reuse port on Linux, not supported on other OS yet
# reuse_port_on_linux = true

max_peers = 125
max_outbound_peers = 8
# 2 minutes
ping_interval_secs = 120
# 20 minutes
ping_timeout_secs = 1200
connect_outbound_interval_secs = 15
# If set to true, try to register upnp
upnp = false
# If set to true, network service will add discovered local address to peer store, it's helpful for private net development
discovery_local_address = false
# If set to true, random cleanup when there are too many inbound nodes
# Ensure that itself can continue to serve as a bootnode node
bootnode_mode = false

[rpc]
# Light client rpc is designed for self hosting, exposing to public network is not recommended and may cause security issues.
# By default RPC only binds to localhost, thus it only allows accessing from the same machine.
listen_address = "127.0.0.1:9000"
"""

var mainnetConfig: String = """
# chain = "mainnet"
# chain = "testnet"
# chain = "your_path_to/dev.toml"
chain = "mainnet"

[store]
path = "/data/store"

[network]
path = "/data/network"

listen_addresses = ["/ip4/0.0.0.0/tcp/8118"]
### Specify the public and routable network addresses
# public_addresses = []

# Node connects to nodes listed here to discovery other peers when there's no local stored peers.
# When chain.spec is changed, this usually should also be changed to the bootnodes in the new chain.
bootnodes = [
  # Hongkong, Asia
  "/ip4/16.163.82.218/tcp/8114/p2p/QmaZMemLXSsxKUrYNucjEbPxVX3rBKsGhWW2muWtWxUWyh",
  # Tokyo, Asia
  "/ip4/35.79.196.111/tcp/8114/p2p/QmYCRVonLfP18LSoz2WCHaXDorUYxuUMfhtcXK1TuZ1iwF",
  # Mumbai, Asia
  "/ip4/13.234.144.148/tcp/8114/p2p/QmbT7QimcrcD5k2znoJiWpxoESxang6z1Gy9wof1rT1LKR",
  # Seoul, Asia
  "/ip4/34.64.120.143/tcp/8114/p2p/QmejEJEbDcGGMp4D6WtftMMVLkR1ZuBfMgyLFDMJymkDt6",
  # Virginia, North America
  "/ip4/3.218.170.86/tcp/8114/p2p/QmShw2vtVt49wJagc1zGQXGS6LkQTcHxnEV3xs6y8MAmQN",
  # Los Angeles, North America
  "/ip4/35.236.107.161/tcp/8114/p2p/QmSRj57aa9sR2AiTvMyrEea8n1sEM1cDTrfb2VHVJxnGuu",
  # Texas, North America
  "/ip4/23.101.191.12/tcp/8114/p2p/QmexvXVDiRt2FBGptgK4gBJusWyyTEEaHeuCAa35EPNkZS",
  # Toronto, North America
  "/ip4/20.151.143.237/tcp/8114/p2p/QmNsGNQjYA6iP472bNnNE2GR31kCYBifhY1XcaUxRjZ1py",
  # Frankfurt, Europe
  "/ip4/52.59.155.249/tcp/8114/p2p/QmRHqhSGMGm5FtnkW8D6T83X7YwaiMAZXCXJJaKzQEo3rb",
  # London, Europe
  "/ip4/3.10.216.39/tcp/8114/p2p/QmagxSv7GNwKXQE7mi1iDjFHghjUpbqjBgqSot7PmMJqHA",
  # Paris, Europe
  "/ip4/13.37.172.80/tcp/8114/p2p/QmXJg4iKbQzMpLhX75RyDn89Mv7N2H8vLePBR7kgZf6hYk",
  # Warsaw, Europe
  "/ip4/34.118.49.255/tcp/8114/p2p/QmeCzzVmSAU5LNYAeXhdJj8TCq335aJMqUxcvZXERBWdgS",
  # Victoria, Oceania
  "/ip4/40.115.75.216/tcp/8114/p2p/QmW3P1WYtuz9hitqctKnRZua2deHXhNePNjvtc9Qjnwp4q",
  # Santiago, South America
  "/ip4/34.176.239.95/tcp/8114/p2p/QmQoWrmuFauCn3zZ2mYYKAciG9opTbjzC2wVEfWveZNDt8",
  # Capetown, Africa
  "/ip4/13.245.217.98/tcp/8114/p2p/Qmf4t1SzFhRWuGcFcgs7r4pXvkACsz3FcaBMcmMKQMMpn7"
]

### Whitelist-only mode
# whitelist_only = false
### Whitelist peers connecting from the given IP addresses
# whitelist_peers = []

### Enable `SO_REUSEPORT` feature to reuse port on Linux, not supported on other OS yet
# reuse_port_on_linux = true

max_peers = 125
max_outbound_peers = 8
# 2 minutes
ping_interval_secs = 120
# 20 minutes
ping_timeout_secs = 1200
connect_outbound_interval_secs = 15
# If set to true, try to register upnp
upnp = false
# If set to true, network service will add discovered local address to peer store, it's helpful for private net development
discovery_local_address = false
# If set to true, random cleanup when there are too many inbound nodes
# Ensure that itself can continue to serve as a bootnode node
bootnode_mode = false

[rpc]
# Light client rpc is designed for self hosting, exposing to public network is not recommended and may cause security issues.
# By default RPC only binds to localhost, thus it only allows accessing from the same machine.
listen_address = "127.0.0.1:9000"
"""

class RustGreetings {
    var lightThread: Optional<Thread> = nil
    func startLight(netType: String) -> Void {
        Bagel.start()
        writeTomlFile(netType: netType)
        print(getHomeDir())
        let tomlPath = getHomeDir() + "/" + netType + ".toml"
        lightThread = Thread {
            run_light(tomlPath)
        }
        lightThread!.start()
    }
    
    func stopLight() -> Void {
        if (lightThread != nil) {
            lightThread!.cancel()
        }
    }
    
    func rpcRequest(methodName: String, params: Any) {
        let provider = MoyaProvider<MyService>()
        provider.request(.rpc(methodName: methodName, params: params)) { result in
            switch result {
            case let .success(moyaResponse):
                do {
//                    try moyaResponse.filterSuccessfulStatusCodes()
                    let data = try moyaResponse.mapJSON()
                    let statusCode = moyaResponse.statusCode // Int - 200, 401, 500, etc
                    print("call success with", data, statusCode)
                    // do something in your app
                }
                catch {
                    // show an error to your user
                    print("mapJSON failed")
                }
            case let .failure(error):
                print("call failed")
                // TODO: handle the error == best. comment. ever.
            }
        }
    }
    
    func writeTomlFile(netType: String) {
        let configPath = getHomeDir() + "/" + netType + ".toml"
        if FileManager.default.fileExists(atPath: configPath) {
            return
        }
        FileManager.default.createFile(atPath: configPath, contents: nil, attributes: nil)
        let fileHandle = FileHandle(forWritingAtPath: configPath)!
        fileHandle.seekToEndOfFile()
        fileHandle.write(
            (netType == "mainnet" ? mainnetConfig : testnetConfig)
                .replacingOccurrences(of: "/data/", with: getHomeDir() + "/" + netType + "/data/")
                .data(using: .utf8)!)
        try? fileHandle.close()
    }
    
    func getHomeDir() -> String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }
}
