import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Button("start mainnet light") {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/let rustGreetings = RustGreetings()
                rustGreetings.startLight(netType: "mainnet")
            }
            Button("start testnet light") {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/let rustGreetings = RustGreetings()
                rustGreetings.startLight(netType: "testnet")
            }
            Button("stop light client") {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/let rustGreetings = RustGreetings()
                rustGreetings.stopLight()
            }
            Button("get_scripts") {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/let rustGreetings = RustGreetings()
                rustGreetings.rpcRequest(methodName: "get_scripts", params: [])
            }
            Button("set_scripts") {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/let rustGreetings = RustGreetings()
                rustGreetings.rpcRequest(
                    methodName: "set_scripts",
                    params: [
                        [
                            [
                                "script": [
                                    "code_hash": "0x9bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce8",
                                    "hash_type": "type",
                                    "args": "0x89c1bff68855f1b35d8af6790fd04c6f3fbe4ea4"
                                ],
                                "script_type": "lock",
                                "block_number": "0xd62b58"
                            ]
                        ],
                        "all"
                    ]
                )
            }
            Button("get_cells") {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/let rustGreetings = RustGreetings()
                rustGreetings.rpcRequest(
                    methodName: "get_cells",
                    params: [
                        [
                            "script": [
                                "code_hash": "0x9bd7e06f3ecf4be0f2fcd2188b23f1b9fcc88e5d4b65a8637b17723bbda3cce8",
                                "hash_type": "type",
                                "args": "0x89c1bff68855f1b35d8af6790fd04c6f3fbe4ea4"
                            ],
                            "script_type": "lock"
                        ],
                        "asc",
                        "0x64"
                    ]
                )
            }
            Button("get_tip_header") {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/let rustGreetings = RustGreetings()
                rustGreetings.rpcRequest(methodName: "get_tip_header", params: [])
            }
            Button("fetch_transaction") {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/let rustGreetings = RustGreetings()
                rustGreetings.rpcRequest(methodName: "fetch_transaction", params: ["0x5dadc517c2605745c50412b425f7f32a5a4887396a155152be2cd34672d80c35"])
            }
            Button("get_peers") {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/let rustGreetings = RustGreetings()
                rustGreetings.rpcRequest(methodName: "get_peers", params: [])
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
