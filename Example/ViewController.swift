//
//  ViewController.swift
//  MarkdownTextView
//
//  Created by Indragie on 4/27/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

import UIKit
import MarkdownTextView

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attributes = MarkdownAttributes()
        let textStorage = MarkdownTextStorage(attributes: attributes)
        var error: NSError?
        if let linkHighlighter = LinkHighlighter(errorPtr: &error) {
            textStorage.addHighlighter(linkHighlighter)
        } else {
            assertionFailure("Error initializing LinkHighlighter: \(error)")
        }
        textStorage.addHighlighter(MarkdownStrikethroughHighlighter())
        textStorage.addHighlighter(MarkdownSuperscriptHighlighter())
        if let codeBlockAttributes = attributes.codeBlockAttributes {
            textStorage.addHighlighter(MarkdownFencedCodeHighlighter(attributes: codeBlockAttributes))
        }
        
        let textView = MarkdownTextView(frame: CGRectZero, textStorage: textStorage)
        textView.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(textView)
        
        let views = ["textView": textView]
        var constraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-20-[textView]-20-|", options: nil, metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[textView]-20-|", options: nil, metrics: nil, views: views)
        NSLayoutConstraint.activateConstraints(constraints)
    }
}
