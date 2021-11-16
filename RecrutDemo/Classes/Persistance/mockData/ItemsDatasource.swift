import Foundation

func mockData() -> [ThingModel] {
    
    let mockDatasource = ItemsDatasource()
    let things = mockDatasource.allItems
    
    return things
}

struct ItemsDatasource {
    
    var allItems = Array<ThingModel>()
    init() {
        getItemsFromFile()
    }
    
    mutating func getItemsFromFile() {
        let path = Bundle.main.path(forResource: "entities", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        let jsonData = try! Data(contentsOf: url)
        
        let jsonDecoder = JSONDecoder()
        if let items = try? jsonDecoder.decode([ThingModel].self, from: jsonData) {
            allItems = items
        }
    }
}
