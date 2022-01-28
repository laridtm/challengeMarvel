import UIKit

public enum CharacterListFactory {
    public static func make() -> UIViewController {
        let worker = CharactersListWorker()
        let controller = CharactersListViewController()
        let presenter = CharactersListPresenter(view: controller)
        let interactor = CharactersListInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        
        return controller
    }
}
