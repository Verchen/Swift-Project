//
//  ProfileController.swift
//  JinRong
//
//  Created by 乔伟成 on 2017/7/12.
//  Copyright © 2017年 乔伟成. All rights reserved.
//

import UIKit

class ProfileController: BaseController, UITableViewDelegate, UITableViewDataSource {

    lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64 - 49), style: .grouped)
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfig()
        view.addSubview(tableView)
        
    }
    
    //MARK: - tableview代理方法
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        switch indexPath.row {
        case 0:
            cell?.imageView?.image = #imageLiteral(resourceName: "tabbar_home_highlighted")
            cell?.textLabel?.text = "我的信息"
        case 1:
            cell?.imageView?.image = #imageLiteral(resourceName: "tabbar_home_highlighted")
            cell?.textLabel?.text = "账单查询"
        case 2:
            cell?.imageView?.image = #imageLiteral(resourceName: "tabbar_home_highlighted")
            cell?.textLabel?.text = "修改密码"
        case 3:
            cell?.imageView?.image = #imageLiteral(resourceName: "tabbar_home_highlighted")
            cell?.textLabel?.text = "我的银行卡"
        case 4:
            cell?.imageView?.image = #imageLiteral(resourceName: "tabbar_home_highlighted")
            cell?.textLabel?.text = "设置"
        default: break
            
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 120))
        header.backgroundColor = UIColor.white
        
        let background = UIView(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 80))
        background.backgroundColor = UIColor.theme
        header.addSubview(background)
        
        let avator = UIImageView(frame: CGRect.init(x: 20, y: 20, width: 80, height: 80))
        avator.layer.cornerRadius = 40
        avator.clipsToBounds = true
        avator.image = #imageLiteral(resourceName: "placeholder.png")
        avator.layer.borderColor = UIColor.theme.cgColor
        avator.layer.borderWidth = 2
        header.addSubview(avator)
        
        let name = UILabel(frame: CGRect.init(x: avator.frame.maxX + 10, y: background.frame.maxY - 30, width: UIScreen.main.bounds.width - 120, height: 30))
        name.font = UIFont.systemFont(ofSize: 20)
        name.text = "叫我乔哥就好了"
        name.textColor = UIColor.white
        header.addSubview(name)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60))
        footer.backgroundColor = UIColor(valueRGB: 0xEFEFF4)
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 20, width: footer.frame.width, height: 40)
        button.setTitle("退出登录", for: .normal)
        button.backgroundColor = UIColor.theme
        button.addTarget(self, action: #selector(ProfileController.logout), for: .touchUpInside)
        footer.addSubview(button)
        
        return footer
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    
    //MARK: - 私有方法
    func setupConfig() -> Void {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icon_setting.png").withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(ProfileController.settingClick))
    }
    
    //MARK: - 事件方法
    func logout() -> Void {
        navigationController?.pushViewController(LoginVC(), animated: true)
    }
    func settingClick() -> Void {
        navigationController?.pushViewController(SettingVC(), animated: true)
    }
}
