# Aria - 작가들의 미니 홈피

프론트엔드(`Flutter`) : `권태형`, `노송희`

## TODO

- [x] models 작성
- [x] fake service 작성(테스트 데이터)
- [x] viewmodel / simple view 작성 및 연동 테스트
- [x] real service 작성(백엔드 API 참고) => 소셜로그인 관련 포함
- [ ] 전체 동작 점검
- [ ] detail view 작성
- [ ] 애니메이션 등 효과 추가

## 프로젝트 구조

- MVVM 패턴으로 설계하였으며, 이에따라 page 하나에 viewmodel 하나가 매칭됩니다.
- `test`는 @노송희의 원활한 위젯 테스트를 위한 페이지입니다.

```bash
├── constants # 텍스트 스타일, 색상 등 스타일 관련 상수
├── helper # 백엔드 통신을 위한 모듈
├── models # 모델
├── services # 데이터 처리 서비스
├── viewmodels # 페이지 내 데이터 제공, 변경을 위한 viewmodel
└── views # 페이지 UI
    ├── art # 작품 관련 페이지
    ├── artist # 작가 관련 페이지
    ├── auth # 인증 관련 페이지
    ├── error # 에러 처리 페이지
    ├── main # 홈페이지
    ├── my # 마이페이지 및 수정 페이지
    ├── search # 검색 페이지
    └── test # 테스트 페이지(송희)
```

## 프로젝트 구조 상세 - views

```bash
├── art
│   ├── detail_page.dart # 작품 상세페이지
│   └── list_view.dart # (임시)
├── artist
│   ├── add_art_page.dart # 작가 마이페이지 - 작품 추가
│   └── artist_home_page.dart # 작가 홈페이지(미니홈피)
├── auth
│   ├── signin_page.dart # 로그인 페이지
│   ├── signup_page.dart # 회원가입 페이지
│   └── splash_page.dart # 스플래시 페이지
├── error
│   └── error_page.dart # 에러처리 페이지
├── main
│   └── home_page.dart # 홈페이지
├── my
│   ├── edit_profile_page.dart # (작가/유저) 마이페이지 - 프로필 수정
│   └── my_page.dart # (작가/유저) 마이페이지
└── search
    └── search_page.dart # 검색/검색결과 페이지
```