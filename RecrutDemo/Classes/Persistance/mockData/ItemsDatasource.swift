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
        
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options: []) as? Array<Dictionary<String, Any>> {
                
                for (_, entityDict) in jsonArray.enumerated() {
                    
                    let uuid = entityDict["uuid"] as! String
                    let name = entityDict["name"] as! String
                    
                    var item = ThingModel(name: name)
                    item.uuid = uuid
                    
                    let imageArray = entityDict["image"] as? Array<String>
                    let urlString = imageArray?.first
                    item.image = urlString
                    print("\(item.name) \(urlString)")
                    allItems.append(item)
                }
            }
            
        } catch let error as NSError {
            print(error)
        }
    }
}
