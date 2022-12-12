import XCTest
@testable import Alert
import ViewControllerPresentationSpy

final class ViewControllerTests: XCTestCase {
        
    func test_tappingButton_shouldShowAlert() {
        let (sut, alertVerifier) = makeSUT()
    
        tap(sut.button)
        
        alertVerifier.verify(title: "Do the thing?", message: "Let us know if you want to do the thing.", animated: true, actions: [
            .cancel("Cancel"),
            .default("OK")
        ], presentingViewController: sut)
        
        XCTAssertEqual(alertVerifier.preferredAction?.title, "OK", "preferred action")
    }
    
    func test_executeAlertAction_withOKButton() throws {
        let (sut, alertVerifier) = makeSUT()
    
        tap(sut.button)

        try alertVerifier.executeAction(forButton: "OK")
    }
    
}

extension ViewControllerTests {
    // MARK: - Helpers
    func makeSUT() -> (sut: ViewController, alertVerifier: AlertVerifier) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut: ViewController = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))
        let alertVerifier = AlertVerifier()

        sut.loadViewIfNeeded()
        
        return (sut, alertVerifier)
    }
}
