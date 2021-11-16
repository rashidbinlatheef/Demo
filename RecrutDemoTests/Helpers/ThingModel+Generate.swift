//
//  ThingModel+Generate.swift
//  RecrutDemoTests
//
//  Created by Muhammed Rashid on 16/11/21.
//  Copyright © 2021 YouGov. All rights reserved.
//

@testable import RecrutDemo

extension ThingModel {
    static func generate(
        name: String = "Alan Johnson",
        image: String? = "https://d93golxnkabrk.cloudfront.net/things/bb8144d5-a904-11e1-9412-005056900141.jpg?w=200",
        type: String? = "Public Figure",
        uuid: String = "bb8144d5-a904-11e1-9412-005056900141",
        like: Bool? = nil
    ) -> ThingModel {
        ThingModel(
            name: name,
            image: image,
            type: type,
            uuid: uuid,
            like: like
        )
    }
}
