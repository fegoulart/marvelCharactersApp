//
//  Optional+Extensions.swift
//  marvel
//
//  Created by Fernando Luiz Goulart on 04/01/21.
//  Copyright © 2021 Fernando Luiz Goulart. All rights reserved.
//

extension Optional {
    func or(_ other: Optional) -> Optional {
        switch self {
        case .none: return other
        case .some: return self
        }
    }
}

extension Optional {
    func resolve(with error: @autoclosure () -> Error) throws -> Wrapped {
        switch self {
        case .none: throw error()
        case .some(let wrapped): return wrapped
        }
    }
}
