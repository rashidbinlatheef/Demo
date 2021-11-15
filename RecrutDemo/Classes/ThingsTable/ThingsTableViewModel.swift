import Foundation

struct ThingsTableViewModel {
    
    let imageProvider = ImageProvider()
    var things = mockData()
    var datasourceCount: Int {
        return things.count
    }
    
    let thinkCellViewModelBuilder: ThinkCellViewModelBuilding
    
    init(thinkCellViewModelBuilder: ThinkCellViewModelBuilding = ThinkCellViewModelBuilder()) {
        self.thinkCellViewModelBuilder = thinkCellViewModelBuilder
    }
    
    func thingsCellViewModel(for indexPath: IndexPath) -> ThingCellViewModel {
        return thinkCellViewModelBuilder.buildThingCellViewModel(
            thingsModel: thing(for: indexPath)
        )
    }
    
    func indexOf(_ thingModel: ThingModel) -> Int? {
        things.firstIndex { $0.uuid == thingModel.uuid }
    }
    
    func thing(for indexPath: IndexPath) -> ThingModel {
        return things[indexPath.row]
    }
}
