//
//  Copyright (c) 2018. Uber Technologies
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Basic
import Foundation
import Utility

func main() {
    let parser = ArgumentParser(usage: "<subcommand> <options>", overview: "Needle DI code generator.")
    let commandsTypes: [Command.Type] = [GenerateCommand.self]
    let commands = commandsTypes.map { $0.init(parser: parser) }
    let inputs = Array(CommandLine.arguments.dropFirst())
    do {
        let args = try parser.parse(inputs)
        if let subparserName = args.subparser(parser) {
            for command in commands {
                if subparserName == command.name {
                    command.execute(with: args)
                }
            }
        } else {
            parser.printUsage(on: stdoutStream)
        }
    } catch {
        print("Command-line pasing error (use --help for help):", error)
    }
}

main()
