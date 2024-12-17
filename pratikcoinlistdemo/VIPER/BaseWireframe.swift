import UIKit

public protocol WireframeInterface: AnyObject {
    func popFromNavigationController(animated: Bool)
    func dismiss(animated: Bool)
}

open class Wireframe {

    fileprivate var _viewController: UIViewController

    public init(viewController: UIViewController) {
        _viewController = viewController
    }
    public var viewController: UIViewController {
        return _viewController
    }

    var navigationController: UINavigationController? {
        return viewController.navigationController
    }
}

extension Wireframe: WireframeInterface {
    public func popFromNavigationController(animated: Bool) {
        let _ = navigationController?.popViewController(animated: animated)
    }

    public func dismiss(animated: Bool) {
        navigationController?.dismiss(animated: animated)
    }
}

public extension UIViewController {

    func presentWireframe(_ wireframe: Wireframe, animated: Bool = true, wrapInNavigationController: Bool = false, completion: (() -> Void)? = nil) {
        present(wrapInNavigationController ? UINavigationController(rootViewController: wireframe.viewController) : wireframe.viewController, animated: animated, completion: completion)
    }

}

public extension UINavigationController {

    func pushWireframe(_ wireframe: Wireframe, animated: Bool = true) {
        self.pushViewController(wireframe.viewController, animated: animated)
    }

    func setRootWireframe(_ wireframe: Wireframe, animated: Bool = true) {
        self.setViewControllers([wireframe.viewController], animated: animated)
    }
}

public extension UITabBarController {
    
    func setWireframes(_ wireframes: Wireframe..., animated: Bool = false) {
        self.setViewControllers(wireframes.compactMap({ $0.viewController }), animated: animated)
    }
   
}
