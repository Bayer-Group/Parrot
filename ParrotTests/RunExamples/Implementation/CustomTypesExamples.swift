protocol CustomProtocol: class {
    var customThing: Custom { get }
    var customProtocolThingGetSet: CustomProtocol { get set }
    var customThingGetSet: Custom { get set }
    var customProtocolThing: CustomProtocol { get }
    func returnCustom() -> AnotherCustom
    func returnCustomFormatted ()->AnotherCustom
}

class Custom: CustomProtocol {
    var customProtocolThingGetSet: CustomProtocol = Custom(propertyString: "get set", propertyInt: 3)
    var customThingGetSet = Custom(propertyString: "get set", propertyInt: 3)
    let customProtocolThing: CustomProtocol = Custom(propertyString: "protocolImplementation", propertyInt: 2)
    
    init(propertyString: String, propertyInt: Int) {
        
    }
    
    var customThing: Custom {
        return Custom(propertyString: "0", propertyInt: 0)
    }
    
    func functionWithCustom() -> Custom {
        return Custom(propertyString: "1", propertyInt: 1)
    }
    
    func returnCustom() -> AnotherCustom {
        return AnotherCustom(custom: self)
    }
    
    func returnCustomFormatted() -> AnotherCustom {
        return AnotherCustom(custom: self)
    }
}

final class AnotherCustom {
    let custom: CustomProtocol
    
    init(custom: CustomProtocol) {
        self.custom = custom
    }
}
