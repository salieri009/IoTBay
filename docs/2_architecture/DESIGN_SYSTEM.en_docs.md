# IoTBay Design System

## 📋 Project Information

**Course**: 41025 Information Systems Development (ISD)  
**Assignment**: Assignment 2 - Autumn 2025  
**Institution**: University of Technology Sydney (UTS)  
**Project Type**: E-commerce Web Application for IoT Devices

---

## 🎨 디자인 철학

IoTBay는 **미래지향적이고 직관적인 IoT 생태계**를 위한 디자인 시스템입니다. **UTS 41025 ISD Assignment 2 Autumn 2025**의 요구사항에 맞춰 산업용 정밀함과 소비자 친화적 접근성을 조화롭게 결합하여, 기술적 복잡성을 단순하고 아름다운 인터페이스로 표현합니다.

### 핵심 가치
- **직관성**: 복잡한 IoT 기술을 누구나 쉽게 이해할 수 있도록
- **신뢰성**: 산업용 IoT의 안정성과 품질을 시각적으로 전달
- **혁신성**: 최신 웹 기술과 트렌드를 반영한 미래지향적 UI
- **접근성**: 모든 사용자가 차별 없이 서비스를 이용할 수 있도록

---

## 🌈 컬러 시스템

### Primary Palette (주요 색상)
```css
:root {
  /* Primary Colors - 기술적 신뢰감을 주는 딥 블루 */
  --primary-50: #e8f4ff;
  --primary-100: #b8e1ff;
  --primary-200: #87ceff;
  --primary-300: #56bbff;
  --primary-400: #25a8ff;
  --primary-500: #0a95ff;  /* Main Primary */
  --primary-600: #0873cc;
  --primary-700: #065199;
  --primary-800: #043066;
  --primary-900: #020e33;

  /* Secondary Colors - 에너지와 혁신을 상징하는 네온 그린 */
  --secondary-50: #f0fdf4;
  --secondary-100: #dcfce7;
  --secondary-200: #bbf7d0;
  --secondary-300: #86efac;
  --secondary-400: #4ade80;
  --secondary-500: #22c55e;  /* Main Secondary */
  --secondary-600: #16a34a;
  --secondary-700: #15803d;
  --secondary-800: #166534;
  --secondary-900: #14532d;
}
```

### Semantic Colors (의미 색상)
```css
:root {
  /* Success - 성공, 완료, 활성 상태 */
  --success-light: #d1fae5;
  --success: #10b981;
  --success-dark: #047857;

  /* Warning - 주의, 대기, 처리 중 */
  --warning-light: #fef3c7;
  --warning: #f59e0b;
  --warning-dark: #d97706;

  /* Error - 오류, 실패, 위험 */
  --error-light: #fee2e2;
  --error: #ef4444;
  --error-dark: #dc2626;

  /* Info - 정보, 알림 */
  --info-light: #dbeafe;
  --info: #3b82f6;
  --info-dark: #1d4ed8;
}
```

### Neutral Palette (중성 색상)
```css
:root {
  /* Grayscale - 다크 모드 우선 설계 */
  --gray-50: #fafafa;
  --gray-100: #f4f4f5;
  --gray-200: #e4e4e7;
  --gray-300: #d4d4d8;
  --gray-400: #a1a1aa;
  --gray-500: #71717a;
  --gray-600: #52525b;
  --gray-700: #3f3f46;
  --gray-800: #27272a;
  --gray-900: #18181b;

  /* Background Colors */
  --bg-primary: #ffffff;
  --bg-secondary: #f8fafc;
  --bg-tertiary: #f1f5f9;
  --bg-dark: #0f172a;
  --bg-dark-secondary: #1e293b;
  --bg-dark-tertiary: #334155;
}
```

### Gradient System (그라디언트)
```css
:root {
  /* Primary Gradients */
  --gradient-primary: linear-gradient(135deg, var(--primary-400) 0%, var(--primary-600) 100%);
  --gradient-primary-dark: linear-gradient(135deg, var(--primary-500) 0%, var(--primary-800) 100%);
  
  /* Accent Gradients */
  --gradient-success: linear-gradient(135deg, var(--secondary-400) 0%, var(--success) 100%);
  --gradient-tech: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  --gradient-neon: linear-gradient(135deg, #00f5ff 0%, #0a95ff 50%, #6366f1 100%);
  
  /* Background Gradients */
  --gradient-bg: linear-gradient(180deg, #ffffff 0%, #f8fafc 100%);
  --gradient-bg-dark: linear-gradient(180deg, #0f172a 0%, #1e293b 100%);
}
```

---

## 📝 타이포그래피

### Font Stack (폰트 계층)
```css
:root {
  /* Primary Font - 모던하고 읽기 쉬운 Sans-serif */
  --font-primary: 'Inter', 'Pretendard', -apple-system, BlinkMacSystemFont, 
                  'Segoe UI', Roboto, 'Noto Sans KR', sans-serif;
  
  /* Display Font - 헤드라인용 강조 폰트 */
  --font-display: 'JetBrains Mono', 'D2Coding', 'Fira Code', monospace;
  
  /* Body Font - 본문용 최적화 폰트 */
  --font-body: 'Inter', 'Pretendard', -apple-system, BlinkMacSystemFont, sans-serif;
  
  /* Code Font - 코드 및 기술 문서용 */
  --font-mono: 'JetBrains Mono', 'D2Coding', Consolas, 'Liberation Mono', monospace;
}
```

### Typography Scale (타이포그래피 스케일)
```css
:root {
  /* Font Sizes - 1.125 비율 기반 */
  --text-xs: 0.75rem;      /* 12px */
  --text-sm: 0.875rem;     /* 14px */
  --text-base: 1rem;       /* 16px */
  --text-lg: 1.125rem;     /* 18px */
  --text-xl: 1.25rem;      /* 20px */
  --text-2xl: 1.5rem;      /* 24px */
  --text-3xl: 1.875rem;    /* 30px */
  --text-4xl: 2.25rem;     /* 36px */
  --text-5xl: 3rem;        /* 48px */
  --text-6xl: 3.75rem;     /* 60px */
  --text-7xl: 4.5rem;      /* 72px */

  /* Line Heights */
  --leading-none: 1;
  --leading-tight: 1.25;
  --leading-snug: 1.375;
  --leading-normal: 1.5;
  --leading-relaxed: 1.625;
  --leading-loose: 2;

  /* Font Weights */
  --font-thin: 100;
  --font-extralight: 200;
  --font-light: 300;
  --font-normal: 400;
  --font-medium: 500;
  --font-semibold: 600;
  --font-bold: 700;
  --font-extrabold: 800;
  --font-black: 900;
}
```

### Typography Classes (타이포그래피 클래스)
```css
/* Heading Styles */
.heading-1 {
  font-family: var(--font-display);
  font-size: var(--text-5xl);
  font-weight: var(--font-bold);
  line-height: var(--leading-tight);
  letter-spacing: -0.025em;
}

.heading-2 {
  font-family: var(--font-primary);
  font-size: var(--text-4xl);
  font-weight: var(--font-semibold);
  line-height: var(--leading-tight);
  letter-spacing: -0.025em;
}

.heading-3 {
  font-family: var(--font-primary);
  font-size: var(--text-3xl);
  font-weight: var(--font-semibold);
  line-height: var(--leading-snug);
}

/* Body Text Styles */
.body-large {
  font-family: var(--font-body);
  font-size: var(--text-lg);
  font-weight: var(--font-normal);
  line-height: var(--leading-relaxed);
}

.body-base {
  font-family: var(--font-body);
  font-size: var(--text-base);
  font-weight: var(--font-normal);
  line-height: var(--leading-normal);
}

.body-small {
  font-family: var(--font-body);
  font-size: var(--text-sm);
  font-weight: var(--font-normal);
  line-height: var(--leading-normal);
}

/* Utility Text Styles */
.text-tech {
  font-family: var(--font-mono);
  font-size: var(--text-sm);
  font-weight: var(--font-medium);
  letter-spacing: 0.025em;
  color: var(--primary-500);
}

.text-caption {
  font-family: var(--font-body);
  font-size: var(--text-xs);
  font-weight: var(--font-medium);
  text-transform: uppercase;
  letter-spacing: 0.1em;
  color: var(--gray-500);
}
```

---

## 🧩 컴포넌트 라이브러리

### Button System (버튼 시스템)
```css
/* Base Button */
.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  border: none;
  border-radius: 0.5rem;
  font-family: var(--font-primary);
  font-weight: var(--font-medium);
  text-decoration: none;
  cursor: pointer;
  transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
  position: relative;
  overflow: hidden;
}

/* Button Sizes */
.btn-sm {
  padding: 0.5rem 1rem;
  font-size: var(--text-sm);
  min-height: 2rem;
}

.btn-md {
  padding: 0.75rem 1.5rem;
  font-size: var(--text-base);
  min-height: 2.5rem;
}

.btn-lg {
  padding: 1rem 2rem;
  font-size: var(--text-lg);
  min-height: 3rem;
}

/* Button Variants */
.btn-primary {
  background: var(--gradient-primary);
  color: white;
  box-shadow: 0 4px 14px 0 rgba(10, 149, 255, 0.25);
}

.btn-primary:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 25px 0 rgba(10, 149, 255, 0.35);
}

.btn-secondary {
  background: var(--bg-primary);
  color: var(--primary-600);
  border: 2px solid var(--primary-200);
}

.btn-secondary:hover {
  background: var(--primary-50);
  border-color: var(--primary-300);
}

.btn-ghost {
  background: transparent;
  color: var(--primary-600);
}

.btn-ghost:hover {
  background: var(--primary-50);
}

/* Floating Action Button */
.btn-fab {
  width: 3.5rem;
  height: 3.5rem;
  border-radius: 50%;
  background: var(--gradient-neon);
  color: white;
  box-shadow: 0 8px 25px 0 rgba(99, 102, 241, 0.3);
  position: fixed;
  bottom: 2rem;
  right: 2rem;
  z-index: 50;
}

.btn-fab:hover {
  transform: scale(1.1);
  box-shadow: 0 12px 35px 0 rgba(99, 102, 241, 0.4);
}
```

### Card System (카드 시스템)
```css
.card {
  background: var(--bg-primary);
  border-radius: 1rem;
  border: 1px solid var(--gray-200);
  box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  overflow: hidden;
}

.card:hover {
  transform: translateY(-4px);
  box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 
              0 10px 10px -5px rgba(0, 0, 0, 0.04);
}

/* Card Variants */
.card-product {
  position: relative;
  background: linear-gradient(145deg, #ffffff 0%, #f8fafc 100%);
}

.card-product::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 4px;
  background: var(--gradient-neon);
  opacity: 0;
  transition: opacity 0.3s ease;
}

.card-product:hover::before {
  opacity: 1;
}

.card-tech {
  background: linear-gradient(145deg, #1e293b 0%, #334155 100%);
  color: white;
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.card-glass {
  background: rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
}
```

### Input System (입력 시스템)
```css
.input-group {
  position: relative;
  margin-bottom: 1.5rem;
}

.input {
  width: 100%;
  padding: 0.75rem 1rem;
  border: 2px solid var(--gray-300);
  border-radius: 0.5rem;
  font-family: var(--font-body);
  font-size: var(--text-base);
  background: var(--bg-primary);
  transition: all 0.2s ease;
  outline: none;
}

.input:focus {
  border-color: var(--primary-500);
  box-shadow: 0 0 0 3px rgba(10, 149, 255, 0.1);
}

.input:focus + .label {
  color: var(--primary-600);
  transform: translateY(-1.5rem) scale(0.875);
}

.label {
  position: absolute;
  left: 1rem;
  top: 0.75rem;
  color: var(--gray-500);
  font-size: var(--text-base);
  font-weight: var(--font-medium);
  pointer-events: none;
  transition: all 0.2s ease;
  transform-origin: left top;
}

/* Floating Label */
.input-floating .label {
  position: absolute;
  left: 1rem;
  top: 0.75rem;
  background: var(--bg-primary);
  padding: 0 0.25rem;
}

.input-floating .input:not(:placeholder-shown) + .label,
.input-floating .input:focus + .label {
  transform: translateY(-1.5rem) scale(0.875);
}

/* Input States */
.input-error {
  border-color: var(--error);
}

.input-success {
  border-color: var(--success);
}

.input-tech {
  font-family: var(--font-mono);
  background: var(--gray-900);
  color: var(--secondary-400);
  border-color: var(--gray-700);
}
```

### Navigation Components (네비게이션 컴포넌트)
```css
/* Main Navigation */
.navbar {
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
  border-bottom: 1px solid rgba(0, 0, 0, 0.1);
  position: sticky;
  top: 0;
  z-index: 40;
  transition: all 0.3s ease;
}

.navbar-dark {
  background: rgba(15, 23, 42, 0.95);
  border-bottom-color: rgba(255, 255, 255, 0.1);
}

.nav-link {
  position: relative;
  color: var(--gray-700);
  font-weight: var(--font-medium);
  text-decoration: none;
  padding: 0.5rem 1rem;
  border-radius: 0.375rem;
  transition: all 0.2s ease;
}

.nav-link::after {
  content: '';
  position: absolute;
  bottom: -2px;
  left: 50%;
  width: 0;
  height: 2px;
  background: var(--gradient-primary);
  transition: all 0.3s ease;
  transform: translateX(-50%);
}

.nav-link:hover::after,
.nav-link.active::after {
  width: 100%;
}

/* Breadcrumb */
.breadcrumb {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-size: var(--text-sm);
  color: var(--gray-500);
}

.breadcrumb-item {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.breadcrumb-item:not(:last-child)::after {
  content: '/';
  color: var(--gray-400);
  margin-left: 0.5rem;
}

/* Sidebar */
.sidebar {
  width: 16rem;
  background: var(--bg-secondary);
  border-right: 1px solid var(--gray-200);
  height: 100vh;
  position: fixed;
  left: 0;
  top: 0;
  transform: translateX(-100%);
  transition: transform 0.3s ease;
  z-index: 30;
}

.sidebar.open {
  transform: translateX(0);
}

.sidebar-item {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  padding: 0.75rem 1.5rem;
  color: var(--gray-700);
  text-decoration: none;
  transition: all 0.2s ease;
  border-left: 3px solid transparent;
}

.sidebar-item:hover,
.sidebar-item.active {
  background: var(--primary-50);
  color: var(--primary-700);
  border-left-color: var(--primary-500);
}
```

---

## 📱 반응형 디자인

### Breakpoint System (중단점 시스템)
```css
:root {
  /* Breakpoints */
  --screen-sm: 640px;   /* Mobile Large */
  --screen-md: 768px;   /* Tablet */
  --screen-lg: 1024px;  /* Desktop Small */
  --screen-xl: 1280px;  /* Desktop Large */
  --screen-2xl: 1536px; /* Desktop Extra Large */
}

/* Media Query Mixins */
@media (min-width: 640px) { /* sm */ }
@media (min-width: 768px) { /* md */ }
@media (min-width: 1024px) { /* lg */ }
@media (min-width: 1280px) { /* xl */ }
@media (min-width: 1536px) { /* 2xl */ }
```

### Grid System (그리드 시스템)
```css
.container {
  width: 100%;
  margin: 0 auto;
  padding: 0 1rem;
  max-width: 1280px;
}

.grid {
  display: grid;
  gap: 1.5rem;
}

/* Responsive Grid Classes */
.grid-1 { grid-template-columns: 1fr; }
.grid-2 { grid-template-columns: repeat(2, 1fr); }
.grid-3 { grid-template-columns: repeat(3, 1fr); }
.grid-4 { grid-template-columns: repeat(4, 1fr); }

@media (min-width: 768px) {
  .md\:grid-2 { grid-template-columns: repeat(2, 1fr); }
  .md\:grid-3 { grid-template-columns: repeat(3, 1fr); }
  .md\:grid-4 { grid-template-columns: repeat(4, 1fr); }
}

@media (min-width: 1024px) {
  .lg\:grid-3 { grid-template-columns: repeat(3, 1fr); }
  .lg\:grid-4 { grid-template-columns: repeat(4, 1fr); }
  .lg\:grid-6 { grid-template-columns: repeat(6, 1fr); }
}

/* Flexbox Utilities */
.flex { display: flex; }
.flex-col { flex-direction: column; }
.items-center { align-items: center; }
.justify-center { justify-content: center; }
.justify-between { justify-content: space-between; }
.gap-4 { gap: 1rem; }
.gap-6 { gap: 1.5rem; }
```

---

## 🌙 다크 모드

### Dark Mode CSS Variables
```css
[data-theme="dark"] {
  /* Primary Colors - 다크 모드 최적화 */
  --primary-400: #4fb3ff;
  --primary-500: #2196f3;
  --primary-600: #1976d2;

  /* Background Colors */
  --bg-primary: #0f172a;
  --bg-secondary: #1e293b;
  --bg-tertiary: #334155;

  /* Text Colors */
  --text-primary: #f1f5f9;
  --text-secondary: #cbd5e1;
  --text-tertiary: #94a3b8;

  /* Border Colors */
  --border-primary: #334155;
  --border-secondary: #475569;
}

/* Dark Mode Component Adjustments */
[data-theme="dark"] .card {
  background: var(--bg-secondary);
  border-color: var(--border-primary);
}

[data-theme="dark"] .input {
  background: var(--bg-tertiary);
  border-color: var(--border-secondary);
  color: var(--text-primary);
}

[data-theme="dark"] .navbar {
  background: rgba(15, 23, 42, 0.95);
  border-bottom-color: var(--border-primary);
}
```

### Theme Toggle Implementation
```css
.theme-toggle {
  position: relative;
  width: 3rem;
  height: 1.5rem;
  background: var(--gray-300);
  border-radius: 1rem;
  cursor: pointer;
  transition: all 0.3s ease;
}

.theme-toggle::after {
  content: '';
  position: absolute;
  top: 2px;
  left: 2px;
  width: 1.25rem;
  height: 1.25rem;
  background: white;
  border-radius: 50%;
  transition: all 0.3s ease;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

[data-theme="dark"] .theme-toggle {
  background: var(--primary-500);
}

[data-theme="dark"] .theme-toggle::after {
  transform: translateX(1.5rem);
}
```

---

## ⚡ 애니메이션 시스템

### Transition Presets (전환 프리셋)
```css
:root {
  /* Easing Functions */
  --ease-in-out: cubic-bezier(0.4, 0, 0.2, 1);
  --ease-out: cubic-bezier(0, 0, 0.2, 1);
  --ease-in: cubic-bezier(0.4, 0, 1, 1);
  --ease-bounce: cubic-bezier(0.68, -0.55, 0.265, 1.55);

  /* Duration */
  --duration-fast: 150ms;
  --duration-normal: 300ms;
  --duration-slow: 500ms;
}

/* Animation Classes */
.animate-fade-in {
  animation: fadeIn var(--duration-normal) var(--ease-out);
}

.animate-slide-up {
  animation: slideUp var(--duration-normal) var(--ease-out);
}

.animate-scale-in {
  animation: scaleIn var(--duration-normal) var(--ease-bounce);
}

/* Keyframes */
@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}

@keyframes slideUp {
  from {
    opacity: 0;
    transform: translateY(1rem);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@keyframes scaleIn {
  from {
    opacity: 0;
    transform: scale(0.9);
  }
  to {
    opacity: 1;
    transform: scale(1);
  }
}

/* Hover Effects */
.hover-lift {
  transition: transform var(--duration-fast) var(--ease-out);
}

.hover-lift:hover {
  transform: translateY(-2px);
}

.hover-glow {
  transition: box-shadow var(--duration-normal) var(--ease-out);
}

.hover-glow:hover {
  box-shadow: 0 0 20px rgba(10, 149, 255, 0.3);
}
```

### Loading Animations (로딩 애니메이션)
```css
.spinner {
  width: 2rem;
  height: 2rem;
  border: 2px solid var(--gray-200);
  border-top-color: var(--primary-500);
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  to { transform: rotate(360deg); }
}

.skeleton {
  background: linear-gradient(90deg, 
    var(--gray-200) 25%, 
    var(--gray-100) 50%, 
    var(--gray-200) 75%
  );
  background-size: 200% 100%;
  animation: skeleton-loading 1.5s infinite;
}

@keyframes skeleton-loading {
  0% { background-position: 200% 0; }
  100% { background-position: -200% 0; }
}

.pulse {
  animation: pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite;
}

@keyframes pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.5; }
}
```

---

## 🎯 사용성 가이드라인

### Accessibility (접근성)
```css
/* Focus States */
.focus-ring:focus {
  outline: 2px solid var(--primary-500);
  outline-offset: 2px;
}

/* Screen Reader Only */
.sr-only {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  white-space: nowrap;
  border: 0;
}

/* High Contrast Mode Support */
@media (prefers-contrast: high) {
  .btn-primary {
    border: 2px solid currentColor;
  }
  
  .card {
    border: 2px solid var(--gray-400);
  }
}

/* Reduced Motion Support */
@media (prefers-reduced-motion: reduce) {
  * {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
  }
}
```

### Interactive States (상호작용 상태)
```css
/* Button States */
.btn {
  /* Default state styles already defined */
}

.btn:hover {
  transform: translateY(-1px);
}

.btn:active {
  transform: translateY(0);
}

.btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
  transform: none;
}

.btn:focus-visible {
  outline: 2px solid var(--primary-500);
  outline-offset: 2px;
}

/* Link States */
.link {
  color: var(--primary-600);
  text-decoration: underline;
  text-decoration-color: transparent;
  transition: text-decoration-color var(--duration-fast);
}

.link:hover {
  text-decoration-color: currentColor;
}

.link:visited {
  color: var(--primary-700);
}
```

---

## 📐 레이아웃 패턴

### Page Layouts (페이지 레이아웃)
```css
/* Main App Layout */
.app-layout {
  display: grid;
  grid-template-areas: 
    "header header"
    "sidebar main"
    "sidebar footer";
  grid-template-rows: auto 1fr auto;
  grid-template-columns: 16rem 1fr;
  min-height: 100vh;
}

.app-header { grid-area: header; }
.app-sidebar { grid-area: sidebar; }
.app-main { grid-area: main; }
.app-footer { grid-area: footer; }

/* Mobile Layout */
@media (max-width: 768px) {
  .app-layout {
    grid-template-areas: 
      "header"
      "main"
      "footer";
    grid-template-columns: 1fr;
  }
  
  .app-sidebar {
    position: fixed;
    transform: translateX(-100%);
    transition: transform var(--duration-normal);
  }
  
  .app-sidebar.open {
    transform: translateX(0);
  }
}

/* Content Layouts */
.hero-section {
  background: var(--gradient-bg);
  padding: 4rem 0 8rem;
  text-align: center;
  position: relative;
  overflow: hidden;
}

.hero-section::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120"><path d="M1200 120L0 16.48 0 0 1200 0 1200 120z" fill="%23f8fafc"></path></svg>') no-repeat bottom;
  background-size: cover;
}

.section {
  padding: 4rem 0;
}

.section-dark {
  background: var(--bg-dark);
  color: white;
}
```

### Component Layouts (컴포넌트 레이아웃)
```css
/* Product Grid */
.product-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 2rem;
  padding: 2rem 0;
}

/* Product Card Layout */
.product-card {
  display: flex;
  flex-direction: column;
  height: 100%;
}

.product-image {
  aspect-ratio: 4/3;
  object-fit: cover;
  border-radius: 0.5rem 0.5rem 0 0;
}

.product-content {
  padding: 1.5rem;
  flex: 1;
  display: flex;
  flex-direction: column;
}

.product-title {
  font-size: var(--text-lg);
  font-weight: var(--font-semibold);
  margin-bottom: 0.5rem;
}

.product-price {
  font-size: var(--text-xl);
  font-weight: var(--font-bold);
  color: var(--primary-600);
  margin-top: auto;
}

/* Dashboard Layout */
.dashboard-grid {
  display: grid;
  grid-template-columns: repeat(12, 1fr);
  gap: 1.5rem;
}

.widget {
  background: var(--bg-primary);
  border-radius: 1rem;
  padding: 1.5rem;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.widget-sm { grid-column: span 3; }
.widget-md { grid-column: span 6; }
.widget-lg { grid-column: span 9; }
.widget-full { grid-column: span 12; }

@media (max-width: 768px) {
  .widget-sm,
  .widget-md,
  .widget-lg {
    grid-column: span 12;
  }
}
```

---

이 디자인 시스템은 IoTBay의 브랜드 정체성을 일관되게 유지하면서도 사용자 경험을 최적화하고, 개발자의 생산성을 향상시키는 것을 목표로 합니다. 모든 컴포넌트는 접근성, 반응형 디자인, 성능을 고려하여 설계되었습니다.


---

**Document Version**: 1.0.0
**Status**: Published
**Last Updated**: 12�� 3, 2025
**Audience**: Developers, Stakeholders
**Maintained By**: IoT Bay Documentation Team
