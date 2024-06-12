//
//  ChatsViewController.swift
//  IncuLink
//
//  Created by Batch-2 on 21/05/24.
//

import UIKit

class ChatsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = "John Dae"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    
    @IBOutlet var myTable :UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        myTable.dataSource = self
        myTable.delegate = self

       
    }
    
}
