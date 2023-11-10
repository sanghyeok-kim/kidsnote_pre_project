# 키즈노트 사전과제

<br>

실행 방법
1. 압축 파일을 다운로드해 주세요.
2. 워크스페이스(.xcworkspace)와 Podfile이 있는 경로에서 터미널을 열고, `pod install` 명령어를 입력해주세요
3. CocoaPods 의존성이 설치되어 Pods 디렉토리와 Podfile.lock 파일이 생겼다면, 워크스페이스 파일을 실행시켜주세요.

---

<br>

### 사용 기술

|Design Pattern & Architecture|Description|
|---|---|
|**MVVM-C**|UI와 데이터 가공, 그리고 화면 전환의 로직을 각각 분리|
|**Clean Architecture**|계층 간 책임 분리, 재사용성 및 유지보수성 향상|

<br>

|Libraries|Description|
|---|---|
|**RxSwift**|비동기 및 반응형 프로그래밍|
|**ReactorKit**|단방향 이벤트 처리 및 뷰모델 상태 관리|

<br>

- Build Target: iOS 15.0  
- 의존성 관리 도구: CocoaPods

<br>

### 기능 및 실행 화면

|검색|검색 조건 필터링 & 결과 없음 처리|페이지네이션|상세 화면|
|---|---|---|---|
|![CleanShot 2023-11-10 at 21 41 20](https://github.com/sanghyeok-kim/kidsnote_pre_project/assets/57667738/31bde618-0c77-43ad-a1a9-a665478ea30a)|![CleanShot 2023-11-10 at 21 44 50](https://github.com/sanghyeok-kim/kidsnote_pre_project/assets/57667738/70c81696-4091-49a8-96fd-66191c55d663)|![ezgif com-optimize](https://github.com/sanghyeok-kim/kidsnote_pre_project/assets/57667738/f5fe0b77-fb9b-491c-a424-0b4a5279cbaa)|![CleanShot 2023-11-10 at 21 37 36](https://github.com/sanghyeok-kim/kidsnote_pre_project/assets/57667738/cd9fa6a7-80fb-4b29-b950-4d7ee4659c1a)|

