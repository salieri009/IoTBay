# IoTBay UI/UX デザインドキュメント
## 包括的ユーザーエクスペリエンスデザイン仕様

**言語**: 日本語 (Japanese)  
**Course**: 41025 Information Systems Development (ISD)  
**Assignment**: Assignment 2 - Autumn 2025  
**Institution**: University of Technology Sydney (UTS)  
**Project Type**: E-commerce Web Application for IoT Devices  
**Document Version**: 2.0  
**Last Updated**: 2025  
**Reference**: Based on `FEATURES.md` - Complete Feature List

---

## Executive Summary

This document provides a comprehensive UI/UX design specification for IoTBay, an e-commerce platform specifically designed for Internet of Things (IoT) devices and components. The design approach prioritizes user experience excellence while maintaining technical sophistication required for IoT product purchasing decisions.

**Design Philosophy**: Technical sophistication meets user-friendly design, ensuring that complex IoT product information is presented in an intuitive, accessible, and trustworthy manner.

**Key Design Principles**:
- **User-Centered Design**: Every design decision prioritizes user needs and goals
- **Progressive Disclosure**: Complex technical information presented in digestible layers
- **Accessibility First**: WCAG 2.1 AA compliance as a baseline, not an afterthought
- **Trust & Credibility**: Critical for technical buyers making significant purchase decisions
- **Performance & Efficiency**: Fast, responsive interactions that respect user time
- **Consistency**: Unified design system across all touchpoints

---

## 1. User Research & Personas

### 1.1 Primary Persona: The Precision-Focused IoT Engineer

**Name**: Alex Chen  
**Age**: 32  
**Role**: Senior IoT Solutions Architect  
**Experience**: 8 years in industrial IoT implementation

#### Demographics
- **Location**: Urban technology hub
- **Education**: Bachelor's in Electrical Engineering, Master's in Computer Science
- **Company**: Mid-size industrial automation company
- **Team Size**: Manages team of 5 engineers

#### Psychographics
- **Values**: Accuracy, reliability, systematic approaches, technical depth
- **Goals**: Find compatible IoT devices quickly, verify technical specifications, ensure long-term reliability
- **Pain Points**: 
  - Incomplete product specifications
  - Unclear compatibility information
  - Difficulty comparing technical features
  - Lack of integration documentation
- **Technology Comfort**: Expert level
- **Decision-Making Style**: Data-driven, methodical, risk-averse

#### Behavioral Patterns
- **Research Process**: 
  1. Reviews technical specifications first
  2. Checks compatibility matrices
  3. Reads integration guides
  4. Compares 3-5 products side-by-side
  5. Verifies certifications and warranties
- **Time Investment**: 30-60 minutes per product research
- **Purchase Frequency**: 2-3 times per month
- **Budget Authority**: $5,000 - $50,000 per purchase

#### Information Needs
- **Critical**: Communication protocols, voltage requirements, operating ranges, certifications
- **Important**: Integration guides, API documentation, compatibility lists, warranty information
- **Nice-to-Have**: User reviews, performance metrics, community resources

#### Technology Preferences
- **Primary Device**: Desktop (80%), Tablet (15%), Mobile (5%)
- **Browser**: Chrome (70%), Firefox (25%), Safari (5%)
- **Screen Resolution**: 1920x1080 or higher
- **Accessibility**: Uses keyboard navigation, prefers high contrast

#### Quote
> "I need to trust that the product will work in our industrial environment. Technical specifications aren't optional—they're everything."

---

### 1.2 Secondary Persona: The Smart Home Enthusiast

**Name**: Sarah Martinez  
**Age**: 28  
**Role**: Marketing Manager / DIY Smart Home Builder  
**Experience**: 3 years building personal smart home

#### Demographics
- **Location**: Suburban area
- **Education**: Bachelor's in Marketing
- **Company**: Marketing agency (day job)
- **Personal Interest**: Smart home automation

#### Psychographics
- **Values**: Ease of use, aesthetics, integration simplicity
- **Goals**: Create cohesive smart home ecosystem, learn new technologies
- **Pain Points**:
  - Overwhelming technical jargon
  - Uncertainty about compatibility
  - Installation complexity
  - Lack of visual examples
- **Technology Comfort**: Intermediate level
- **Decision-Making Style**: Visual, example-driven, community-influenced

#### Behavioral Patterns
- **Research Process**:
  1. Views product images and videos
  2. Reads user reviews
  3. Checks compatibility with existing devices
  4. Reviews installation guides
  5. Seeks community recommendations
- **Time Investment**: 15-30 minutes per product
- **Purchase Frequency**: 1-2 times per month
- **Budget Authority**: $100 - $1,000 per purchase

#### Information Needs
- **Critical**: Ease of installation, compatibility with popular platforms (Home Assistant, Alexa, Google Home)
- **Important**: Visual guides, user reviews, example setups
- **Nice-to-Have**: Community forums, video tutorials

---

### 1.3 Tertiary Persona: The Procurement Manager

**Name**: James Wilson  
**Age**: 45  
**Role**: Procurement Manager  
**Experience**: 15 years in industrial procurement

#### Demographics
- **Location**: Corporate headquarters
- **Education**: MBA in Supply Chain Management
- **Company**: Large manufacturing company
- **Team Size**: Manages procurement for 200+ employees

#### Psychographics
- **Values**: Cost efficiency, reliability, vendor relationships, compliance
- **Goals**: Source reliable IoT components at competitive prices, ensure compliance
- **Pain Points**:
  - Complex pricing structures
  - Unclear bulk pricing
  - Compliance documentation
  - Vendor reliability assessment
- **Technology Comfort**: Basic to intermediate
- **Decision-Making Style**: Process-driven, approval-focused, risk-averse

#### Behavioral Patterns
- **Research Process**:
  1. Reviews pricing and bulk discounts
  2. Checks vendor reliability indicators
  3. Verifies compliance certifications
  4. Reviews warranty and support terms
  5. Prepares comparison reports for approval
- **Time Investment**: 1-2 hours per product category
- **Purchase Frequency**: Quarterly bulk orders
- **Budget Authority**: $10,000 - $500,000 per order

---

## 2. User Journey Maps

### 2.1 Primary Journey: Product Discovery to Purchase (IoT Engineer)

#### Stage 1: Awareness & Discovery
**Touchpoint**: Search engine, direct URL, referral  
**User Goal**: Find IoT device for specific use case  
**Emotions**: Curious, hopeful  
**Actions**:
- Lands on homepage or category page
- Uses search or browses categories
- Filters by protocol, voltage, use case

**Pain Points**:
- Generic search results
- Unclear category organization
- Missing filter options

**Design Solutions**:
- Multi-dimensional filtering (protocol, voltage, range, use case)
- Smart search with autocomplete
- Clear category hierarchy

---

#### Stage 2: Research & Evaluation
**Touchpoint**: Product listing, product detail page  
**User Goal**: Verify technical specifications and compatibility  
**Emotions**: Analytical, cautious  
**Actions**:
- Reviews product cards with key specs
- Opens product detail page
- Expands technical specifications
- Checks compatibility matrix
- Reviews integration documentation
- Compares with other products

**Pain Points**:
- Technical specs buried in description
- No compatibility checker
- Missing integration guides
- Difficult product comparison

**Design Solutions**:
- Progressive disclosure of technical specs
- Prominent compatibility indicators
- Embedded documentation viewer
- Product comparison tool (3-4 products max)

---

#### Stage 3: Decision Making
**Touchpoint**: Product detail, comparison tool, cart  
**User Goal**: Confirm product meets requirements  
**Emotions**: Confident, decisive  
**Actions**:
- Adds product to comparison
- Reviews side-by-side comparison
- Checks stock availability
- Verifies pricing
- Adds to cart

**Pain Points**:
- No comparison functionality
- Unclear stock status
- Hidden pricing information

**Design Solutions**:
- Comparison tool with sticky header
- Real-time stock indicators
- Clear pricing display
- Trust badges (certifications, warranties)

---

#### Stage 4: Purchase & Checkout
**Touchpoint**: Cart, checkout page  
**User Goal**: Complete purchase securely  
**Emotions**: Focused, slightly anxious  
**Actions**:
- Reviews cart items
- Checks compatibility warnings
- Enters shipping information
- Selects payment method
- Reviews order summary
- Confirms purchase

**Pain Points**:
- Compatibility issues discovered late
- Complex checkout process
- Unclear shipping options
- Payment security concerns

**Design Solutions**:
- Proactive compatibility checking
- Progress indicator for checkout
- Clear shipping options
- Security badges and trust indicators

---

#### Stage 5: Post-Purchase
**Touchpoint**: Order confirmation, email, order history  
**User Goal**: Track order and access resources  
**Emotions**: Relieved, anticipatory  
**Actions**:
- Receives order confirmation
- Tracks order status
- Accesses integration guides
- Downloads documentation

**Pain Points**:
- Unclear order status
- Difficult to find documentation
- No integration support

**Design Solutions**:
- Clear order status updates
- Easy access to documentation
- Integration support resources

---

### 2.2 Secondary Journey: Quick Purchase (Smart Home Enthusiast)

#### Simplified Flow
1. **Browse by Category** → Smart Home category
2. **View Product** → Visual-first product cards
3. **Check Compatibility** → "Works with" badges
4. **Read Reviews** → User experience focus
5. **Quick Add to Cart** → One-click purchase option
6. **Express Checkout** → Saved payment methods

**Key Differences**:
- Visual-first approach
- Simplified technical information
- Community-driven recommendations
- Faster checkout process

---

## 3. Information Architecture

### 3.1 Site Structure

```
IoTBay
├── Home
│   ├── Hero Section (Featured Products)
│   ├── Category Quick Links
│   ├── Trust Indicators
│   └── Featured Use Cases
│
├── Browse Products
│   ├── Category Filter
│   ├── Protocol Filter
│   ├── Use Case Filter
│   ├── Technical Spec Filters
│   └── Product Grid
│
├── Product Detail
│   ├── Product Overview
│   │   ├── Images/Gallery
│   │   ├── Key Specs (Always Visible)
│   │   ├── Price & Stock
│   │   └── Quick Actions
│   ├── Technical Specifications (Accordion)
│   │   ├── Essential Specs
│   │   ├── Detailed Specs
│   │   └── Advanced Configuration
│   ├── Compatibility Matrix
│   ├── Integration Guides
│   ├── Documentation
│   ├── Reviews & Ratings
│   └── Related Products
│
├── Shopping Cart
│   ├── Cart Items
│   ├── Compatibility Warnings
│   ├── Order Summary
│   └── Checkout CTA
│
├── Checkout
│   ├── Progress Indicator
│   ├── Shipping Information
│   ├── Payment Method
│   ├── Order Review
│   └── Confirmation
│
├── User Account
│   ├── Profile Management
│   ├── Order History
│   ├── Saved Products
│   └── Preferences
│
└── Support
    ├── Help Center
    ├── Integration Guides
    ├── Community Forums
    └── Contact Support
```

### 3.2 Content Hierarchy

#### Product Information Priority

**Level 1 - Critical (Always Visible)**
- Product name
- Key specification (protocol, voltage)
- Price
- Stock status
- Primary action (Add to Cart)

**Level 2 - Important (First Fold)**
- Product description
- Key technical specs (3-5 items)
- Trust badges
- Compatibility indicators

**Level 3 - Detailed (Progressive Disclosure)**
- Full technical specifications
- Compatibility matrix
- Integration guides
- Documentation

**Level 4 - Supporting (On Demand)**
- User reviews
- Related products
- Community resources
- Advanced configuration

---


---

## 5. Design System & Visual Language

### 5.1 Color System

#### Primary Colors
- **Primary Blue (#0a95ff)**: Trust, technology, professionalism
- **Secondary Green (#22c55e)**: Success, energy, innovation
- **Accent Orange (#f97316)**: Attention, warnings, CTAs

#### Semantic Colors
- **Success**: Green (#22c55e) - Stock available, order confirmed
- **Warning**: Orange (#f97316) - Low stock, compatibility warnings
- **Error**: Red (#ef4444) - Out of stock, errors
- **Info**: Blue (#0a95ff) - General information

#### Neutral Palette
- **Neutral-50 to Neutral-900**: Gray scale for text, backgrounds, borders
- **High Contrast Mode**: Enhanced contrast ratios for accessibility

### 5.2 Typography

#### Font Family
- **Primary**: Inter (Sans-serif)
  - Clean, modern, highly readable
  - Excellent for technical content
  - Strong number rendering

#### Type Scale
- **Display XL**: 48px / 56px - Hero headlines
- **Display L**: 36px / 44px - Section headers
- **Display M**: 30px / 38px - Page titles
- **Heading L**: 24px / 32px - Card titles
- **Heading M**: 20px / 28px - Subsection headers
- **Body L**: 18px / 28px - Body text
- **Body M**: 16px / 24px - Default body
- **Body S**: 14px / 20px - Secondary text
- **Caption**: 12px / 16px - Labels, metadata

#### Font Weights
- **Light (300)**: Decorative text
- **Regular (400)**: Body text
- **Medium (500)**: Emphasis
- **Semibold (600)**: Headings
- **Bold (700)**: Strong emphasis

### 5.3 Spacing System

Based on 4px base unit:
- **Space-1**: 4px
- **Space-2**: 8px
- **Space-3**: 12px
- **Space-4**: 16px
- **Space-6**: 24px
- **Space-8**: 32px
- **Space-12**: 48px
- **Space-16**: 64px
- **Space-20**: 80px

### 5.4 Component Specifications

#### Buttons

**Primary Button**
- Background: Primary blue (#0a95ff)
- Text: White
- Padding: 12px 24px
- Border radius: 8px
- Font: 16px, Semibold
- Hover: Darker blue (#0873cc)
- Focus: 2px outline, offset 2px

**Secondary Button**
- Background: Transparent
- Border: 2px solid primary blue
- Text: Primary blue
- Same padding and radius as primary

**Ghost Button**
- Background: Transparent
- Border: None
- Text: Primary blue
- Hover: Light blue background

#### Product Cards

**Structure**:
- Image container (300x300px)
- Stock badge (top-right)
- Product name (Heading M)
- Key spec badge (protocol/voltage)
- Description (truncated to 2 lines)
- Price (Body L, Bold)
- Stock status (Body S)
- Actions: View Details, Add to Cart

**States**:
- Default: Full opacity
- Hover: Slight elevation, scale 1.02
- Out of Stock: Reduced opacity, disabled state

#### Form Inputs

**Text Input**:
- Border: 1px solid neutral-300
- Border radius: 8px
- Padding: 12px 16px
- Focus: 2px solid primary blue
- Error: Red border, error message below
- Success: Green border

**Labels**:
- Font: Body M, Semibold
- Color: Neutral-900
- Required indicator: Red asterisk

---

## 6. Interaction Design

### 6.1 Micro-interactions

#### Button Interactions
- **Hover**: 150ms transition, slight scale (1.02)
- **Active**: 100ms transition, scale (0.98)
- **Loading**: Spinner replaces text, button disabled

#### Form Validation
- **Real-time**: Validation on blur
- **Visual Feedback**: 
  - Green checkmark for valid
  - Red X for invalid
  - Error message below field
- **Screen Reader**: ARIA live region announcements

#### Cart Add Animation
- **Optimistic UI**: Immediate visual feedback
- **Animation**: Item slides to cart icon (300ms)
- **Toast Notification**: Success message appears
- **Cart Count**: Number increments with bounce

### 6.2 Loading States

#### Skeleton Loading
- **Product Cards**: Animated shimmer effect
- **Product Detail**: Progressive loading (image → specs → reviews)
- **Cart**: Skeleton items while loading

#### Progress Indicators
- **Checkout**: Step-by-step progress bar
- **File Upload**: Progress percentage
- **Page Load**: Top progress bar

### 6.3 Feedback Systems

#### Toast Notifications
- **Success**: Green, 3-second auto-dismiss
- **Error**: Red, manual dismiss required
- **Warning**: Orange, 5-second auto-dismiss
- **Info**: Blue, 3-second auto-dismiss

#### Error Handling
- **Inline Errors**: Below form fields
- **Page-level Errors**: Prominent banner at top
- **404 Errors**: Helpful message with navigation options
- **500 Errors**: Apologetic message with support contact

---

## 7. Accessibility Design

### 7.1 WCAG 2.1 AA Compliance

#### Color Contrast
- **Normal Text**: 4.5:1 minimum contrast ratio
- **Large Text**: 3:1 minimum contrast ratio
- **UI Components**: 3:1 minimum contrast ratio
- **Focus Indicators**: 3:1 contrast, 2px minimum width

#### Keyboard Navigation
- **Tab Order**: Logical, sequential
- **Focus Indicators**: Visible, high contrast
- **Skip Links**: Jump to main content, navigation, search
- **Keyboard Shortcuts**: 
  - Escape: Close modals/dropdowns
  - Enter/Space: Activate buttons
  - Arrow keys: Navigate product grid

#### Screen Reader Support
- **ARIA Labels**: All interactive elements
- **ARIA Live Regions**: Dynamic content announcements
- **Semantic HTML**: Proper heading hierarchy, landmarks
- **Alt Text**: Descriptive for all images
- **Form Labels**: Associated with inputs

#### Visual Accessibility
- **Text Scaling**: Supports up to 200% zoom
- **Reduced Motion**: Respects `prefers-reduced-motion`
- **High Contrast**: Supports `prefers-contrast: high`
- **Touch Targets**: Minimum 44x44px

### 7.2 Accessibility Features

#### Skip Links
- Skip to main content
- Skip to navigation
- Skip to search

#### ARIA Landmarks
- `<header role="banner">`
- `<nav role="navigation">`
- `<main role="main">`
- `<aside role="complementary">`
- `<footer role="contentinfo">`

#### Focus Management## 4. Wireframes & Layout Specifications

### 4.1 Homepage Layout (index.jsp)

**Purpose**: Primary landing page introducing IoTBay platform, showcasing featured products, and providing quick access to main categories.

**Layout Structure**:

```
┌─────────────────────────────────────────────────────────────────────────┐
│ [Skip Links - Accessibility]                                            │
│ Skip to main content | Skip to navigation | Skip to search            │
├─────────────────────────────────────────────────────────────────────────┤
│ [Header - Global Navigation]                                           │
│ ┌───────────────────────────────────────────────────────────────────┐ │
│ │ Logo (IoT Bay) | Nav (Home|Products|About) | Search Bar          │ │
│ │ User Menu (Avatar/Name) | Cart Icon (Badge: 3) | Theme Toggle    │ │
│ │ Mobile: Hamburger Menu                                            │ │
│ └───────────────────────────────────────────────────────────────────┘ │
├─────────────────────────────────────────────────────────────────────────┤
│ [Hero Section - Full Width]                                            │
│ ┌───────────────────────────────────────────────────────────────────┐ │
│ │ Background: Gradient (Primary Blue → Secondary Green)            │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ Hero Image: IoT Devices Showcase (1920x600px)              │   │ │
│ │ │ Headline: "Your Premier IoT Device Store" (Display XL)      │   │ │
│ │ │ Subheadline: "Technical sophistication meets user-friendly │   │ │
│ │ │            design" (Body L, 18px)                          │   │ │
│ │ │ CTA Buttons: [Browse Products] [Learn More]                │   │ │
│ │ │ Trust Badge: "Trusted by 10,000+ Engineers"                │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ └───────────────────────────────────────────────────────────────────┘ │
├─────────────────────────────────────────────────────────────────────────┤
│ [Category Quick Links - Grid Layout]                                    │
│ ┌───────────────────────────────────────────────────────────────────┐ │
│ │ Section Title: "Shop by Category" (Display M, 30px)              │ │
│ │ ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐              │ │
│ │ │ Industrial│ │Warehouse │ │Agriculture│ │Smart Home│              │ │
│ │ │  [Icon]  │ │  [Icon]  │ │  [Icon]  │ │  [Icon]  │              │ │
│ │ │ Sensors  │ │RFID Sys  │ │Environ   │ │Security  │              │ │
│ │ │Controllers│ │Automation │ │Irrigation│ │Energy Mgmt│              │ │
│ │ │Connectivity│ │Monitoring │ │Livestock │ │Automation │              │ │
│ │ │[Explore →]│ │[Explore →]│ │[Explore →]│ │[Explore →]│              │ │
│ │ └──────────┘ └──────────┘ └──────────┘ └──────────┘              │ │
│ └───────────────────────────────────────────────────────────────────┘ │
├─────────────────────────────────────────────────────────────────────────┤
│ [Featured Products - Product Grid]                                     │
│ ┌───────────────────────────────────────────────────────────────────┐ │
│ │ Section Header: "Featured IoT Products" (Display M)               │ │
│ │ Subtitle: "Handpicked devices for professionals" (Body M)         │ │
│ │                                                                     │ │
│ │ Product Grid (4 columns desktop, 2 tablet, 1 mobile):            │ │
│ │ ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐                                  │ │
│ │ │Prod │ │Prod │ │Prod │ │Prod │                                  │ │
│ │ │Card │ │Card │ │Card │ │Card │                                  │ │
│ │ │ 1   │ │ 2   │ │ 3   │ │ 4   │                                  │ │
│ │ └─────┘ └─────┘ └─────┘ └─────┘                                  │ │
│ │                                                                     │ │
│ │ Each Product Card Contains:                                       │ │
│ │ - Product Image (300x300px, lazy-loaded)                          │ │
│ │ - Stock Badge (Top-right: "In Stock" / "Low Stock" / "Out")       │ │
│ │ - Product Name (Heading M, 20px)                                  │ │
│ │ - Key Spec Badge (e.g., "LoRaWAN", "12V DC")                      │ │
│ │ - Description (Truncated to 2 lines, Body S)                      │ │
│ │ - Price (Body L, Bold, $199.99)                                   │ │
│ │ - Stock Status (Body S, "✓ In Stock (15 available)")              │ │
│ │ - Actions: [View Details] [Add to Cart]                           │ │
│ │                                                                     │ │
│ │ [View All Products →] Button (Secondary)                         │ │
│ └───────────────────────────────────────────────────────────────────┘ │
├─────────────────────────────────────────────────────────────────────────┤
│ [Trust Indicators - Horizontal Strip]                                  │
│ ┌───────────────────────────────────────────────────────────────────┐ │
│ │ Section: "Why Choose IoTBay?"                                     │ │
│ │ ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐              │ │
│ │ │Certified │ │24/7      │ │2-Year    │ │Free      │              │ │
│ │ │Products  │ │Support   │ │Warranty  │ │Shipping  │              │ │
│ │ │[CE/FCC]  │ │[Live Chat]│ │[All Items]│ │[$50+]    │              │ │
│ │ └──────────┘ └──────────┘ └──────────┘ └──────────┘              │ │
│ └───────────────────────────────────────────────────────────────────┘ │
├─────────────────────────────────────────────────────────────────────────┤
│ [Newsletter Signup - Optional]                                         │
│ ┌───────────────────────────────────────────────────────────────────┐ │
│ │ "Stay Updated with Latest IoT Solutions"                          │ │
│ │ Email Input: [________________] [Subscribe]                      │ │
│ └───────────────────────────────────────────────────────────────────┘ │
├─────────────────────────────────────────────────────────────────────────┤
│ [Footer - Site-wide]                                                   │
│ ┌───────────────────────────────────────────────────────────────────┐ │
│ │ Footer Grid (4 columns desktop, 2 tablet, 1 mobile):           │ │
│ │ - Company: About | Careers | Contact                            │ │
│ │ - Products: Categories | New Arrivals | Featured                │ │
│ │ - Support: Help Center | Shipping | Returns                      │ │
│ │ - Legal: Privacy | Terms | Cookies                               │ │
│ │                                                                     │ │
│ │ Social Media Links | Copyright | Back to Top Button              │ │
│ └───────────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────────┘
```

**Key Features**:
- **Skip Links**: Accessibility-first navigation for keyboard users
- **Responsive Header**: Collapses to hamburger menu on mobile
- **Hero Section**: Full-width banner with clear value proposition
- **Category Navigation**: Visual category cards with icons and descriptions
- **Featured Products**: Curated product selection with full product card details
- **Trust Indicators**: Social proof and credibility signals
- **Newsletter**: Optional email capture (GDPR compliant)
- **Footer**: Comprehensive site navigation and legal links

**Interactive Elements**:
- Search bar with autocomplete suggestions
- Cart icon with live item count badge
- Theme toggle (light/dark mode)
- Product card hover effects (elevation, scale)
- Category card click-through to category pages
- "Add to Cart" optimistic UI updates

### 4.2 Product Listing Pages

**Pages**: `browse.jsp`, `categories.jsp`, `category-industrial.jsp`, `category-warehouse.jsp`, `category-agriculture.jsp`, `category-smarthome.jsp`

**Purpose**: Display filtered and searchable product listings with multi-dimensional filtering capabilities for IoT products.

**Layout Structure**:

```
┌─────────────────────────────────────────────────────────────────────────┐
│ [Breadcrumb Navigation]                                                 │
│ Home > Categories > Industrial                                          │
│ (Clickable path, aria-label for screen readers)                        │
├─────────────────────────────────────────────────────────────────────────┤
│ [Page Header Section]                                                   │
│ ┌───────────────────────────────────────────────────────────────────┐ │
│ │ Page Title: "Industrial IoT Products" (Display L, 36px)         │ │
│ │ Description: "Discover comprehensive range of Industrial IoT      │ │
│ │              devices for automation and monitoring" (Body L)      │ │
│ │                                                                     │ │
│ │ Search Bar: [Search products...] [🔍] [Advanced Filters ▼]       │ │
│ │ Results Count: "Showing 1-12 of 48 products" (Body S)            │ │
│ │ Sort Dropdown: [Sort by: Relevance ▼]                            │ │
│ │ View Toggle: [Grid] [List] (Icon buttons)                        │ │
│ └───────────────────────────────────────────────────────────────────┘ │
├─────────────────────────────────────────────────────────────────────────┤
│ [Main Content Area - Two Column Layout]                                 │
│ ┌──────────────────────────────┐ ┌──────────────────────────────────┐ │
│ │ [Filters Sidebar]              │ │ [Product Grid Area]             │ │
│ │ ┌──────────────────────────┐ │ │                                   │ │
│ │ │ FILTERS                  │ │ │ Product Grid (3 columns desktop, │ │
│ │ │                          │ │ │ 2 tablet, 1 mobile):             │ │
│ │ │ Category Filter          │ │ │ ┌─────┐ ┌─────┐ ┌─────┐        │ │
│ │ │ ☑ Industrial             │ │ │ │Prod │ │Prod │ │Prod │        │ │
│ │ │ ☐ Warehouse              │ │ │ │ 1   │ │ 2   │ │ 3   │        │ │
│ │ │ ☐ Agriculture            │ │ │ └─────┘ └─────┘ └─────┘        │ │
│ │ │ ☐ Smart Home             │ │ │ ┌─────┐ ┌─────┐ ┌─────┐        │ │
│ │ │                          │ │ │ │Prod │ │Prod │ │Prod │        │ │
│ │ │ Protocol Filter          │ │ │ │ 4   │ │ 5   │ │ 6   │        │ │
│ │ │ ☑ LoRaWAN                │ │ │ └─────┘ └─────┘ └─────┘        │ │
│ │ │ ☐ WiFi                   │ │ │                                 │ │
│ │ │ ☐ Zigbee                 │ │ │ [Skeleton Loading State]        │ │
│ │ │ ☐ Bluetooth              │ │ │ (Shown during data fetch)        │ │
│ │ │                          │ │ │                                 │ │
│ │ │ Voltage Filter           │ │ │ [Empty State]                   │ │
│ │ │ ☑ 12V DC                 │ │ │ (If no products match filters)  │ │
│ │ │ ☐ 24V DC                 │ │ │                                 │ │
│ │ │ ☐ 5V DC                  │ │ │                                 │ │
│ │ │                          │ │ │                                 │ │
│ │ │ Price Range              │ │ │                                 │ │
│ │ │ $0 ──────●─────── $1000  │ │ │                                 │ │
│ │ │ Min: $50  Max: $500      │ │ │                                 │ │
│ │ │                          │ │ │                                 │ │
│ │ │ Stock Status             │ │ │                                 │ │
│ │ │ ☑ In Stock Only           │ │ │                                 │ │
│ │ │ ☐ Include Out of Stock    │ │ │                                 │ │
│ │ │                          │ │ │                                 │ │
│ │ │ Compatibility             │ │ │                                 │ │
│ │ │ ☐ Home Assistant          │ │ │                                 │ │
│ │ │ ☐ AWS IoT                 │ │ │                                 │ │
│ │ │                          │ │ │                                 │ │
│ │ │ [Clear All Filters]      │ │ │                                 │ │
│ │ │ [Apply Filters]          │ │ │                                 │ │
│ │ │                          │ │ │                                 │ │
│ │ │ Mobile: Collapsible      │ │ │                                 │ │
│ │ │ [Filters ▼]              │ │ │                                 │ │
│ │ └──────────────────────────┘ │ │                                 │ │
│ └──────────────────────────────┘ │                                 │ │
│                                   │ [Pagination]                     │ │
│                                   │ [← Previous] 1 2 3 4 5 [Next →] │ │
│                                   │ "Page 1 of 4"                    │ │
│                                   └──────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────────┘
```

**Product Card Details** (Grid View):
- **Image Container**: 300x300px, lazy-loaded, fallback image
- **Stock Badge**: Top-right corner
  - Green: "In Stock" (stock > 5)
  - Orange: "Low Stock" (1-5 items)
  - Red: "Out of Stock" (0 items)
- **Product Name**: Heading M (20px), clickable to product detail
- **Key Spec Badge**: Protocol/Voltage indicator (e.g., "LoRaWAN", "12V DC")
- **Description**: Truncated to 2 lines with ellipsis, Body S
- **Price**: Body L, Bold ($199.99)
- **Stock Status**: Body S ("✓ In Stock (15 available)")
- **Action Buttons**: 
  - "View Details" (Secondary button)
  - "Add to Cart" (Primary button, disabled if out of stock)

**Product Card Details** (List View):
- Horizontal layout with image on left (200x200px)
- Product info and actions on right
- Same information as grid view, different layout

**Filter Functionality**:
- **URL-based State**: Filters reflected in URL (`?category=industrial&protocol=lorawan&voltage=12v`)
- **Progressive Enhancement**: Filters work without JavaScript (form submission)
- **Real-time Updates**: JavaScript-enabled instant filtering
- **Filter Persistence**: Saved in sessionStorage
- **Clear Filters**: One-click reset to default state
- **Active Filter Tags**: Chips showing active filters with remove button

**Sort Options**:
- Relevance (default)
- Price: Low to High
- Price: High to Low
- Name: A to Z
- Name: Z to A
- Newest First
- Stock: High to Low

**Pagination**:
- Page numbers with ellipsis for large result sets
- Previous/Next buttons
- Jump to page input
- Results per page selector (12, 24, 48, 96)

**Accessibility Features**:
- ARIA labels on all filter controls
- Keyboard navigation for filter options
- Screen reader announcements for filter changes
- Focus management when filters applied
- Skip link to product grid

### 4.3 Product Detail Page (productDetails.jsp)

**Purpose**: Comprehensive product information page with technical specifications, compatibility information, and purchase options.

**Layout Structure**:

```
┌─────────────────────────────────────────────────────────────────────────┐
│ [Breadcrumb Navigation]                                                 │
│ Home > Categories > Industrial > LoRaWAN Temperature Sensor            │
│ (Clickable path, aria-label for screen readers)                        │
├─────────────────────────────────────────────────────────────────────────┤
│ [Product Overview Section - Two Column Layout]                         │
│ ┌──────────────────────────────┐ ┌──────────────────────────────────┐ │
│ │ [Product Image Gallery]       │ │ [Product Information Panel]      │ │
│ │ ┌──────────────────────────┐ │ │                                   │ │
│ │ │ Main Image (600x600px)    │ │ │ Product Name                     │ │
│ │ │ [Zoom on hover]          │ │ │ "LoRaWAN Temperature Sensor"    │ │
│ │ │                           │ │ │ (Display M, 30px)                │ │
│ │ │ Thumbnail Strip:          │ │ │                                   │ │
│ │ │ [Img1] [Img2] [Img3] [Img4]│ │ │ Product SKU: IOT-TEMP-LORA-001  │ │
│ │ │                            │ │ │ (Body S, Caption)                │ │
│ │ │ [Previous] [Next] arrows  │ │ │                                   │ │
│ │ └──────────────────────────┘ │ │ │ Trust Badges:                    │ │
│ │                               │ │ │ [CE Certified] [FCC Approved]  │ │
│ │                               │ │ │ [2-Year Warranty]               │ │
│ │                               │ │ │                                   │ │
│ │                               │ │ │ Key Specifications (Quick View): │ │
│ │                               │ │ │ ┌─────────────────────────────┐ │ │
│ │                               │ │ │ │ Protocol: LoRaWAN           │ │
│ │                               │ │ │ │ Voltage: 12V DC, 100mA      │ │
│ │                               │ │ │ │ Range: -40°C to 85°C         │ │
│ │                               │ │ │ │ Accuracy: ±0.5°C            │ │
│ │                               │ │ │ │ Communication: 915MHz       │ │
│ │                               │ │ │ └─────────────────────────────┘ │ │
│ │                               │ │ │                                   │ │
│ │                               │ │ │ Price Section:                   │ │
│ │                               │ │ │ $199.99 (Body XL, Bold)          │ │
│ │                               │ │ │ $249.99 (Strikethrough, Body S)  │ │
│ │                               │ │ │ "Save 20%" (Success badge)      │ │
│ │                               │ │ │                                   │ │
│ │                               │ │ │ Stock Status:                    │ │
│ │                               │ │ │ ✓ In Stock (15 available)       │ │
│ │                               │ │ │ [Stock Indicator Bar: ████░░]   │ │
│ │                               │ │ │ "Low stock - Order soon!"       │ │
│ │                               │ │ │                                   │ │
│ │                               │ │ │ Quantity Selector:               │ │
│ │                               │ │ │ [- 1 +] (Min: 1, Max: 15)       │ │
│ │                               │ │ │                                   │ │
│ │                               │ │ │ Action Buttons:                  │ │
│ │                               │ │ │ [Add to Cart] (Primary, Large)  │ │
│ │                               │ │ │ [Add to Wishlist] (Secondary)    │ │
│ │                               │ │ │ [Compare] (Ghost)               │ │
│ │                               │ │ │                                   │ │
│ │                               │ │ │ Compatibility Warning:          │ │
│ │                               │ │ │ ⚠ Check compatibility with      │ │
│ │                               │ │ │   your existing devices          │ │
│ │                               │ │ │ [View Compatibility Matrix]     │ │
│ │                               │ │ │                                   │ │
│ │                               │ │ │ Shipping Info:                   │ │
│ │                               │ │ │ ✓ Free shipping on orders $50+   │ │
│ │                               │ │ │ ✓ Usually ships within 2-3 days  │ │
│ │                               │ │ │                                   │ │
│ │                               │ │ │ Support:                         │ │
│ │                               │ │ │ [📞 Contact Support]            │ │
│ │                               │ │ │ [📧 Email Product Specialist]    │ │
│ │                               │ │ │ [💬 Live Chat]                  │ │
│ │                               │ │ └──────────────────────────────────┘ │
│ └──────────────────────────────┘ └──────────────────────────────────┘ │
├─────────────────────────────────────────────────────────────────────────┤
│ [Tabbed Content Navigation]                                             │
│ ┌───────────────────────────────────────────────────────────────────┐ │
│ │ Tab Navigation (Underline indicator):                             │ │
│ │ [Specifications] [Compatibility] [Documentation] [Reviews]       │ │
│ │ (Active tab highlighted, keyboard navigable)                      │ │
│ └───────────────────────────────────────────────────────────────────┘ │
├─────────────────────────────────────────────────────────────────────────┤
│ [Technical Specifications Tab - Accordion Layout]                      │
│ ┌───────────────────────────────────────────────────────────────────┐ │
│ │ ▼ Essential Specifications (Expanded by default)                  │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ Communication Protocol: LoRaWAN (Class A)                  │   │ │
│ │ │ Power Requirements: 12V DC, 100mA                           │   │ │
│ │ │ Operating Range: -40°C to 85°C                              │   │ │
│ │ │ Temperature Accuracy: ±0.5°C                                │   │ │
│ │ │ Response Time: < 2 seconds                                   │   │ │
│ │ │ Communication Frequency: 915MHz (US) / 868MHz (EU)          │   │ │
│ │ │ Range: Up to 15km (line of sight)                           │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ │                                                                     │ │
│ │ ▶ Detailed Specifications (Collapsed)                              │ │
│ │   (Click to expand: Environmental ratings, dimensions, etc.)      │ │
│ │                                                                     │ │
│ │ ▶ Advanced Configuration (Collapsed)                              │ │
│ │   (Click to expand: API endpoints, firmware version, etc.)        │ │
│ │                                                                     │ │
│ │ [Expand All] [Collapse All] [Print Specs]                         │ │
│ └───────────────────────────────────────────────────────────────────┘ │
├─────────────────────────────────────────────────────────────────────────┤
│ [Compatibility Tab]                                                     │
│ ┌───────────────────────────────────────────────────────────────────┐ │
│ │ Compatibility Matrix:                                            │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ Compatible Gateways:                                        │   │ │
│ │ │ ✓ Gateway X (LoRaWAN)                                      │   │ │
│ │ │ ✓ Gateway Y (Multi-protocol)                               │   │ │
│ │ │ ✗ Gateway Z (Zigbee only)                                  │   │ │
│ │ │                                                             │   │ │
│ │ │ Compatible Platforms:                                       │   │ │
│ │ │ ✓ Home Assistant                                            │   │ │
│ │ │ ✓ AWS IoT Core                                              │   │ │
│ │ │ ✓ Azure IoT Hub                                             │   │ │
│ │ │                                                             │   │ │
│ │ │ Power Supply Compatibility:                                │   │ │
│ │ │ ✓ 12V DC Power Adapter (included)                          │   │ │
│ │ │ ✓ 12V Battery Pack                                         │   │ │
│ │ │ ⚠ 24V DC (Requires voltage regulator)                      │   │ │
│ │ │                                                             │   │ │
│ │ │ [View Full Compatibility Matrix]                           │   │ │
│ │ │ [Check Your Setup] (Interactive tool)                      │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ └───────────────────────────────────────────────────────────────────┘ │
├─────────────────────────────────────────────────────────────────────────┤
│ [Documentation Tab]                                                     │
│ ┌───────────────────────────────────────────────────────────────────┐ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ Quick Start Guide                                          │   │ │
│ │ │ [Download PDF] [View Online]                               │   │ │
│ │ │                                                             │   │ │
│ │ │ Full Datasheet                                             │   │ │
│ │ │ [Download PDF] [Embedded Viewer]                           │   │ │
│ │ │                                                             │   │ │
│ │ │ Integration Guides:                                        │   │ │
│ │ │ • Home Assistant Integration                               │   │ │
│ │ │ • AWS IoT Setup Guide                                      │   │ │
│ │ │ • API Documentation                                        │   │ │
│ │ │                                                             │   │ │
│ │ │ Code Examples:                                             │   │ │
│ │ │ [Python] [JavaScript] [Arduino] [Copy Code]               │   │ │
│ │ │                                                             │   │ │
│ │ │ Firmware Updates:                                          │   │ │
│ │ │ Current Version: v2.1.3                                    │   │ │
│ │ │ [Download Latest] [Update Instructions]                    │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ └───────────────────────────────────────────────────────────────────┘ │
├─────────────────────────────────────────────────────────────────────────┤
│ [Reviews Tab]                                                           │
│ ┌───────────────────────────────────────────────────────────────────┐ │
│ │ Average Rating: 4.5/5.0 (128 reviews)                           │ │
│ │ Rating Breakdown: ████████░░ 85% | ██░░░░░░░░ 10% | ...         │ │
│ │                                                                     │ │
│ │ [Write a Review] Button                                            │ │
│ │                                                                     │ │
│ │ Review List:                                                        │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ John D. ⭐⭐⭐⭐⭐ (Verified Purchase)                        │   │ │
│ │ │ "Excellent sensor, easy integration with Home Assistant"    │   │ │
│ │ │ [Helpful: 12] [Reply]                                       │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ │ [Load More Reviews]                                                 │ │
│ └───────────────────────────────────────────────────────────────────┘ │
├─────────────────────────────────────────────────────────────────────────┤
│ [Related Products Section]                                             │
│ ┌───────────────────────────────────────────────────────────────────┐ │
│ │ Section Title: "You May Also Like" (Display M)                   │ │
│ │ Product Grid (4 items):                                          │ │
│ │ ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐                                │ │
│ │ │Prod │ │Prod │ │Prod │ │Prod │                                │ │
│ │ │ 1   │ │ 2   │ │ 3   │ │ 4   │                                │ │
│ │ └─────┘ └─────┘ └─────┘ └─────┘                                │ │
│ │ (Compatible products, same category, or frequently bought together)│ │
│ └───────────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────────┘
```

**Key Features**:
- **Image Gallery**: Main image with thumbnail navigation, zoom functionality
- **Trust Badges**: Certifications, warranty, and quality indicators
- **Stock Indicators**: Visual and textual stock status with urgency messaging
- **Quantity Selector**: Min/max validation based on stock
- **Compatibility Warnings**: Proactive alerts for incompatible products
- **Progressive Disclosure**: Accordion for technical specifications
- **Tabbed Content**: Organized information architecture
- **Documentation Access**: Embedded PDF viewer and downloadable resources
- **Review System**: Star ratings, verified purchases, helpful votes
- **Related Products**: Cross-sell and upsell opportunities

**Interactive Elements**:
- Image zoom on hover/click
- Thumbnail navigation
- Tab switching with keyboard support
- Accordion expand/collapse
- Quantity increment/decrement
- Add to cart with optimistic UI
- Wishlist toggle
- Compatibility checker tool
- Code example copy-to-clipboard
- Review submission form (modal)

### 4.4 Shopping Cart Page (cart.jsp)

**Purpose**: Review cart items, manage quantities, check compatibility, and proceed to checkout.

**Layout Structure**:

```
┌─────────────────────────────────────────────────────────────────────────┐
│ [Breadcrumb Navigation]                                                 │
│ Home > Shopping Cart                                                    │
│ (Clickable path)                                                        │
├─────────────────────────────────────────────────────────────────────────┤
│ [Page Header]                                                           │
│ ┌───────────────────────────────────────────────────────────────────┐ │
│ │ Page Title: "Shopping Cart" (Display L, 36px)                    │ │
│ │ Item Count: "3 items in your cart" (Body M)                     │ │
│ │ [Continue Shopping] Link (Secondary)                              │ │
│ └───────────────────────────────────────────────────────────────────┘ │
├─────────────────────────────────────────────────────────────────────────┤
│ [Compatibility Warnings Section] (Conditional - if issues detected)     │
│ ┌───────────────────────────────────────────────────────────────────┐ │
│ │ ⚠ Compatibility Warning Banner (Orange/Red)                      │ │
│ │ "Voltage mismatch detected in your cart"                          │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ Product A requires 12V DC                                    │   │ │
│ │ │ Product B provides 24V DC                                    │   │ │
│ │ │ ⚠ These products may not be compatible                        │   │ │
│ │ │ [View Details] [Find Compatible Alternative]                  │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ │                                                                     │ │
│ │ Protocol Compatibility Warning:                                    │ │
│ │ "Product C uses LoRaWAN, but your gateway supports Zigbee only"  │ │
│ │ [View Compatibility Guide]                                         │ │
│ └───────────────────────────────────────────────────────────────────┘ │
├─────────────────────────────────────────────────────────────────────────┤
│ [Main Content - Two Column Layout]                                      │
│ ┌──────────────────────────────────────┐ ┌──────────────────────────┐│
│ │ [Cart Items Section]                 │ │ [Order Summary Sidebar]   ││
│ │ ┌──────────────────────────────────┐ │ │ ┌──────────────────────┐  ││
│ │ │ Cart Item 1                      │ │ │ │ Order Summary        │  ││
│ │ │ ┌──────────────────────────────┐ │ │ │ │                      │  ││
│ │ │ │ [Product Image 150x150px]   │ │ │ │ │ Subtotal:            │  ││
│ │ │ │                              │ │ │ │ │ $599.97              │  ││
│ │ │ │ Product Name                 │ │ │ │ │                      │  ││
│ │ │ │ "LoRaWAN Temperature Sensor" │ │ │ │ │ Shipping:            │  ││
│ │ │ │                              │ │ │ │ │ $15.00               │  ││
│ │ │ │ Key Specs:                   │ │ │ │ │ (Free over $50)      │  ││
│ │ │ │ • Protocol: LoRaWAN          │ │ │ │ │                      │  ││
│ │ │ │ • Voltage: 12V DC            │ │ │ │ │ Tax:                 │  ││
│ │ │ │ • Range: -40°C to 85°C       │ │ │ │ │ $60.00               │  ││
│ │ │ │                              │ │ │ │ │                      │  ││
│ │ │ │ Unit Price: $199.99          │ │ │ │ │ ──────────────────── │  ││
│ │ │ │                              │ │ │ │ │                      │  ││
│ │ │ │ Quantity:                    │ │ │ │ │ Total:               │  ││
│ │ │ │ [- 2 +] (Min: 1, Max: 15)   │ │ │ │ │ $674.97              │  ││
│ │ │ │                              │ │ │ │ │ (Body XL, Bold)      │  ││
│ │ │ │ Subtotal: $399.98            │ │ │ │ │                      │  ││
│ │ │ │                              │ │ │ │ │ [Proceed to Checkout]│  ││
│ │ │ │ Actions:                     │ │ │ │ │ (Primary, Full Width)│ ││
│ │ │ │ [Update] [Remove] [Save for  │ │ │ │ │                      │  ││
│ │ │ │ Later] [Move to Wishlist]    │ │ │ │ │                      │  ││
│ │ │ │                              │ │ │ │ │ Promo Code:          │  ││
│ │ │ │ Stock Status:                │ │ │ │ │ [Enter code...] [Apply]││
│ │ │ │ ✓ In Stock (13 remaining)   │ │ │ │ │                      │  ││
│ │ │ └──────────────────────────────┘ │ │ │ │ Security Badges:      │  ││
│ │ │                                   │ │ │ │ [🔒 Secure Checkout] │  ││
│ │ │ Cart Item 2                      │ │ │ │ [✓ SSL Encrypted]    │  ││
│ │ │ [Same structure as Item 1]      │ │ │ │                      │  ││
│ │ │                                   │ │ │ │ Trust Indicators:    │  ││
│ │ │ Cart Item 3                      │ │ │ │ "30-day returns"     │  ││
│ │ │ [Same structure as Item 1]      │ │ │ │ "Free shipping $50+"  │  ││
│ │ │                                   │ │ │ └──────────────────────┘  ││
│ │ │ [Empty Cart State] (if no items) │ │ │                           ││
│ │ │ ┌──────────────────────────────┐ │ │ │                           ││
│ │ │ │ Empty Cart Icon             │ │ │ │                           ││
│ │ │ │ "Your cart is empty"        │ │ │ │                           ││
│ │ │ │ [Continue Shopping]          │ │ │ │                           ││
│ │ │ └──────────────────────────────┘ │ │ │                           ││
│ │ └──────────────────────────────────┘ │ │                           ││
│ │                                       │ │                           ││
│ │ [Cart Actions - Bottom of Items]      │ │                           ││
│ │ [Clear Cart] [Save Cart] [Continue    │ │                           ││
│ │ Shopping]                              │ │                           ││
│ └──────────────────────────────────────┘ └──────────────────────────┘│
├─────────────────────────────────────────────────────────────────────────┤
│ [Recently Viewed Products] (Optional Section)                          │
│ ┌───────────────────────────────────────────────────────────────────┐ │
│ │ Section Title: "Recently Viewed"                                 │ │
│ │ Product Grid (4 items, horizontal scroll on mobile):               │ │
│ │ ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐                                  │ │
│ │ │Prod │ │Prod │ │Prod │ │Prod │                                  │ │
│ │ │ 1   │ │ 2   │ │ 3   │ │ 4   │                                  │ │
│ │ └─────┘ └─────┘ └─────┘ └─────┘                                  │ │
│ └───────────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────────┘
```

**Key Features**:
- **Compatibility Checking**: Real-time validation of product compatibility
- **Quantity Management**: Increment/decrement with stock validation
- **Item Actions**: Update, remove, save for later, move to wishlist
- **Stock Warnings**: Low stock alerts for individual items
- **Order Summary**: Real-time calculation with shipping and tax
- **Promo Code**: Discount code application
- **Security Indicators**: Trust badges for secure checkout
- **Empty State**: Helpful messaging when cart is empty
- **Recently Viewed**: Cross-sell opportunities

**Interactive Elements**:
- Quantity selector with validation
- Remove item with confirmation dialog
- Update cart with optimistic UI
- Compatibility warning expand/collapse
- Promo code input and validation
- Proceed to checkout button (disabled if compatibility issues)
- Continue shopping link
- Save cart for later functionality

**Accessibility Features**:
- ARIA labels for all cart actions
- Screen reader announcements for quantity changes
- Keyboard navigation for all interactive elements
- Focus management after item removal
- Error announcements for compatibility issues

### 4.5 Checkout Page (checkout.jsp)

**Purpose**: Multi-step checkout process for order placement with shipping, payment, and review steps.

**Layout Structure**:

```
┌─────────────────────────────────────────────────────────────────────────┐
│ [Progress Indicator - Top of Page]                                     │
│ ┌───────────────────────────────────────────────────────────────────┐ │
│ │ Progress Stepper (Visual indicator):                            │ │
│ │ [✓] Cart → [2] Shipping → [3] Payment → [4] Review              │ │
│ │ Step 1 Complete    Step 2 Current    Step 3      Step 4         │ │
│ │ (Completed steps: Green checkmark, Current: Blue highlight)      │ │
│ │ (Future steps: Gray, disabled)                                   │ │
│ │                                                                     │ │
│ │ Mobile: Simplified "Step 2 of 4" text                            │ │
│ └───────────────────────────────────────────────────────────────────┘ │
├─────────────────────────────────────────────────────────────────────────┤
│ [Main Content - Two Column Layout]                                      │
│ ┌──────────────────────────────────────┐ ┌──────────────────────────┐│
│ │ [Checkout Form - Left Column]        │ │ [Order Summary - Sticky] ││
│ │                                       │ │ ┌──────────────────────┐  ││
│ │ STEP 2: Shipping Information         │ │ │ Order Summary       │  ││
│ │ ┌──────────────────────────────────┐ │ │ │                     │  ││
│ │ │ Shipping Address                 │ │ │ │ Items (3)           │  ││
│ │ │                                  │ │ │ │ ┌─────────────────┐ │  ││
│ │ │ Full Name:                       │ │ │ │ │ Product 1 x2     │ │  ││
│ │ │ [_____________________________]  │ │ │ │ │ $399.98         │ │  ││
│ │ │ (Required, real-time validation) │ │ │ │ └─────────────────┘ │  ││
│ │ │                                  │ │ │ │ ┌─────────────────┐ │  ││
│ │ │ Email Address:                   │ │ │ │ │ Product 2 x1     │ │  ││
│ │ │ [_____________________________]  │ │ │ │ │ $199.99         │ │  ││
│ │ │ (Business email validation)      │ │ │ │ └─────────────────┘ │  ││
│ │ │                                  │ │ │ │                     │  ││
│ │ │ Phone Number:                     │ │ │ │ Subtotal:          │  ││
│ │ │ [_____________________________]  │ │ │ │ $599.97            │  ││
│ │ │ (Format: +1 (555) 123-4567)      │ │ │ │                     │  ││
│ │ │                                  │ │ │ │ Shipping:           │  ││
│ │ │ Address Line 1:                   │ │ │ │ $15.00             │  ││
│ │ │ [_____________________________]  │ │ │ │ (Free over $50)    │  ││
│ │ │                                  │ │ │ │                     │  ││
│ │ │ Address Line 2 (Optional):       │ │ │ │ Tax:               │  ││
│ │ │ [_____________________________]  │ │ │ │ $60.00             │  ││
│ │ │                                  │ │ │ │                     │  ││
│ │ │ City:                             │ │ │ │ ────────────────── │  ││
│ │ │ [_____________________________]  │ │ │ │                     │  ││
│ │ │                                  │ │ │ │ Total:              │  ││
│ │ │ State/Province:                  │ │ │ │ $674.97            │  ││
│ │ │ [_____________________________]  │ │ │ │ (Body XL, Bold)    │  ││
│ │ │                                  │ │ │ │                     │  ││
│ │ │ Postal/ZIP Code:                 │ │ │ │ [Place Order]      │  ││
│ │ │ [_____________________________]  │ │ │ │ (Primary, Full Width)│││
│ │ │                                  │ │ │ │                     │  ││
│ │ │ Country:                          │ │ │ │ Security:          │  ││
│ │ │ [United States ▼]                │ │ │ │ [🔒 SSL Encrypted] │  ││
│ │ │                                  │ │ │ │                     │  ││
│ │ │ [Use Billing Address] Checkbox    │ │ │ │ Estimated Delivery: │  ││
│ │ │                                  │ │ │ │ 2-3 business days   │  ││
│ │ │ [Save Address] Checkbox          │ │ │ │                     │  ││
│ │ │                                  │ │ │ │ [Edit Cart] Link    │  ││
│ │ │ [Saved Addresses Dropdown]       │ │ │ └──────────────────────┘  ││
│ │ │ [Select saved address... ▼]      │ │ │                           ││
│ │ └──────────────────────────────────┘ │ │                           ││
│ │                                       │ │                           ││
│ │ Shipping Method:                      │ │                           ││
│ │ ┌──────────────────────────────────┐ │ │                           ││
│ │ │ ○ Standard Shipping ($15.00)     │ │ │                           ││
│ │ │   "5-7 business days"             │ │ │                           ││
│ │ │                                  │ │ │                           ││
│ │ │ ○ Express Shipping ($25.00)      │ │ │                           ││
│ │ │   "2-3 business days"            │ │ │                           ││
│ │ │                                  │ │ │                           ││
│ │ │ ○ Overnight ($45.00)             │ │ │                           ││
│ │ │   "Next business day"            │ │ │                           ││
│ │ └──────────────────────────────────┘ │ │                           ││
│ │                                       │ │                           ││
│ │ STEP 3: Payment Method                │ │                           ││
│ │ ┌──────────────────────────────────┐ │ │                           ││
│ │ │ Payment Options:                 │ │ │                           ││
│ │ │                                  │ │ │                           ││
│ │ │ ○ Credit/Debit Card              │ │ │                           ││
│ │ │   [Card Icon]                    │ │ │                           ││
│ │ │                                  │ │ │                           ││
│ │ │ ○ PayPal                         │ │ │                           ││
│ │ │   [PayPal Icon]                  │ │ │                           ││
│ │ │                                  │ │ │                           ││
│ │ │ ○ Bank Transfer                  │ │ │                           ││
│ │ │   "For orders over $1000"        │ │ │                           ││
│ │ │                                  │ │ │                           ││
│ │ │ [Credit Card Form - if selected] │ │ │                           ││
│ │ │ ┌──────────────────────────────┐ │ │ │                           ││
│ │ │ │ Card Number:                 │ │ │ │                           ││
│ │ │ │ [4242 4242 4242 4242]        │ │ │ │                           ││
│ │ │ │ [Card Type Icon: Visa]        │ │ │ │                           ││
│ │ │ │                              │ │ │ │                           ││
│ │ │ │ Cardholder Name:             │ │ │ │                           ││
│ │ │ │ [John Doe]                   │ │ │ │                           ││
│ │ │ │                              │ │ │ │                           ││
│ │ │ │ Expiry Date:                 │ │ │ │                           ││
│ │ │ │ [MM] / [YY]                  │ │ │ │                           ││
│ │ │ │                              │ │ │ │                           ││
│ │ │ │ CVV:                         │ │ │ │                           ││
│ │ │ │ [123] [What's this?]         │ │ │ │                           ││
│ │ │ │                              │ │ │ │                           ││
│ │ │ │ [Save Card] Checkbox         │ │ │ │                           ││
│ │ │ │ (Encrypted storage)          │ │ │ │                           ││
│ │ │ └──────────────────────────────┘ │ │ │                           ││
│ │ └──────────────────────────────────┘ │ │                           ││
│ │                                       │ │                           ││
│ │ STEP 4: Review & Confirm              │ │                           ││
│ │ ┌──────────────────────────────────┐ │ │                           ││
│ │ │ Order Review:                     │ │ │                           ││
│ │ │                                  │ │ │                           ││
│ │ │ Shipping Address:                │ │ │                           ││
│ │ │ John Doe                         │ │ │                           ││
│ │ │ 123 Main St                      │ │ │                           ││
│ │ │ New York, NY 10001               │ │ │                           ││
│ │ │ [Edit]                           │ │ │                           ││
│ │ │                                  │ │ │                           ││
│ │ │ Payment Method:                  │ │ │                           ││
│ │ │ Visa •••• 4242                  │ │ │                           ││
│ │ │ [Edit]                           │ │ │                           ││
│ │ │                                  │ │ │                           ││
│ │ │ Order Items:                     │ │ │                           ││
│ │ │ [Product list with quantities]   │ │ │                           ││
│ │ │                                  │ │ │                           ││
│ │ │ Terms & Conditions:              │ │ │                           ││
│ │ │ ☑ I agree to Terms & Conditions │ │ │                           ││
│ │ │ ☑ I agree to Privacy Policy     │ │ │                           ││
│ │ │                                  │ │ │                           ││
│ │ │ [Place Order] Button             │ │ │                           ││
│ │ │ (Loading state: Spinner)         │ │ │                           ││
│ │ └──────────────────────────────────┘ │ │                           ││
│ │                                       │ │                           ││
│ │ [Back to Cart] Link                   │ │                           ││
│ └──────────────────────────────────────┘ └──────────────────────────┘│
└─────────────────────────────────────────────────────────────────────────┘
```

**Key Features**:
- **Progress Indicator**: Visual stepper showing current step and progress
- **Form Validation**: Real-time validation with helpful error messages
- **Address Management**: Save addresses, use saved addresses, autocomplete
- **Shipping Options**: Multiple shipping methods with cost and delivery time
- **Payment Methods**: Credit card, PayPal, bank transfer options
- **Card Validation**: Real-time card number validation and type detection
- **Order Review**: Final confirmation before order placement
- **Terms Acceptance**: Required checkboxes for terms and privacy policy
- **Sticky Summary**: Order summary remains visible while scrolling
- **Error Recovery**: Form state preservation on validation errors

**Interactive Elements**:
- Step navigation (can go back to previous steps)
- Real-time form validation
- Address autocomplete (if API available)
- Card number formatting and validation
- Shipping method selection with price update
- Payment method switching
- Terms checkbox validation
- Place order with loading state
- Confirmation dialog before order placement

**Accessibility Features**:
- ARIA labels for all form fields
- Error announcements for screen readers
- Keyboard navigation through all steps
- Focus management between steps
- Required field indicators
- Help text for complex fields (CVV, etc.)
- Skip links for form sections

- Focus trap in modals
- Focus return after modal close
- Visible focus indicators (not just outline)

---

## 4.6 User Management Pages

### 4.6.1 Registration Page (register.jsp)

**Purpose**: New user account creation with comprehensive validation and security.

**Layout Structure**:

```
┌─────────────────────────────────────────────────────────────────────────┐
│ [Header - Global Navigation]                                           │
├─────────────────────────────────────────────────────────────────────────┤
│ [Registration Form - Centered Layout]                                  │
│ ┌───────────────────────────────────────────────────────────────────┐ │
│ │ Page Title: "Create Your Account" (Display L, 36px)              │ │
│ │ Subtitle: "Join IoTBay and access exclusive IoT solutions"       │ │
│ │                                                                     │ │
│ │ Registration Form:                                                 │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ First Name: *                                                │   │ │
│ │ │ [_____________________________]                              │   │ │
│ │ │ (Required, min 2 characters)                                 │   │ │
│ │ │                                                               │   │ │
│ │ │ Last Name: *                                                 │   │ │
│ │ │ [_____________________________]                              │   │ │
│ │ │                                                               │   │ │
│ │ │ Email Address: *                                             │   │ │
│ │ │ [_____________________________]                              │   │ │
│ │ │ ✓ Valid email format                                         │   │ │
│ │ │ (Real-time validation, business email option)                 │   │ │
│ │ │                                                               │   │ │
│ │ │ Password: *                                                  │   │ │
│ │ │ [••••••••••••••••] [Show/Hide]                              │   │ │
│ │ │ Password Strength Indicator:                                 │   │ │
│ │ │ [████░░░░] Medium (Body S)                                    │   │ │
│ │ │ Requirements:                                                 │   │ │
│ │ │ ✓ 8+ characters                                              │   │ │
│ │ │ ✓ Uppercase letter                                           │   │ │
│ │ │ ✓ Lowercase letter                                           │   │ │
│ │ │ ✓ Number                                                     │   │ │
│ │ │                                                               │   │ │
│ │ │ Confirm Password: *                                          │   │ │
│ │ │ [••••••••••••••••]                                           │   │ │
│ │ │ ✓ Passwords match                                            │   │ │
│ │ │                                                               │   │ │
│ │ │ Phone Number (Optional):                                      │   │ │
│ │ │ [+1] [_____________________________]                         │   │ │
│ │ │ (Auto-formatting: +1 (555) 123-4567)                        │   │ │
│ │ │                                                               │   │ │
│ │ │ Terms & Conditions: *                                        │   │ │
│ │ │ ☑ I agree to the Terms & Conditions                          │   │ │
│ │ │ [Read Terms]                                                 │   │ │
│ │ │                                                               │   │ │
│ │ │ Privacy Policy: *                                            │   │ │
│ │ │ ☑ I agree to the Privacy Policy                             │   │ │
│ │ │ [Read Privacy Policy]                                        │   │ │
│ │ │                                                               │   │ │
│ │ │ [Create Account] Button (Primary, Full Width)               │   │ │
│ │ │ (Loading state: Spinner + "Creating account...")             │   │ │
│ │ │                                                               │   │ │
│ │ │ Already have an account? [Log In]                           │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ └───────────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────────┘
```

**Key Features**:
- **Real-time Validation**: Immediate feedback on all fields
- **Password Strength Indicator**: Visual and textual feedback
- **Business Email Detection**: Automatic B2B account classification
- **Phone Number Formatting**: Auto-formatting as user types
- **Terms Acceptance**: Required checkboxes with links
- **Error Handling**: Clear, actionable error messages
- **Success Redirect**: Redirects to welcome page after registration

**Interactive Elements**:
- Real-time email validation
- Password strength meter (weak, medium, strong)
- Password visibility toggle
- Phone number auto-formatting
- Terms/Privacy policy modal links
- Form submission with loading state
- Error message display

**Accessibility Features**:
- ARIA labels for all form fields
- Error announcements for screen readers
- Required field indicators (asterisk + aria-required)
- Keyboard navigation
- Focus management on errors
- Help text for complex fields

### 4.6.2 Login Page (login.jsp)

**Purpose**: Secure user authentication with session management.

**Layout Structure**:

```
┌─────────────────────────────────────────────────────────────────────────┐
│ [Header - Global Navigation]                                           │
├─────────────────────────────────────────────────────────────────────────┤
│ [Login Form - Centered Layout]                                         │
│ ┌───────────────────────────────────────────────────────────────────┐ │
│ │ Page Title: "Welcome Back" (Display L, 36px)                     │ │
│ │ Subtitle: "Sign in to your IoTBay account"                        │ │
│ │                                                                     │ │
│ │ Login Form:                                                        │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ Email Address: *                                             │   │ │
│ │ │ [_____________________________]                              │   │ │
│ │ │ (Auto-focus on page load)                                    │   │ │
│ │ │                                                               │   │ │
│ │ │ Password: *                                                  │   │ │
│ │ │ [••••••••••••••••] [Show/Hide]                              │   │ │
│ │ │ [Forgot Password?] Link                                      │   │ │
│ │ │                                                               │   │ │
│ │ │ [Remember Me] Checkbox                                       │   │ │
│ │ │ "Keep me signed in for 30 days"                              │   │ │
│ │ │                                                               │   │ │
│ │ │ [Sign In] Button (Primary, Full Width)                       │   │ │
│ │ │ (Loading state: Spinner + "Signing in...")                  │   │ │
│ │ │                                                               │   │ │
│ │ │ Error Message (if invalid):                                  │   │ │
│ │ │ ⚠ Invalid email or password. Please try again.              │   │ │
│ │ │                                                               │   │ │
│ │ │ Divider: "or"                                                │   │ │
│ │ │                                                               │   │ │
│ │ │ [Create Account] Link (Secondary)                            │   │ │
│ │ │ "Don't have an account? Create one now"                     │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ └───────────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────────┘
```

**Key Features**:
- **Email Auto-focus**: Cursor in email field on load
- **Password Visibility Toggle**: Show/hide password
- **Remember Me**: Session persistence option
- **Forgot Password**: Link to password reset
- **Error Handling**: Clear error messages
- **Success Redirect**: Redirects to welcome page after login

**Interactive Elements**:
- Email input with validation
- Password visibility toggle
- Remember me checkbox
- Form submission with loading state
- Error message display
- Link to registration page

### 4.6.3 User Profile Page (Profiles.jsp)

**Purpose**: View and manage user account information, addresses, and preferences.

**Layout Structure**:

```
┌─────────────────────────────────────────────────────────────────────────┐
│ [Header - Global Navigation]                                           │
├─────────────────────────────────────────────────────────────────────────┤
│ [Profile Page - Two Column Layout]                                     │
│ ┌──────────────────────────────┐ ┌──────────────────────────────────┐ │
│ │ [Profile Navigation Sidebar] │ │ [Main Profile Content]            │ │
│ │ ┌──────────────────────────┐ │ │                                   │ │
│ │ │ Profile Menu:            │ │ │ Page Title: "My Account"         │ │
│ │ │                          │ │ │ (Display L, 36px)                 │ │
│ │ │ • Personal Information   │ │ │                                   │ │
│ │ │ • Addresses             │ │ │ Personal Information Section:    │ │
│ │ │ • Payment Methods       │ │ │ ┌─────────────────────────────┐   │ │
│ │ │ • Order History         │ │ │ │ First Name: John            │   │ │
│ │ │ • Reviews               │ │ │ │ Last Name: Doe              │   │ │
│ │ │ • Account Settings      │ │ │ │ Email: john.doe@email.com   │   │ │
│ │ │ • Change Password       │ │ │ │ Phone: +1 (555) 123-4567    │   │ │
│ │ │ • Delete Account        │ │ │ │                              │   │ │
│ │ │                          │ │ │ │ [Edit Profile] Button       │   │ │
│ │ └──────────────────────────┘ │ │ └─────────────────────────────┘   │ │
│ │                               │ │                                   │ │
│ │                               │ │ Addresses Section:               │ │
│ │                               │ │ ┌─────────────────────────────┐   │ │
│ │                               │ │ │ Saved Addresses:            │   │ │
│ │                               │ │ │ ┌─────────────────────────┐ │   │ │
│ │                               │ │ │ │ Home Address (Default)   │ │   │ │
│ │                               │ │ │ │ 123 Main St              │ │   │ │
│ │                               │ │ │ │ New York, NY 10001       │ │   │ │
│ │                               │ │ │ │ [Edit] [Delete]          │ │   │ │
│ │                               │ │ │ └─────────────────────────┘ │   │ │
│ │                               │ │ │ [Add New Address] Button   │   │ │
│ │                               │ │ └─────────────────────────────┘   │ │
│ │                               │ │                                   │ │
│ │                               │ │ Payment Methods Section:          │ │
│ │                               │ │ ┌─────────────────────────────┐   │ │
│ │                               │ │ │ Saved Cards:                │   │ │
│ │                               │ │ │ ┌─────────────────────────┐ │   │ │
│ │                               │ │ │ │ Visa •••• 4242          │ │   │ │
│ │                               │ │ │ │ Expires: 12/25          │ │   │ │
│ │                               │ │ │ │ [Edit] [Delete]          │ │   │ │
│ │                               │ │ │ └─────────────────────────┘ │   │ │
│ │                               │ │ │ [Add Payment Method]       │   │ │
│ │                               │ │ └─────────────────────────────┘   │ │
│ │                               │ │                                   │ │
│ │                               │ │ Quick Links:                     │ │
│ │                               │ │ [View Order History]            │ │
│ │                               │ │ [View My Reviews]               │ │
│ │                               │ │ [Change Password]                │ │
│ │                               │ └──────────────────────────────────┘ │
│ └──────────────────────────────┘ └──────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────────┘
```

**Key Features**:
- **Profile Navigation**: Sidebar menu for quick access
- **Personal Information**: Display and edit user details
- **Address Management**: Multiple saved addresses
- **Payment Methods**: Saved payment information
- **Quick Links**: Access to order history, reviews, settings
- **Edit Functionality**: Inline editing or separate edit page

### 4.6.4 Account Deletion Page (deleteaccount.jsp)

**Purpose**: Secure account deletion with confirmation and data retention information.

**Layout Structure**:

```
┌─────────────────────────────────────────────────────────────────────────┐
│ [Header - Global Navigation]                                           │
├─────────────────────────────────────────────────────────────────────────┤
│ [Account Deletion - Centered Warning Layout]                           │
│ ┌───────────────────────────────────────────────────────────────────┐ │
│ │ Warning Icon: ⚠ (Large, Red)                                      │ │
│ │                                                                     │ │
│ │ Page Title: "Delete Account" (Display L, 36px, Red)              │ │
│ │                                                                     │ │
│ │ Warning Message:                                                   │ │
│ │ "This action cannot be undone. All your data will be permanently  │ │
│ │  deleted, including:"                                             │ │
│ │                                                                     │ │
│ │ • Order history                                                    │ │
│ │ • Saved addresses                                                  │ │
│ │ • Payment methods                                                  │ │
│ │ • Product reviews                                                  │ │
│ │ • Wishlist items                                                   │ │
│ │                                                                     │ │
│ │ Data Retention Policy:                                             │ │
│ │ "Some data may be retained for legal and accounting purposes for  │ │
│ │  up to 7 years as required by law."                               │ │
│ │                                                                     │ │
│ │ Confirmation Form:                                                 │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ Type "DELETE" to confirm:                                   │   │ │
│ │ │ [_____________________________]                            │   │ │
│ │ │                                                               │   │ │
│ │ │ ☑ I understand this action is permanent                      │   │ │
│ │ │ ☑ I have downloaded my data (if needed)                      │   │ │
│ │ │                                                               │   │ │
│ │ │ [Cancel] [Delete My Account] (Destructive, Red)             │   │ │
│ │ │ (Loading state: Spinner + "Deleting account...")            │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ │                                                                     │ │
│ │ [Back to Profile] Link                                            │ │
│ └───────────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────────┘
```

**Key Features**:
- **Clear Warnings**: Prominent warning about permanent deletion
- **Data List**: What will be deleted
- **Confirmation Required**: Type "DELETE" to confirm
- **Checkboxes**: Additional confirmation steps
- **Data Retention Info**: Legal requirements explained
- **Destructive Action**: Red button to indicate danger
- **Success Redirect**: Redirects to goodbye page after deletion

### 4.6.5 Welcome Page (welcome.jsp)

**Purpose**: Personalized welcome message after registration or login.

**Layout Structure**:

```
┌─────────────────────────────────────────────────────────────────────────┐
│ [Header - Global Navigation]                                           │
├─────────────────────────────────────────────────────────────────────────┤
│ [Welcome Section - Centered Layout]                                    │
│ ┌───────────────────────────────────────────────────────────────────┐ │
│ │ Success Animation: ✓ (Animated checkmark)                        │ │
│ │                                                                     │ │
│ │ Welcome Title: "Welcome to IoTBay, [FirstName]!"                 │ │
│ │ (Display L, 36px)                                                  │ │
│ │                                                                     │ │
│ │ Welcome Message:                                                   │ │
│ │ "Your registration was successful" (if from registration)         │ │
│ │ OR                                                                 │ │
│ │ "Welcome back!" (if from login)                                   │ │
│ │                                                                     │ │
│ │ Description:                                                       │ │
│ │ "Thank you for joining IoTBay — your gateway to smarter living.   │ │
│ │  Explore our cutting-edge IoT solutions and start your connected   │ │
│ │  journey today."                                                   │ │
│ │                                                                     │ │
│ │ Quick Actions:                                                     │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ [Browse Products] (Primary)                                 │   │ │
│ │ │ [View Profile] (Secondary)                                  │   │ │
│ │ │ [Explore Categories] (Secondary)                            │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ │                                                                     │ │
│ │ Feature Highlights:                                                │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ ✓ Free shipping on orders $50+                             │   │ │
│ │ │ ✓ 2-year warranty on all products                          │   │ │
│ │ │ ✓ 24/7 technical support                                    │   │ │
│ │ │ ✓ Compatibility checking                                    │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ └───────────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────────┘
```

**Key Features**:
- **Personalized Greeting**: Uses user's first name
- **Success Animation**: Animated checkmark or success icon
- **Context-Aware Message**: Different message for registration vs login
- **Quick Actions**: Direct links to key features
- **Feature Highlights**: Trust indicators and benefits
- **Auto-redirect Option**: Optional redirect after 5 seconds

### 4.6.6 Goodbye Page (goodbye.jsp)

**Purpose**: Confirmation message after logout or account deletion.

**Layout Structure**:

```
┌─────────────────────────────────────────────────────────────────────────┐
│ [Goodbye Section - Centered Layout]                                    │
│ ┌───────────────────────────────────────────────────────────────────┐ │
│ │ Goodbye Icon: ↑ (Upward arrow or wave)                           │ │
│ │                                                                     │ │
│ │ Goodbye Title: "Thank you for visiting IoTBay!"                   │ │
│ │ (Display L, 36px)                                                  │ │
│ │                                                                     │ │
│ │ Goodbye Message:                                                   │ │
│ │ "You have successfully logged out. We hope you enjoyed your       │ │
│ │  experience exploring our IoT solutions and products."             │ │
│ │                                                                     │ │
│ │ Feature Reminders:                                                 │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ "Come back soon! We're constantly adding new products and    │   │ │
│ │ │  features to enhance your IoT experience."                  │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ │                                                                     │ │
│ │ Action Buttons:                                                    │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ [Return to Homepage] (Primary)                              │   │ │
│ │ │ [Log In Again] (Secondary)                                  │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ └───────────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────────┘
```

**Key Features**:
- **Friendly Message**: Thank you message
- **Feature Reminders**: Encouragement to return
- **Navigation Options**: Links to homepage or login
- **No Header/Footer**: Simplified layout for logout confirmation

### 4.6.7 Error Page (error.jsp)

**Purpose**: User-friendly error handling with helpful navigation options.

**Layout Structure**:

```
┌─────────────────────────────────────────────────────────────────────────┐
│ [Header - Global Navigation]                                           │
├─────────────────────────────────────────────────────────────────────────┤
│ [Error Section - Centered Layout]                                      │
│ ┌───────────────────────────────────────────────────────────────────┐ │
│ │ Error Icon: ⚠ (Large, Red/Orange)                               │ │
│ │                                                                     │ │
│ │ Error Title: "Oops! Something went wrong"                         │ │
│ │ (Display L, 36px)                                                  │ │
│ │                                                                     │ │
│ │ Error Message:                                                     │ │
│ │ "We're experiencing some technical difficulties. Don't worry,      │ │
│ │  our team has been notified and is working to fix this issue."   │ │
│ │                                                                     │ │
│ │ Error Details (Development Mode Only):                            │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ Error Code: 500                                             │   │ │
│ │ │ Error Message: Internal Server Error                       │   │ │
│ │ │ Timestamp: 2025-11-13 14:30:00                            │   │ │
│ │ │ Request ID: abc123def456                                   │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ │                                                                     │ │
│ │ Action Buttons:                                                    │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ [Return to Homepage] (Primary)                              │   │ │
│ │ │ [Go Back] (Secondary)                                        │   │ │
│ │ │ [Contact Support] (Secondary)                              │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ │                                                                     │ │
│ │ Helpful Links:                                                      │ │
│ │ • [Browse Products]                                                │ │
│ │ • [View Cart]                                                      │ │
│ │ • [My Account]                                                     │ │
│ └───────────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────────┘
```

**Key Features**:
- **User-Friendly Message**: Non-technical error description
- **Error Details**: Only shown in development mode
- **Navigation Options**: Multiple ways to recover
- **Support Contact**: Link to contact support
- **Helpful Links**: Quick access to key pages

---

## 4.7 Product Reviews & Ratings Pages

### 4.7.1 Product Reviews Section (productDetails.jsp - Reviews Tab)

**Purpose**: Display and manage product reviews with ratings and moderation.

**Layout Structure**:

```
┌─────────────────────────────────────────────────────────────────────────┐
│ [Reviews Tab Content]                                                  │
│ ┌───────────────────────────────────────────────────────────────────┐ │
│ │ Reviews Summary Section:                                          │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ Average Rating: 4.5/5.0 (Display M, Bold)                  │   │ │
│ │ │ Total Reviews: 128 reviews (Body M)                        │   │ │
│ │ │                                                             │   │ │
│ │ │ Rating Distribution:                                        │   │ │
│ │ │ 5 stars: ████████████░░░░░░░░ 85% (109 reviews)           │   │ │
│ │ │ 4 stars: ██░░░░░░░░░░░░░░░░░░ 10% (13 reviews)            │   │ │
│ │ │ 3 stars: █░░░░░░░░░░░░░░░░░░░ 3% (4 reviews)              │   │ │
│ │ │ 2 stars: ░░░░░░░░░░░░░░░░░░░░ 1% (1 review)               │   │ │
│ │ │ 1 star:  ░░░░░░░░░░░░░░░░░░░░ 1% (1 review)                │   │ │
│ │ │                                                             │   │ │
│ │ │ [Write a Review] Button (Primary)                          │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ │                                                                     │ │
│ │ Review Filters:                                                    │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ Sort by: [Most Recent ▼]                                   │   │ │
│ │ │ Filter by: [All Ratings ▼] [5 Stars] [4 Stars] ...         │   │ │
│ │ │ Show: [Verified Purchases Only ☐]                          │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ │                                                                     │ │
│ │ Review List:                                                        │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ Review 1:                                                    │   │ │
│ │ │ ┌─────────────────────────────────────────────────────────┐ │   │ │
│ │ │ │ John D. ⭐⭐⭐⭐⭐ (Verified Purchase) ✓                │   │ │
│ │ │ │ "Excellent sensor, easy integration with Home Assistant"│   │ │
│ │ │ │                                                         │   │ │
│ │ │ │ Review Date: 2 weeks ago                               │   │ │
│ │ │ │ [Helpful: 12] [Not Helpful: 2] [Reply]                │   │ │
│ │ │ │                                                         │   │ │
│ │ │ │ Staff Response (if any):                               │   │ │
│ │ │ │ "Thank you for your feedback! We're glad it worked    │   │ │
│ │ │ │  well with your setup." - IoTBay Support              │   │ │
│ │ │ └─────────────────────────────────────────────────────────┘ │   │ │
│ │ │                                                             │   │ │
│ │ │ Review 2: [Similar structure]                             │   │ │
│ │ │                                                             │   │ │
│ │ │ [Load More Reviews] Button                                 │   │ │
│ │ │ [Show All Reviews] Link                                    │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ └───────────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────────┘
```

**Key Features**:
- **Rating Summary**: Average rating and total count
- **Rating Distribution**: Visual bar chart
- **Review Filters**: Sort and filter options
- **Verified Badge**: Indicates verified purchases
- **Helpful Voting**: Users can vote on review helpfulness
- **Staff Responses**: Admin/staff can respond to reviews
- **Pagination**: Load more or show all reviews

### 4.7.2 Review Submission Form (review-form.jsp)

**Purpose**: Submit product reviews with rating and moderation.

**Layout Structure**:

```
┌─────────────────────────────────────────────────────────────────────────┐
│ [Review Form Modal/Page]                                                │
│ ┌───────────────────────────────────────────────────────────────────┐ │
│ │ Form Title: "Write a Review" (Display M, 30px)                   │ │
│ │ Product: "LoRaWAN Temperature Sensor" (Body L)                  │ │
│ │                                                                     │ │
│ │ Review Form:                                                       │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ Overall Rating: *                                           │   │ │
│ │ │ ⭐⭐⭐⭐⭐ (Click to select, 1-5 stars)                      │   │ │
│ │ │                                                             │   │ │
│ │ │ Review Title: *                                            │   │ │
│ │ │ [_____________________________]                            │   │ │
│ │ │ "Summarize your experience" (Placeholder)                  │   │ │
│ │ │                                                             │   │ │
│ │ │ Review Text: *                                             │   │ │
│ │ │ [_________________________________________________]         │   │ │
│ │ │ [_________________________________________________]         │   │ │
│ │ │ "Share your detailed experience with this product"          │   │ │
│ │ │ (Min 50 characters, max 2000 characters)                   │   │ │
│ │ │ Character count: 0/2000                                    │   │ │
│ │ │                                                             │   │ │
│ │ │ Pros (Optional):                                           │   │ │
│ │ │ [_________________________________________________]         │   │ │
│ │ │                                                             │   │ │
│ │ │ Cons (Optional):                                           │   │ │
│ │ │ [_________________________________________________]         │   │ │
│ │ │                                                             │   │ │
│ │ │ [Submit Review] Button (Primary)                           │   │ │
│ │ │ [Cancel] Link                                              │   │ │
│ │ │                                                             │   │ │
│ │ │ Note: "Your review will be visible after moderation"      │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ └───────────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────────┘
```

**Key Features**:
- **Star Rating**: Interactive star selection
- **Review Title**: Summary of experience
- **Review Text**: Detailed feedback with character limit
- **Pros/Cons**: Optional structured feedback
- **Moderation Notice**: Informs about review moderation
- **Validation**: Real-time validation and character count
- **Duplicate Prevention**: Prevents multiple reviews per product

---

## 4.8 Order Management & Tracking Pages

### 4.8.1 Order History Page (orderList.jsp)

**Purpose**: Display user's order history with filtering and detailed order information.

**Layout Structure**:

```
┌─────────────────────────────────────────────────────────────────────────┐
│ [Header - Global Navigation]                                           │
├─────────────────────────────────────────────────────────────────────────┤
│ [Order History Page]                                                   │
│ ┌───────────────────────────────────────────────────────────────────┐ │
│ │ Page Title: "Order History" (Display L, 36px)                    │ │
│ │ Subtitle: "View and track your past orders"                       │ │
│ │                                                                     │ │
│ │ Filter Section:                                                    │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ Filter by Status: [All Orders ▼]                           │   │ │
│ │ │ Filter by Date: [All Time ▼] [Last 30 Days] [Last 90 Days]│   │ │
│ │ │ Search: [Search by order number...] [🔍]                   │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ │                                                                     │ │
│ │ Order List:                                                         │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ Order #ORD-2025-001234                                      │   │ │
│ │ │ ┌─────────────────────────────────────────────────────────┐ │   │ │
│ │ │ │ Order Date: November 10, 2025                           │   │ │
│ │ │ │ Status: [Shipped] (Status badge with color)             │   │ │
│ │ │ │ Total: $674.97                                           │   │ │
│ │ │ │                                                          │   │ │
│ │ │ │ Items:                                                   │   │ │
│ │ │ │ • LoRaWAN Temperature Sensor x2 ($399.98)              │   │ │
│ │ │ │ • WiFi Gateway x1 ($199.99)                            │   │ │
│ │ │ │                                                          │   │ │
│ │ │ │ Tracking: TRACK-123456789                               │   │ │
│ │ │ │ Estimated Delivery: November 15, 2025                   │   │ │
│ │ │ │                                                          │   │ │
│ │ │ │ Actions:                                                 │   │ │
│ │ │ │ [View Details] [Track Order] [Reorder] [Download Invoice]│   │ │
│ │ │ └─────────────────────────────────────────────────────────┘ │   │ │
│ │ │                                                             │   │ │
│ │ │ Order #ORD-2025-001235 [Similar structure]                 │   │ │
│ │ │                                                             │   │ │
│ │ │ [Load More Orders] Button                                  │   │ │
│ │ │ [Pagination: 1 2 3 ... 10]                                 │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ │                                                                     │ │
│ │ Empty State (if no orders):                                        │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ Empty Cart Icon                                             │   │ │
│ │ │ "You haven't placed any orders yet"                         │   │ │
│ │ │ [Browse Products] Button                                    │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ └───────────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────────┘
```

**Key Features**:
- **Order Filtering**: Filter by status and date range
- **Order Search**: Search by order number
- **Status Badges**: Color-coded order status indicators
- **Order Summary**: Quick view of order items and total
- **Tracking Information**: Tracking number and delivery estimate
- **Order Actions**: View details, track, reorder, download invoice
- **Pagination**: For users with many orders

**Interactive Elements**:
- Filter dropdowns
- Search functionality
- Order detail expansion
- Tracking link
- Reorder button
- Invoice download

### 4.8.2 Order Details Page

**Purpose**: Comprehensive order information with timeline and tracking.

**Layout Structure**:

```
┌─────────────────────────────────────────────────────────────────────────┐
│ [Header - Global Navigation]                                           │
├─────────────────────────────────────────────────────────────────────────┤
│ [Order Details Page]                                                    │
│ ┌───────────────────────────────────────────────────────────────────┐ │
│ │ Breadcrumb: Home > Order History > Order #ORD-2025-001234        │ │
│ │                                                                     │ │
│ │ Order Header:                                                       │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ Order Number: ORD-2025-001234 (Display M, Bold)            │   │ │
│ │ │ Order Date: November 10, 2025 at 2:30 PM                   │   │ │
│ │ │ Status: [Shipped] (Status badge)                            │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ │                                                                     │ │
│ │ Order Timeline:                                                      │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ Order Timeline (Visual stepper):                            │   │ │
│ │ │ [✓] Order Placed (Nov 10, 2:30 PM)                        │   │ │
│ │ │ [✓] Payment Confirmed (Nov 10, 2:31 PM)                   │   │ │
│ │ │ [✓] Processing (Nov 11, 9:00 AM)                           │   │ │
│ │ │ [✓] Shipped (Nov 12, 3:00 PM)                              │   │ │
│ │ │ [ ] Out for Delivery (Nov 15, 8:00 AM)                    │   │ │
│ │ │ [ ] Delivered (Estimated: Nov 15)                          │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ │                                                                     │ │
│ │ Two Column Layout:                                                  │ │
│ │ ┌──────────────────────────────┐ ┌──────────────────────────────┐ │
│ │ │ [Order Items Section]        │ │ [Order Information Sidebar]  │ │
│ │ │ ┌──────────────────────────┐ │ │ ┌──────────────────────────┐ │ │
│ │ │ │ Order Items:             │ │ │ │ Shipping Address:        │ │ │
│ │ │ │ ┌──────────────────────┐ │ │ │ │ John Doe                │ │ │
│ │ │ │ │ Product Image        │ │ │ │ │ 123 Main St             │ │ │
│ │ │ │ │ LoRaWAN Temp Sensor  │ │ │ │ │ New York, NY 10001      │ │ │
│ │ │ │ │ Quantity: 2          │ │ │ │ │                         │ │ │
│ │ │ │ │ Unit Price: $199.99   │ │ │ │ │ Billing Address:        │ │ │
│ │ │ │ │ Subtotal: $399.98     │ │ │ │ │ [Same as shipping]      │ │ │
│ │ │ │ │ [View Product]        │ │ │ │ │                         │ │ │
│ │ │ │ └──────────────────────┘ │ │ │ │ Payment Method:          │ │ │
│ │ │ │                          │ │ │ │ Visa •••• 4242          │ │ │
│ │ │ │ [Similar for other items]│ │ │ │                         │ │ │
│ │ │ │                          │ │ │ │ Order Summary:          │ │ │
│ │ │ │                          │ │ │ │ Subtotal: $599.97       │ │ │
│ │ │ │                          │ │ │ │ Shipping: $15.00        │ │ │
│ │ │ │                          │ │ │ │ Tax: $60.00             │ │ │
│ │ │ │                          │ │ │ │ ────────────────────    │ │ │
│ │ │ │                          │ │ │ │ Total: $674.97          │ │ │
│ │ │ │                          │ │ │ │                         │ │ │
│ │ │ │                          │ │ │ │ Tracking:               │ │ │
│ │ │ │                          │ │ │ │ TRACK-123456789         │ │ │
│ │ │ │                          │ │ │ │ [Track Package]         │ │ │
│ │ │ │                          │ │ │ │                         │ │ │
│ │ │ │                          │ │ │ │ [Download Invoice]      │ │ │
│ │ │ │                          │ │ │ │ [Reorder Items]         │ │ │
│ │ │ │                          │ │ │ └──────────────────────────┘ │ │
│ │ │ └──────────────────────────┘ │ └──────────────────────────────┘ │
│ │ └──────────────────────────────┘                                   │ │
│ └───────────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────────┘
```

**Key Features**:
- **Order Timeline**: Visual progress indicator
- **Order Items**: Detailed product information
- **Shipping/Billing Address**: Complete address information
- **Payment Information**: Payment method details
- **Order Summary**: Complete cost breakdown
- **Tracking Integration**: Direct link to tracking
- **Invoice Download**: PDF invoice generation
- **Reorder Functionality**: Quick reorder option

### 4.8.3 Shipment Tracking Page

**Purpose**: Track shipment status and delivery information.

**Layout Structure**:

```
┌─────────────────────────────────────────────────────────────────────────┐
│ [Header - Global Navigation]                                           │
├─────────────────────────────────────────────────────────────────────────┤
│ [Shipment Tracking Page]                                               │
│ ┌───────────────────────────────────────────────────────────────────┐ │
│ │ Page Title: "Track Your Shipment" (Display L, 36px)              │ │
│ │                                                                     │ │
│ │ Tracking Search:                                                   │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ Enter Tracking Number:                                       │   │ │
│ │ │ [TRACK-123456789________________] [Track]                     │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ │                                                                     │ │
│ │ Tracking Information:                                              │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ Tracking Number: TRACK-123456789                             │   │ │
│ │ │ Order Number: ORD-2025-001234                                │   │ │
│ │ │ Carrier: FedEx                                               │   │ │
│ │ │                                                               │   │ │
│ │ │ Current Status: Out for Delivery                             │   │ │
│ │ │ Estimated Delivery: November 15, 2025 by 8:00 PM            │   │ │
│ │ │                                                               │   │ │
│ │ │ Tracking Timeline:                                           │   │ │
│ │ │ ┌─────────────────────────────────────────────────────────┐ │   │ │
│ │ │ │ [✓] Label Created                                       │ │   │ │
│ │ │ │     Nov 12, 2025 3:00 PM                               │ │   │ │
│ │ │ │     Origin: Sydney, Australia                          │ │   │ │
│ │ │ │                                                         │ │   │ │
│ │ │ │ [✓] In Transit                                          │ │   │ │
│ │ │ │     Nov 13, 2025 10:00 AM                              │ │   │ │
│ │ │ │     Location: Melbourne, Australia                    │ │   │ │
│ │ │ │                                                         │   │ │
│ │ │ │ [✓] Out for Delivery                                    │ │   │ │
│ │ │ │     Nov 15, 2025 8:00 AM                               │ │   │ │
│ │ │ │     Location: Sydney, Australia                        │ │   │ │
│ │ │ │                                                         │   │ │
│ │ │ │ [ ] Delivered                                           │ │   │ │
│ │ │ │     Estimated: Nov 15, 2025 by 8:00 PM                │ │   │ │
│ │ │ └─────────────────────────────────────────────────────────┘ │   │ │
│ │ │                                                               │   │ │
│ │ │ Shipment Details:                                            │   │ │
│ │ │ • Weight: 2.5 kg                                             │   │ │
│ │ │ • Dimensions: 30 x 20 x 15 cm                              │   │ │
│ │ │ • Service: Standard Shipping                               │   │ │
│ │ │                                                               │   │ │
│ │ │ [View Order Details] [Contact Carrier]                     │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ └───────────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────────┘
```

**Key Features**:
- **Tracking Search**: Enter tracking number to track
- **Status Display**: Current shipment status
- **Timeline**: Visual tracking history
- **Delivery Estimate**: Expected delivery date and time
- **Location Updates**: Current and past locations
- **Carrier Information**: Shipping carrier details
- **Order Link**: Link back to order details

---

## 4.9 Administrative Pages

### 4.9.1 Admin Dashboard (admin-dashboard.jsp)

**Purpose**: Central hub for administrative functions with statistics and quick access.

**Layout Structure**:

```
┌─────────────────────────────────────────────────────────────────────────┐
│ [Header - Admin Navigation]                                            │
├─────────────────────────────────────────────────────────────────────────┤
│ [Admin Dashboard]                                                       │
│ ┌───────────────────────────────────────────────────────────────────┐ │
│ │ Page Title: "Admin Dashboard" (Display L, 36px)                    │ │
│ │ Welcome: "Welcome back, [Admin Name]"                              │ │
│ │                                                                     │ │
│ │ Statistics Cards (Grid Layout):                                     │ │
│ │ ┌──────────────┐ ┌──────────────┐ ┌──────────────┐ ┌────────────┐│
│ │ │ Total Users │ │ Total Orders │ │ Total Revenue│ │ Total      ││
│ │ │              │ │              │ │              │ │ Products   ││
│ │ │ 1,234        │ │ 5,678        │ │ $125,678     │ │ 456        ││
│ │ │ +12% this    │ │ +8% this     │ │ +15% this    │ │ +5% this   ││
│ │ │ month        │ │ month        │ │ month        │ │ month      ││
│ │ │ [View Users] │ │ [View Orders]│ │ [View Report]│ │ [View      ││
│ │ │              │ │              │ │              │ │ Products]  ││
│ │ └──────────────┘ └──────────────┘ └──────────────┘ └────────────┘│
│ │                                                                     │ │
│ │ Quick Actions:                                                      │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ [Manage Users] [Manage Products] [Manage Orders]            │   │ │
│ │ │ [View Access Logs] [Generate Reports] [Data Export]        │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ │                                                                     │ │
│ │ Recent Activity:                                                    │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ Activity Feed:                                               │   │ │
│ │ │ • New order #ORD-2025-001234 placed (2 hours ago)           │   │ │
│ │ │ • User john.doe@email.com registered (3 hours ago)          │   │ │
│ │ │ • Product "LoRaWAN Sensor" stock updated (4 hours ago)      │   │ │
│ │ │ • Review submitted for "WiFi Gateway" (5 hours ago)        │   │ │
│ │ │ [View All Activity]                                         │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ │                                                                     │ │
│ │ System Health:                                                      │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ Database: ✓ Healthy                                         │   │ │
│ │ │ Server: ✓ Running                                           │   │ │
│ │ │ Storage: 75% used                                           │   │ │
│ │ │ Last Backup: 2 hours ago                                    │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ └───────────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────────┘
```

**Key Features**:
- **Statistics Overview**: Key metrics at a glance
- **Quick Actions**: Direct links to management pages
- **Recent Activity**: Real-time activity feed
- **System Health**: System status indicators
- **Trend Indicators**: Percentage changes for metrics

### 4.9.2 User Management Page (WEB-INF/views/manage-users.jsp)

**Purpose**: Admin interface for managing user accounts.

**Layout Structure**:

```
┌─────────────────────────────────────────────────────────────────────────┐
│ [Header - Admin Navigation]                                            │
├─────────────────────────────────────────────────────────────────────────┤
│ [User Management Page]                                                  │
│ ┌───────────────────────────────────────────────────────────────────┐ │
│ │ Page Title: "User Management" (Display L, 36px)                    │ │
│ │                                                                     │ │
│ │ Action Bar:                                                         │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ Search: [Search users...] [🔍]                              │   │ │
│ │ │ Filter: [All Roles ▼] [All Status ▼]                        │   │ │
│ │ │ [Add New User] Button                                        │   │ │
│ │ │ [Export Users] Button                                        │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ │                                                                     │ │
│ │ User Table:                                                         │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ ┌──────┬─────────────┬──────────┬────────┬─────────┬──────┐ │   │ │
│ │ │ │ Name │ Email       │ Role     │ Status │ Joined  │Actions│ │   │ │
│ │ │ ├──────┼─────────────┼──────────┼────────┼─────────┼──────┤ │   │ │
│ │ │ │John D│john@email...│Customer  │Active  │Nov 1    │[View]│ │   │ │
│ │ │ │      │             │          │        │         │[Edit]│ │   │ │
│ │ │ │      │             │          │        │         │[Delete]│ │   │ │
│ │ │ ├──────┼─────────────┼──────────┼────────┼─────────┼──────┤ │   │ │
│ │ │ │Jane S│jane@email...│Staff     │Active  │Oct 15   │[View]│ │   │ │
│ │ │ │      │             │          │        │         │[Edit]│ │   │ │
│ │ │ │      │             │          │        │         │[Delete]│ │   │ │
│ │ │ └──────┴─────────────┴──────────┴────────┴─────────┴──────┘ │   │ │
│ │ │                                                                 │   │ │
│ │ │ [Pagination: 1 2 3 ... 10]                                     │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ └───────────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────────┘
```

**Key Features**:
- **User Search**: Search by name, email, or ID
- **Role Filtering**: Filter by Customer, Staff, Admin
- **Status Filtering**: Filter by Active/Inactive
- **Bulk Actions**: Select multiple users for bulk operations
- **User Actions**: View, Edit, Delete, Change Role
- **Export Functionality**: Export user list to CSV
- **Pagination**: For large user lists

### 4.9.3 Product Management Page (WEB-INF/views/manage-products.jsp)

**Purpose**: Admin interface for managing product catalog.

**Layout Structure**:

```
┌─────────────────────────────────────────────────────────────────────────┐
│ [Header - Admin Navigation]                                            │
├─────────────────────────────────────────────────────────────────────────┤
│ [Product Management Page]                                               │
│ ┌───────────────────────────────────────────────────────────────────┐ │
│ │ Page Title: "Product Management" (Display L, 36px)                 │ │
│ │                                                                     │ │
│ │ Action Bar:                                                         │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ Search: [Search products...] [🔍]                            │   │ │
│ │ │ Filter: [All Categories ▼] [All Status ▼]                   │   │ │
│ │ │ [Add New Product] Button                                      │   │ │
│ │ │ [Bulk Edit] [Bulk Delete] [Export Products]                   │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ │                                                                     │ │
│ │ Product Grid/Table:                                                 │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ Product Cards or Table with:                                │   │ │
│ │ │ • Product Image                                             │   │ │
│ │ │ • Product Name                                              │   │ │
│ │ │ • Category                                                  │   │ │
│ │ │ • Price                                                     │   │ │
│ │ │ • Stock Quantity                                            │   │ │
│ │ │ • Status (Active/Inactive)                                  │   │ │
│ │ │ • Actions: [Edit] [Delete] [View]                           │   │ │
│ │ │                                                             │   │ │
│ │ │ [Pagination]                                                 │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ └───────────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────────┘
```

**Key Features**:
- **Product Search**: Search by name, SKU, or category
- **Category Filtering**: Filter by product category
- **Stock Management**: Quick stock updates
- **Bulk Operations**: Edit or delete multiple products
- **Product Actions**: Edit, Delete, View, Duplicate
- **Export Functionality**: Export product catalog to CSV
- **Quick Edit**: Inline editing for price and stock

### 4.9.4 Access Log Management Page (WEB-INF/views/manage-access-logs.jsp)

**Purpose**: View and manage system access logs for security auditing.

**Layout Structure**:

```
┌─────────────────────────────────────────────────────────────────────────┐
│ [Header - Admin Navigation]                                            │
├─────────────────────────────────────────────────────────────────────────┤
│ [Access Log Management Page]                                            │
│ ┌───────────────────────────────────────────────────────────────────┐ │
│ │ Page Title: "Access Logs" (Display L, 36px)                       │ │
│ │                                                                     │ │
│ │ Filter Section:                                                     │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ Filter by User: [All Users ▼]                               │   │ │
│ │ │ Filter by Action: [All Actions ▼]                           │   │ │
│ │ │ Date Range: [From: ___] [To: ___]                          │   │ │
│ │ │ Filter by IP: [________________]                            │   │ │
│ │ │ [Apply Filters] [Clear Filters]                             │   │ │
│ │ │ [Export Logs] Button                                        │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ │                                                                     │ │
│ │ Log Table:                                                          │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ ┌──────┬─────────────┬──────────┬────────────┬──────────┐ │   │ │
│ │ │ │User  │ Action      │ Timestamp│ IP Address │ User Agent│ │   │ │
│ │ │ ├──────┼─────────────┼──────────┼────────────┼──────────┤ │   │ │
│ │ │ │John D│ Login       │ Nov 13   │ 192.168.1.1│ Chrome   │ │   │ │
│ │ │ │      │             │ 14:30    │            │          │ │   │ │
│ │ │ ├──────┼─────────────┼──────────┼────────────┼──────────┤ │   │ │
│ │ │ │Jane S│ View Product│ Nov 13   │ 192.168.1.2│ Firefox  │ │   │ │
│ │ │ │      │             │ 14:25    │            │          │ │   │ │
│ │ │ └──────┴─────────────┴──────────┴────────────┴──────────┘ │   │ │
│ │ │                                                             │   │ │
│ │ │ [Pagination]                                                 │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ └───────────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────────┘
```

**Key Features**:
- **Advanced Filtering**: Filter by user, action, date, IP
- **Log Details**: Complete access log information
- **Export Functionality**: Export logs to CSV
- **Security Monitoring**: Track suspicious activities
- **Pagination**: For large log files
- **Search**: Search within logs

### 4.9.5 Data Management & Export Page (data-management.jsp)

**Purpose**: Admin interface for data export and management operations.

**Layout Structure**:

```
┌─────────────────────────────────────────────────────────────────────────┐
│ [Header - Admin Navigation]                                            │
├─────────────────────────────────────────────────────────────────────────┤
│ [Data Management Page]                                                  │
│ ┌───────────────────────────────────────────────────────────────────┐ │
│ │ Page Title: "Data Management" (Display L, 36px)                    │ │
│ │                                                                     │ │
│ │ Statistics Overview:                                               │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ Total Users: 1,234                                           │   │ │
│ │ │ Total Orders: 5,678                                          │   │ │
│ │ │ Total Products: 456                                          │   │ │
│ │ │ Total Access Logs: 12,345                                    │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ │                                                                     │ │
│ │ Export Options:                                                     │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ Export Section:                                             │   │ │
│ │ │ ┌─────────────────────────────────────────────────────────┐ │   │ │
│ │ │ │ Export Users                                             │   │ │
│ │ │ │ "Export all user accounts to CSV"                        │   │ │
│ │ │ │ [Export Users] Button                                     │   │ │
│ │ │ │                                                          │   │ │
│ │ │ │ Export Orders                                            │   │ │
│ │ │ │ "Export all orders to CSV"                               │   │ │
│ │ │ │ Date Range: [From: ___] [To: ___]                       │   │ │
│ │ │ │ [Export Orders] Button                                    │   │ │
│ │ │ │                                                          │   │ │
│ │ │ │ Export Products                                          │   │ │
│ │ │ │ "Export product catalog to CSV"                          │   │ │
│ │ │ │ [Export Products] Button                                 │   │ │
│ │ │ │                                                          │   │ │
│ │ │ │ Export Access Logs                                        │   │ │
│ │ │ │ "Export access logs to CSV"                              │   │ │
│ │ │ │ Date Range: [From: ___] [To: ___]                       │   │ │
│ │ │ │ [Export Access Logs] Button                              │   │ │
│ │ │ └─────────────────────────────────────────────────────────┘ │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ │                                                                     │ │
│ │ Data Import (Future):                                               │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ Import Section:                                             │   │ │
│ │ │ [Import Products from CSV] [Import Users from CSV]         │   │ │
│ │ │ (Coming soon)                                               │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ └───────────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────────┘
```

**Key Features**:
- **Statistics Overview**: Data counts at a glance
- **CSV Export**: Export users, orders, products, access logs
- **Date Range Selection**: Filter exports by date range
- **Download Links**: Direct download of exported files
- **Future Import**: Placeholder for data import functionality

---

## 4.10 Static Pages

### 4.10.1 About Page (about.jsp)

**Purpose**: Company information, mission, vision, and team details.

**Layout Structure**:

```
┌─────────────────────────────────────────────────────────────────────────┐
│ [Header - Global Navigation]                                           │
├─────────────────────────────────────────────────────────────────────────┤
│ [About Page]                                                            │
│ ┌───────────────────────────────────────────────────────────────────┐ │
│ │ Hero Section:                                                       │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ Background: Gradient                                         │   │ │
│ │ │ Title: "About IoTBay" (Display XL, 48px)                     │   │ │
│ │ │ Subtitle: "Building the Future of Connected Living"          │   │ │
│ │ │ [Our Story] [Meet the Team] Buttons                          │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ │                                                                     │ │
│ │ Our Story Section:                                                  │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ Section Title: "Our Story" (Display L, 36px)                │   │ │
│ │ │ Content: Company history and mission                         │   │ │
│ │ │ Image: Company photo or illustration                        │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ │                                                                     │ │
│ │ Mission & Vision:                                                   │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ Mission: "To provide the best IoT solutions..."               │   │ │
│ │ │ Vision: "A world where IoT technology..."                    │   │ │
│ │ │ Values: Innovation, Quality, Trust, Customer Focus            │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ │                                                                     │ │
│ │ Team Section:                                                        │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ Section Title: "Meet the Team"                              │   │ │
│ │ │ Team Member Cards (Grid):                                   │   │ │
│ │ │ ┌──────┐ ┌──────┐ ┌──────┐                                 │   │ │
│ │ │ │Member│ │Member│ │Member│                                 │   │ │
│ │ │ │  1   │ │  2   │ │  3   │                                 │   │ │
│ │ │ └──────┘ └──────┘ └──────┘                                 │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ │                                                                     │ │
│ │ Contact Section:                                                    │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ [Contact Us] Button                                           │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ └───────────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────────┘
```

**Key Features**:
- **Hero Section**: Engaging introduction
- **Company Story**: History and background
- **Mission & Vision**: Company values and goals
- **Team Information**: Team member profiles
- **Contact Link**: Link to contact page

### 4.10.2 Contact Page (contact.jsp)

**Purpose**: Contact form and company contact information.

**Layout Structure**:

```
┌─────────────────────────────────────────────────────────────────────────┐
│ [Header - Global Navigation]                                           │
├─────────────────────────────────────────────────────────────────────────┤
│ [Contact Page]                                                          │
│ ┌───────────────────────────────────────────────────────────────────┐ │
│ │ Hero Section:                                                       │ │
│ │ ┌─────────────────────────────────────────────────────────────┐   │ │
│ │ │ Title: "Get in Touch" (Display L, 36px)                     │   │ │
│ │ │ Subtitle: "Have questions? Our team is here to help"        │   │ │
│ │ └─────────────────────────────────────────────────────────────┘   │ │
│ │                                                                     │ │
│ │ Two Column Layout:                                                  │ │
│ │ ┌──────────────────────────────┐ ┌──────────────────────────────┐ │
│ │ │ [Contact Form]               │ │ [Contact Information]        │ │
│ │ │ ┌──────────────────────────┐ │ │ ┌────────────────────────┐ │ │
│ │ │ │ Name: *                   │ │ │ │ Office Address:        │ │ │
│ │ │ │ [________________]        │ │ │ │ 123 Tech Street        │ │ │
│ │ │ │                          │ │ │ │ Sydney, NSW 2000        │ │ │
│ │ │ │ Email: *                 │ │ │ │ Australia              │ │ │
│ │ │ │ [________________]        │ │ │ │                        │ │ │
│ │ │ │                          │ │ │ │ Phone:                 │ │ │
│ │ │ │ Subject: *               │ │ │ │ +61 2 1234 5678        │ │ │
│ │ │ │ [________________]        │ │ │ │                        │ │ │
│ │ │ │                          │ │ │ │ Email:                 │ │ │
│ │ │ │ Message: *               │ │ │ │ support@iotbay.com     │ │ │
│ │ │ │ [________________]        │ │ │ │                        │ │ │
│ │ │ │ [________________]        │ │ │ │ Business Hours:        │ │ │
│ │ │ │                          │ │ │ │ Mon-Fri: 9AM-5PM       │ │ │
│ │ │ │ [Send Message] Button    │ │ │ │ Sat: 10AM-2PM         │ │ │
│ │ │ └──────────────────────────┘ │ │ └────────────────────────┘ │ │
│ │ └──────────────────────────────┘ └──────────────────────────────┘ │
│ └───────────────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────────┘
```

**Key Features**:
- **Contact Form**: Name, email, subject, message
- **Form Validation**: Real-time validation
- **Contact Information**: Office address, phone, email, hours
- **Success Message**: Confirmation after form submission
- **Error Handling**: Clear error messages

---

## 8. Responsive Design

### 8.1 Breakpoints

- **Mobile**: 320px - 639px
- **Tablet**: 640px - 1023px
- **Desktop**: 1024px - 1439px
- **Large Desktop**: 1440px+

### 8.2 Mobile-First Approach

#### Mobile Optimizations
- **Touch Targets**: Minimum 44x44px
- **Simplified Navigation**: Hamburger menu
- **Stacked Layouts**: Single column
- **Optimized Images**: Responsive srcset
- **Simplified Forms**: Larger inputs, fewer fields per screen

#### Tablet Optimizations
- **Two-Column Layouts**: Where appropriate
- **Sidebar Filters**: Collapsible
- **Product Grid**: 2-3 columns

#### Desktop Optimizations
- **Multi-Column Layouts**: Full use of space
- **Persistent Sidebars**: Always visible filters
- **Product Grid**: 4 columns
- **Hover States**: Enhanced interactions

---

## 9. Usability Testing Plan

### 9.1 Testing Objectives

1. **Task Completion Rate**: Measure success rate for key user flows
2. **Time to Complete Tasks**: Efficiency measurement
3. **Error Rate**: Frequency of user errors
4. **User Satisfaction**: Post-task questionnaires
5. **Accessibility Compliance**: Automated and manual testing

### 9.2 Test Scenarios

#### Scenario 1: Product Discovery
**Task**: Find a LoRaWAN temperature sensor for industrial use
**Success Criteria**: 
- Task completed in < 2 minutes
- Correct product selected
- Technical specifications verified

#### Scenario 2: Product Comparison
**Task**: Compare 3 similar products side-by-side
**Success Criteria**:
- Comparison tool discovered
- All 3 products added to comparison
- Key differences identified

#### Scenario 3: Checkout Process
**Task**: Complete purchase of 2 products
**Success Criteria**:
- Cart items correct
- Compatibility warnings noticed
- Checkout completed successfully
- Order confirmation received

### 9.3 Testing Methods

- **Moderated Usability Testing**: 8-10 participants per persona
- **A/B Testing**: Key interaction patterns
- **Accessibility Audit**: Automated tools + manual testing
- **Performance Testing**: Load times, interaction responsiveness

---

## 10. Success Metrics

### 10.1 User Experience Metrics

- **Task Completion Rate**: Target 95%+ for key flows
- **Time to Find Product**: Reduce by 30% from baseline
- **Error Rate**: Reduce form errors by 50%
- **User Satisfaction Score**: Target 4.5/5.0
- **Accessibility Score**: 100/100 on Lighthouse

### 10.2 Business Metrics

- **Cart Abandonment Rate**: Reduce by 20%
- **Average Order Value**: Increase by 15%
- **Conversion Rate**: Increase by 25%
- **Customer Support Tickets**: Reduce by 30%

### 10.3 Technical Metrics

- **Page Load Time**: < 2s for First Contentful Paint
- **Time to Interactive**: < 3.5s
- **Cumulative Layout Shift (CLS)**: < 0.1
- **Largest Contentful Paint (LCP)**: < 2.5s

---

## 11. Design Rationale

### 11.1 Why This Design Works for IoT Engineers

1. **Technical Depth First**: Specifications are prominent, not hidden
2. **Progressive Disclosure**: Complex information doesn't overwhelm
3. **Trust Signals**: Certifications and compatibility clearly visible
4. **Efficiency**: Quick access to critical information
5. **Precision**: Error prevention through compatibility checking

### 11.2 Design Decisions Explained

#### Why Accordion for Technical Specs?
- Reduces cognitive load
- Allows users to focus on relevant information
- Maintains page performance
- Improves mobile experience

#### Why Comparison Tool Limited to 3-4 Products?
- Cognitive load research shows 3-4 items optimal
- Prevents decision paralysis
- Maintains performance
- Focuses user attention

#### Why Skeleton Loading Instead of Spinners?
- Provides context about content structure
- Reduces perceived wait time
- Maintains visual hierarchy
- Better user experience

---

## 12. Implementation Guidelines

### 12.1 Design System Usage

- **Consistent Components**: Use design system components, don't create custom ones
- **Design Tokens**: Use CSS custom properties, not hardcoded values
- **Responsive Patterns**: Follow established breakpoint patterns
- **Accessibility**: Always include ARIA attributes and keyboard support

### 12.2 Content Guidelines

- **Technical Writing**: Clear, concise, jargon-appropriate for audience
- **Error Messages**: Helpful, actionable, not technical
- **Labels**: Descriptive, not ambiguous
- **Help Text**: Contextual, not overwhelming

### 12.3 Quality Assurance

- **Design Review**: All designs reviewed against this specification
- **Accessibility Audit**: Automated and manual testing
- **Browser Testing**: Chrome, Firefox, Safari, Edge
- **Device Testing**: Mobile, tablet, desktop
- **User Testing**: Regular usability testing with target personas

---

## 13. Future Enhancements

### 13.1 Phase 2 Features

- **Product Comparison Tool**: Side-by-side technical comparison
- **Use Case Wizard**: Interactive product recommendation
- **Technical Review System**: Verified engineer reviews
- **Performance Metrics Visualization**: Real-world product data
- **Voice Search**: Web Speech API integration

### 13.2 Advanced Features

- **AR Product Preview**: 3D product visualization
- **AI-Powered Recommendations**: Machine learning suggestions
- **Collaborative Shopping**: Team purchase workflows
- **Integration Testing Tools**: Compatibility verification

---

## 14. References & Resources

### 14.1 Design Principles

- **Nielsen's Usability Heuristics**: Applied throughout design
- **WCAG 2.1 Guidelines**: Accessibility compliance
- **Material Design**: Interaction patterns
- **Human Interface Guidelines**: iOS/mobile patterns

### 14.2 Research Sources

- **IoT Market Research**: Industry trends and user needs
- **E-commerce Best Practices**: Conversion optimization
- **Accessibility Studies**: User needs and patterns
- **Performance Research**: Web vitals and optimization

---

## Appendix A: Persona Scenarios

### Scenario: Alex (IoT Engineer) - Industrial Sensor Purchase

**Context**: Alex needs to purchase temperature sensors for a new industrial automation project. The sensors must work with existing LoRaWAN infrastructure and operate in harsh environments.

**Journey**:
1. Searches "LoRaWAN temperature sensor industrial"
2. Filters by: Protocol=LoRaWAN, Voltage=12V, Range=-40°C to 85°C
3. Reviews 5 products in comparison tool
4. Selects product based on compatibility matrix
5. Adds to cart, sees compatibility warning (checks other items)
6. Completes checkout with business email
7. Downloads integration guide immediately after purchase

**Success**: Product meets all technical requirements, integration is straightforward, project proceeds on schedule.

---

## Appendix B: Design Checklist

### Pre-Development Checklist
- [ ] Persona alignment verified
- [ ] User journey mapped
- [ ] Information architecture defined
- [ ] Wireframes approved
- [ ] Design system components ready
- [ ] Accessibility requirements documented
- [ ] Responsive breakpoints defined

### Pre-Launch Checklist
- [ ] WCAG 2.1 AA compliance verified
- [ ] Keyboard navigation tested
- [ ] Screen reader tested
- [ ] Cross-browser tested
- [ ] Performance benchmarks met
- [ ] Usability testing completed
- [ ] Error states designed
- [ ] Loading states implemented

---

---

## 15. API Endpoints & Integration

### 15.1 RESTful API Design

**Purpose**: Programmatic access to IoTBay functionality for integration and automation.

#### Authentication API
- **POST `/api/auth/register`**: User registration
  - Request: User registration data (JSON)
  - Response: User object with session token
  - Error Handling: Validation errors, duplicate email

- **POST `/api/login`**: User authentication
  - Request: Email and password (JSON)
  - Response: User object with session token
  - Error Handling: Invalid credentials

- **GET `/api/me`**: Get current user information
  - Response: Current user profile (JSON)
  - Authentication: Required

#### Product API
- **GET `/api/v1/products`**: List all products
  - Query Parameters: `category`, `search`, `page`, `limit`
  - Response: Product list with pagination (JSON)
  
- **GET `/api/v1/products/{id}`**: Get product details
  - Response: Complete product information (JSON)
  
- **POST `/api/v1/products`**: Create product (Admin/Staff)
  - Request: Product data (JSON)
  - Response: Created product (JSON)
  
- **PUT `/api/v1/products/{id}`**: Update product (Admin/Staff)
  - Request: Updated product data (JSON)
  - Response: Updated product (JSON)
  
- **DELETE `/api/v1/products/{id}`**: Delete product (Admin/Staff)
  - Response: Success confirmation (JSON)

#### Cart API
- **GET `/api/cart`**: Get cart data
  - Response: Cart items and total (JSON)
  
- **POST `/api/cart/add`**: Add item to cart
  - Request: Product ID and quantity (JSON)
  - Response: Updated cart (JSON)
  
- **PUT `/api/cart/update`**: Update cart item quantity
  - Request: Cart item ID and new quantity (JSON)
  - Response: Updated cart (JSON)
  
- **DELETE `/api/cart/remove`**: Remove item from cart
  - Request: Cart item ID (JSON)
  - Response: Updated cart (JSON)
  
- **DELETE `/api/cart/clear`**: Clear entire cart
  - Response: Empty cart confirmation (JSON)

#### Payment API
- **GET `/api/payment/{id}`**: Get payment details
  - Response: Payment information (JSON)
  
- **GET `/api/payment/user/{userId}`**: Get user payments
  - Response: Payment list (JSON)
  
- **GET `/api/payment/search`**: Search payments
  - Query Parameters: `userId`, `dateFrom`, `dateTo`, `status`
  - Response: Filtered payment list (JSON)

#### Shipment API
- **GET `/shipment/{id}`**: Get shipment details
  - Response: Shipment information with tracking (JSON)
  
- **GET `/shipment/tracking/{trackingNumber}`**: Track by tracking number
  - Response: Tracking information (JSON)
  
- **GET `/shipment/search`**: Search shipments
  - Query Parameters: `userId`, `dateFrom`, `dateTo`, `status`
  - Response: Filtered shipment list (JSON)

#### Review API
- **GET `/review`**: List all reviews
  - Query Parameters: `productId`, `userId`, `verified`
  - Response: Review list (JSON)
  
- **GET `/review/product/{productId}`**: Get product reviews
  - Response: Product reviews with average rating (JSON)
  
- **GET `/review/user/{userId}`**: Get user reviews
  - Response: User's review list (JSON)
  
- **GET `/review/view/{reviewId}`**: Get review details
  - Response: Complete review information (JSON)
  
- **POST `/review/create`**: Create review
  - Request: Review data (JSON)
  - Response: Created review (JSON)
  
- **POST `/review/update`**: Update review
  - Request: Updated review data (JSON)
  - Response: Updated review (JSON)
  
- **POST `/review/delete`**: Delete review
  - Request: Review ID (JSON)
  - Response: Success confirmation (JSON)

#### Access Log API
- **GET `/api/accessLog`**: Get access logs
  - Query Parameters: `userId`, `action`, `dateFrom`, `dateTo`, `ipAddress`
  - Response: Access log list (JSON)
  
- **GET `/api/accessLog/user/{userId}`**: Get user access logs
  - Response: User's access log list (JSON)
  
- **GET `/api/accessLog/search`**: Search access logs
  - Query Parameters: Various filters
  - Response: Filtered access log list (JSON)

#### Data Management API
- **GET `/api/dataManagement/exportUsers`**: Export users to CSV
  - Response: CSV file download
  
- **GET `/api/dataManagement/exportAccessLogs`**: Export access logs to CSV
  - Query Parameters: `startDate`, `endDate`
  - Response: CSV file download
  
- **GET `/api/dataManagement/exportOrders`**: Export orders to CSV
  - Response: CSV file download
  
- **GET `/api/dataManagement/exportProducts`**: Export products to CSV
  - Response: CSV file download
  
- **GET `/api/dataManagement/dashboard`**: Get data management dashboard
  - Response: Statistics and overview (JSON)

### 15.2 API Response Format

**Standard Success Response**:
```json
{
  "success": true,
  "data": { ... },
  "message": "Operation completed successfully"
}
```

**Standard Error Response**:
```json
{
  "success": false,
  "error": {
    "code": "ERROR_CODE",
    "message": "Human-readable error message",
    "details": { ... }
  }
}
```

### 15.3 API Authentication

- **Session-Based**: Uses HTTP session cookies
- **Token-Based** (Future): JWT tokens for API access
- **Rate Limiting**: Prevents abuse
- **CORS Configuration**: For cross-origin requests

---

## 16. Feature Cross-Reference

### 16.1 Feature to Page Mapping

This section maps features from `FEATURES.md` to their corresponding UI/UX specifications in this document.

#### User Management Features
- **Registration**: Section 4.6.1 (Registration Page)
- **Login**: Section 4.6.2 (Login Page)
- **Profile Management**: Section 4.6.3 (User Profile Page)
- **Account Deletion**: Section 4.6.4 (Account Deletion Page)
- **Welcome/Goodbye**: Sections 4.6.5, 4.6.6

#### Product Catalog Features
- **Homepage**: Section 4.1 (Homepage Layout)
- **Product Listing**: Section 4.2 (Product Listing Pages)
- **Product Details**: Section 4.3 (Product Detail Page)
- **Search & Filtering**: Section 4.2 (Multi-dimensional filtering)

#### E-commerce Features
- **Shopping Cart**: Section 4.4 (Shopping Cart Page)
- **Checkout**: Section 4.5 (Checkout Page)
- **Order History**: Section 4.8.1 (Order History Page)
- **Order Details**: Section 4.8.2 (Order Details Page)
- **Shipment Tracking**: Section 4.8.3 (Shipment Tracking Page)

#### Product Reviews & Ratings
- **Review Display**: Section 4.7.1 (Product Reviews Section)
- **Review Submission**: Section 4.7.2 (Review Submission Form)

#### Administrative Features
- **Admin Dashboard**: Section 4.9.1 (Admin Dashboard)
- **User Management**: Section 4.9.2 (User Management Page)
- **Product Management**: Section 4.9.3 (Product Management Page)
- **Access Logs**: Section 4.9.4 (Access Log Management Page)
- **Data Management**: Section 4.9.5 (Data Management & Export Page)

#### Static Pages
- **About**: Section 4.10.1 (About Page)
- **Contact**: Section 4.10.2 (Contact Page)
- **Error**: Section 4.6.7 (Error Page)

### 16.2 Design System Alignment

All pages and components follow the design system principles outlined in:
- **Section 5**: Visual Design System
- **Section 6**: Interaction Design
- **Section 7**: Accessibility Design
- **Section 8**: Responsive Design

### 16.3 Accessibility Compliance

All features documented in `FEATURES.md` are designed with WCAG 2.1 AA compliance:
- **Keyboard Navigation**: Full keyboard support
- **Screen Reader Support**: ARIA attributes and semantic HTML
- **Color Contrast**: WCAG AA compliant contrast ratios
- **Focus Management**: Visible focus indicators
- **Skip Links**: Navigation shortcuts

---

**Document Status**: Complete - Version 2.0  
**Last Updated**: 2025  
**Next Review**: After Implementation  
**Maintained By**: UX/UI Design Team  
**Approved By**: Project Stakeholders  
**Reference Documents**: 
- `FEATURES.md` - Complete Feature List
- `improvement.md` - UX Improvement Plan
- `41025 ISD Assignment 2 Autumn 2025.pdf` - Assignment Brief

---

*This document is a living specification and will be updated as the project evolves and user feedback is incorporated. All features documented in `FEATURES.md` are reflected in this UI/UX specification.*

