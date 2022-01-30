final class CharacterListPresenterSpy: CharactersListPresentable {
    private(set) var didCallShowItems = 0
    private(set) var itemsToShowSpy: [Character] = []
    
    func show(items: [Character]) {
        didCallShowItems += 1
        itemsToShowSpy = items
    }
}
