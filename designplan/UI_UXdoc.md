# IoTBay UI/UX Design Documentation
## Comprehensive User Experience Design Specification

**Course**: 41025 Information Systems Development (ISD)  
**Assignment**: Assignment 2 - Autumn 2025  
**Institution**: University of Technology Sydney (UTS)  
**Project Type**: E-commerce Web Application for IoT Devices  
**Document Version**: 1.0  
**Last Updated**: 2025

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

**Document Status**: Complete  
**Next Review**: After Phase 1 Implementation  
**Maintained By**: UX/UI Design Team  
**Approved By**: Project Stakeholders

---

*This document is a living specification and will be updated as the project evolves and user feedback is incorporated.*

