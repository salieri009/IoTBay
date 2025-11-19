# Atomic Design Migration Guide
## Step-by-Step Implementation

**Last Updated**: 2025

---

## Quick Start

### 1. Use New Atomic Components

#### Button (Atom)
```jsp
<jsp:include page="/components/atoms/button/button.jsp">
  <jsp:param name="text" value="Add to Cart" />
  <jsp:param name="type" value="primary" />
  <jsp:param name="size" value="medium" />
</jsp:include>
```

#### Form Field (Molecule)
```jsp
<jsp:include page="/components/molecules/form-field/form-field.jsp">
  <jsp:param name="label" value="Email Address" />
  <jsp:param name="name" value="email" />
  <jsp:param name="type" value="email" />
  <jsp:param name="required" value="true" />
</jsp:include>
```

#### Product Card (Molecule)
```jsp
<c:set var="product" value="${product}" scope="request" />
<jsp:include page="/components/molecules/product-card/product-card.jsp">
  <jsp:param name="showQuickView" value="true" />
</jsp:include>
```

---

## Migration Examples

### Before: Inline Button
```jsp
<button class="btn btn--primary">Add to Cart</button>
```

### After: Atomic Button
```jsp
<jsp:include page="/components/atoms/button/button.jsp">
  <jsp:param name="text" value="Add to Cart" />
  <jsp:param name="type" value="primary" />
</jsp:include>
```

### Before: Inline Form Field
```jsp
<label for="email">Email</label>
<input type="email" id="email" name="email" />
```

### After: Form Field Molecule
```jsp
<jsp:include page="/components/molecules/form-field/form-field.jsp">
  <jsp:param name="label" value="Email" />
  <jsp:param name="name" value="email" />
  <jsp:param name="type" value="email" />
</jsp:include>
```

---

## Component Reference

See individual component README files in:
- `components/atoms/` - Atom components
- `components/molecules/` - Molecule components
- `components/organisms/` - Organism components
- `components/templates/` - Template components

---

**Status**: Foundation Complete  
**Next**: Continue building molecules and organisms

