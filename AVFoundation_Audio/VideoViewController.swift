//
//  VideoViewController.swift
//  AVFoundation_Audio
//
//  Created by Alex M on 25.09.2022.
//

import UIKit
import AVKit

var videoList: [(name: String, link: String)] = [
    
    ("Complications and widgets: Reloaded WWDC22",                                           "https://devstreaming-cdn.apple.com/videos/wwdc/2022/10050/5/358B551F-283C-4CD1-8172-DAC014727969/cmaf.m3u8"),
    
    ("Design App Shortcuts WWDC22",
     "https://devstreaming-cdn.apple.com/videos/wwdc/2022/10169/5/8F7E31FB-73E9-405E-8031-74902FC37BB8/cmaf.m3u8"),
    
    ("Meet WeatherKit WWDC22",
     "https://devstreaming-cdn.apple.com/videos/wwdc/2022/10003/5/C8AAE478-A435-4DA4-8256-F32941E32204/cmaf.m3u8"),
    
    ("What's new in Vision WWDC22",
     "https://devstreaming-cdn.apple.com/videos/wwdc/2022/10024/3/9BD19E63-1BFD-49E9-A941-5CA5A937682C/cmaf.m3u8"),
    
    ("What's new in Xcode WWDC22",
     "https://devstreaming-cdn.apple.com/videos/wwdc/2022/110427/5/60E9EBA5-592E-48D0-9429-A85E40C4C9F0/cmaf.m3u8")
    
]



class VideoViewController: UIViewController, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        videoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        var content: UIListContentConfiguration = cell.defaultContentConfiguration()
        content.text = videoList[indexPath.row].name
        content.secondaryText = videoList[indexPath.row].link
        cell.contentConfiguration = content
        return cell
    }
    
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    private func layout() {
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    
}


extension VideoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        
        let streamURL = URL(string: videoList[indexPath.row].link)!
        
        let player = AVPlayer(url: streamURL)
        
        let controller = AVPlayerViewController()
        controller.player = player
        present(controller, animated: true) {
            player.play()
            
        }
    }
    
}
