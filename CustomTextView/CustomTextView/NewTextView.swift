import SwiftUI

struct TextView: UIViewRepresentable {

    typealias UIViewType = UITextView
    
    @Binding var text: String
    var configuration = { (view: UIViewType) in }
   
    
    //var text: Binding<String>
    //var onDone: (() -> Void)?

    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIViewType {
        let uiView = UIViewType()
        uiView.delegate = context.coordinator
        
        uiView.textColor = .red
        
        return uiView
    }

    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<Self>) {
        //configuration(uiView)
    }
    
    
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    final class Coordinator: NSObject, UITextViewDelegate {
        let parent: TextView
        
        init(parent: TextView) {
            self.parent = parent
        }
        
        func textViewDidChange(_ uiView: UITextView) {
            print("changed")
            parent.text = uiView.text
        }
        
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            ////            if let onDone = self.onDone, text == "\n" {
            ////                textView.resignFirstResponder()
            ////                onDone()
            ////                return false
            ////            }
            print("should change")
            return true
        }
    }
}
