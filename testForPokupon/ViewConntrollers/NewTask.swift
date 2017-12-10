//
//  NewTask.swift
//  testForPokupon
//
//  Created by Stanislav Astakhov on 28.11.17.
//  Copyright © 2017 Stanislav Astakhov. All rights reserved.
//

import UIKit

class NewTask: UIViewController {
    // MARK: Private Properties
    @IBOutlet weak private var headerTextField: UITextField!
    @IBOutlet weak private var descriptionTextView: UITextView!

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Новая задача"
        setupUI()
    }

    // MARK: Actions
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        let task = MyTasks(context: context)
        task.headerText = headerTextField.text!
        task.descriptionText = descriptionTextView.text!

        //save the data to CoreData
        (UIApplication.shared.delegate as! AppDelegate).saveContext()

        //need close modal screen
        dismiss(animated: true)
    }

    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        //need close modal screen
        dismiss(animated: true)
    }

    //MARK: Private Methods
    private func setupUI() {
        descriptionTextView.layer.cornerRadius = 5
        descriptionTextView.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        descriptionTextView.layer.borderWidth = 0.5
        descriptionTextView.clipsToBounds = true
        descriptionTextView.textContainer.maximumNumberOfLines = 2
    }
}
