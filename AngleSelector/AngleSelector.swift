//
//  AngleSelector.swift
//  AngleSelector
//
//  Created by SpotCam-MBP-01 on 2021/11/15.
//

import UIKit
@objc (AngleSelectorDelegate)
protocol AngleSelectorDelegate{
    func angleSelectorDelegate_scrollto(angle:Int)
}

@objc class AngleSelector: UIView{
    
    @IBOutlet weak var view_scale: UIView!
    @IBOutlet weak var view_touch: UIView!
    @IBOutlet weak var leading_selection: NSLayoutConstraint!
    
    @IBOutlet weak var lb_angle_select: UILabel!
    
    var angle_state:Int!
    
    @objc public var delegate:AngleSelectorDelegate?
    
    @objc func initUI(angle:Int){
        var angle_tmp:Int = angle
        angle_state = angle
        if angle > 0{
            angle_tmp -= 1
        }
        self.leading_selection.constant = CGFloat((angle_tmp + 180)) * (self.view_scale.frame.self.width/360)
        self.lb_angle_select.text = String(angle)
    }
    
    func pan(recognizer:UIPanGestureRecognizer) {
        // 設置 UIView 新的位置
        let point = recognizer.location(in: self.view_touch)
        self.leading_selection.constant = point.x
    }
    @IBAction func pan_view_touch(_ sender: UIPanGestureRecognizer) {
        let point = sender.location(in: self.view_scale)
        NSLog("point:%f", point.x);
        if point.x > -10 && point.x <= self.view_scale.frame.self.width + 10 {
            var float_x:CGFloat = point.x
            if point.x < 0 {
                float_x = 0
            }
            if point.x > self.view_scale.frame.self.width {
                float_x = self.view_scale.frame.self.width
            }
            let distance_center = float_x - (self.view_scale.frame.self.width/2)
            var str_sign_symbol:String = ""
            var angle:Int = Int((abs(distance_center)/(self.view_scale.frame.self.width/2))*180)
            if distance_center > 0 {
                str_sign_symbol = "+"
                angle += 1
            }else if distance_center < 0{
                str_sign_symbol = "-"
            }
            if angle == 0{
                str_sign_symbol = ""
            }
            if angle < 180 {
                self.leading_selection.constant = float_x
                self.lb_angle_select.text = str_sign_symbol + String(angle)
                if angle != angle_state {
                    if abs(angle_state - angle) > 10{
                        let generator = UISelectionFeedbackGenerator()
                                    generator.selectionChanged()
                    }
                    var int_return_angle: Int = angle
                    if str_sign_symbol == "-" {
                        int_return_angle = int_return_angle * -1
                    }
                    self.delegate?.angleSelectorDelegate_scrollto(angle: int_return_angle)
                    
                    let number1 = int_return_angle
                    let number2 = 15
                    let answer = number1.quotientAndRemainder(dividingBy: number2)
                    if answer.remainder == 0 {
                        let generator = UISelectionFeedbackGenerator()
                                    generator.selectionChanged()
    //                    let generator = UIImpactFeedbackGenerator(style: .heavy)
    //                                generator.impactOccurred()
                    }else if abs(angle - angle_state) > 10{
                        let generator = UISelectionFeedbackGenerator()
                            generator.selectionChanged()
                    }
                    angle_state = angle
                }
            }
            
        }
    }
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
