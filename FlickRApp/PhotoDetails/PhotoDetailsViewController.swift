//
//  PhotoDetailsViewController.swift
//  FlickRApp
//
//  Created by Joshua on 13/09/2022.
//

import UIKit

class PhotoDetailsViewController: UIViewController {
    
    private struct StringConstants {
        static let DateTaken = "Date Taken: "
        static let Author = "Author: "
        static let DatePublished = "Date Published: "
        static let ImageAccessibilityText = "This is "
    }
    private struct IntConstants {
        static let maxBodyTextFontSize = 25
    }

    var image: PhotoItem?
    @IBOutlet weak var detailedPictureImageView: CustomImageView!
    
    @IBOutlet weak var pictureTitleLabel: UILabel! {
        didSet {
            pictureTitleLabel.textColor = CommonConstants.Indentifiers.GlobalColour
        }
    }
    @IBOutlet weak var pictureTakenDateLabel: UILabel!
    @IBOutlet weak var pictureDescriptionLabel: UILabel!
    
    @IBOutlet weak var pictureAuthorLabel: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let bodyFont = UIFontMetrics(forTextStyle: .body)
        pictureTakenDateLabel.font = bodyFont.scaledFont(for: .systemFont(ofSize: 17),
                                                                maximumPointSize: CGFloat(IntConstants.maxBodyTextFontSize))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        assignPictureDetails()
        setupUI()
    }

    private func setupUI() {
        detailedPictureImageView.layer.cornerRadius = detailedPictureImageView.frame.width / 10
        detailedPictureImageView.layer.borderWidth = 2
        detailedPictureImageView.layer.borderColor = CommonConstants.Indentifiers.GlobalColour.cgColor
    }

    private func assignPictureDetails() {
        guard let imageUrl = image?.media.first?.value,
              let url = URL(string: imageUrl),
        let dateTaken = image?.dateTaken.getStringToDate(),
        let datePublished = image?.published.getStringToDate(),
        let title = image?.title,
        let author = image?.author else { return }
        detailedPictureImageView.loadImage(from: url)
        pictureTitleLabel.text = title
        pictureTakenDateLabel.text = StringConstants.DateTaken + dateTaken
        pictureDescriptionLabel.text = StringConstants.DatePublished + datePublished
        pictureAuthorLabel.text = StringConstants.Author + author
        detailedPictureImageView.accessibilityLabel = StringConstants.ImageAccessibilityText + title
        pictureTitleLabel.isAccessibilityElement = true
        pictureTitleLabel.isAccessibilityElement = false

    }
}

