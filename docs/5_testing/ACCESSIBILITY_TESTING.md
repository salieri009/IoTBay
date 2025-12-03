# Accessibility Testing Guide

**Document Version**: 1.0.0  
**Status**: Published  
**Last Updated**: December 3, 2025  
**Audience**: QA, Developers  
**Maintained By**: IoT Bay Documentation Team

---

## Overview

IoT Bay is committed to ensuring digital accessibility for people with disabilities. We target **WCAG 2.1 Level AA** compliance.

## Testing Checklist

### 1. Keyboard Navigation
- [ ] All interactive elements are focusable
- [ ] Focus order is logical (left-to-right, top-to-bottom)
- [ ] Focus indicator is visible
- [ ] No keyboard traps

### 2. Screen Reader Compatibility
- [ ] Images have `alt` text
- [ ] Form fields have labels
- [ ] Headings follow a logical hierarchy (`h1` -> `h2` -> `h3`)
- [ ] ARIA labels used where visual context is missing

### 3. Visual Design
- [ ] Color contrast ratio is at least 4.5:1 for normal text
- [ ] Text can be resized up to 200% without loss of content
- [ ] Color is not used as the only visual means of conveying information

## Tools

- **WAVE**: Web Accessibility Evaluation Tool
- **axe DevTools**: Automated accessibility testing
- **NVDA/VoiceOver**: Screen readers for manual testing

## Related Reports

- [Accessibility Audit Summary](./ACCESSIBILITY_AUDIT_SUMMARY_docs.md)
- [Nielsen Heuristics Review](./NIELSEN_HEURISTICS_REVIEW.md)
