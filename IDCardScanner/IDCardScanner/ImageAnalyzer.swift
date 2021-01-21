//
//  ImageAnalyzer.swift
//
//
//  Created by miyasaka on 2020/07/30.
//

import Foundation
#if canImport(Vision)
import Vision

protocol ImageAnalyzerProtocol: AnyObject {
    /// 解析完成的时候
    func didFinishAnalyzation(with result: Result<IDCard, IDCardScannerError>)
}


///定义了一个类
@available(iOS 13, *)
final class ImageAnalyzer {
    enum Candidate: Hashable {
        case number(String), name(String), cardName(String),  cardNation(String), cardAddress(String),cardNumber(String)
        case expireDate(DateComponents)
    }

    typealias PredictedCount = Int

    private var selectedCard = IDCard()
    private var cacheCard = IDCardInfo(cardName: [], cardNation: [], cardAddress: [], cardNumber: [])
    
    private var predictedCardInfo: [Candidate: PredictedCount] = [:]

    private weak var delegate: ImageAnalyzerProtocol?
    init(delegate: ImageAnalyzerProtocol) {
        self.delegate = delegate
    }

    // MARK: - Vision-related

    public lazy var request = VNRecognizeTextRequest(completionHandler: requestHandler)
//    public lazy var request = VNDetectRectanglesRequest.init(completionHandler: requestHandler)

    
    /// VN解析cgImage
    func analyze(image: CGImage) {
        
        print("打印识别矩形函数执行所在的线程-函数体内部",Thread.current)

        /// 这里是用cgimage  不适用cgimage 也可以使用ciimage  / buffer 或者 
        let requestHandler = VNImageRequestHandler(
            cgImage: image,
            orientation: .up,
            options: [:]
        )
        
        do {
            request.recognitionLevel = .accurate;
            request.recognitionLanguages = ["zh-CN"]
            request.usesLanguageCorrection = true
            request.customWords = ["姓名", "住 址", "住  址", "住址", "公民身份号码", "民族", "公民", "身份", "号码"]
            try requestHandler.perform([request])
        } catch {
            let e = IDCardScannerError(kind: .photoProcessing, underlyingError: error)
            delegate?.didFinishAnalyzation(with: .failure(e))
            delegate = nil
        }
    }

    
    ///身份证图片解析
    ///身份证图片解析
    lazy var requestHandler: ((VNRequest, Error?) -> Void)? = { [weak self] request, _ in
        
        
        print("打印身份证解析所在的线程",Thread.current)

        
        guard let strongSelf = self else { return }
        print("进入身份证图片解析部分");
        guard let results = request.results as? [VNRecognizedTextObservation] else {
            
            return
        }

        var idCard = IDCard(cardName: nil, cardNation: nil, cardAddress: nil, cardNumber: nil)

        let maxCandidates = 1
        
        ///for循环 用来遍历身份证的全部分文信息
        for result in results {
            
            guard let candidate = result.topCandidates(maxCandidates).first,candidate.confidence > 0.1
            else {
                continue
            }
            print("打印识别结果的确信度,", candidate.confidence)
            let string = candidate.string
            print("字符串是", string)
            ///身份证部分
            if candidate.string.contains("名")
            {
                let cardName = candidate.string.components(separatedBy: "名")[1]
                print("查看身份证姓名", cardName)
                idCard.cardName = cardName
            }  else if candidate.string.contains("族") && (candidate.string.contains("别"))
            {
                let nation = candidate.string.components(separatedBy: "族")[1]
                idCard.cardNation = nation
            } else if (candidate.string.contains("住址") || candidate.string.contains("佳址") || candidate.string.contains("佳 址") || candidate.string.contains("住 址"))
            {
                let address = candidate.string.components(separatedBy: "址")[1]
                idCard.cardAddress = address
            }else if (idCard.cardAddress != nil) && (idCard.cardNumber == nil){
                if (candidate.string.contains("公民") && candidate.string.contains("号码")){
                    let ids = candidate.string.components(separatedBy: "号码")[1]
                    idCard.cardNumber = ids
                }else {
                    idCard.cardAddress = idCard.cardAddress! + candidate.string
                    print("查看地址", idCard.cardAddress)
                }
            }
            else if (candidate.string.contains("公民身份") && candidate.string.contains("号码"))
            {
                let ids = candidate.string.components(separatedBy: "号码")[1]
                idCard.cardNumber = ids
            }else {
                continue
            }
        }
        ///到此遍历身份证信息结束

        ///身份证姓名   非空  同上一次一样
        if (strongSelf.selectedCard.cardName == nil){
            if let cardName = idCard.cardName {
                print("这里再看cardName", cardName)
                let count = strongSelf.predictedCardInfo[.cardName(cardName), default: 0]
                strongSelf.predictedCardInfo[.cardName(cardName)] = count + 1
                strongSelf.cacheCard.cardName.append(cardName)
                /// 连续三次识别的名字一致
                if count > 3 &&  strongSelf.cacheCard.cardName.contains(cardName) {
                    print("姓名已确认")
                    strongSelf.selectedCard.cardName = cardName
                }else {
                    strongSelf.cacheCard.cardName.append(cardName)
                }
            }
        }

        
        
        ///民族
        if (strongSelf.selectedCard.cardNation == nil) {
            if let cardNation = idCard.cardNation {
                let count = strongSelf.predictedCardInfo[.cardNation(cardNation), default: 0]
                strongSelf.predictedCardInfo[.cardNation(cardNation)] = count + 1
                if count > 2 {
                    print("民族已确认")
                    strongSelf.selectedCard.cardNation = cardNation
                }
            }
        }

        
        ///身份证地址
        if let cardAddress = idCard.cardAddress {
            let count = strongSelf.predictedCardInfo[.cardAddress(cardAddress), default: 0]
            strongSelf.predictedCardInfo[.cardAddress(cardAddress)] = count + 1
            if count > 2 {
                print("地址已确认")
                strongSelf.selectedCard.cardAddress = cardAddress
            }
        }
        
        ///身份证号码
        if let cardNumber = idCard.cardNumber {
            let count = strongSelf.predictedCardInfo[.cardNumber(cardNumber), default: 0]
            strongSelf.predictedCardInfo[.cardNumber(cardNumber)] = count + 1
            if count > 2 {
                print("身份证号码已验证")
                strongSelf.selectedCard.cardNumber = cardNumber
            }
        }
        
        
        
        /// 如果选中卡片的 number != nul     返回成功 然后取消代理
        if strongSelf.selectedCard.cardNumber != nil
            && strongSelf.selectedCard.cardName != nil
            && strongSelf.selectedCard.cardNation != nil
            && strongSelf.selectedCard.cardAddress != nil{
            strongSelf.delegate?.didFinishAnalyzation(with: .success(strongSelf.selectedCard))
            strongSelf.delegate = nil
        }
    }
}
#endif
