//
//  LoginViewController.swift
//  week3
//
//  Created by 예리 on 2022/03/26.
//

import UIKit

class LoginViewController: UIViewController {

    var email = String()
    var password = String()
    var userInfo: UserInfo?
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAttribute()

    }
    

    @IBAction func emailTextFieldEditingChanged(_ sender: UITextField) {
        
        let text = sender.text ?? ""
//        if text.isValidEmail() {
//            self.loginButton.backgroundColor = .facebookColor
//        }else {self.loginButton.backgroundColor = .disabledButtonColor}
        //로그인 정보가 유효성 검사를 통과하면, 버튼색 바꾸기
        //윗줄을 한줄로 작성가능하다.(3항연산자)
        self.loginButton.backgroundColor
        = text.isValidEmail() ? .facebookColor : .disabledButtonColor
        //ture일 때 = ?, false일 때 = :
        
        self.email = text
    }
    
    
    @IBAction func passwordTextFileldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? "" //sender text해서 초기값을 줘서 값이 없는 경우 필터값, 빈값 전달
        
        self.loginButton.backgroundColor
        = text.count > 2 ? .facebookColor : .disabledButtonColor
        // 두글자 이상치면 색 변함
        
        self.password = text
    }
    
    @IBAction func loginButtonDidTap(_ sender: UIButton) {
        //회원가입 정보를 전달 받아서, 그것과 textField 데이터가 일치하면,
        //로그인이 되어야한다.
        
        guard let userInfo = self.userInfo else {return}
        //guard let은 옵셔널을 벗기는 다른 방법
        //데이터가 있으면 let으로 새롭게 데이터 선언, 데이터가 없으면 else로 리턴해서 함수 종료
        if userInfo.email == self.email
            && userInfo.password == self.password {//enable을 풀어줘야 실행이 된다
            //일치하면 tapbar화면 나타나게 만든다
            //tapbar는 카테고리가 다른 화면을 하단에 버튼을 위치시킬 때 사용한다.
            let vc = storyboard? .instantiateViewController(withIdentifier: "TapBarVC") as! UITabBarController
            vc.modalPresentationStyle = .fullScreen
            //꽉찬화면으로 호출
            
            self.present(vc, animated: true, completion: nil)
            
        }else{
            
            
        }
    }
    
    @IBAction func registerButtonDidTap(_ sender: UIButton) {
        
        //화면전환
        //1 스토리보드 생성
        let storyboard = UIStoryboard(name : "Main", bundle: nil)
        
        //2 뷰컨드롤러를 생성
        let registerViewController = storyboard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterViewController
        
        // 화면전환 메소드를 이용해서 화면을 전환
//        self.present(registerViewController, animated: true, completion: nil)
        //에니메이션 유무, 화면 전환이후에 필요한 동작이 있는지
        
        self.navigationController?.pushViewController(registerViewController, animated: true)
        
        //ARC개념 - swift의 메모리 관리 방식 -> 약한 참조, 강한 참조
        //약한참조는 ARC를 낮춰서 메모리가 해제되면 같이 해제되도록 함
        //강한참조는 안없어지기 때문에 메모리를 소비한다
        //데이터를 수신하게 되면 코드블럭을 실행
        registerViewController.userInfo = { [weak self]
            (UserInfo) in
            self?.userInfo = UserInfo
        }
    }
    private func setupAttribute() {
        //registerButton
        
        let text1 = "계정이 없으신가요?"
        let text2 = "가입하기"
        
        let font1 = UIFont.systemFont(ofSize: 13)
        let font2 = UIFont.boldSystemFont(ofSize: 13)

        
        let color1 = UIColor.darkGray
        let color2 = UIColor.facebookColor

        let attribute = generateButtonAtttribute(registerButton,
                                                 texts: text1, text2,
                                                 fonts: font1, font2,
                                                 colors: color1, color2)
        
    
        //순서 1212로 잘지키기
        
        self.registerButton.setAttributedTitle(attribute, for: .normal)
        
    }
}

