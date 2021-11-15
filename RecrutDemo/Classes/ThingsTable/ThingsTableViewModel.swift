import Foundation

struct ThingsTableViewModel {
    private var things: [ThingModel] = mockData()
    var datasourceCount: Int {
        return things.count
    }
    
    func indexOf(_ thingModel: ThingModel) -> Int? {
        things.firstIndex { $0.uuid == thingModel.uuid }
    }
    
    func thing(for indexPath: IndexPath) -> ThingModel {
        return things[indexPath.row]
    }
}
