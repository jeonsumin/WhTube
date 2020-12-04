//
//  ChannelViewController.swift
//  WhTube
//
//  Created by Terry on 2020/12/02.
//

import UIKit
import Kingfisher

class ChannelViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var channel : [channels] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        NetworkManager.channelRequest { (channels :[channels]) in
            print("count ::: \(self.channel.count)")
        }
    }
}

//MARK: - CollectionView
extension ChannelViewController: UICollectionViewDataSource {
    //TODO: collectionView 아이템 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    //TODO: colectionView 데이터
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectChannelListCell
        
        cell.backgroundColor = UIColor.randomColor()
//        let thumbnailURL = URL(string: channel[indexPath.row].profileImg)
//        cell.thumbnailImg.kf.setImage(with: thumbnailURL)
        return cell
    }
    
    
}

extension ChannelViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.tableView.reloadData()
    }
}

extension ChannelViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
}

class CollectChannelListCell: UICollectionViewCell {
    @IBOutlet weak var thumbnailImg: UIImageView!
}
//MARK: - TableView


extension ChannelViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as? TableChannelListCell else {
            return UITableViewCell()
        }
        
        cell.backgroundColor = UIColor.randomColor()
        
        return cell
    }
    
    
}

extension ChannelViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(identifier: "ContentDetailViewController") as! ContentDetailViewController
        
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
}

class TableChannelListCell: UITableViewCell{
    
}
