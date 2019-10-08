//
//  ViewController.swift
//  project1
//
//  Created by 伊藤潤人 on 2019/10/04.
//  Copyright © 2019年 hirotoshin. All rights reserved.
//

import UIKit
extension UIView {
    
    
}
class ViewController: UIViewController,UIGestureRecognizerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        setup()
        // Screen Size の取得
        let _:CGFloat = view.frame.size.width
        let _:CGFloat = view.frame.size.height
        // タッチ操作を enable
        
        self.view.addSubview(imageSample)
        self.view.addSubview(secondImageView)
        let image = UIImage(named: "Level")
        imageSample.image = image
    }
    
    var dispImageNo = 0
    var flag = 1
    
    @IBOutlet weak var imageSample: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBAction func saveDisplay(_ sender: Any) {
        let rect = view.bounds
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        
        // ここでtrueを指定しないと、画面が変わった時に再キャプチャできない
        view.drawHierarchy(in: rect, afterScreenUpdates: true)
        
        let cont = UIGraphicsGetCurrentContext()
        view.layer.render(in: cont!)
        
        // キャプチャした画像を変数に保持
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
    }
    
    @IBAction func pushImageSample(_ sender: Any) {
        flag = 1
    }
    @IBAction func pushSecondImageView(_ sender: Any) {
        flag = 2
    }
    @IBAction func changeImage(_ sender: Any) {
        if dispImageNo>=1{
            dispImageNo = -1
        }
        dispImageNo = dispImageNo + 1
        displayImage()
        print(dispImageNo)
    }
    @IBAction func secondChangeImage(_ sender: Any) {
    }
    var capturedImage : UIImage?
    
    func displayImage() {
        
        // 画像の名前の配列
        let imageNameArray = [
            "Level.png",
            "kageno01.jpg"
            ]
        
        // 表示している画像の番号から名前を取り出し
        let name = imageNameArray[dispImageNo]
        
        // 画像を読み込み
        let image = UIImage(named: name)
        
        // Image Viewに読み込んだ画像をセット
        imageSample.image = image
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan")
        
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // タッチイベントを取得
        let touchEvent = touches.first!
        
        // ドラッグ前の座標, Swift 1.2 から
        let preDx = touchEvent.previousLocation(in: self.view).x
        let preDy = touchEvent.previousLocation(in: self.view).y
        
        
        // ドラッグ後の座標
        let newDx = touchEvent.location(in: self.view).x
        let newDy = touchEvent.location(in: self.view).y
        
        // ドラッグしたx座標の移動距離
        let dx = newDx - preDx
        print("x:\(dx)")
        
        // ドラッグしたy座標の移動距離
        let dy = newDy - preDy
        print("y:\(dy)")
        
        // 画像のフレーム
        if flag==1{
            var viewFrame: CGRect = imageSample.frame
            
            // 移動分を反映させる
            viewFrame.origin.x += dx
            viewFrame.origin.y += dy
            
            imageSample.frame = viewFrame
            
            self.view.addSubview(imageSample)
        }else{
            var viewFrame: CGRect = secondImageView.frame
            
            // 移動分を反映させる
            viewFrame.origin.x += dx
            viewFrame.origin.y += dy
            
            secondImageView.frame = viewFrame
            
            self.view.addSubview(secondImageView)
        }
        
    }
    
    var currentScale:CGFloat = 1.0
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

