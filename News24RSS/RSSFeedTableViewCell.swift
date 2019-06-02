//
//  RSSFeedTableViewCell.swift
//  News24RSS
//
//  Created by Wafiq Salie on 2019/06/02.
//  Copyright © 2019 EndCrypt3d. All rights reserved.
//

import UIKit

class RSSFeedTableViewCell: UITableViewCell {

    private var data: RSSFeedResponse.Item?
    
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var feedTitleLabel: UILabel!
    @IBOutlet weak var feedDescriptionLabel: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data: RSSFeedResponse.Item){
        self.data = data
        
        DispatchQueue.main.async {
            self.configureUI()
        }
    }
    
    private func configureUI(){
        
        if let imageUrl = URL(string: data!.enclosure.link){
            URLSession.shared.dataTask(with: imageUrl, completionHandler: {(data, response, error) -> Void in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    self.feedImageView.image = UIImage(data: data)
                }
            }).resume()
        }
        self.feedTitleLabel.text = data?.title
        self.feedDescriptionLabel.text = data?.itemDescription
    }
}
