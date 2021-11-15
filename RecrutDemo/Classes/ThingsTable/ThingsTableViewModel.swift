import Foundation

struct ThingsTableViewModel {
    
    let imageProvider = ImageProvider()
    var things = mockData()
    var datasourceCount: Int {
        return things.count
    }
    
    func thing(for indexPath: IndexPath) -> ThingModel {
        return things[indexPath.row]
    }
    
    mutating func bindModelWithView(cell: ThingCell, at indexPath: IndexPath) {
        things[indexPath.row].modelCell = cell
    }
}











