//
//  ViewController.swift
//  Navigation
//
//  Created by Nam on 2024/06/30.
//

import UIKit

class ViewController: UIViewController, EditDelegate {
    
    
    
    // 상속받으면서 프로토콜에 어긋나는 에러 발생 -> Fix 눌러 추가
    
    let imgOn = UIImage(named: "lamp_on.png")
    let imgOff = UIImage(named: "lamp_off.png")
    var isOn = true // 전구가 켜져있는지 나타내는 변수
    var isZoom = false
    var orgZoom = false // EditViewController에 넘기기 위한 변수

    @IBOutlet var txtMessage: UITextField!
    
    @IBOutlet var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imgView.image = imgOn   // 전구가 켜져 있는 첫 화면

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let editViewController = segue.destination as! EditViewController
        // 버튼을 클릭한 경우
        if segue.identifier == "editButton" {
            editViewController.textWayValue = "segue: use button"
        } else if segue.identifier == "editBarButton" { // 바 버튼을 클릭한 경우
            editViewController.textWayValue = "segue: use Bar button"
        }
        editViewController.textMessage = txtMessage.text! // 메인화면의 텍스트 필드 내용을 수정화면에 전달
        editViewController.isOn = isOn
        editViewController.isZoom = orgZoom // orgZoom을 넘겨주어야 동작이 없을 때 상태를 유지할 수 있다
        editViewController.delegate = self
    }
     
    func didMessageEditDone(_ controller: EditViewController, message: String) {
        // 수정화면의 데이터를 메인화면에 전달하여 보여줌
        txtMessage.text = message
    }
    
    func didImageOnOffDOne(_ controller
                           : EditViewController, isOn: Bool) {  // 수정화면의 상태를 메인화면에 전달
        if isOn {
            imgView.image = imgOn
            self.isOn = true
        } else {
            imgView.image = imgOff
            self.isOn = false
        }
    }
    
    func didZoomInDone(_ controller: EditViewController, isZoom: Bool) {
        let scale: CGFloat = 2.0
        var newWidth: CGFloat, newHeight: CGFloat
        if isZoom { // 확대 이미 되어있는 상태
            if !orgZoom{
                newWidth = imgView.frame.width / scale
                newHeight = imgView.frame.height / scale
                imgView.frame.size = CGSize(width: newWidth, height: newHeight)
                self.isZoom = false
                self.orgZoom = true // 확대되어 있다고 EditViewController에 넘긴다
            }
            

        } else{ // 축소 되어있는 상태
            if orgZoom{
                newWidth = imgView.frame.width * scale
                newHeight = imgView.frame.height * scale
                imgView.frame.size = CGSize(width: newWidth, height: newHeight)
                self.isZoom = true
                self.orgZoom = false // 축소되어 있다고 EditViewController에 넘긴다
            }
            
        }
//          self.isZoom = !isZoom
        
    }
}
    


