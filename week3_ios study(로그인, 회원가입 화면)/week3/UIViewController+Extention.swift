//
//  UIViewController+Extention.swift
//  week3
//
//  Created by 예리 on 2022/03/27.
//

import UIKit

extension UIViewController {
    func generateButtonAtttribute(_ button : UIButton, //어떤 버튼
                                    texts: String..., //어떤 텍스트
                                    fonts: UIFont..., //어떤 폰트, 어떻게 적용할지 값을 받는다. ...은 복수를 나타내는 swift문법
                                  colors: UIColor...) -> NSMutableAttributedString{ //어떤 속성이 적용된 스트링에 형태로 리턴한다.
        //UIButton에 입력된 text를 가져온다
        guard let wholeText = button.titleLabel?.text else { fatalError("버튼에 텍스트가 없음.")}
        
        //폰트들
        let customFonts: [UIFont] = fonts
        
        //설명하고자 하는 String의 NSRanges
        let customTextsRanges = texts.indices.map { index in
            (wholeText as NSString).range(of: texts[index])
        
        }
        
        //설정하고자 하는 색상들
        let customcolors = colors
        
        //attribute 객체를 생성한다
        let attridutedString = NSMutableAttributedString(string:  wholeText)
            
        texts.indices.forEach {index in
            attridutedString.addAttribute(.font,
                                          value: customFonts [index],
                                          range: customTextsRanges [index])
            attridutedString.addAttribute(.foregroundColor,
                                          value: customcolors [index],
                                          range: customTextsRanges [index])
            
        }
        return attridutedString

    }
}
//지금은 이 코드를 저장했다가 똑같이 쓸일이 있다면 사용하는 것이 좋다.
