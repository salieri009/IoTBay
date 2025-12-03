# IoTBay API Documentation

## 📋 Project Information

**Course**: 41025 Information Systems Development (ISD)  
**Assignment**: Assignment 2 - Autumn 2025  
**Institution**: University of Technology Sydney (UTS)  
**Project Type**: E-commerce Web Application for IoT Devices

---

## 📚 API 개요

IoTBay API는 RESTful 설계 원칙을 따르며, IoT 전자상거래 플랫폼의 모든 기능을 제공합니다. 이 API는 **UTS 41025 ISD Assignment 2 Autumn 2025**의 일부로 개발되었으며, JSP/Servlet 기반 웹 애플리케이션을 위한 엔드포인트를 정의합니다.

### Base URL
```
Development: http://localhost:8080
Production: https://api.iotbay.com
```

### 인증 방식
- **세션 기반 인증**: 서버 세션을 통한 상태 관리
- **CSRF 보호**: Cross-Site Request Forgery 방지
- **Role-based Access Control**: 역할 기반 접근 제어

---

## 🔐 Authentication API

### 1. 사용자 로그인
```http
POST /login
Content-Type: application/x-www-form-urlencoded

email=user@example.com&password=securepassword
```

**Response (Success):**
```json
{
  "success": true,
  "message": "로그인 성공",
  "user": {
    "id": 1,
    "email": "user@example.com",
    "firstName": "김",
    "lastName": "철수",
    "role": "customer",
    "isActive": true
  }
}
```

**Response (Error):**
```json
{
  "success": false,
  "message": "이메일 또는 비밀번호가 올바르지 않습니다.",
  "errorCode": "INVALID_CREDENTIALS"
}
```

### 2. 사용자 회원가입
```http
POST /register
Content-Type: application/x-www-form-urlencoded

email=newuser@example.com&password=securepassword&firstName=김&lastName=영희&phone=010-1234-5678
```

**Response (Success):**
```json
{
  "success": true,
  "message": "회원가입이 완료되었습니다.",
  "user": {
    "id": 2,
    "email": "newuser@example.com",
    "firstName": "김",
    "lastName": "영희",
    "role": "customer",
    "isActive": true
  }
}
```

### 3. 로그아웃
```http
POST /logout
```

**Response:**
```json
{
  "success": true,
  "message": "로그아웃되었습니다."
}
```

### 4. 현재 사용자 정보 조회
```http
GET /me
```

**Response:**
```json
{
  "success": true,
  "user": {
    "id": 1,
    "email": "user@example.com",
    "firstName": "김",
    "lastName": "철수",
    "phone": "010-1234-5678",
    "role": "customer",
    "isActive": true
  }
}
```

---

## 🛍️ Product API

### 1. 상품 목록 조회/검색
```http
GET /browse?keyword={searchTerm}&category={categoryId}&page={pageNumber}&limit={itemsPerPage}
```

**Parameters:**
- `keyword` (optional): 검색 키워드
- `category` (optional): 카테고리 ID
- `page` (optional): 페이지 번호 (기본값: 1)
- `limit` (optional): 페이지당 항목 수 (기본값: 20)

**Response:**
```json
{
  "success": true,
  "products": [
    {
      "id": 1,
      "categoryId": 1,
      "name": "IoT 온도 센서",
      "description": "고정밀 디지털 온도 센서",
      "price": 45000,
      "stockQuantity": 50,
      "imageUrl": "/images/sensor-temp-001.jpg",
      "createdAt": "2025-01-15T10:30:00Z",
      "category": {
        "id": 1,
        "name": "센서",
        "description": "다양한 IoT 센서 제품"
      }
    }
  ],
  "pagination": {
    "currentPage": 1,
    "totalPages": 5,
    "totalItems": 95,
    "itemsPerPage": 20
  }
}
```

### 2. 상품 상세 정보 조회
```http
GET /product?productId={id}
```

**Response:**
```json
{
  "success": true,
  "product": {
    "id": 1,
    "categoryId": 1,
    "name": "IoT 온도 센서",
    "description": "고정밀 디지털 온도 센서로 -40°C부터 +85°C까지 측정 가능",
    "price": 45000,
    "stockQuantity": 50,
    "imageUrl": "/images/sensor-temp-001.jpg",
    "specifications": {
      "accuracy": "±0.5°C",
      "resolution": "0.1°C",
      "interface": "I2C/SPI",
      "voltage": "3.3V-5V"
    },
    "reviews": [
      {
        "id": 1,
        "userId": 5,
        "rating": 5,
        "comment": "정확하고 사용하기 쉬워요",
        "createdAt": "2025-01-10T14:20:00Z"
      }
    ]
  }
}
```

---

## 🛒 Cart API

### 1. 장바구니 조회
```http
GET /cart
```

**Response:**
```json
{
  "success": true,
  "cartItems": [
    {
      "id": 1,
      "productId": 1,
      "quantity": 2,
      "addedAt": "2025-01-15T10:30:00Z",
      "product": {
        "id": 1,
        "name": "IoT 온도 센서",
        "price": 45000,
        "imageUrl": "/images/sensor-temp-001.jpg",
        "stockQuantity": 50
      }
    }
  ],
  "summary": {
    "totalItems": 2,
    "subtotal": 90000,
    "tax": 9000,
    "total": 99000
  }
}
```

### 2. 장바구니에 상품 추가
```http
POST /cart
Content-Type: application/x-www-form-urlencoded

action=add&productId=1&quantity=2
```

**Response:**
```json
{
  "success": true,
  "message": "상품이 장바구니에 추가되었습니다.",
  "cartItem": {
    "id": 1,
    "productId": 1,
    "quantity": 2
  }
}
```

### 3. 장바구니 수량 변경
```http
POST /cart
Content-Type: application/x-www-form-urlencoded

action=update&productId=1&quantity=3
```

### 4. 장바구니에서 상품 제거
```http
POST /cart
Content-Type: application/x-www-form-urlencoded

action=remove&productId=1
```

---

## 📦 Order API

### 1. 주문 생성 (체크아웃)
```http
POST /checkout
Content-Type: application/x-www-form-urlencoded

shippingAddress=서울시 강남구 테헤란로 123&paymentMethod=card
```

**Response:**
```json
{
  "success": true,
  "message": "주문이 성공적으로 생성되었습니다.",
  "order": {
    "id": 100,
    "orderDate": "2025-01-15T11:00:00Z",
    "status": "pending",
    "totalAmount": 99000,
    "shippingAddress": "서울시 강남구 테헤란로 123",
    "orderItems": [
      {
        "productId": 1,
        "productName": "IoT 온도 센서",
        "quantity": 2,
        "unitPrice": 45000,
        "totalPrice": 90000
      }
    ]
  }
}
```

### 2. 주문 내역 조회
```http
GET /orderHistory?page={pageNumber}&limit={itemsPerPage}
```

**Response:**
```json
{
  "success": true,
  "orders": [
    {
      "id": 100,
      "orderDate": "2025-01-15T11:00:00Z",
      "status": "shipped",
      "totalAmount": 99000,
      "trackingNumber": "TRK123456789"
    }
  ],
  "pagination": {
    "currentPage": 1,
    "totalPages": 3,
    "totalItems": 25
  }
}
```

---

## 👤 User Profile API

### 1. 프로필 정보 수정
```http
POST /updateProfile
Content-Type: application/x-www-form-urlencoded

firstName=김&lastName=철수&phone=010-9876-5432&addressLine1=서울시 서초구 강남대로 456
```

**Response:**
```json
{
  "success": true,
  "message": "프로필이 업데이트되었습니다.",
  "user": {
    "id": 1,
    "email": "user@example.com",
    "firstName": "김",
    "lastName": "철수",
    "phone": "010-9876-5432",
    "addressLine1": "서울시 서초구 강남대로 456"
  }
}
```

---

## 🔧 Admin API

### 1. 사용자 관리 (관리자 전용)
```http
GET /manage-users
Authorization: Admin role required
```

**Response:**
```json
{
  "success": true,
  "users": [
    {
      "id": 1,
      "email": "user@example.com",
      "firstName": "김",
      "lastName": "철수",
      "role": "customer",
      "isActive": true,
      "createdAt": "2025-01-01T00:00:00Z"
    }
  ]
}
```

### 2. 상품 관리 (관리자 전용)
```http
POST /manage-products
Content-Type: application/x-www-form-urlencoded
Authorization: Admin role required

action=add&name=새 센서&description=새로운 IoT 센서&price=50000&categoryId=1&stockQuantity=100
```

---

## 📊 Error Codes

| Code | Description | HTTP Status |
|------|-------------|-------------|
| `INVALID_CREDENTIALS` | 잘못된 로그인 정보 | 401 |
| `UNAUTHORIZED` | 인증되지 않은 접근 | 401 |
| `FORBIDDEN` | 권한 없음 | 403 |
| `NOT_FOUND` | 리소스를 찾을 수 없음 | 404 |
| `VALIDATION_ERROR` | 입력 데이터 검증 실패 | 400 |
| `INSUFFICIENT_STOCK` | 재고 부족 | 400 |
| `INTERNAL_ERROR` | 서버 내부 오류 | 500 |

---

## 🚀 Rate Limiting

- **인증된 사용자**: 분당 100 요청
- **비인증 사용자**: 분당 20 요청
- **관리자**: 분당 200 요청

## 📝 Response Format

모든 API 응답은 다음 구조를 따릅니다:

```json
{
  "success": boolean,
  "message": "string (optional)",
  "data": "object (optional)",
  "error": "object (optional)",
  "timestamp": "ISO 8601 format",
  "requestId": "unique identifier"
}
```

## 🔄 Versioning

API 버전은 URL 경로에 포함됩니다:
- `v1`: 현재 안정 버전
- `v2`: 베타 버전 (향후 지원)


---

**Document Version**: 1.0.0
**Status**: Published
**Last Updated**: 12�� 3, 2025
**Audience**: Developers, Stakeholders
**Maintained By**: IoT Bay Documentation Team
