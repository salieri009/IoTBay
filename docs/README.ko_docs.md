# IoT Bay - 스마트 기술 스토어

<div align="center">

한국어 | [English](README.en_docs.md) | [日本語](README.ja_docs.md)

</div>

---

## 📋 프로젝트 정보

**과목 코드**: 41025  
**과목명**: Introduction to Software Development  
**학점**: 6 Credit Points  
**과제**: Assignment 2 - Autumn 2025  
**기관**: University of Technology Sydney (UTS)  
**프로젝트 유형**: IoT 기기 전자상거래 웹 애플리케이션  
**과목 핸드북**: [41025 - Introduction to Software Development](https://coursehandbook.uts.edu.au/subject/2026/41025)

---

## 📚 과목 정보

이 프로젝트는 시드니 공과대학교(UTS)의 **41025 - Introduction to Software Development** 과목의 일부로 개발되었습니다.

- **과목 코드**: 41025
- **과목명**: Introduction to Software Development
- **학점**: 6 Credit Points
- **과목 핸드북**: [과목 상세 정보 보기](https://coursehandbook.uts.edu.au/subject/2026/41025)
- **과제**: Assignment 2 - Autumn 2025

**IoT Bay**는 **UTS (시드니 공과대학교) 학술 과제 (41025 Introduction to Software Development - Assignment 2 Autumn 2025)**의 일부로 개발된 IoT 기기 관리 및 전자상거래를 위한 현대적이고 반응형 웹 애플리케이션입니다. **JSP**, **Java MVC**, **Maven**, **Jetty 서버**로 구축되었으며, 포괄적인 디자인 시스템, 다크 모드 지원, 반응형 그리드 레이아웃, 엔터프라이즈급 보안 기능을 특징으로 합니다.

### 프로젝트 목표

- IoT 기기를 위한 완전한 기능의 전자상거래 플랫폼 구현
- JSP/Servlet 웹 개발 능력 시연
- MVC 아키텍처 패턴 적용
- 안전한 사용자 인증 및 권한 부여 구현
- 직관적이고 현대적인 사용자 인터페이스 생성
- 데이터베이스 설계 및 데이터 액세스 패턴 시연
- 엔터프라이즈급 보안 조치 구현

---

## 목차

- [주요 기능](#주요-기능)
- [빠른 시작](#빠른-시작)
- [프로젝트 구조](#프로젝트-구조)
- [디자인 시스템](#디자인-시스템)
- [보안](#보안)
- [개발](#개발)
- [설정](#설정)
- [기술 스택](#기술-스택)
- [라이선스](#라이선스)

---

## 주요 기능

### 현대적인 UI/UX 디자인
- **반응형 디자인**: 커스텀 CSS를 사용한 모바일 우선 접근 방식
- **다크 모드**: 라이트/다크 테마 전환
- **컴포넌트 기반 아키텍처**: 재사용 가능한 JSP 컴포넌트
- **그리드 레이아웃**: 현대적인 제품 그리드 시스템
- **인터랙티브 요소**: 부드러운 애니메이션 및 호버 효과

### 전자상거래 기능
- **제품 카테고리**: 산업용, 창고, 농업, 스마트홈
- **제품 탐색**: 고급 필터링 및 검색
- **쇼핑 카트**: 장바구니 추가 기능
- **사용자 인증**: 역할 기반 접근 권한을 가진 로그인/회원가입
- **주문 관리**: 주문 내역 및 추적

### 사용자 관리
- **고객 계정**: 프로필 관리 및 주문 내역
- **직원 대시보드**: 관리 도구 및 분석
- **역할 기반 접근**: 고객과 직원에 대한 서로 다른 권한
- **세션 관리**: 안전한 사용자 세션

### 관리자 기능
- **직원 대시보드**: 분석 및 보고
- **사용자 관리**: 고객 및 직원 계정 관리
- **제품 관리**: 재고 및 카탈로그 관리
- **데이터 관리**: 시스템 데이터 관리

### 보안 기능
- **서버 사이드 검증**: 포괄적인 입력 검증
- **CSRF 보호**: 토큰 기반 보호
- **Rate Limiting**: 요청 제한
- **보안 에러 처리**: 일반적인 에러 메시지
- **보안 로깅**: 보안 이벤트 감사 추적

---

## 빠른 시작

### 사전 요구사항

- **Java JDK 8+** 설치
- **Maven 3.6+** 설치
- 의존성을 위한 **인터넷 연결**

### 설치 및 설정

1. **저장소 클론**
   ```bash
   git clone <repository-url>
   cd IoTBay
   ```

2. **프로젝트 빌드**
   ```bash
   mvn clean install
   ```

3. **애플리케이션 실행**
   ```bash
   mvn jetty:run
   ```

4. **애플리케이션 접속**
   ```
   http://localhost:8080/
   ```

### 기본 로그인 정보

#### 고객 계정
- **이메일**: `customer@iotbay.com`
- **비밀번호**: `password123`

#### 직원 계정
- **이메일**: `staff@iotbay.com`
- **비밀번호**: `staff123`

---

## 프로젝트 구조

```
IoTBay/
├── src/main/java/
│   ├── controller/           # 서블릿 (MVC 컨트롤러)
│   ├── dao/                  # 데이터 접근 객체
│   │   ├── stub/            # 테스트용 스텁 구현
│   │   └── impl/            # 데이터베이스 구현
│   ├── model/               # JavaBeans (User, Product, Order)
│   ├── service/             # 비즈니스 로직 계층
│   ├── utils/               # 유틸리티 클래스 (보안, 검증, 에러 처리)
│   └── config/              # 설정 (DIContainer)
├── src/main/webapp/
│   ├── components/          # 재사용 가능한 JSP 컴포넌트
│   │   ├── header.jsp       # 네비게이션 헤더
│   │   ├── footer.jsp       # 사이트 푸터
│   │   └── layout/          # 레이아웃 템플릿
│   ├── css/
│   │   └── modern-theme.css # 디자인 시스템이 포함된 메인 스타일시트
│   ├── js/
│   │   └── main.js          # JavaScript 기능
│   ├── images/              # 정적 자산
│   ├── WEB-INF/
│   │   ├── web.xml          # 배포 설명자
│   │   └── views/           # 보호된 JSP 페이지
│   └── *.jsp                # JSP 페이지
├── docs/                    # 프로젝트 문서
│   ├── architecture/        # 시스템 설계 및 결정
│   ├── requirements/        # 기능 및 사양
│   ├── testing/             # 테스트 전략 및 감사
│   ├── development/         # 개발자 가이드
│   ├── plans/               # 구현 계획
│   ├── reports/             # 상태 보고서
│   └── archive/             # 기록 데이터
└── pom.xml                  # Maven 설정
```

---

## 디자인 시스템

### 색상 팔레트
- **Primary**: 파란색 (#0a95ff)
- **Secondary**: 초록색 (#22c55e)
- **Accent**: 주황색 (#f97316)
- **Neutral**: 회색 스케일 (50-900)

### 타이포그래피
- **폰트 패밀리**: Inter (Google Fonts)
- **제목**: 폰트 굵기 600-700
- **본문 텍스트**: 폰트 굵기 400, 줄 간격 1.6

### 컴포넌트
- **카드**: 둥근 모서리, 미묘한 그림자
- **버튼**: 여러 변형 (primary, outline, ghost)
- **폼**: 검증이 포함된 일관된 스타일링
- **네비게이션**: 드롭다운 메뉴가 있는 반응형

### 반응형 브레이크포인트
- **모바일**: < 768px
- **태블릿**: 768px - 1024px
- **데스크톱**: 1024px - 1280px
- **대형 데스크톱**: > 1280px

---

## 보안

### 엔터프라이즈급 보안 구현

- **입력 검증**: 포괄적인 서버 사이드 검증
- **XSS 방지**: 모든 사용자 입력의 향상된 정제
- **SQL 주입 방지**: 매개변수화된 쿼리
- **CSRF 보호**: 토큰 기반 보호
- **Rate Limiting**: 요청 제한
- **보안 에러 처리**: 일반적인 에러 메시지
- **보안 로깅**: 포괄적인 감사 추적

### 보안 유틸리티

- `SecurityUtil`: 입력 검증, 정제, CSRF 토큰 관리
- `ErrorAction`: 일관된 에러 처리
- `ValidationUtil`: 비즈니스 로직 검증

---

## 개발

### 일반 명령어

| 작업 | 명령어 | 설명 |
|------|--------|------|
| 정리 | `mvn clean` | 빌드 아티팩트 제거 |
| 컴파일 | `mvn compile` | 소스 코드 컴파일 |
| 테스트 | `mvn test` | 단위 테스트 실행 |
| 패키징 | `mvn package` | WAR 파일 생성 |
| 실행 | `mvn jetty:run` | 개발 서버 시작 |
| 중지 | `Ctrl + C` | 서버 중지 |

---

## 설정

### 포트 설정

기본 포트는 **8080**입니다. 변경하려면 `pom.xml`을 수정하세요:

```xml
<plugin>
    <groupId>org.eclipse.jetty</groupId>
    <artifactId>jetty-maven-plugin</artifactId>
    <configuration>
        <httpConnector>
            <port>8090</port>
        </httpConnector>
    </configuration>
</plugin>
```

### 데이터베이스 설정

현재 개발을 위해 **DAO Stubs**를 사용하고 있습니다. 실제 데이터베이스를 사용하려면:

1. `src/main/resources/database.properties` 업데이트
2. `src/main/java/dao/impl/`에 데이터베이스 DAO 클래스 구현
3. `web.xml` 서블릿 설정 업데이트

---

## 기술 스택

### 백엔드
- **Java**: JDK 8 이상
- **JSP**: JavaServer Pages 2.3+
- **Servlets**: Java Servlet API 3.1+
- **Maven**: 빌드 자동화 및 의존성 관리
- **Jetty**: 임베디드 웹 서버 (개발용)
- **아키텍처**: MVC (Model-View-Controller) 패턴
- **데이터 접근**: DAO (Data Access Object) 패턴

### 프론트엔드
- **HTML5**: 시맨틱 마크업
- **CSS3**: CSS 커스텀 속성을 사용한 현대적 스타일링
- **JavaScript**: ES6+ 상호작용
- **디자인 시스템**: 컴포넌트 기반 아키텍처를 가진 커스텀 CSS 프레임워크
- **반응형 디자인**: 모바일 우선 접근 방식

### 데이터베이스
- **SQLite**: 경량 관계형 데이터베이스 (개발용)
- **JDBC**: 데이터베이스 연결
- **DAO 패턴**: 데이터 접근을 위한 추상화 계층

### 보안
- **비밀번호 해싱**: 솔트를 사용한 SHA-256
- **세션 관리**: 안전한 세션 처리
- **역할 기반 접근 제어**: 고객, 직원, 관리자 역할
- **입력 검증**: SQL 주입 및 XSS 방지
- **CSRF 보호**: 토큰 기반 보호
- **Rate Limiting**: 요청 제한

---

## 과제 요구사항

### 기능 요구사항

1. **사용자 관리**
   - 사용자 등록 및 인증
   - 프로필 관리
   - 역할 기반 접근 제어 (고객, 직원, 관리자)
   - 세션 관리

2. **제품 관리**
   - 카테고리가 있는 제품 카탈로그
   - 제품 검색 및 필터링
   - 제품 상세 페이지
   - 재고 관리

3. **전자상거래 기능**
   - 쇼핑 카트 기능
   - 체크아웃 프로세스
   - 주문 관리
   - 주문 내역

4. **관리 기능**
   - 사용자 관리 대시보드
   - 제품 관리
   - 주문 처리
   - 접근 로깅 및 분석

### 기술 요구사항

- MVC 아키텍처 구현
- 데이터 접근을 위한 DAO 패턴
- 안전한 인증 및 권한 부여
- 반응형 웹 디자인
- 디자인 시스템 원칙을 따르는 현대적인 UI/UX
- 오류 처리 및 검증
- 보안 감사를 위한 접근 로깅
- 서버 사이드 검증 및 보안 조치

### 디자인 요구사항

- 모든 페이지에 걸친 일관된 디자인 시스템
- 모바일, 태블릿, 데스크톱을 위한 반응형 레이아웃
- 접근성 준수 (WCAG 2.1 AA)
- 다크 모드 지원
- 현대적이고 깔끔한 인터페이스

---

## 개발 가이드라인

### 코드 표준

- Java 명명 규칙 준수
- 의미 있는 변수 및 메서드 이름 사용
- 적절한 오류 처리 구현
- 복잡한 로직에 주석 추가
- 일관된 코드 포맷팅 유지

### 테스트

- 모든 사용자 흐름 테스트
- 인증 및 권한 부여 확인
- 여러 기기에서 반응형 디자인 테스트
- 폼 입력 검증
- 오류 시나리오 테스트

### 문서화

- 최신 README 유지
- API 엔드포인트 문서화
- 인라인 코드 주석 포함
- 디자인 시스템 문서 업데이트

---

## 라이선스

이 프로젝트는 **UTS 41025 Introduction to Software Development - Assignment 2 Autumn 2025**의 일부로 **학술적 목적**을 위해 개발되었습니다. 모든 코드와 문서는 교육용으로만 사용됩니다.


---

**Document Version**: 1.0.0
**Status**: Published
**Last Updated**: 12�� 3, 2025
**Audience**: Developers, Stakeholders
**Maintained By**: IoT Bay Documentation Team
