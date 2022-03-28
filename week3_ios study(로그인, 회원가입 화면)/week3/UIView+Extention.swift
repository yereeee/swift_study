//
//  UIView+Extention.swift
//  week3
//
//  Created by 예리 on 2022/03/27.
//

import UIKit

extension UIView {//uiview에 기능확장
    @IBInspectable var cornerRadius: CGFloat{//ib사용 - 인터페이스 빌더에 인스펙터블을 인스펙터로 사용한다(모따기)
        get {//프로퍼티 정의 - 값을 읽어온다 얼마나 모따기 할건지(수치)
            return layer.cornerRadius
        }
        
        set {//세팅할 때 뉴벨류로 받고 해당 ui에 적용
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

}
