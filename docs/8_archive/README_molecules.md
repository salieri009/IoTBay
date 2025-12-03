# Molecules

Simple combinations of atoms that form functional units.

## Components

- **product-card** - Product display card
- **search-form** - Search input with button
- **form-field** - Label + Input + Error message
- **navigation-item** - Navigation link with optional icon
- **cart-item** - Shopping cart item row
- **order-summary** - Order summary card
- **alert** - Alert message with icon
- **filter-group** - Filter section with options

## Usage

```jsp
<jsp:include page="/components/molecules/product-card/product-card.jsp">
  <jsp:param name="product" value="${product}" />
</jsp:include>
```

## Rules

1. Molecules combine 2+ atoms
2. Should have a single, clear purpose
3. Can depend on atoms only
4. Document dependencies



---

**Document Version**: 1.0.0
**Status**: Published
**Last Updated**: 12¿ù 3, 2025
**Audience**: Developers, Stakeholders
**Maintained By**: IoT Bay Documentation Team
