//
//  EditViewController.swift
//  Navigation
//
//  Created by Nam on 2024/06/30.
//

import UIKit

// 프로토콜 형태의 델리게이트
// 프로토콜은 특정 객체가 갖추어야 할 속성에 대한 설계도
protocol EditDelegate {
    func didMessageEditDone(_ controller: EditViewController, message: String)
    func didImageOnOffDOne(_ controller: EditViewController, isOn: Bool)    // 수정화면의 스위치 상태를 메인화면에 보내기 위한 함수
    func didZoomInDone(_ controller: EditViewController, isZoom: Bool)
}


class EditViewController: UIViewController {
    
    var textWayValue: String = ""
    var textMessage: String = ""    // 수정화면에서 직접 텍스트 필드 제어를 위해 문자열로 생성
    var delegate: EditDelegate?
    
    var isOn = false    // 수정화면에서 직접 제어할 수 없기에 isOn 따로 선언
    var isZoom = false  // isZoom 따로 선언
    
    @IBOutlet var txtMessage: UITextField!
    
    @IBOutlet var lblWay: UILabel!
    
    @IBOutlet var lampSwitch: UISwitch!
    
    @IBOutlet var btnZoom: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblWay.text = textWayValue
        txtMessage.text = textMessage   // 텍스트 필드의 텍스트로 대입
        lampSwitch.isOn = isOn  // 스위치의 on에 대입한다 (초기엔 false이므로 꺼져있음)
        
        if(isZoom){
            btnZoom.setTitle("확대", for: .normal)
        } else {
            btnZoom.setTitle("축소", for: .normal)
        }
        
    }
    

        // 수정 완료하면 메인화면으로 이동
    @IBAction func btnDone(_ sender: UIButton) {
        if delegate != nil {
            delegate?.didMessageEditDone(self, message: txtMessage.text!)   // 텍스트 필드에 대한 델리게이트
            delegate?.didImageOnOffDOne(self, isOn: isOn)   // 이미지 뷰에 대한 델리게이트
            delegate?.didZoomInDone(self, isZoom: isZoom)
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func lampSwitchOnOff(_ sender: UISwitch) {
        if sender.isOn {
            isOn = true
        }   else {
            isOn = false
            
        }
    }
    
    
    @IBAction func zoomOnOff(_ sender: UIButton) {
        if isZoom {
            isZoom = false // 확대 된 상태
            btnZoom.setTitle("축소", for: UIControl.State())
        } else {
            isZoom = true  // 축소 된 상태
            btnZoom.setTitle("확대", for: UIControl.State())

        }
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
