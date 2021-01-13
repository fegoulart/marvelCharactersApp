//
//  SingleCharacterErrors.swift
//  marvel
//
//  Created by Fernando Luiz Goulart on 12/01/21.
//  Copyright © 2021 Fernando Luiz Goulart. All rights reserved.
//

enum SingleCharacterErrors: Error {
    case couldNotLoadComics(error: String)
    case couldNotLoadSeries(error: String)
}
