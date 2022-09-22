//
//  PhotoTableViewCell.swift
//  FlickRApp
//
//  Created by Joshua on 20/09/2022.
//

import UIKit
class PhotoTableViewCell: UITableViewCell {
    private struct StringConstants {
        static let Author = "Author ID: "
    }

    @IBOutlet weak var photoImageView: CustomImageView!
    @IBOutlet weak var posterIDLabel: UILabel!
    @IBOutlet weak var pictureTagsLabel: UILabel!
    @IBOutlet weak var userIconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
        pictureTagsLabel.text = nil
        posterIDLabel.text = nil
    }

    func setupCell(_ picture: PhotoItem) {
        guard let imageUrl = picture.media.first?.value,
              let url = URL(string: imageUrl) else { return }

        photoImageView.loadImage(from: url)
        posterIDLabel.text = StringConstants.Author + picture.authorID
        pictureTagsLabel.text = picture.tags
    }
}

