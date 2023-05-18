//
//  PersonCell.swift
//  RandomPersonTV
//
//  Created by Brendon Crowe on 5/12/23.
//

import UIKit

class PersonCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var personNameLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.layer.cornerRadius = photoImageView.frame.width / 2
    }
    
    public func configureUI(_ person: Person) {
        Task {
            let name = person.name.first.capitalized + " " + person.name.last.capitalized
            personNameLabel.text = name
            photoImageView.image = try await PersonAPIClient.fetchPhoto(person.picture.medium)
        }
    }
}
