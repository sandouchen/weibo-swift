//
//  ComposeViewController.swift
//  weibo-swift
//
//  Created by fqq3 on 2018/2/6.
//  Copyright © 2018年 sandouchan. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    @IBOutlet weak var composeTextView: ComposeTextView!
    
    @IBOutlet weak var picPickerView: PicPickerCollectionView!
    
    @IBOutlet weak var bottomToolViewCons: NSLayoutConstraint!
    
    @IBOutlet weak var picPicerViewHCons: NSLayoutConstraint!
    
    @IBOutlet weak var textCountBtn: UIButton!
    
    private lazy var composeTitleView = ComposeTitleView.composeTitleView()
    
    private lazy var images = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置导航栏
        setupNavigationBar()
        // 添加通知
        setupNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        composeTextView.becomeFirstResponder()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - 设置UI界面
extension ComposeViewController {
    /// 设置导航栏按钮
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(ComposeViewController.closeItemClick))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: .plain, target: self, action: #selector(ComposeViewController.sendItemClick))
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        composeTitleView.frame = CGRect(x: 0, y: 0, width: 150, height: 44)
        navigationItem.titleView = composeTitleView
    }

    /// 添加通知
    private func setupNotifications() {
        // 监听键盘通知
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillChangeFrame(note:)), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        // 监听键盘通知
        NotificationCenter.default.addObserver(self, selector: #selector(self.addPhotoClick), name: NSNotification.Name(rawValue: PicPickerAddPhotoNote), object: nil)
        
        // 监听键盘通知
        NotificationCenter.default.addObserver(self, selector: #selector(self.removePhotoClick(note:)), name: NSNotification.Name(rawValue: PicPickerRemovePhotoNote), object: nil)
    }
}

// MARK:- 事件监听函数
extension ComposeViewController {
    @objc private func closeItemClick() {
        composeTextView.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func sendItemClick() {
        SDLog("sendItemClick")
    }
    
    /// 监听键盘弹出
    @objc func keyboardWillChangeFrame(note: Notification) {
        let userInfo = note.userInfo!
        let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        let y = endFrame.origin.y
        let margin = UIScreen.main.bounds.height - y
        bottomToolViewCons.constant = -margin
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }

    @IBAction func picPickerBtnClick() {
        composeTextView.resignFirstResponder()
        
        picPicerViewHCons.constant = UIScreen.main.bounds.height * 0.65
        
        UIView .animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func emoticonBtnClick() {
        composeTextView.resignFirstResponder()
        
        composeTextView.inputView = composeTextView.inputView != nil ? nil : UISwitch()
        
        composeTextView.becomeFirstResponder()
    }
}

// MARK:- 添加照片和删除照片的事件
extension ComposeViewController {
    /// 添加图片事件
    @objc private func addPhotoClick() {
        if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            return
        }
        
        let ipc = UIImagePickerController()
        
        ipc.sourceType = .photoLibrary
        
        ipc.delegate = self
        
        present(ipc, animated: true, completion: nil)
    }
    
    /// 删除图片事件
    @objc private func removePhotoClick(note : NSNotification) {
        guard let image = note.object as? UIImage else {
            return
        }
        
        guard let index = images.index(of: image) else {
            return
        }
        
        images.remove(at: index)
        
        picPickerView.images = images
    }
}

// MARK:- UIImagePickerController的代理方法
extension ComposeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        images.append(image)
        
        picPickerView.images = images
        
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITextView的代理方法
extension ComposeViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        composeTextView.placeHolderLabel.isHidden = textView.hasText
        textCountBtn.isHidden = !textView.hasText
        navigationItem.rightBarButtonItem?.isEnabled = textView.hasText
        
        // 统计字数
        let count = NSString(string: textView.text).length
        textCountBtn.setTitle("\(count)", for: .normal)
        
        guard count >= 140 else {
            return textCountBtn.setTitleColor(.lightGray, for: .normal)
        }
        
        textCountBtn.isEnabled = false
        
        guard count >= 350 else {
            return textCountBtn.setTitleColor(mainColor, for: .normal)
        }
        
        textCountBtn.setTitleColor(.red, for: .normal)
        textCountBtn.isEnabled = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        composeTextView.resignFirstResponder()
    }
    
    
}






