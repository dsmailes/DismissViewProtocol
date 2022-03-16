import Combine
import SwiftUI

struct DismissViewComponent: Identifiable {
    var id = UUID()
    var dismissViewPublisher = PassthroughSubject<Bool, Never>()
    var shouldDismissView = false {
        didSet {
            dismissViewPublisher.send(self.shouldDismissView)
        }
    }
}

protocol DismissViewProtocol {
    var dismissComponent: DismissViewComponent { get set }
}

extension DismissViewProtocol {
    var dismissViewPublisher: PassthroughSubject<Bool, Never> {
        get { return dismissComponent.dismissViewPublisher }
    }

    var shouldDismissView: Bool {
        get { return dismissComponent.shouldDismissView }
        set { dismissComponent.shouldDismissView = newValue }
    }
}

struct DismissableView: ViewModifier {
    @Environment(\.presentationMode) var presentationMode
    let viewModel: DismissViewProtocol

    func body(content: Content) -> some View {
        content
            .onReceive(viewModel.dismissComponent.dismissViewPublisher) { value in
                if value {
                    presentationMode.wrappedValue.dismiss()
                }
            }
    }
}

extension View {
    func dismissable(_ viewModel: DismissViewProtocol) -> some View {
        modifier(DismissableView(viewModel: viewModel))
    }
}
