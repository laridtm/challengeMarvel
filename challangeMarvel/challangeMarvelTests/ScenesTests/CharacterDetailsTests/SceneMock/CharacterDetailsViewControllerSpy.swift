import Foundation

final class CharacterDetailsViewControllerSpy: CharacterDetailsView {
    private(set) var didCallShowCharacter = 0
    private(set) var characterToShowSpy: Character?
    
    private(set) var didCallShowComics = 0
    private(set) var comicsToShowSpy: [Comic] = []
    
    func show(character: Character) {
        didCallShowCharacter += 1
        characterToShowSpy = character
    }
    
    func show(comics: [Comic]) {
        didCallShowComics += 1
        comicsToShowSpy = comics
    }
}
