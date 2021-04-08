//
//  ContentsViewController.swift
//  WhTube
//
//  Created by Terry on 2020/12/02.
//

import UIKit
import Kingfisher

class ContentsViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    var viewModel: ContentsViewModel!
    
    //MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ContentsViewModel(changeHandler: { contents in
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        })
        viewModel.fetchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
    }
    
    
    //MARK: - Private Method
}


//MARK: - TableViewDelegate And DataSource
extension ContentsViewController: UITableViewDataSource, UITableViewDelegate{
    
    //TODO: 셀 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    //TODO: 셀 데이터
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = viewModel.cell(for: indexPath, at: tableView)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contentsDetailVC = storyboard?.instantiateViewController(identifier: "ContentDetailViewController") as! ContentDetailViewController
        let selectByContent = viewModel.selectByContent(at: indexPath)
        let channelImage = viewModel.selectedContentChannel(channelId: selectByContent.channelId)
        contentsDetailVC.contentBy = selectByContent
        
        contentsDetailVC.channlImageURL = channelImage
        navigationController?.pushViewController(contentsDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 312
    }
}
