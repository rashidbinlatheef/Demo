//
//  ThingViewModelBuilder.swift
//  RecrutDemo
//
//  Created by Muhammed Rashid on 15/11/21.
//  Copyright © 2021 YouGov. All rights reserved.
//

import Foundation

/// Protocol for building View model for `ThingCell` and `ThingDetailsViewController`
protocol ThingViewModelBuilding {
    /// Builds `ThingCellViewModel` from given `ThingModel`
    /// - Parameters:
    ///   - thingsModel: The model which is used to create View model
    func buildThingCellViewModel(thingsModel: ThingModel) -> ThingCellViewModel
    
    /// Builds `ThingDetailsVCViewModel` from given `ThingModel`
    /// - Parameters:
    ///   - thingsModel: The model which is used to create View model
    func buildThingDetailsVCViewModel(thingsModel: ThingModel) -> ThingDetailsVCViewModel
    
    /// Builds `ThingDetailsViewModel` from given `ThingModel`
    /// - Parameters:
    ///   - thingsModel: The model which is used to create View model
    func buildThingDetailsViewModel(thingsModel: ThingModel) -> ThingDetailsViewModel
}

final class ThingViewModelBuilder {
}

extension ThingViewModelBuilder: ThingViewModelBuilding {
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
    
    func buildThingDetailsVCViewModel(thingsModel: ThingModel) -> ThingDetailsVCViewModel {
        ThingDetailsVCViewModel(
            title: thingsModel.name
        )
    }
    
    func buildThingDetailsViewModel(thingsModel: ThingModel) -> ThingDetailsViewModel {
        ThingDetailsViewModel(
            imageUrlString: thingsModel.image
        )
    }
}
