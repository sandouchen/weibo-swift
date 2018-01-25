//
//  MessageViewController.swift
//  weibo-swift
//
//  Created by fqq3 on 2018/1/19.
//  Copyright © 2018年 sandouchan. All rights reserved.
//

import UIKit

class MessageViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitorView.setupVisitorViewInfo(iconName: "visitordiscover_image_message", tipTitle: "登陆后，别人评论你的微博，给你发消息，都会在这里收到通知")
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */


}
