private var instantiators: [String: Any] = [:]
private var mockInstantiators: [String: Any] = [:]

enum SimpleDI {
    static var isTestEnvironment = false

    static func bind<T>(_ interfaceType: T.Type, instantiator: @escaping () -> T) -> () -> T {
        instantiators[String(describing: interfaceType)] = instantiator
        return self.instance
    }

    private static func instance<T>() -> T {
        if self.isTestEnvironment {
            guard let mockInstantiator = mockInstantiators[String(describing: T.self)] as? () -> T else {
                fatalError("Type \(String(describing: T.self)) unmocked in test!")
            }
            return mockInstantiator()
        }
        let key = String(describing: T.self)
        let instantiator = instantiators[key] as! () -> T
        return instantiator()
    }

    static func mock<T>(_ interfaceType: T.Type, instantiator: @escaping () -> T) {
        mockInstantiators[String(describing: interfaceType)] = instantiator
    }
}
