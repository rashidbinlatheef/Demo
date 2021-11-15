import Foundation

protocol ThingDetailsDelegate {
    
    func thingDetails(viewController: ThingDetailsViewController, didLike thingModel: inout ThingModel)
    func thingDetails(viewController: ThingDetailsViewController, didDislike thingModel: inout ThingModel)
    func thingDetails(viewController: ThingDetailsViewController, willDismiss thingModel: inout ThingModel)
}
