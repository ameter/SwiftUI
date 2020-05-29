import SwiftUI

struct TextView: UIViewRepresentable {

    //typealias UIViewType = UITextView
    
    @Binding var text: String
    
    var returnKeyType = UIReturnKeyType.default
    var onCommit: (() -> Void)? = nil
    //var font: 
    
//    var configuration = { (view: UITextView) in }

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        
//        if onCommit != nil {
//            textView.returnKeyType = .done
//        }
        
        // style it here
        //textView.textColor = .red
        textView.returnKeyType = returnKeyType
        textView.font = .preferredFont(forTextStyle: .body)
        
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<Self>) {
//        configuration(uiView)
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
            parent.text = uiView.text
        }
        
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if let onCommit = parent.onCommit, text == "\n" {
                textView.resignFirstResponder()
                onCommit()
                return false
            }
            return true
        }
    }
}
