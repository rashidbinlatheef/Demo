//
//  ThinkCellViewModelBuilder.swift
//  RecrutDemo
//
//  Created by Muhammed Rashid on 15/11/21.
//  Copyright © 2021 YouGov. All rights reserved.
//

import Foundation

/// Protocol for building View model for `ThinkCell`
protocol ThinkCellViewModelBuilding {
    /// Builds `ThingCellViewModel` from given `ThingModel`
    /// - Parameters:
    ///   - thingsModel: The model which is used to create View model
    func buildThingCellViewModel(thingsModel: ThingModel) -> ThingCellViewModel
}

final class ThinkCellViewModelBuilder {
}

extension ThinkCellViewModelBuilder: ThinkCellViewModelBuilding {
    func buildThingCellViewModel(thingsModel: ThingModel) -> ThingCellViewModel {
        if let isLiked = thingsModel.like {
            return ThingCellViewModel(
                name: thingsModel.name,
                imageUrlString: thingsModel.image,
                likeImage: isLiked ? .likeImage : .dislikeImage
            )
        } else {
            return ThingCellViewModel(
                name: thingsModel.name,
                imageUrlString: thingsModel.image,
                likeImage: nil
            )
        }
    }
}
