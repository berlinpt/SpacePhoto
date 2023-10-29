//
//  ViewController.swift
//  SpacePhoto
//
//  Created by Berlin Thomas on 2023-05-28.
//

import UIKit

//@MainActor
class ViewController: UIViewController {

    @IBOutlet var spaceImageView: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var copyrightLabel: UILabel!
    
    let photoInfoController = PhotoInfoController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //title = ""
        //spaceImageView.image = UIImage(systemName: "photo.on.rectangle")
        //descriptionLabel.text = ""
        //copyrightLabel.text = ""
        
        Task {
            do {
                let photoInfo = try await photoInfoController.fetchPhotoInfo()
                self.title = photoInfo.title
                self.copyrightLabel.text = photoInfo.copyright
                self.descriptionLabel.text = photoInfo.description
                updateUI(with: photoInfo)
            }
            catch {
                updateUI(with: error)
            }
        }
    }
    
    func updateUI(with photoInfo: PhotoInfo) {
        Task {
            do {
                let image = try await photoInfoController.fetchImage(from: photoInfo.url)
                title = photoInfo.title
                spaceImageView.image = image
                descriptionLabel.text = photoInfo.description
                copyrightLabel.text = photoInfo.copyright
            }
            catch {
                updateUI(with: error)
            }
        }
    }
    
    func updateUI(with error: Error) {
        title = "Error Fetching Photo"
        spaceImageView.image = UIImage(systemName: "exclamationmark.octagon")
        descriptionLabel.text = error.localizedDescription
        copyrightLabel.text = ""
    }
}

