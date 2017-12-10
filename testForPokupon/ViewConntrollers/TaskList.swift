//
//  TaskList.swift
//  testForPokupon
//
//  Created by Stanislav Astakhov on 28.11.17.
//  Copyright © 2017 Stanislav Astakhov. All rights reserved.
//

import UIKit

class TaskList: UIViewController {
    // MARK: Private Properties
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak private var currentTableView: UITableView!

    private var tasks: [MyTasks] = []

    private struct Constants {
        static let TaskCellName = "ProtoTableViewCell"
    }

    @IBOutlet weak private var tasksTableView: UITableView!

    // MARK: Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        getData()
        currentTableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        currentTableView.delegate = self
        currentTableView.dataSource = self

        currentTableView.register(UINib(nibName: Constants.TaskCellName ,bundle: nil),
                                  forCellReuseIdentifier: Constants.TaskCellName)

        self.navigationItem.title = "Список задач"

        self.currentTableView.tableFooterView = UIView()
    }

    //MARK: Private Methods
    private func getData() {
        do {
            tasks = try context.fetch(MyTasks.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
    }

    //MARK: Actions
    @IBAction func addNewTask(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showTaskModally", sender: nil)
    }
    
}
extension TaskList: UITableViewDataSource, UITableViewDelegate {
    // MARK: Table view methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TaskCellName, for: indexPath) as! ProtoTableViewCell

        let task = tasks[indexPath.row]

        guard let headerText = task.headerText,
            let descriptionText = task.descriptionText else { return UITableViewCell() }

        cell.configure(headerText: headerText, descriptionText: descriptionText)

        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = tasks[indexPath.row]
            context.delete(task)

            (UIApplication.shared.delegate as! AppDelegate).saveContext()

            do {
                tasks = try context.fetch(MyTasks.fetchRequest())
            } catch {
                print("Fetching Failed")
            }
        }
        tableView.reloadData()
    }
}

