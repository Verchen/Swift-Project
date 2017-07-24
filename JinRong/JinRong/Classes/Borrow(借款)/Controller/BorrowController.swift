//
//  BorrowController.swift
//  JinRong
//
//  Created by 乔伟成 on 2017/7/12.
//  Copyright © 2017年 乔伟成. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper


class BorrowController: BaseController, UITableViewDelegate, UITableViewDataSource {
    
    lazy var borrowTypeView: UITableView = {
        var table = UITableView(frame: CGRect.zero, style: .plain)
        table.delegate = self as UITableViewDelegate
        table.dataSource = self as UITableViewDataSource
        table.separatorStyle = .none
        return table
    }()
    
    lazy var progressView: UITableView = {
        var table = UITableView(frame: CGRect.zero, style: .plain)
        table.delegate = self as UITableViewDelegate
        table.dataSource = self as UITableViewDataSource
        table.separatorStyle = .none
        table.isHidden = true
        return table
    }()
    
    lazy var segmentView: UIView = {
        var segmentView = UIView()
        segmentView.backgroundColor = UIColor.theme
        return segmentView
    }()
    
    lazy var segment: UISegmentedControl = {
        let segm = UISegmentedControl(items: ["申请借款", "进度查询"])
        segm.setWidth(120, forSegmentAt: 0)
        segm.setWidth(120, forSegmentAt: 1)
        segm.addTarget(self, action: #selector(BorrowController.segmentChange(segment:)), for: .valueChanged)
        segm.tintColor = UIColor.white
        segm.selectedSegmentIndex = 0;
        return segm
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "佳易贷"
        view.addSubview(segmentView)
        segmentView.addSubview(segment)
        view.addSubview(borrowTypeView)
        view.addSubview(progressView)
        setupLayout()
        
        let params:Parameters = ["member_id":"10001"]
        Alamofire.request("https://api.canka168.com/api/homes", method:.post, parameters:params).responseJSON { (response) in
            if let jsonObj = response.value as? NSDictionary{
                let models = Mapper<RootClass>().mapArray(JSONArray: jsonObj["list"] as! Array)
                for model in models{
                    print(model.title)
                }
            }
        }
        
    }
    func setupLayout() -> Void {
        segmentView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(0)
            make.height.equalTo(45)
        }
        segment.snp.makeConstraints { (make) in
            make.center.equalTo(segmentView)
        }
        borrowTypeView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(segmentView.snp.bottom)
            make.bottom.equalTo(-49)
        }
        progressView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(segmentView.snp.bottom)
            make.bottom.equalTo(-49)
        }
    }
    
    //MARK: - tableview代理方法
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case borrowTypeView:
            return 5
        default:
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView {
        case borrowTypeView:
            var cell = tableView.dequeueReusableCell(withIdentifier: "ApplyCell") as? ApplyCell
            if cell == nil {
                cell = ApplyCell(style: .default, reuseIdentifier: "ApplyCell")
            }
            if indexPath.row == 0 {
                cell?.levelIcon.image = #imageLiteral(resourceName: "lock_open.png")
                cell?.lockView.isHidden = true
            }else{
                cell?.levelIcon.image = #imageLiteral(resourceName: "lock.png")
                cell?.lockView.isHidden = false
            }
            return cell!
        default:
            var cell = tableView.dequeueReusableCell(withIdentifier: "ProgressCell")
            if cell == nil {
                cell = ProgressCell(style: .default, reuseIdentifier: "ProgressCell")
            }
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch tableView {
        case borrowTypeView:
            if indexPath.row == 0 {
                let vc = BorrowDetailVC()
                navigationController?.pushViewController(vc, animated: true)
            }
        default:
            break
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case borrowTypeView:
            return 100
        default:
            return 200
        }
    }
    
    //MARK: - 自定义代理方法
    
    //MARK: - 事件方法
    func segmentChange(segment: UISegmentedControl) -> Void {
        switch segment.selectedSegmentIndex {
        case 0:
            progressView.isHidden = true
            borrowTypeView.isHidden = false
            break
            
        case 1:
            progressView.isHidden = false
            borrowTypeView.isHidden = true
            break
        
        default: break
            
        }
    }

}
