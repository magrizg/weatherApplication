//
//  RouterBaseInput.swift
//
//  Created by Mikhail Garbuz on 30.10.17.
//  Copyright © 2017 mg. All rights reserved.
//

protocol RouterBaseInput {
    func closeModule()
    func closeModule(completion: (() -> Void)?)
}
