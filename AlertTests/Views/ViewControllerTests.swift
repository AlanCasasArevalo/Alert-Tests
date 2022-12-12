import XCTest
@testable import Alert
import ViewControllerPresentationSpy

final class ViewControllerTests: XCTestCase {
    
    private var alertVerifier: AlertVerifier!
    
    
    override func setUp() {
        super.setUp()
        alertVerifier = AlertVerifier()
    }
    
    override func tearDown() {
        super.tearDown()
        alertVerifier = nil
    }
        
    func test_tappingButton_shouldShowAlert() {
    
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut: ViewController = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))
        
        sut.loadViewIfNeeded()

        tap(sut.button)
        
        alertVerifier.verify(title: "Do the thing?", message: "Let us know if you want to do the thing.", animated: true, actions: [
            .cancel("Cancel"),
            .default("OK")
        ], presentingViewController: sut)
        
        XCTAssertEqual(alertVerifier.preferredAction?.title, "OK", "preferred action")
    }
}
