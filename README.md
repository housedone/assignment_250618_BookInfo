
# **📚 Book Info App**

**UIKit 기반의 컴포넌트 분리 및 재사용성 연습 프로젝트**

---

## **소개**

이 프로젝트는 UIKit으로 커스텀 뷰 컴포넌트를 설계하고, 화면 구성 요소를 깔끔하게 분리하여 재사용성을 높이는 것을 목표로 만든 학습용 앱입니다.

책 정보를 보여주는 단순한 도메인을 통해 다음과 같은 UI 패턴들을 연습합니다:

- 스택뷰 기반의 뷰 컴포넌트 분리
- Delegate 패턴을 통한 이벤트 전달
- 뷰와 데이터 바인딩의 분리
- 상태 관리 (UserDefaults 활용)
- 확장 가능한 컴포넌트 설계

---

## **주요 화면 구성**

### **📖 MainView**

- HeaderView와 ContentView로 구성된 전체 컨테이너 뷰
- 상태 (현재 선택된 책 권수) 를 관리하며 내부 뷰에 전달

### **🗂 HeaderView**

- 책 시리즈의 권수를 선택할 수 있는 상단 버튼 뷰
- 선택된 책 정보를 ContentView에 전달

### **📄 ContentView**

- 스크롤뷰 내부 스택뷰로 여러 컴포넌트를 수직 배치
    - BookBasicInfoView : 표지 및 기본 정보
    - DedicationView : 헌정사
    - SummaryView : 요약 (더보기 기능 포함)
    - ChapterListView : 챕터 목록

---

## **주요 기술 스택**

- Swift 5
- UIKit
- SnapKit (AutoLayout DSL)
- Delegate 패턴
- UserDefaults 상태 저장

---

## **프로젝트 설계 포인트**

- ✅ 뷰의 책임과 상태 분리를 연습
- ✅ 뷰 구성과 데이터 바인딩 분리를 통한 재사용성 확보
- ✅ 상태 저장 및 UI 동기화를 통한 상태 관리 연습
- ✅ 델리게이트를 통한 이벤트 흐름 정리

---

## **스크린샷**


| ![Simulator Screen Recording - iPhone 16 Pro - 2025-06-23 at 20 55 44](https://github.com/user-attachments/assets/7dbc72e4-b6ab-42d0-9d59-0fae4ccf9ae1) | ![Simulator Screen Recording - iPhone 13 mini - 2025-06-23 at 20 58 48](https://github.com/user-attachments/assets/7a7cbf31-dc16-407a-bea7-c56b24d8fbb0) |
|:--:|:--:|
| iPhone 16 Pro | iPhone 13 mini |

| ![Simulator Screen Recording - iPhone 16 Pro - 2025-06-23 at 21 01 11](https://github.com/user-attachments/assets/409b7e83-7418-45b7-8438-3f3d8bf001e5) | ![Simulator Screen Recording - iPhone 16 Pro - 2025-06-23 at 21 02 03](https://github.com/user-attachments/assets/febc00c4-bed9-459d-b252-fc7ba9370226) |
|:--:|:--:|
| 데이터 파일이 없는 경우 | 파일은 있는데 내용을 불러오지 못한 경우 |

---

## **실행 방법**

```
$ git clone [저장소 URL]
$ cd 프로젝트 디렉토리
$ Xcode 15 이상에서 실행
```

---

## **제작 목적**

이 프로젝트는 UIKit 기반 UI 설계 패턴을 체계적으로 연습하고

실전에서 많이 쓰이는 컴포넌트 분리 방식을 익히기 위해 작성되었습니다.

---
