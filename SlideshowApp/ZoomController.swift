//
//  ZoomController.swift
//  SlideshowApp
//
//  Created by 早田美喜 on 2021/01/02.
//

import UIKit

class ZoomController: UIViewController {
    
    @IBOutlet weak var ZoomView: UIImageView!
    
    //画像を受け取る為の変数を宣言。
    var zoomimage = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()

        ZoomView.image = self.zoomimage
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
