import UIKit

public enum CharacterDetailsFactory {
    public static func make(character: Character) -> UIViewController {
        let worker = CharacterDetailsWorker()
        let controller = CharacterDetailsViewController()
        let presenter = CharacterDetailsPresenter(view: controller)
        let interactor = CharacterDetailsInteractor(presenter: presenter, worker: worker, character: character)
        
        controller.interactor = interactor
        
        return controller
    }
}
