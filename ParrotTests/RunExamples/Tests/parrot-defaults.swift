import Foundation

let parrot_customThing: Custom = Custom(propertyString: "", propertyInt: 0)
let parrot_anotherCustom: AnotherCustom = AnotherCustom(custom: Custom(propertyString: "", propertyInt: 0))
let parrot_customProtocol: CustomProtocol = Custom(propertyString: "protocol", propertyInt: 1)
let parrot_customFunction: (String?, Int?) -> () = { _, _ in } // This shouldn't be necessary
let parrot_Date: Date = Date()
let parrot_Uuid: UUID = UUID()
