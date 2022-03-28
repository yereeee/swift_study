//
//  RegisterViewController.swift
//  week3
//
//  Created by 예리 on 2022/03/26.
//

import UIKit

class RegisterViewController: UIViewController {
    //MARK: - Properties
    
    //회원정보 전달을 위한 프로퍼티 선언
    var email: String = ""
    var name: String = ""
    var nickname: String = ""
    var password: String = ""
    
    var userInfo: ((UserInfo) -> Void)?
    //구조체 파라미터 불러옴, 리턴을 할 필요없는 식이 성립
    
    
    //유효성검사를 위한 프로퍼티
    var isValidEmail = false{
        didSet { //프로퍼티 옵저버, 값이 입력 될 때마다 유효성 검사로직 실행하겠다
            self.validateUseriInfo()
        }
    }
    
    var isValidName = false{
        didSet { //프로퍼티 옵저버
            self.validateUseriInfo()
        }
    }
    
    
    var isValidNickname = false{
        didSet { //프로퍼티 옵저버
            self.validateUseriInfo()
        }
    }
    
    
    var isValidpassword = false{
        didSet { //프로퍼티 옵저버
            self.validateUseriInfo()
        }
    }
    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var popToLoginButton: UIButton!
    
    //Textfields
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var nicknameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    

    
    
    
    var textFields: [UITextField]{
        [emailTextField, nameTextField, nicknameTextField, passwordTextField]
    }
    
    //MARK: - Lifecyce
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        setupAttribute()
//        signupButton.layer.cornerRadius = 5 여기서 코너 모따기도 가능

        //bug fix
        self .navigationController?.interactivePopGestureRecognizer?.delegate = nil
        //화면 밀기로 뒤로가기 버그 픽스

    }
    
    
    //MARK: - Actions
    @objc //ibaction이랑 다르게 코드는 붙여줘야한다.
    func textFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        
        switch sender {
        case emailTextField:
            self.isValidEmail = text.isValidEmail()
            self.email = text
            
        case nameTextField:
            self.isValidName = text.count > 2
            self.name = text
            
        case nicknameTextField:
            self.isValidNickname = text.count > 2
            self.nickname = text
            
        case passwordTextField:
            self.isValidpassword = text.isValidPassword()
            self.password = text
            
        default:
            fatalError("Missing Textfield")
        }
    }
    
    
    @IBAction func backButtonDidTap(_ sender: UIBarButtonItem) {
        //뒤로가기
        self.navigationController?.popViewController(animated: true)
        //네비게이션 컨드롤러가 임베디드 되었을 때, popveiwcontroller로 뒤로가기 할 수 있다.
    }
    
    
    @IBAction func registerButtonDidTap(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        //회원정보 프로퍼티를 유저인포라는 구조체로 작성
        let userInfo = UserInfo(email: self.email,
                                name: self.name,
                                nickname: self.nickname,
                                password: self.password)
        //클로저로 데이터를 전달
        self.userInfo?(userInfo)//userinfo로 전송 완료
       //사용자 정보 보내주기
    }
    
    
    
    
    //MARK: - Helper
    private func setupTextField(){
        //emailTextField.addTarget(self,action: #selector(textFieldEditingChanged(_sender:)),for: .editingChanged)
        
        //nameTextField.addTarget(self,action: #selector(textFieldEditingChanged(_sender:)),for: .editingChanged)

        //nicknameTextField.addTarget(self,action: #selector(textFieldEditingChanged(_sender:)),for: .editingChanged)

       //passwordTextField.addTarget(self,
//                                 action: #selector(textFieldEditingChanged(_sender:)),
//                                 for: .editingChanged)
// 반복되는 코드가 많으니깐 연산 프로퍼티로 코드를 줄임

        //textFields가 배열이라 foreach를 쓴다 -> for 문이라고 봐도 무방
        textFields.forEach{ tf in
            tf.addTarget(self,
                         action: #selector(textFieldEditingChanged(_:)),
                         for: .editingChanged)
        }
    }
    //사용자가 입력한 회원정보를 확인하고 -> UI 업데이트
    private func validateUseriInfo() {
        
        if isValidEmail
            && isValidName
            && isValidNickname
            && isValidpassword {
            
            self.signupButton.isEnabled = true
            UIView.animate(withDuration: 0.33) {
                self.signupButton.backgroundColor = UIColor.facebookColor
            }
            

            
        }else {
            //유효성 검사 -> 유효하지 않음
            self.signupButton.isEnabled = false
            UIView.animate(withDuration: 0.33) {
                self.signupButton.backgroundColor = UIColor.disabledButtonColor
            }
        }
    }
    
    
    
    private func setupAttribute() {
        //registerButton
        
        let text1 = "계정이 있으신가요?"
        let text2 = "로그인"
        
        let font1 = UIFont.systemFont(ofSize: 13)
        let font2 = UIFont.boldSystemFont(ofSize: 13)

        
        let color1 = UIColor.darkGray
        let color2 = UIColor.facebookColor

        let attribute = generateButtonAtttribute(popToLoginButton,
                                                 texts: text1, text2,
                                                 fonts: font1, font2,
                                                 colors: color1, color2)
        
    
        //순서 1212로 잘지키기
        
        self.popToLoginButton.setAttributedTitle(attribute, for: .normal)
        
    }
}

//유효성검사
//정규표현식
extension String{
    //대문자, 소문자, 특수문자, 숫자, 8자 이상일 때 ->True
    func isValidPassword() -> Bool {
        let regularExpression = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
        let passwordValidation = NSPredicate.init(format:"SELF MATCHES %@", regularExpression)
        
        return passwordValidation.evaluate(with: self)
    }
    
    //2글자 이상을 확인
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
