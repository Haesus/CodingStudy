//
//  NetworkService.swift
//  TuistSwiftUIApp
//
//  Created by 윤해수 on 9/10/25.
//

import Foundation
import Alamofire

class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    /// 제네릭 디코딩 요청 (JSON → `Decodable` 모델)
    ///
    /// 서버 응답을 `Decodable` 제네릭 `T`로 디코딩해 반환합니다. 상태코드 200~299만 성공으로 간주합니다.
    /// - Parameters:
    ///   - url: 호출하려는 절대/상대 URL 문자열
    ///   - method: HTTP 메서드 (`.get`, `.post`, `.put`, `.patch`, `.delete` 등)
    ///   - parameters: 쿼리/바디 파라미터. `encoding`에 따라 URL 또는 JSON 바디로 전송
    ///   - encoding: `URLEncoding.default`(기본, GET 쿼리) 또는 `JSONEncoding.default`(POST JSON 바디)
    ///   - headers: 요청 헤더 (`Authorization`, `Accept` 등)
    ///   - completion: `Result<T, AFError>` 콜백
    /// - Note: 응답 바디가 JSON이 아닐 경우 `requestData(_:...)` 사용을 고려하세요.
    /// - Author: tag
    func request<T: Decodable>(_ url: String, method: HTTPMethod, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil, completion: @escaping (Result<T, AFError>) -> Void) {
        AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self) { response in
                completion(response.result)
            }
    }
    
    /// 원시 Data 요청 (디코딩 없음)
    ///
    /// 서버 응답을 디코딩하지 않고 `Data` 그대로 반환합니다. 바이너리(이미지/CSV/PDF 등)나 커스텀 파싱이 필요할 때 사용하세요.
    /// - Parameters:
    ///   - url: 호출하려는 절대/상대 URL 문자열
    ///   - method: HTTP 메서드
    ///   - parameters: 쿼리/바디 파라미터
    ///   - encoding: 파라미터 인코딩 방식
    ///   - headers: 요청 헤더
    ///   - completion: `Result<Data, AFError>` 콜백
    /// - Author: tag
    func requestData(_ url: String, method: HTTPMethod, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil, completion: @escaping (Result<Data, AFError>) -> Void) {
        AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
            .validate(statusCode: 200..<300)
            .responseData { response in
                completion(response.result)
            }
    }
    
    /// 멀티파트 업로드 (응답을 `Decodable`로 디코딩)
    ///
    /// 파일/텍스트 필드를 멀티파트로 업로드하고, 응답을 `Decodable` `T`로 디코딩해 반환합니다.
    /// - Parameters:
    ///   - url: 업로드 대상 URL
    ///   - headers: 요청 헤더 (`Authorization`, `Content-Type` 등). `Content-Type`은 Alamofire가 자동 지정
    ///   - multipart: `MultipartFormData` 구성 클로저 (파일/필드 추가)
    ///   - completion: `Result<T, AFError>` 콜백
    /// - Note: 기본 메서드는 `POST`입니다.
    /// - Author: tag
    func upload<T: Decodable>(to url: String, headers: HTTPHeaders? = nil, multipart: @escaping (MultipartFormData) -> Void, completion: @escaping (Result<T, AFError>) -> Void) {
        AF.upload(multipartFormData: multipart, to: url, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self) { response in
                completion(response.result)
            }
    }
    
    /// 멀티파트 업로드 (원시 Data 반환)
    ///
    /// 파일/텍스트 필드를 멀티파트로 업로드하고, 응답을 디코딩 없이 `Data`로 반환합니다.
    /// - Parameters:
    ///   - url: 업로드 대상 URL
    ///   - headers: 요청 헤더
    ///   - multipart: `MultipartFormData` 구성 클로저
    ///   - completion: `Result<Data, AFError>` 콜백
    /// - Author: tag
    func uploadData(to url: String, headers: HTTPHeaders? = nil, multipart: @escaping (MultipartFormData) -> Void, completion: @escaping (Result<Data, AFError>) -> Void) {
        AF.upload(multipartFormData: multipart, to: url, headers: headers)
            .validate(statusCode: 200..<300)
            .responseData { response in
                completion(response.result)
            }
    }
    
    /// 파일 다운로드 (진행률 콜백)
    ///
    /// 지정한 URL에서 파일을 다운로드하여 로컬 파일 URL을 반환합니다.
    /// - Parameters:
    ///   - url: 다운로드 URL
    ///   - destination: 저장 위치(기본: 문서 디렉토리). 커스텀 저장소가 필요하면 지정
    ///   - progress: 0.0~1.0 진행률 콜백
    ///   - completion: `Result<URL, AFError>` 콜백 (저장된 로컬 파일 URL)
    /// - Note: 기본 HTTP 메서드는 `GET`입니다.
    /// - Author: tag
    func download(_ url: String, to destination: DownloadRequest.Destination? = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory, in: .userDomainMask), progress: ((Double) -> Void)? = nil, completion: @escaping (Result<URL, AFError>) -> Void) {
        AF.download(url, to: destination)
            .downloadProgress { prog in
                progress?(prog.fractionCompleted)
            }
            .responseURL { response in
                if let fileURL = response.fileURL {
                    completion(.success(fileURL))
                } else if let error = response.error {
                    completion(.failure(error))
                } else {
                    completion(.failure(.responseValidationFailed(reason: .dataFileNil)))
                }
            }
    }
    /// 스트리밍 요청 (Server-Sent 스타일)
    ///
    /// 서버로부터 스트림으로 전달되는 데이터를 조각(`Result<Data, Never>`) 단위로 전달받고, 완료 시 에러를 넘깁니다.
    /// - Parameters:
    ///   - url: 스트리밍 엔드포인트 URL
    ///   - onEvent: 각 데이터 조각을 담은 `Result<Data, Never>` 콜백 (조각 단계에서는 실패가 발생하지 않음)
    ///   - onComplete: 완료 시 에러(`AFError?`). 에러가 없다면 정상 완료
    /// - Note: UI 갱신이 필요하면 `responseStream(on: .main)` 큐를 지정하세요. 취소가 필요하면 반환 타입을 `DataStreamRequest`로 바꾸어 `cancel()` 하세요.
    /// - Author: tag
    func stream(_ url: String, onEvent: @escaping (Result<Data, Never>) -> Void, onComplete: @escaping (AFError?) -> Void) {
        AF.streamRequest(url)
            .responseStream { stream in
                switch stream.event {
                    case let .stream(result):
                        onEvent(result)
                    case let .complete(completion):
                        onComplete(completion.error)
                }
            }
    }
}

