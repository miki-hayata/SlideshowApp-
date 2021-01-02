//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 早田美喜 on 2021/01/01.
//

import UIKit

class ViewController: UIViewController {
    
    //画像を表示する為、接続。
    @IBOutlet weak var imageView: UIImageView!
    
    //再生・停止を切り替える為に接続。
    @IBOutlet weak var onoffButton: UIButton!
    
    //戻る・進むボタンの表示・非表示を切り替える為、接続。
    @IBOutlet weak var noPrev: UIButton!
    @IBOutlet weak var noNext: UIButton!
    
    // 表示している画像の番号。
    var dispImageNo = 0
    
    //スライドショーで利用するタイマーの宣言。nilを設定しても良い型にしている。
    var timer: Timer!
    
    // 画像の名前の配列。
    let imageNameArray = [
        "ike",
        "sora",
        "yama",
    ]
    //接続。戻るボタンを押した時の処理。
    @IBAction func onPrev(_ sender: Any) {
        
        // 表示している画像の番号を1減らす。
        dispImageNo -= 1
        
        //最初の画像表示時に戻るを押された時は最後の画像の番号を設定。
        if(dispImageNo < 0){
            
            dispImageNo = 2
        }
        
        // 表示している画像の番号を元に画像を表示する。
        displayImage()
    }
    
    //進むボタンを押した時の処理。
    @IBAction func onNext(_ sender: Any) {
        
        // 表示している画像の番号を1増やす。
        dispImageNo += 1
        
        //最後の画像表示時に進むを押された時は最初の画像の番号を設定。
        if (dispImageNo > 2){
            
            dispImageNo = 0
        }
        // 表示している画像の番号を元に画像を表示する。
        displayImage()
    }
    // 表示している画像の番号を元に画像を表示する。
    func displayImage() {
        // 表示している画像の番号から名前を取り出し。
        let name = imageNameArray[dispImageNo]
        
        // 画像を読み込み。
        let image = UIImage(named: name)
        
        // Image Viewに読み込んだ画像をセット。
        imageView.image = image
    }
    
    // selector: #selector(updatetimer(_:)) で指定された関数
    // timeInterval: 2.0, repeats: true で指定された通り、2秒毎に呼び出され続ける。
    @objc func updateTimer(_ timer: Timer) {
        self.dispImageNo += 1
        if (dispImageNo > 2) {
            dispImageNo = 0
        }
        
        let name = imageNameArray[dispImageNo]
        
        // 画像を読み込み。
        let image = UIImage(named: name)
        
        // Image Viewに読み込んだ画像をセット。
        imageView.image = image
    }
    
    // 接続。再生・停止ボタンを押した時の処理。
    @IBAction func slideshow(_ sender: Any) {
        // 動作中のタイマーを1つに保つために、 timer が存在しない場合だけ、タイマーを生成して動作させる。
        if self.timer == nil {
            //停止中。タイマーを作動し、スライドショーを作動。ボタンのラベルを停止にする。
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(updateTimer(_:)), userInfo: nil, repeats: true)
            
            //再生中のボタンのラベルを設定。
            onoffButton.setTitle("停止", for: .normal)
            
            //再生中は戻る・進むボタンを無効化。
            noPrev.isEnabled = false
            noNext.isEnabled = false
            
        }else{
            //再生中。タイマーを停止し、リセット。ボタンのラベルを再生にする。
            timer.invalidate()
            timer = nil
            
            //停止時のボタンのラベルを設定。
            onoffButton.setTitle("再生", for: .normal)
            
            //停止中は戻る・進むボタンを有効化。
            noPrev.isEnabled = true
            noNext.isEnabled = true
        }
    }
    
    //画像をタップされた時に　ズーム画面に移動。
    @IBAction func toZoom(_ segue: UIStoryboardSegue) {
        
        //自動再生中に画像がタップされた時はタイマーを止め、拡大画面から戻ってきた時に、
        //タップ時と同じ画像が表示されている状態にしている。
        if self.timer != nil {
            timer.invalidate()
            timer = nil
            
            //停止時のボタンのラベルを設定。
            onoffButton.setTitle("再生", for: .normal)
            
            //停止中は戻る・進むボタンを有効化。
            noPrev.isEnabled = true
            noNext.isEnabled = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // segueから遷移先のZoomController取得する。
        let zoomController:ZoomController = segue.destination as! ZoomController
        
        // 遷移先ZoomControllerで宣言しているzoomimageに画像を渡す為、現在表示されている画像の
        //場所を取得し、nameに設定。
        let name = imageNameArray[dispImageNo]
        
        // nameを元に、画像を読み込み。
        let image = UIImage(named: name)
        
        // 読み込んだ画像をimageにセットし、ZoomControllerのzoomimageに渡す。
        zoomController.zoomimage = image!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "ike")
        imageView.image = image
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
