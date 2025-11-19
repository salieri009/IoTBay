<%--
  ============================================
  Organism: Bottom Sheet
  ============================================
  
  Description:
    Mobile-friendly bottom sheet drawer component.
    Used for filters, menus, and additional content on mobile devices.
    Follows thumb zone principles (44px+ touch targets).
  
  Parameters:
    - id (string, required): Unique ID for the bottom sheet
    - title (string): Sheet title
    - trigger (string): Selector for trigger button
    - closeOnBackdrop (boolean): Close when backdrop clicked (default: true)
  
  Usage:
    <jsp:include page="/components/organisms/bottom-sheet/bottom-sheet.jsp">
      <jsp:param name="id" value="filter-sheet" />
      <jsp:param name="title" value="Filters" />
      <jsp:param name="trigger" value="#filter-trigger" />
    </jsp:include>
  
  Last Updated: 2025
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
  String idParam = request.getParameter("id");
  String titleParam = request.getParameter("title");
  String triggerParam = request.getParameter("trigger");
  boolean closeOnBackdrop = !"false".equalsIgnoreCase(request.getParameter("closeOnBackdrop"));

  String sheetId = (idParam != null && !idParam.trim().isEmpty())
      ? idParam
      : "bottom-sheet-" + java.util.UUID.randomUUID();

  String backdropId = sheetId + "-backdrop";
  String contentId = sheetId + "-content";

  pageContext.setAttribute("sheetIdAttr", sheetId);
  pageContext.setAttribute("backdropIdAttr", backdropId);
  pageContext.setAttribute("contentIdAttr", contentId);
  pageContext.setAttribute("closeOnBackdropAttr", closeOnBackdrop);
  pageContext.setAttribute("sheetTitleAttr", titleParam);
  String triggerSelector = triggerParam != null ? triggerParam : "";
  String triggerSelectorSafe = triggerSelector
      .replace("\\", "\\\\")
      .replace("'", "\\'");
  pageContext.setAttribute("triggerSelectorAttr", triggerSelector);
  pageContext.setAttribute("triggerSelectorSafeAttr", triggerSelectorSafe);
%>

<div id="${backdropIdAttr}" 
     class="bottom-sheet-backdrop" 
     role="dialog"
     aria-modal="true"
     aria-labelledby="${sheetIdAttr}-title"
     aria-hidden="true"
     <c:if test="${closeOnBackdropAttr}">data-close-on-backdrop="true"</c:if>>
  <div id="${contentIdAttr}" 
       class="bottom-sheet-content" 
       role="document">
    <%-- Handle for drag gesture --%>
    <div class="bottom-sheet-handle" aria-hidden="true"></div>
    
    <%-- Header --%>
    <div class="bottom-sheet-header">
      <c:if test="${not empty sheetTitleAttr}">
        <h2 id="${sheetIdAttr}-title" class="bottom-sheet-title">${sheetTitleAttr}</h2>
      </c:if>
      <button type="button" 
              class="bottom-sheet-close" 
              aria-label="Close"
              data-sheet-close="${sheetIdAttr}">
        <jsp:include page="/components/atoms/icon/icon.jsp">
          <jsp:param name="name" value="close" />
          <jsp:param name="size" value="medium" />
        </jsp:include>
      </button>
    </div>
    
    <%-- Content Area --%>
    <div class="bottom-sheet-body" id="${contentIdAttr}-body">
      <%-- Content will be injected via JavaScript or included separately --%>
    </div>
  </div>
</div>

<script>
(function() {
  const sheetId = '${sheetIdAttr}';
  const backdrop = document.getElementById('${backdropIdAttr}');
  const content = document.getElementById('${contentIdAttr}');
  const closeButton = content.querySelector('.bottom-sheet-close');
  const triggerSelector = '<%= triggerSelectorSafe %>';
  
  if (!backdrop || !content) return;
  
  // Open function
  window.openBottomSheet = window.openBottomSheet || function(id) {
    if (id === sheetId) {
      backdrop.setAttribute('aria-hidden', 'false');
      backdrop.classList.add('bottom-sheet-backdrop--visible');
      content.classList.add('bottom-sheet-content--visible');
      document.body.style.overflow = 'hidden';
      
      // Focus trap
      const firstFocusable = content.querySelector('button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])');
      if (firstFocusable) {
        firstFocusable.focus();
      }
    }
  };
  
  // Close function
  window.closeBottomSheet = window.closeBottomSheet || function(id) {
    if (id === sheetId) {
      backdrop.setAttribute('aria-hidden', 'true');
      backdrop.classList.remove('bottom-sheet-backdrop--visible');
      content.classList.remove('bottom-sheet-content--visible');
      document.body.style.overflow = '';
    }
  };
  
  // Close button
  if (closeButton) {
    closeButton.addEventListener('click', () => {
      window.closeBottomSheet(sheetId);
    });
  }
  
  // Backdrop click
  if (backdrop.dataset.closeOnBackdrop !== 'false') {
    backdrop.addEventListener('click', (e) => {
      if (e.target === backdrop) {
        window.closeBottomSheet(sheetId);
      }
    });
  }
  
  // ESC key
  document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape' && backdrop.getAttribute('aria-hidden') === 'false') {
      window.closeBottomSheet(sheetId);
    }
  });
  
  // Trigger button
  let trigger = null;
  if (triggerSelector && triggerSelector.trim().length > 0) {
    try {
      trigger = document.querySelector(triggerSelector);
    } catch (error) {
      console.error(`[BottomSheet:${sheetId}] Invalid trigger selector "${triggerSelector}"`, error);
    }
  }

  if (trigger) {
    trigger.addEventListener('click', (e) => {
      e.preventDefault();
      window.openBottomSheet(sheetId);
    });
  }
  
  // Touch gesture support (swipe down to close)
  let touchStartY = 0;
  let touchCurrentY = 0;
  
  content.addEventListener('touchstart', (e) => {
    touchStartY = e.touches[0].clientY;
  }, { passive: true });
  
  content.addEventListener('touchmove', (e) => {
    touchCurrentY = e.touches[0].clientY;
    const deltaY = touchCurrentY - touchStartY;
    
    if (deltaY > 0) {
      content.style.transform = `translateY(${deltaY}px)`;
    }
  }, { passive: true });
  
  content.addEventListener('touchend', () => {
    const deltaY = touchCurrentY - touchStartY;
    
    if (deltaY > 100) {
      window.closeBottomSheet(sheetId);
    }
    
    content.style.transform = '';
    touchStartY = 0;
    touchCurrentY = 0;
  });
})();
</script>

