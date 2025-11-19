# IoTBay 컴포넌트 아키텍처

## 📋 프로젝트 정보

**언어**: 한국어 (Korean)  
**Course**: 41025 Information Systems Development (ISD)  
**Assignment**: Assignment 2 - Autumn 2025  
**Institution**: University of Technology Sydney (UTS)  
**Project Type**: E-commerce Web Application for IoT Devices

---

## 🏗️ 아키텍처 개요

IoTBay의 컴포넌트 아키텍처는 **확장가능하고 유지보수가 용이한 모듈형 구조**를 기반으로 설계되었습니다. **UTS 41025 ISD Assignment 2 Autumn 2025**의 요구사항에 맞춰 JSP 기반 컴포넌트 시스템을 구현하며, 재사용 가능한 UI 컴포넌트와 일관된 디자인 시스템을 제공합니다.

> **참고**: 이 문서는 JSP/Servlet 기반 프로젝트를 위한 컴포넌트 아키텍처를 설명합니다. React/TypeScript 기반 프론트엔드가 별도로 존재하는 경우, 해당 프로젝트의 컴포넌트 구조도 참고할 수 있습니다.

### 설계 원칙
- **단일 책임 원칙**: 각 컴포넌트는 하나의 명확한 역할을 담당
- **재사용성**: 공통 컴포넌트의 최대한 활용
- **조합성**: 작은 컴포넌트들을 조합하여 복잡한 UI 구성
- **일관성**: 디자인 시스템을 통한 일관된 사용자 경험
- **접근성**: WCAG 2.1 AA 준수를 위한 접근성 고려
- **성능 최적화**: 효율적인 렌더링과 최소한의 DOM 조작

---

## 📁 프로젝트 구조

### JSP 기반 컴포넌트 구조 (메인 프로젝트)

```
IoTBay/
├── src/main/webapp/
│   ├── components/          # 재사용 가능한 JSP 컴포넌트
│   │   ├── header.jsp       # 헤더 컴포넌트
│   │   ├── footer.jsp       # 푸터 컴포넌트
│   │   ├── masthead.jsp     # 히어로 섹션
│   │   ├── product-card.jsp # 제품 카드 컴포넌트
│   │   ├── modal.jsp        # 모달 컴포넌트
│   │   ├── toast.jsp        # 토스트 알림
│   │   └── layout/          # 레이아웃 태그
│   │       └── base.tag     # 기본 레이아웃 태그
│   ├── css/                 # 스타일시트
│   │   ├── modern-theme.css # 메인 디자인 시스템
│   │   └── themes/          # 테마 파일
│   ├── js/                  # JavaScript 파일
│   │   └── main.js          # 메인 JavaScript
│   └── *.jsp                # 페이지 JSP 파일
```

### React 기반 프론트엔드 구조 (선택적)

```
IoTBay-Frontend/ (별도 프로젝트)
├── src/
│   ├── components/          # 재사용 가능한 공통 컴포넌트
│   │   ├── ui/             # 기본 UI 컴포넌트
│   │   ├── forms/          # 폼 관련 컴포넌트
│   │   ├── layout/         # 레이아웃 컴포넌트
│   │   ├── navigation/     # 네비게이션 컴포넌트
│   │   ├── feedback/       # 피드백 컴포넌트 (토스트, 모달 등)
│   │   └── data-display/   # 데이터 표시 컴포넌트
│   ├── pages/              # 페이지 컴포넌트
│   ├── hooks/              # 커스텀 훅
│   ├── contexts/           # React Context
│   ├── services/           # API 서비스
│   ├── types/              # TypeScript 타입 정의
│   ├── utils/              # 유틸리티 함수
│   └── styles/             # 스타일 파일
```

---

## 🧩 컴포넌트 계층 구조

### 1. Atoms (원자 컴포넌트)
가장 기본적인 UI 요소들로, 더 이상 분해할 수 없는 최소 단위의 컴포넌트입니다.

```typescript
// src/components/ui/Button/Button.tsx
import React from 'react';
import { ButtonVariant, ButtonSize } from '@/types/components';

interface ButtonProps {
  variant?: ButtonVariant;
  size?: ButtonSize;
  disabled?: boolean;
  loading?: boolean;
  children: React.ReactNode;
  onClick?: () => void;
  type?: 'button' | 'submit' | 'reset';
  className?: string;
}

export const Button: React.FC<ButtonProps> = ({
  variant = 'primary',
  size = 'md',
  disabled = false,
  loading = false,
  children,
  onClick,
  type = 'button',
  className = '',
}) => {
  const baseClasses = 'btn';
  const variantClasses = `btn-${variant}`;
  const sizeClasses = `btn-${size}`;
  const stateClasses = disabled ? 'btn-disabled' : '';
  
  const classes = [
    baseClasses,
    variantClasses,
    sizeClasses,
    stateClasses,
    className
  ].filter(Boolean).join(' ');

  return (
    <button
      type={type}
      className={classes}
      disabled={disabled || loading}
      onClick={onClick}
      aria-busy={loading}
    >
      {loading && <Spinner size="sm" />}
      {children}
    </button>
  );
};
```

**Atoms 컴포넌트 목록:**
- `Button` - 버튼
- `Input` - 입력 필드
- `Label` - 라벨
- `Icon` - 아이콘
- `Avatar` - 아바타
- `Badge` - 배지
- `Spinner` - 로딩 스피너
- `Divider` - 구분선
- `Image` - 이미지
- `Link` - 링크

### 2. Molecules (분자 컴포넌트)
Atoms를 조합하여 하나의 기능을 수행하는 컴포넌트입니다.

```typescript
// src/components/forms/FormField/FormField.tsx
import React from 'react';
import { Input } from '@/components/ui/Input';
import { Label } from '@/components/ui/Label';
import { ErrorMessage } from '@/components/ui/ErrorMessage';

interface FormFieldProps {
  label: string;
  name: string;
  type?: string;
  placeholder?: string;
  required?: boolean;
  error?: string;
  value?: string;
  onChange?: (value: string) => void;
  disabled?: boolean;
}

export const FormField: React.FC<FormFieldProps> = ({
  label,
  name,
  type = 'text',
  placeholder,
  required = false,
  error,
  value,
  onChange,
  disabled = false,
}) => {
  return (
    <div className="form-field">
      <Label htmlFor={name} required={required}>
        {label}
      </Label>
      <Input
        id={name}
        name={name}
        type={type}
        placeholder={placeholder}
        value={value}
        onChange={(e) => onChange?.(e.target.value)}
        disabled={disabled}
        error={!!error}
        aria-describedby={error ? `${name}-error` : undefined}
      />
      {error && (
        <ErrorMessage id={`${name}-error`}>
          {error}
        </ErrorMessage>
      )}
    </div>
  );
};
```

**Molecules 컴포넌트 목록:**
- `FormField` - 라벨, 입력, 오류 메시지가 조합된 폼 필드
- `SearchBox` - 검색 입력과 버튼
- `PriceDisplay` - 가격 표시 (통화, 할인 등)
- `Rating` - 평점 표시
- `Pagination` - 페이지네이션
- `BreadcrumbNavigation` - 브레드크럼
- `ProductCard` - 상품 카드
- `CartItem` - 장바구니 항목

### 3. Organisms (유기체 컴포넌트)
Molecules와 Atoms를 조합하여 복잡한 UI 섹션을 구성하는 컴포넌트입니다.

```typescript
// src/components/layout/Header/Header.tsx
import React from 'react';
import { Navigation } from '@/components/navigation/Navigation';
import { SearchBox } from '@/components/ui/SearchBox';
import { CartIcon } from '@/components/navigation/CartIcon';
import { UserMenu } from '@/components/navigation/UserMenu';
import { Logo } from '@/components/ui/Logo';
import { useAuth } from '@/hooks/useAuth';
import { useCart } from '@/hooks/useCart';

export const Header: React.FC = () => {
  const { user, isAuthenticated } = useAuth();
  const { itemCount } = useCart();

  return (
    <header className="navbar">
      <div className="container">
        <div className="navbar-content">
          {/* 로고 */}
          <div className="navbar-brand">
            <Logo />
          </div>

          {/* 네비게이션 */}
          <Navigation />

          {/* 검색 */}
          <div className="navbar-search">
            <SearchBox 
              placeholder="IoT 제품 검색..."
              onSearch={(query) => {
                // 검색 로직
              }}
            />
          </div>

          {/* 사용자 액션 */}
          <div className="navbar-actions">
            <CartIcon itemCount={itemCount} />
            {isAuthenticated ? (
              <UserMenu user={user} />
            ) : (
              <div className="auth-buttons">
                <Button variant="ghost" href="/login">
                  로그인
                </Button>
                <Button variant="primary" href="/register">
                  회원가입
                </Button>
              </div>
            )}
          </div>
        </div>
      </div>
    </header>
  );
};
```

**Organisms 컴포넌트 목록:**
- `Header` - 사이트 헤더
- `Footer` - 사이트 푸터
- `Sidebar` - 사이드바
- `ProductGrid` - 상품 그리드
- `CartSummary` - 장바구니 요약
- `OrderSummary` - 주문 요약
- `UserProfile` - 사용자 프로필
- `AdminDashboard` - 관리자 대시보드

### 4. Templates (템플릿)
페이지의 전체적인 레이아웃을 정의하는 컴포넌트입니다.

```typescript
// src/components/layout/PageTemplate/PageTemplate.tsx
import React from 'react';
import { Header } from '@/components/layout/Header';
import { Footer } from '@/components/layout/Footer';
import { Sidebar } from '@/components/layout/Sidebar';
import { ErrorBoundary } from '@/components/feedback/ErrorBoundary';
import { NotificationContainer } from '@/components/feedback/NotificationContainer';

interface PageTemplateProps {
  children: React.ReactNode;
  sidebar?: boolean;
  fullWidth?: boolean;
  className?: string;
}

export const PageTemplate: React.FC<PageTemplateProps> = ({
  children,
  sidebar = false,
  fullWidth = false,
  className = '',
}) => {
  return (
    <div className={`app-layout ${className}`}>
      <Header />
      
      {sidebar && <Sidebar />}
      
      <main className={`app-main ${fullWidth ? 'full-width' : 'container'}`}>
        <ErrorBoundary>
          {children}
        </ErrorBoundary>
      </main>
      
      <Footer />
      
      <NotificationContainer />
    </div>
  );
};
```

### 5. Pages (페이지)
실제 라우트와 연결되는 최상위 컴포넌트입니다.

```typescript
// src/pages/Products/Products.tsx
import React from 'react';
import { PageTemplate } from '@/components/layout/PageTemplate';
import { ProductGrid } from '@/components/organisms/ProductGrid';
import { ProductFilters } from '@/components/organisms/ProductFilters';
import { BreadcrumbNavigation } from '@/components/ui/BreadcrumbNavigation';
import { useProducts } from '@/hooks/api/useProducts';
import { useFilters } from '@/hooks/ui/useFilters';

export const ProductsPage: React.FC = () => {
  const { filters, updateFilter } = useFilters();
  const { products, loading, error } = useProducts(filters);

  const breadcrumbs = [
    { label: '홈', href: '/' },
    { label: '상품', href: '/products' },
  ];

  return (
    <PageTemplate sidebar>
      <div className="products-page">
        <BreadcrumbNavigation items={breadcrumbs} />
        
        <div className="page-header">
          <h1 className="heading-1">IoT 제품</h1>
          <p className="body-large text-gray-600">
            혁신적인 IoT 솔루션을 만나보세요
          </p>
        </div>

        <div className="products-content">
          <aside className="products-filters">
            <ProductFilters 
              filters={filters}
              onFilterChange={updateFilter}
            />
          </aside>

          <section className="products-main">
            {loading && <ProductGridSkeleton />}
            {error && <ErrorMessage error={error} />}
            {products && (
              <ProductGrid 
                products={products}
                loading={loading}
              />
            )}
          </section>
        </div>
      </div>
    </PageTemplate>
  );
};
```

---

## 🔗 상태 관리 아키텍처

### Context 기반 상태 관리

```typescript
// src/contexts/AuthContext.tsx
import React, { createContext, useContext, useReducer, useEffect } from 'react';
import { User } from '@/types/models';
import { authService } from '@/services/auth';

interface AuthState {
  user: User | null;
  isAuthenticated: boolean;
  loading: boolean;
  error: string | null;
}

type AuthAction =
  | { type: 'AUTH_START' }
  | { type: 'AUTH_SUCCESS'; payload: User }
  | { type: 'AUTH_FAILURE'; payload: string }
  | { type: 'AUTH_LOGOUT' };

const AuthContext = createContext<{
  state: AuthState;
  login: (email: string, password: string) => Promise<void>;
  logout: () => void;
  register: (userData: RegisterData) => Promise<void>;
} | null>(null);

const authReducer = (state: AuthState, action: AuthAction): AuthState => {
  switch (action.type) {
    case 'AUTH_START':
      return { ...state, loading: true, error: null };
    case 'AUTH_SUCCESS':
      return { 
        ...state, 
        user: action.payload, 
        isAuthenticated: true, 
        loading: false 
      };
    case 'AUTH_FAILURE':
      return { 
        ...state, 
        error: action.payload, 
        loading: false,
        isAuthenticated: false 
      };
    case 'AUTH_LOGOUT':
      return { 
        user: null, 
        isAuthenticated: false, 
        loading: false, 
        error: null 
      };
    default:
      return state;
  }
};

export const AuthProvider: React.FC<{ children: React.ReactNode }> = ({ 
  children 
}) => {
  const [state, dispatch] = useReducer(authReducer, {
    user: null,
    isAuthenticated: false,
    loading: false,
    error: null,
  });

  const login = async (email: string, password: string) => {
    dispatch({ type: 'AUTH_START' });
    try {
      const user = await authService.login(email, password);
      dispatch({ type: 'AUTH_SUCCESS', payload: user });
    } catch (error) {
      dispatch({ 
        type: 'AUTH_FAILURE', 
        payload: error instanceof Error ? error.message : 'Login failed' 
      });
    }
  };

  const logout = () => {
    authService.logout();
    dispatch({ type: 'AUTH_LOGOUT' });
  };

  const register = async (userData: RegisterData) => {
    dispatch({ type: 'AUTH_START' });
    try {
      const user = await authService.register(userData);
      dispatch({ type: 'AUTH_SUCCESS', payload: user });
    } catch (error) {
      dispatch({ 
        type: 'AUTH_FAILURE', 
        payload: error instanceof Error ? error.message : 'Registration failed' 
      });
    }
  };

  // 초기 인증 상태 확인
  useEffect(() => {
    const checkAuth = async () => {
      const token = localStorage.getItem('auth-token');
      if (token) {
        try {
          const user = await authService.getCurrentUser();
          dispatch({ type: 'AUTH_SUCCESS', payload: user });
        } catch {
          localStorage.removeItem('auth-token');
        }
      }
    };
    checkAuth();
  }, []);

  return (
    <AuthContext.Provider value={{ state, login, logout, register }}>
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
};
```

### 커스텀 훅을 통한 로직 분리

```typescript
// src/hooks/api/useProducts.ts
import { useState, useEffect } from 'react';
import { Product, ProductFilters } from '@/types/models';
import { productService } from '@/services/products';

interface UseProductsReturn {
  products: Product[];
  loading: boolean;
  error: string | null;
  totalCount: number;
  hasMore: boolean;
  loadMore: () => void;
  refresh: () => void;
}

export const useProducts = (filters: ProductFilters): UseProductsReturn => {
  const [products, setProducts] = useState<Product[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [totalCount, setTotalCount] = useState(0);
  const [page, setPage] = useState(1);

  const loadProducts = async (pageNum: number, append = false) => {
    setLoading(true);
    setError(null);
    
    try {
      const response = await productService.getProducts({
        ...filters,
        page: pageNum,
        limit: 20,
      });
      
      setProducts(prev => 
        append ? [...prev, ...response.products] : response.products
      );
      setTotalCount(response.total);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to load products');
    } finally {
      setLoading(false);
    }
  };

  const loadMore = () => {
    if (!loading && hasMore) {
      const nextPage = page + 1;
      setPage(nextPage);
      loadProducts(nextPage, true);
    }
  };

  const refresh = () => {
    setPage(1);
    loadProducts(1, false);
  };

  const hasMore = products.length < totalCount;

  useEffect(() => {
    setPage(1);
    loadProducts(1, false);
  }, [filters]);

  return {
    products,
    loading,
    error,
    totalCount,
    hasMore,
    loadMore,
    refresh,
  };
};
```

---

## 🎨 컴포넌트 스타일링 전략

### CSS Modules + CSS Variables 조합

```typescript
// src/components/ui/Button/Button.module.css
.button {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  border: none;
  border-radius: var(--radius-md);
  font-family: var(--font-primary);
  font-weight: var(--font-medium);
  text-decoration: none;
  cursor: pointer;
  transition: all var(--duration-normal) var(--ease-out);
  position: relative;
  overflow: hidden;
}

.button:disabled {
  opacity: 0.5;
  cursor: not-allowed;
  transform: none;
}

/* Size Variants */
.small {
  padding: 0.5rem 1rem;
  font-size: var(--text-sm);
  min-height: 2rem;
}

.medium {
  padding: 0.75rem 1.5rem;
  font-size: var(--text-base);
  min-height: 2.5rem;
}

.large {
  padding: 1rem 2rem;
  font-size: var(--text-lg);
  min-height: 3rem;
}

/* Color Variants */
.primary {
  background: var(--gradient-primary);
  color: white;
  box-shadow: 0 4px 14px 0 rgba(10, 149, 255, 0.25);
}

.primary:hover:not(:disabled) {
  transform: translateY(-2px);
  box-shadow: 0 8px 25px 0 rgba(10, 149, 255, 0.35);
}

.secondary {
  background: var(--bg-primary);
  color: var(--primary-600);
  border: 2px solid var(--primary-200);
}

.secondary:hover:not(:disabled) {
  background: var(--primary-50);
  border-color: var(--primary-300);
}
```

### 조건부 클래스 명 유틸리티

```typescript
// src/utils/classNames.ts
export type ClassValue = string | number | boolean | undefined | null | ClassValue[];

export const cn = (...classes: ClassValue[]): string => {
  const result: string[] = [];
  
  for (const cls of classes) {
    if (typeof cls === 'string' && cls.length > 0) {
      result.push(cls);
    } else if (typeof cls === 'object' && cls !== null) {
      for (const [key, value] of Object.entries(cls)) {
        if (value) {
          result.push(key);
        }
      }
    }
  }
  
  return result.join(' ');
};

// 사용 예시
const buttonClasses = cn(
  styles.button,
  styles[size],
  styles[variant],
  {
    [styles.loading]: loading,
    [styles.disabled]: disabled,
  },
  className
);
```

---

## 🔄 컴포넌트 생명주기 및 성능 최적화

### React.memo를 활용한 메모이제이션

```typescript
// src/components/ui/ProductCard/ProductCard.tsx
import React, { memo } from 'react';
import { Product } from '@/types/models';

interface ProductCardProps {
  product: Product;
  onAddToCart: (productId: string) => void;
  onToggleWishlist: (productId: string) => void;
  isInWishlist: boolean;
}

export const ProductCard = memo<ProductCardProps>(({
  product,
  onAddToCart,
  onToggleWishlist,
  isInWishlist,
}) => {
  const handleAddToCart = () => {
    onAddToCart(product.id);
  };

  const handleToggleWishlist = () => {
    onToggleWishlist(product.id);
  };

  return (
    <div className="product-card">
      <div className="product-image">
        <img 
          src={product.imageUrl} 
          alt={product.name}
          loading="lazy"
        />
        <button 
          className="wishlist-btn"
          onClick={handleToggleWishlist}
          aria-label={isInWishlist ? "위시리스트에서 제거" : "위시리스트에 추가"}
        >
          <HeartIcon filled={isInWishlist} />
        </button>
      </div>
      
      <div className="product-content">
        <h3 className="product-title">{product.name}</h3>
        <p className="product-price">
          {new Intl.NumberFormat('ko-KR', {
            style: 'currency',
            currency: 'KRW',
          }).format(product.price)}
        </p>
        
        <Button 
          variant="primary" 
          size="sm"
          onClick={handleAddToCart}
          disabled={product.stock === 0}
        >
          {product.stock === 0 ? '품절' : '장바구니 담기'}
        </Button>
      </div>
    </div>
  );
}, (prevProps, nextProps) => {
  // 커스텀 비교 함수로 불필요한 리렌더링 방지
  return (
    prevProps.product.id === nextProps.product.id &&
    prevProps.product.name === nextProps.product.name &&
    prevProps.product.price === nextProps.product.price &&
    prevProps.product.stock === nextProps.product.stock &&
    prevProps.isInWishlist === nextProps.isInWishlist
  );
});

ProductCard.displayName = 'ProductCard';
```

### Lazy Loading과 Suspense

```typescript
// src/pages/index.tsx
import React, { Suspense } from 'react';
import { LoadingSpinner } from '@/components/ui/LoadingSpinner';

// 지연 로딩으로 번들 크기 최적화
const ProductsPage = React.lazy(() => import('./Products/Products'));
const CartPage = React.lazy(() => import('./Cart/Cart'));
const ProfilePage = React.lazy(() => import('./Profile/Profile'));
const AdminDashboard = React.lazy(() => import('./Admin/Dashboard'));

export const AppRoutes: React.FC = () => {
  return (
    <Suspense fallback={<PageLoadingSpinner />}>
      <Routes>
        <Route path="/products" element={<ProductsPage />} />
        <Route path="/cart" element={<CartPage />} />
        <Route path="/profile" element={<ProfilePage />} />
        <Route path="/admin" element={<AdminDashboard />} />
      </Routes>
    </Suspense>
  );
};

const PageLoadingSpinner: React.FC = () => (
  <div className="page-loading">
    <LoadingSpinner size="lg" />
    <p>페이지를 불러오는 중...</p>
  </div>
);
```

---

## 🧪 테스트 전략

### 컴포넌트 단위 테스트

```typescript
// src/components/ui/Button/Button.test.tsx
import React from 'react';
import { render, fireEvent, screen } from '@testing-library/react';
import '@testing-library/jest-dom';
import { Button } from './Button';

describe('Button Component', () => {
  it('renders correctly with default props', () => {
    render(<Button>Click me</Button>);
    
    const button = screen.getByRole('button', { name: /click me/i });
    expect(button).toBeInTheDocument();
    expect(button).toHaveClass('btn', 'btn-primary', 'btn-md');
  });

  it('handles click events', () => {
    const handleClick = jest.fn();
    render(<Button onClick={handleClick}>Click me</Button>);
    
    const button = screen.getByRole('button', { name: /click me/i });
    fireEvent.click(button);
    
    expect(handleClick).toHaveBeenCalledTimes(1);
  });

  it('shows loading state correctly', () => {
    render(<Button loading>Loading</Button>);
    
    const button = screen.getByRole('button');
    expect(button).toBeDisabled();
    expect(button).toHaveAttribute('aria-busy', 'true');
    expect(screen.getByTestId('spinner')).toBeInTheDocument();
  });

  it('applies different variants correctly', () => {
    const { rerender } = render(<Button variant="secondary">Test</Button>);
    expect(screen.getByRole('button')).toHaveClass('btn-secondary');
    
    rerender(<Button variant="ghost">Test</Button>);
    expect(screen.getByRole('button')).toHaveClass('btn-ghost');
  });

  it('disables button when disabled prop is true', () => {
    render(<Button disabled>Disabled</Button>);
    
    const button = screen.getByRole('button');
    expect(button).toBeDisabled();
    expect(button).toHaveClass('btn-disabled');
  });
});
```

### 통합 테스트

```typescript
// src/pages/Products/Products.test.tsx
import React from 'react';
import { render, screen, waitFor } from '@testing-library/react';
import { BrowserRouter } from 'react-router-dom';
import { ProductsPage } from './Products';
import { AuthProvider } from '@/contexts/AuthContext';
import { CartProvider } from '@/contexts/CartContext';
import * as productService from '@/services/products';

// 서비스 모킹
jest.mock('@/services/products');
const mockedProductService = productService as jest.Mocked<typeof productService>;

const renderWithProviders = (component: React.ReactElement) => {
  return render(
    <BrowserRouter>
      <AuthProvider>
        <CartProvider>
          {component}
        </CartProvider>
      </AuthProvider>
    </BrowserRouter>
  );
};

describe('ProductsPage', () => {
  beforeEach(() => {
    mockedProductService.getProducts.mockClear();
  });

  it('renders products correctly', async () => {
    const mockProducts = [
      {
        id: '1',
        name: 'Arduino Uno',
        price: 25000,
        imageUrl: '/arduino.jpg',
        stock: 10,
      },
      {
        id: '2',
        name: 'Raspberry Pi 4',
        price: 75000,
        imageUrl: '/raspberry.jpg',
        stock: 5,
      },
    ];

    mockedProductService.getProducts.mockResolvedValue({
      products: mockProducts,
      total: 2,
    });

    renderWithProviders(<ProductsPage />);

    // 로딩 상태 확인
    expect(screen.getByTestId('product-grid-skeleton')).toBeInTheDocument();

    // 상품 로드 완료 대기
    await waitFor(() => {
      expect(screen.getByText('Arduino Uno')).toBeInTheDocument();
      expect(screen.getByText('Raspberry Pi 4')).toBeInTheDocument();
    });

    // 가격 표시 확인
    expect(screen.getByText('₩25,000')).toBeInTheDocument();
    expect(screen.getByText('₩75,000')).toBeInTheDocument();
  });

  it('handles error state correctly', async () => {
    mockedProductService.getProducts.mockRejectedValue(
      new Error('Failed to load products')
    );

    renderWithProviders(<ProductsPage />);

    await waitFor(() => {
      expect(screen.getByText(/failed to load products/i)).toBeInTheDocument();
    });
  });
});
```

---

## 📚 컴포넌트 문서화

### Storybook을 활용한 컴포넌트 카탈로그

```typescript
// src/components/ui/Button/Button.stories.tsx
import type { Meta, StoryObj } from '@storybook/react';
import { Button } from './Button';

const meta: Meta<typeof Button> = {
  title: 'UI/Button',
  component: Button,
  parameters: {
    layout: 'centered',
    docs: {
      description: {
        component: '다양한 상황에서 사용할 수 있는 범용 버튼 컴포넌트입니다.',
      },
    },
  },
  argTypes: {
    variant: {
      control: 'radio',
      options: ['primary', 'secondary', 'ghost'],
      description: '버튼의 시각적 스타일을 결정합니다.',
    },
    size: {
      control: 'radio',
      options: ['sm', 'md', 'lg'],
      description: '버튼의 크기를 결정합니다.',
    },
    disabled: {
      control: 'boolean',
      description: '버튼의 비활성화 상태를 제어합니다.',
    },
    loading: {
      control: 'boolean',
      description: '로딩 상태를 표시합니다.',
    },
  },
};

export default meta;
type Story = StoryObj<typeof meta>;

export const Primary: Story = {
  args: {
    variant: 'primary',
    children: 'Primary Button',
  },
};

export const Secondary: Story = {
  args: {
    variant: 'secondary',
    children: 'Secondary Button',
  },
};

export const Ghost: Story = {
  args: {
    variant: 'ghost',
    children: 'Ghost Button',
  },
};

export const Loading: Story = {
  args: {
    variant: 'primary',
    loading: true,
    children: 'Loading...',
  },
};

export const Disabled: Story = {
  args: {
    variant: 'primary',
    disabled: true,
    children: 'Disabled Button',
  },
};

export const AllSizes: Story = {
  render: () => (
    <div style={{ display: 'flex', gap: '1rem', alignItems: 'center' }}>
      <Button size="sm">Small</Button>
      <Button size="md">Medium</Button>
      <Button size="lg">Large</Button>
    </div>
  ),
};
```

---

## 🔧 개발 도구 및 린팅

### ESLint + Prettier 설정

```json
// .eslintrc.json
{
  "extends": [
    "next/core-web-vitals",
    "@typescript-eslint/recommended",
    "plugin:react-hooks/recommended",
    "plugin:jsx-a11y/recommended"
  ],
  "rules": {
    "react/prop-types": "off",
    "react/react-in-jsx-scope": "off",
    "@typescript-eslint/no-unused-vars": "error",
    "@typescript-eslint/explicit-function-return-type": "off",
    "jsx-a11y/anchor-is-valid": "off",
    "prefer-const": "error",
    "no-var": "error"
  },
  "settings": {
    "react": {
      "version": "detect"
    }
  }
}
```

```json
// .prettierrc
{
  "semi": true,
  "trailingComma": "es5",
  "singleQuote": true,
  "printWidth": 80,
  "tabWidth": 2,
  "useTabs": false
}
```

### TypeScript 설정 최적화

```json
// tsconfig.json
{
  "compilerOptions": {
    "target": "ES2020",
    "lib": ["dom", "dom.iterable", "ES6"],
    "allowJs": true,
    "skipLibCheck": true,
    "esModuleInterop": true,
    "allowSyntheticDefaultImports": true,
    "strict": true,
    "forceConsistentCasingInFileNames": true,
    "noFallthroughCasesInSwitch": true,
    "module": "esnext",
    "moduleResolution": "node",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx",
    "baseUrl": ".",
    "paths": {
      "@/*": ["src/*"],
      "@/components/*": ["src/components/*"],
      "@/hooks/*": ["src/hooks/*"],
      "@/contexts/*": ["src/contexts/*"],
      "@/services/*": ["src/services/*"],
      "@/types/*": ["src/types/*"],
      "@/utils/*": ["src/utils/*"]
    }
  },
  "include": [
    "src",
    "types"
  ],
  "exclude": [
    "node_modules"
  ]
}
```

---

이 컴포넌트 아키텍처는 확장성, 재사용성, 유지보수성을 핵심으로 하여 IoTBay 프로젝트의 장기적인 성장을 지원합니다. 각 컴포넌트는 명확한 책임을 가지며, 타입 안전성과 성능 최적화를 통해 안정적인 사용자 경험을 제공합니다.
