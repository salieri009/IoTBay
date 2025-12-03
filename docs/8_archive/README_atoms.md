# Atoms

Basic building blocks that cannot be broken down further.

## Components

- **button** - Button element (primary, secondary, outline variants)
- **input** - Form input field
- **label** - Form label
- **badge** - Status badge
- **icon** - Icon component
- **avatar** - User avatar
- **divider** - Visual divider
- **logo** - Brand logo
- **text** - Typography components

## Usage

```jsp
<jsp:include page="/components/atoms/button/button.jsp">
  <jsp:param name="text" value="Click Me" />
  <jsp:param name="type" value="primary" />
</jsp:include>
```

## Rules

1. Atoms should be completely independent
2. No dependencies on other atoms
3. Use design system tokens only
4. Document all parameters



---

**Document Version**: 1.0.0
**Status**: Published
**Last Updated**: 12¿ù 3, 2025
**Audience**: Developers, Stakeholders
**Maintained By**: IoT Bay Documentation Team
