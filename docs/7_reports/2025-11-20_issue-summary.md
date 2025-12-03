# 2025-11-20 운영 이슈 정리

아래 항목들은 최근 관리자 영역 점검 중 확인된 대표 문제들입니다. 각 항목은 `문제 → 해결 → 결과 → 도메인` 순으로 서술했으며, 재발 방지와 후속 학습에 활용할 수 있도록 구체적인 맥락을 남겼습니다.

---

## 1. 관리자 내비게이션/뷰 경로 불일치
- **문제**  
  - `admin-dashboard.jsp` 사이드바와 퀵 액션이 `/api/manage/...` 엔드포인트를 직접 호출하면서 404/500이 발생했습니다.  
  - `ManageUserController`, `ManageProductController`는 여전히 `/WEB-INF/views/*.jsp` 로 포워딩하고 있어 실제 노출용 JSP(루트 경로로 이동한 최신 버전)와 불일치했습니다.  
  - `manage-users.jsp` 에서는 `userItem.isActive` 필드를 참조하지만, 컨트롤러가 옛 DAO/JSP 조합을 계속 사용해 EL이 해석되지 않는 문제가 재현되었습니다.
- **해결**  
  - 관리자 전용 컨트롤러들을 `/manage/users`, `/manage/products` 등 화면 엔드포인트로 리다이렉트하도록 정비하고, JSP 포워딩 경로도 루트 위치로 수정합니다.  
  - JSTL에서 사용하는 필드명을 `user.isActive()` / `user.active` 등 실존 게터로 통일하고, 누락된 경우 모델/DAO를 업데이트해 일관된 Boolean 게터를 제공합니다.  
  - 사이드바 및 퀵 액션 링크를 실제 JSP 진입점(`/manage/users`, `/manage/products`, `/manage/access-logs`, `/admin/supplier/` 등)으로 교체했습니다.
- **결과**  
  - 관리자 대시보드에서 사용자/상품/로그 화면으로 즉시 진입 가능하며, 더 이상 `/WEB-INF/views/...` JSP 컴파일 오류나 404가 발생하지 않습니다.  
  - `manage-users.jsp` 는 활성/비활성 뱃지를 정상 렌더링하고, 브라우저에서 직접 목록 확인이 가능합니다.
- **도메인**: Admin Console (User & Catalog Management)

---

## 2. 공급업체 및 주문 관리 DB 스키마 누락
- **문제**  
  - `SupplierController` 가 `suppliers` 테이블을 조회하지만, 실행 환경 DB에는 해당 테이블이 생성되지 않아 `no such table: suppliers` 예외가 반복되었습니다.  
  - 주문 관리(`/manage/orders`) 역시 `orders` 테이블 부재로 `Database error: [SQLITE_ERROR] ... no such table: orders` 를 반환했습니다.  
  - `DatabaseInitializer` 는 Users 테이블만 시드하고 있어, 나머지 DDL 스크립트가 실제 DB에 반영되지 않는 구조였습니다.
- **해결**  
  - `DatabaseInitializer` 또는 별도의 마이그레이션 루틴에 `create_orders.sql`, `create_order_products.sql`, `create_supplier*.sql` 등 모든 스키마 스크립트를 순차 적용하도록 확장합니다.  
  - 부팅 시점에 다중 테이블 존재 여부를 검사해 누락된 경우 자동 생성하도록 만들고, 초기 더미 데이터(테스트 공급업체/주문)를 주입해 관리자 화면 검증이 가능하도록 했습니다.  
  - DAO 계층은 실제 DB 연결 실패 시 Stub DAO로 graceful fallback 하도록 설정해, 초기 개발/테스트 단계에서 화면을 띄울 수 있게 했습니다.
- **결과**  
  - `/admin/supplier/` 및 `/manage/orders` 화면이 정상적으로 데이터를 로딩하며, CRUD 및 상태 변경 작업도 DB에 반영됩니다.  
  - 초기 세팅 시 스크립트를 따로 실행할 필요 없이 애플리케이션이 자체적으로 스키마를 구성합니다.
- **도메인**: Supplier Management & Order Processing (Persistence Layer)

---

## 3. 분석/데이터 페이지의 정적 데이터 및 EL 오류
- **문제**  
  - `reports-dashboard.jsp` 는 모든 통계를 하드코딩된 숫자와 이미지로 표시해 실제 DB 상태를 전혀 반영하지 않았습니다.  
  - `data-management.jsp` 는 `${new Date().toISOString().split('T')[0]}` 처럼 EL에서 JavaScript 문법을 사용하여 JSP 컴파일 단계에서 `Failed to parse the expression` 오류가 발생했습니다.  
  - 두 페이지 모두 컨트롤러에서 통계를 주입하지 않아, 관리자 입장에서는 시스템 현황을 전혀 확인할 수 없는 상태였습니다.
- **해결**  
  - `ReportsDashboardController` (신규) 를 작성해 `UserDAO`, `OrderDAO`, `ProductDAO`, `SupplierDAO` 등에서 실시간 집계를 조회한 뒤 JSP에 주입했습니다.  
  - `data-management.jsp` 의 날짜/파일명 표시는 JSTL `<fmt:formatDate>` 또는 서버 측 변수(`request.setAttribute("todayDate", ...)`)를 활용하도록 수정하고, JavaScript 동적 값은 `<script>` 내부에서 처리했습니다.  
  - 운영/분석 카드, 최근 주문 테이블, 백업 로그 등도 실제 DAO 결과로 채워지게 했습니다.
- **결과**  
  - 관리자 보고서와 데이터 관리 페이지가 실행 중인 DB의 사용자/주문/상품/공급업체 현황을 표시하며, 더 이상 JSP 컴파일 오류 없이 로드됩니다.  
  - 향후 BI/통계 고도화를 위한 기반(Controller + Service)을 마련했습니다.
- **도메인**: Reporting & Data Operations (Admin Analytics)

---

### 참고
- 추가적인 세부 로그, SQL 스크립트 반영 순서, 마이그레이션 플로우 등은 `docs/development/`와 `docs/architecture/` 하위 문서를 참고하세요.  
- 새로운 이슈가 발견되면 동일한 `문제-해결-결과-도메인` 구조로 레코드를 추가해 지식 자산화할 예정입니다.



---

**Document Version**: 1.0.0
**Status**: Published
**Last Updated**: 12�� 3, 2025
**Audience**: Developers, Stakeholders
**Maintained By**: IoT Bay Documentation Team
