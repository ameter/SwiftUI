import SwiftUI

struct TextView: UIViewRepresentable {

    //typealias UIViewType = UITextView
    
    @Binding var text: String
    @Binding var selected: Bool
    
    var returnKeyType = UIReturnKeyType.default
    var font = UIFont.TextStyle.body
    var textColor: UIColor? = nil
    var keyboardType = UIKeyboardType.default
    var selectAllOnEdit = false
    
    var editingBegan: (() -> Void)? = nil
    var editingEnded: (() -> Void)? = nil
    var editingChanged: (() -> Void)? = nil
    
    var onCommit: (() -> Void)? = nil
    
//    var configuration = { (view: UITextView) in }
    
    // I only added this init function (instead of using builtin init) because it's the only way to make the "selected" binding an optional parameter with a default value
    init(text: Binding<String>, selected: Binding<Bool> = .constant(false), returnKeyType:UIReturnKeyType = UIReturnKeyType.default, font: UIFont.TextStyle = UIFont.TextStyle.body, textColor: UIColor? = nil, keyboardType: UIKeyboardType = UIKeyboardType.default, selectAllOnEdit: Bool = false, editingBegan: (() -> Void)? = nil, editingEnded: (() -> Void)? = nil, editingChanged: (() -> Void)? = nil, onCommit: (() -> Void)? = nil) {
        
        self._text = text
        self._selected = selected
        self.returnKeyType = returnKeyType
        self.font = font
        self.textColor = textColor
        self.keyboardType = keyboardType
        self.selectAllOnEdit = selectAllOnEdit
        self.editingBegan = editingBegan
        self.editingEnded = editingEnded
        self.editingChanged = editingChanged
        self.onCommit = onCommit

    }

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        
//        if onCommit != nil {
//            textView.returnKeyType = .done
//        }
        
        // style it here
        textView.backgroundColor = .clear
        textView.usesStandardTextScaling = true
        textView.returnKeyType = returnKeyType
        textView.font = .preferredFont(forTextStyle: font)
        if let textColor = textColor { textView.textColor = textColor }
        textView.keyboardType = keyboardType
        
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<Self>) {
//        configuration(uiView)
        if !uiView.isFirstResponder {
            uiView.text = text
        }
        
        if selected && text.isEmpty { uiView.becomeFirstResponder() }
    }
    
    
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    final class Coordinator: NSObject, UITextViewDelegate {
        let parent: TextView
        
//        var isEditing = false
        
        init(parent: TextView) {
            self.parent = parent
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
//            isEditing = true
            if parent.selectAllOnEdit {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    textView.selectAll(nil)
                }
            }
            parent.editingBegan?()
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            //parent.text = textView.text
//            isEditing = false
            parent.editingEnded?()
        }
        
        func textViewDidChange(_ uiView: UITextView) {
            parent.text = uiView.text
            parent.editingChanged?()
//            if uiView.text.isEmpty {
//                parent.showPlaceholder = true
//            } else {
//                parent.showPlaceholder = false
//            }
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


