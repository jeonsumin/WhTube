//
//  ContentsViewController.swift
//  WhTube
//
//  Created by Terry on 2020/12/02.
//

import UIKit

class ContentsViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension ContentsViewController: UITableViewDataSource{
    
    //TODO: 셀 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    //TODO: 셀 데이터
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
    
}

extension ContentsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("SelectRowAt ::: \(indexPath.row)")
        let contentsDetailVC = storyboard?.instantiateViewController(identifier: "ContentDetailViewController") as! ContentDetailViewController
        navigationController?.pushViewController(contentsDetailVC, animated: true) 
    }
}

class ContentsListCell: UITableViewCell {
    
}
