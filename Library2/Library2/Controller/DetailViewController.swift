//
//  DetailViewController.swift
//  Library
//
//  Created by Kenneth Scanlon on 4/15/20.
//  Copyright © 2020 Kenneth Scanlon. All rights reserved.
//

import UIKit
import WebKit



class DetailViewController: UIViewController, UITextFieldDelegate {
    
    var bookBrain = BookBrain()
    var totalPage: Int = 0
    var currentInput: Int = 0
    var amazonURL: String?

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var detailTitle: UINavigationItem!
    @IBOutlet weak var coverView: WKWebView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var totalPages: UILabel!
    @IBOutlet weak var newPageEntry: UITextField!
    @IBOutlet weak var currentPageLabel: UILabel!
    

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            let dict = detail
            let name = dict["Title"]
            detailTitle.title = name as? String
            let urlString = dict["Cover"] as! String
            let currentPage = currentInput
            let total = dict["PageCount"] as! Int
            totalPage = total
            amazonURL = dict["Online"] as? String
            
            if let label = detailDescriptionLabel {
                label.text = ""
                let url = NSURL(string: urlString)!
                let request = URLRequest(url: url as URL)
                coverView.load(request)
                currentPageLabel.text = String(currentPage)
                totalPages.text = String(total)
                if (bookBrain.getProgress(currentPage: currentInput, pageCount: totalPage) == 1.0) {
                    progressLabel.text = "Congratulations! You have finished the book"
                    progressBar.progress = 1.0
                    progressBar.progressTintColor = UIColor.green
                } else {
                    progressLabel.text = "You are on page \(currentInput) out of \(total)"
                    progressBar.progress = bookBrain.getProgress(currentPage: currentInput, pageCount: totalPage)
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newPageEntry.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        configureView()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    var detailItem: [String: Any]! {
        didSet {
            // Update the view.
            configureView()
        }
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        currentInput = Int(newPageEntry.text!)!
        if (currentInput > totalPage) {
            currentInput = totalPage
        }
        newPageEntry.text = ""
        configureView()
    }
    
    @objc func keyboardWillChange(notification: Notification) {
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
            view.frame.origin.y = -keyboardRect.height
        } else {
            view.frame.origin.y = 0
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        newPageEntry.resignFirstResponder()
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "amazonSegue" {
            let desintationVC = segue.destination as! AmazonViewController
            desintationVC.urlString = amazonURL
        }
    }
    
    @IBAction func amazonButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "amazonSegue", sender: self)
    }
}

