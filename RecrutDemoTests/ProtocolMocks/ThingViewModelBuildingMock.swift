//
//  ThingViewModelBuildingMock.swift
//  RecrutDemoTests
//
//  Created by Muhammed Rashid on 16/11/21.
//  Copyright © 2021 YouGov. All rights reserved.
//

@testable import RecrutDemo

final class ThingViewModelBuildingMock: ThingViewModelBuilding {

    var buildThingCellViewModelThingsModelCallsCount = 0
    var buildThingCellViewModelThingsModelReceivedThingsModel: [ThingModel] = []
    var buildThingCellViewModelThingsModelReturnValue: ThingCellViewModel!
    var buildThingDetailsVCViewModelThingsModelCallsCount = 0
    var buildThingDetailsVCViewModelThingsModelReceivedThingsModel: [ThingModel] = []
    var buildThingDetailsVCViewModelThingsModelReturnValue: ThingDetailsVCViewModel!
    var buildThingDetailsViewModelThingsModelCallsCount = 0
    var buildThingDetailsViewModelThingsModelReceivedThingsModel: [ThingModel] = []
    var buildThingDetailsViewModelThingsModelReturnValue: ThingDetailsViewModel!

    func buildThingCellViewModel(thingsModel: ThingModel) -> ThingCellViewModel {
        buildThingCellViewModelThingsModelCallsCount += 1
        buildThingCellViewModelThingsModelReceivedThingsModel.append(thingsModel)
        return buildThingCellViewModelThingsModelReturnValue
    }

    func buildThingDetailsVCViewModel(thingsModel: ThingModel) -> ThingDetailsVCViewModel {
        buildThingDetailsVCViewModelThingsModelCallsCount += 1
        buildThingDetailsVCViewModelThingsModelReceivedThingsModel.append(thingsModel)
        return buildThingDetailsVCViewModelThingsModelReturnValue
    }

    func buildThingDetailsViewModel(thingsModel: ThingModel) -> ThingDetailsViewModel {
        buildThingDetailsViewModelThingsModelCallsCount += 1
        buildThingDetailsViewModelThingsModelReceivedThingsModel.append(thingsModel)
        return buildThingDetailsViewModelThingsModelReturnValue
    }
}
