# Category Card Molecule

## Description
A card component used to display product categories on the homepage or category listing pages.

## Usage
```jsp
<jsp:include page="/components/molecules/category-card/category-card.jsp">
    <jsp:param name="href" value="/category-industrial.jsp" />
    <jsp:param name="title" value="Industrial" />
    <jsp:param name="iconColorClass" value="bg-brand-primary-100" />
    <jsp:param name="iconTextClass" value="text-brand-primary" />
    <jsp:param name="iconSvgPath" value="..." />
    <jsp:param name="subItems" value="Sensors,Controllers,Connectivity" />
</jsp:include>
```

## Props
| Name | Type | Description |
|------|------|-------------|
| href | String | The URL the card links to |
| title | String | The category title |
| iconColorClass | String | Tailwind class for icon background color |
| iconTextClass | String | Tailwind class for icon text color |
| iconSvgPath | String | The SVG path data for the icon |
| subItems | String | Comma-separated list of sub-categories |
