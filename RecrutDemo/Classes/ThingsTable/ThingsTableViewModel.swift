import Foundation

struct ThingsTableViewModel {
    private let things: [ThingModel]
    
    init(
        things: [ThingModel] = mockData()
    ) {
        self.things = things
    }
    
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
