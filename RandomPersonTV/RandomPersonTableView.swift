//
//  ViewController.swift
//  RandomPersonTV
//
//  Created by Brendon Crowe on 5/12/23.
//

import UIKit

class RandomPersonTableView: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let cellId = "personCell"
    private var people = [Person]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTV()
        fetchPeople()
    }
    
    private func configureTV() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func fetchPeople() {
        Task {
            let data = try await PersonAPIClient.fetchPeople()
            let decodedJSON = try JSONDecoder().decode(PeopleResults.self, from: data)
            people = decodedJSON.results
        }
    }
}

extension RandomPersonTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? PersonCell else {
            fatalError("could not dequeue a PersonCell")
        }
        let person = people[indexPath.row]
        cell.configureUI(person)
        return cell
    }
}

extension RandomPersonTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
